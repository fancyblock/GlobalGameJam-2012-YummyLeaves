//
//  GameTask.h
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HIFramework.h"
#import "LevelInfo.h"
#import "ProgressUI.h"

#define STATE_RUNNING   1
#define STATE_COMPLETE  2
#define STATE_GAMEOVER  3
#define STATE_PAUSE     4



@interface GameTask : Task
{
    LevelInfo* m_lvInfo;
    
    float m_curAngle;
    float m_angleInterval;
    
    Sprite* m_bg;
    Sprite* m_bg2;
    Sprite* m_snakeBody;
    MovieClip* m_snakeHead;
    NSMutableArray* m_leafs;
    Sprite* m_aimFrame1;
    Sprite* m_aimFrame2;
    Sprite* m_aimFrame3;
    NSMutableArray* m_levels;
    Sprite* m_bigSnake1;
    Sprite* m_bigSnake2;
    Sprite* m_failMark;
    
    int m_state;
    int m_mark;
    int m_failTimes;
    int m_bigSnakeTime;
    int m_gameOverTime;
    int m_sunFlashTime;
    
    ProgressUI* m_progressUI;
}

@end
