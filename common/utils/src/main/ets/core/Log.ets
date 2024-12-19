/*
 * @Desc: 日志类
 * @Author: qincji
 * @Date: 2024/5/25
 */
import hilog from '@ohos.hilog';

export declare interface ILog {
  d(...args: string[]): void;

  i(...args: string[]): void;

  w(...args: string[]): void;

  e(...args: string[]): void;

  f(...args: string[]): void;

  setLevel(level: hilog.LogLevel): void;
}

class DefaultLog implements ILog {
  private domain: number = 0xFF00;
  private prefix: string = 'OHLog';
  private format: string = `%{public}s, %{public}s`;

  d(...args: string[]) {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  i(...args: string[]) {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  w(...args: string[]) {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  e(...args: string[]) {
    hilog.error(this.domain, this.prefix, this.format, args);
  }

  f(...args: string[]) {
    hilog.fatal(this.domain, this.prefix, this.format, args);
  }

  setLevel(level: hilog.LogLevel) {
    hilog.isLoggable(this.domain, this.prefix, level);
  }
}

class EmptyLog implements ILog {
  d(...args: string[]) {
  }

  i(...args: string[]) {
  }

  w(...args: string[]) {
  }

  e(...args: string[]) {
  }

  f(...args: string[]) {
  }

  setLevel(level: hilog.LogLevel) {
  }
}


export class log {
  private static iLog: ILog = new DefaultLog();

  private constructor() {
  }

  static setImpl(iLog: ILog) {
    log.iLog = iLog;
  }

  static closeLog() {
    log.iLog = new EmptyLog();
  }

  static d(...args: string[]) {
    log.iLog.d(...args);
  }

  static i(...args: string[]) {
    log.iLog.i(...args);
  }

  static w(...args: string[]) {
    log.iLog.w(...args);
  }

  static e(...args: string[]) {
    log.iLog.e(...args);
  }

  static f(...args: string[]) {
    log.iLog.f(...args);
  }

  static setLevel(level: hilog.LogLevel) {
    log.iLog.setLevel(level);
  }
}