/*
 * @Desc: wav文件相关操作
 * @Author: qincji
 * @Date: 2024/5/4
 */
import fs from '@ohos.file.fs';
import { buffer } from '@kit.ArkTS';
import { log } from './Log';

export namespace wav {
  export class Header {
    mChunkID: string = "RIFF";
    mChunkSize: number = 0;
    mFormat: string = "WAVE";
    mSubChunk1ID: string = "fmt ";
    mSubChunk1Size: number = 16;
    mAudioFormat: number = 1; //short
    mNumChannel: number = 1; //short
    mSampleRate: number = 8000;
    mByteRate: number = 0; //每秒钟的比特率
    mBlockAlign: number = 0; //short
    mBitsPerSample: number = 8; //short

    mSubChunk2ID: string = "data";
    mSubChunk2Size: number = 0;

    constructor(sampleRateInHz: number, channels: number, bitsPerSample: number) {
      this.mSampleRate = sampleRateInHz;
      this.mBitsPerSample = bitsPerSample;
      this.mNumChannel = channels;
      this.mByteRate = this.mSampleRate * this.mNumChannel * this.mBitsPerSample / 8;
      this.mBlockAlign = (this.mNumChannel * this.mBitsPerSample / 8);
    }
  }

  function deleteIfExit(path: string) {
    if (fs.accessSync(path)) {
      fs.unlinkSync(path)
    }
  }


  class Options {
    offset?: number;
    length?: number;
  }

  const MAX_COPY_LEN: number = 1024 * 10; //一次最大复制10K？
  const TAG = 'WavUtil';

  function offset(offset: number, length: number): Options {
    return {
      offset: offset,
      length: length
    }
  }

  export class Writer {
    private header: Header;
    private tempPath: string;
    private filePath: string;
    private temp: fs.File;
    private file: fs.File;
    private dataLength: number = 0;

    constructor(folder:string, filepath: string, sampleRateInHz: number, channels: number, bitsPerSample: number) {
      this.header = new Header(sampleRateInHz, channels, bitsPerSample);
      this.tempPath = folder + '/temp.wav';
      this.filePath = filepath;
      deleteIfExit(filepath);
      deleteIfExit(this.tempPath);
      this.file = fs.openSync(filepath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      this.temp = fs.openSync(this.tempPath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    }

    /**
     * 返回多少秒
     * @returns
     */
    public getDuration(): number {
      return Number((this.dataLength / this.header.mByteRate).toFixed(0));
    }

    /**
     * 重新生成文件
     * @param filepath
     */
    public creatNewFile(filepath: string) {
      deleteIfExit(this.filePath);
      this.filePath = filepath;
      this.file = fs.openSync(filepath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    }

    public clearCache() {
      fs.closeSync(this.temp.fd);
      fs.closeSync(this.file.fd);
      deleteIfExit(this.filePath);
      deleteIfExit(this.tempPath);
    }

    public writeData(buffer: ArrayBuffer) {
      fs.writeSync(this.temp.fd, buffer, {
        offset: this.dataLength,
        length: buffer.byteLength
      });
      this.dataLength += buffer.byteLength;
      // log.i(TAG, 'dataLength： ' + this.dataLength);
    }

    /**
     * 移除最后多少秒的内容
     * @param clearEndSecond
     */
    public writeFinish(clearEndSecond: number = 0) {
      log.i(TAG, 'writeFinish dataLength： ' + this.dataLength);
      this.dataLength = this.dataLength - clearEndSecond * this.header.mByteRate;
      this.writeHeader();
      const HEADER_SIZE: number = 44;
      let bufferSize: number = HEADER_SIZE; //这是写入头部后的大小
      let buffer: ArrayBuffer = new ArrayBuffer(MAX_COPY_LEN);
      let curSize = fs.readSync(this.temp.fd, buffer);
      while (curSize > 0) {
        fs.writeSync(this.file.fd, buffer, {
          offset: bufferSize,
          length: curSize
        });
        bufferSize += curSize;
        if (curSize < MAX_COPY_LEN || bufferSize - HEADER_SIZE >= this.dataLength) { //已到达最后
          break;
        }
        curSize = fs.readSync(this.temp.fd, buffer);
      }

      fs.closeSync(this.temp.fd);
      fs.closeSync(this.file.fd);
      fs.unlinkSync(this.tempPath);

      log.i(TAG, 'finish...');
    }

    private writeHeader() {
      //格式参照：https://blog.csdn.net/qq_26990831/article/details/52176495
      //00~03 4字节“RIFF” 资源交换文件标志
      fs.writeSync(this.file.fd, buffer.from(this.header.mChunkID).buffer, offset(0, 4));
      //04~07 4字节size=文件大小-8字节
      const fileSize = fs.statSync(this.temp.fd).size;
      const fileSizeArray = [(fileSize - 8) & 0xff, ((fileSize - 8) >> 8) & 0xff,
        ((fileSize - 8) >> 16) & 0xff, ((fileSize - 8) >> 24) & 0xff];
      fs.writeSync(this.file.fd, buffer.from(fileSizeArray).buffer, offset(4, 4));
      //08~11 4字节“wave” wav文件标志
      fs.writeSync(this.file.fd, buffer.from(this.header.mFormat).buffer, offset(8, 4));
      //12~15 4字节“fmt” 波形格式标志,最后一位空格
      fs.writeSync(this.file.fd, buffer.from(this.header.mSubChunk1ID).buffer, offset(12, 4));
      //16~19 4字节过滤字节(一般为00000010H) SubChunk1Size
      const subChunkArray: number[] = [16, 0, 0, 0];
      fs.writeSync(this.file.fd, buffer.from(subChunkArray).buffer, offset(16, 4));
      //20~21 2字节格式种类(值为1时,表示数据为线性pcm编码)
      const audioFormatArray: number[] = [1, 0];
      fs.writeSync(this.file.fd, buffer.from(audioFormatArray).buffer, offset(20, 2));
      //22~23 2字节通道数,单声道为1,双声道为2
      const channelArray: number[] = [this.header.mNumChannel, 0];
      fs.writeSync(this.file.fd, buffer.from(channelArray).buffer, offset(22, 2));
      //24~27 4字节采样率
      const sampleR = this.header.mSampleRate;
      const sampleRateArray = [sampleR & 0xff, (sampleR >> 8) & 0xff, (sampleR >> 16) & 0xff, (sampleR >> 24) & 0xff];
      fs.writeSync(this.file.fd, buffer.from(sampleRateArray).buffer, offset(24, 4));
      //28~31 4字节比特率(Byte率=采样频率*音频通道数*每次采样得到的样本位数/8)
      const bitRate = this.header.mByteRate;
      const bitRateArray = [bitRate & 0xff, (bitRate >> 8) & 0xff, (bitRate >> 16) & 0xff, (bitRate >> 24) & 0xff];
      fs.writeSync(this.file.fd, buffer.from(bitRateArray).buffer, offset(28, 4));
      //32~33 2字节数据块长度(每个样本的字节数=通道数*每次采样得到的样本位数/8)
      const blockArray = [this.header.mBlockAlign, 0];
      fs.writeSync(this.file.fd, buffer.from(blockArray).buffer, offset(32, 2));
      //34~35 2字节每个采样点的位数
      const bitPerRateArray = [this.header.mBitsPerSample, 0];
      fs.writeSync(this.file.fd, buffer.from(bitPerRateArray).buffer, offset(34, 2));
      //36~39 4字节 “data”数据标志符
      fs.writeSync(this.file.fd, buffer.from(this.header.mSubChunk2ID).buffer, offset(36, 4));
      //40~43 4字节 pcm音频数据大小
      const dataSize = this.dataLength;
      const dataSizeArray = [dataSize & 0xff, (dataSize >> 8) & 0xff, (dataSize >> 16) & 0xff, (dataSize >> 24) & 0xff];
      fs.writeSync(this.file.fd, buffer.from(dataSizeArray).buffer, offset(40, 4));
    }
  }
}
