import { PREVIEWER_V_ZOOM, PREVIEWER_H_ZOOM } from '../common/constants/CommonConstants';
import { Rotation } from '@kit.ArkUI';

export interface TabBarData {
  id: number;
  title: ResourceStr;
  Icon: ResourceStr;
  Rect: ResourceStr;
  TextDefaultPosition: Position;
  TextActivePosition: Position;
  defaultPosition: Position;
  activePosition: Position;
  defaultRotate: RotateOptions;
  activeRotate: RotateOptions;
  TextColor: ResourceStr;
}

export enum TabBarType {
  COOK = 0,
  RECIPE=1,
  MINE=2,

}

export const TabsInfo: TabBarData[] = [
  {
    id: 0,
    title: '烹饪',
    Icon: $r(`app.media.IndexIcon0`),
    Rect: $r(`app.media.IndexRect0`),
    TextDefaultPosition: { x: 0 / PREVIEWER_H_ZOOM, y: 25 / PREVIEWER_H_ZOOM },
    TextActivePosition: { x: 35 / PREVIEWER_H_ZOOM, y: 25 / PREVIEWER_H_ZOOM },
    defaultPosition: { x:  0 /PREVIEWER_H_ZOOM, y:  35 /PREVIEWER_H_ZOOM },
    activePosition: { x:  -15 / PREVIEWER_H_ZOOM, y: -10 / PREVIEWER_H_ZOOM },
    defaultRotate: { angle: (0 / PREVIEWER_H_ZOOM) },
    activeRotate: { angle: (-15 / PREVIEWER_H_ZOOM) },
    TextColor:'#693D0E'
  },
  {
    id: 1,
    title: '食谱',
    Icon: $r(`app.media.IndexIcon1`),
    Rect: $r(`app.media.IndexRect1`),
    TextDefaultPosition: { x: 0 / PREVIEWER_H_ZOOM, y: 25 / PREVIEWER_H_ZOOM },
    TextActivePosition: { x: 35 / PREVIEWER_H_ZOOM, y: 25 / PREVIEWER_H_ZOOM },
    defaultPosition: { x:  0 /PREVIEWER_H_ZOOM, y:  35 /PREVIEWER_H_ZOOM },
    activePosition: { x:  -15 / PREVIEWER_H_ZOOM, y: -10 / PREVIEWER_H_ZOOM },
    defaultRotate: { angle: (0 / PREVIEWER_H_ZOOM) },
    activeRotate: { angle: (-30 / PREVIEWER_H_ZOOM) },
    TextColor:'#466518'
  },
  {
    id: 2,
    title: '我的',
    Icon: $r(`app.media.IndexIcon2`),
    Rect: $r(`app.media.IndexRect2`),
    TextDefaultPosition: { x: 0 / PREVIEWER_H_ZOOM, y: 25 / PREVIEWER_H_ZOOM },
    TextActivePosition: { x: 0 / PREVIEWER_H_ZOOM, y: 3/ PREVIEWER_H_ZOOM },
    defaultPosition: { x:  0 /PREVIEWER_H_ZOOM, y:  35 /PREVIEWER_H_ZOOM },
    activePosition: { x:  0 / PREVIEWER_H_ZOOM, y: -10 / PREVIEWER_H_ZOOM },
    defaultRotate: { angle: (-30 / PREVIEWER_H_ZOOM) },
    activeRotate: { angle: (30 / PREVIEWER_H_ZOOM) },
    TextColor:'#0E457C'
  }

]