//
//  GameTask.m
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameTask.h"
#import "TaskSet.h"
#import "SubLeafInfo.h"
#import "LevelFactory.h"

const float L_ROUND = M_PI * 2;

@interface GameTask(private)

- (void)restart;
- (float)normalizeAngle:(float)angle;
- (int)matchLeaf;
- (void)levelComplete;

@end


@implementation GameTask



- (void)onBegin
{
    // init base parameter
    m_lvInfo = [TaskSet sharedInstance]._curLevel;
    m_curAngle = 0.0f;
    m_angleInterval = _angleInterval;
    
    // init the graphics
    m_leafs = [[NSMutableArray alloc] init];
    for( int i = 0; i < 9; i++ )
    {
        SubLeafInfo* li = [[LevelFactory sharedInstance] CreateSubLeaf:i];
        Sprite* leafSpr = [[GraphicFactory sharedInstance] CreateSprite:li._res];
        float offsetU;
        float offsetV;
        if( li._type == 8 )
        {
            offsetU = 0.0625f;
            offsetV = 0.125f;

        }
        else 
        {
            offsetU = 0.125f;
            offsetV = 0.250f;
        }
        [leafSpr SetUVFrom:CGPointMake(li._u, li._v) to:CGPointMake(li._u + offsetU, li._v + offsetV)];
        [leafSpr SetSize:CGPointMake(32, 64)];
        
        [m_leafs addObject:leafSpr];
        
        [leafSpr release];
        [li release];
    }
    
    m_snakeHead = [[GraphicFactory sharedInstance] CreateMovieClip:@"snake_head_leaf.png" withInterval:0.167f];
    [m_snakeHead AddFrame:CGRectMake(0, 0, 117.0f/256.0f, 65.0f/256.0f)
               withAnchor:CGPointMake(0, 0) 
                 withSize:CGPointMake(117, 65)];
    [m_snakeHead AddFrame:CGRectMake(119.0f/256.0f, 0, (117.0f)/256.0f, 65.0f/256.0f)
               withAnchor:CGPointMake(0, 0 )
                 withSize:CGPointMake( 117, 65 )];
    [m_snakeHead AddFrame:CGRectMake(0, 67.0f/256.0f, 117.0f/256.0f, (65.0f)/256.0f) 
               withAnchor:CGPointMake(0, 0 )
                 withSize:CGPointMake( 117, 65 )];
    [m_snakeHead AddFrame:CGRectMake(0, 134.0f/256.0f, 117.0f/256.0f, (65.0f)/256.0f) 
               withAnchor:CGPointMake(0, 0 )
                 withSize:CGPointMake(117, 65)];
    [m_snakeHead SetPosition:CGPointMake( 88, 284 )];     //[TEMP] 284
    m_snakeBody = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_snakeBody SetUVFrom:CGPointMake(0, 0) to:CGPointMake(181.0f/512.0f, 181.0f/512.0f)];
    [m_snakeBody SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_snakeBody SetSize:CGPointMake(181, 181)];
    m_bg = [[GraphicFactory sharedInstance] CreateSprite:@"bg.png"];
    [m_bg SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    m_bg2 = [[GraphicFactory sharedInstance] CreateSprite:@"bg2.png"];
    [m_bg2 SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    m_aimFrame1 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame1 SetUVFrom:CGPointMake(183.0f/512.0f, 0) to:CGPointMake((float)(183+131)/512.0f, 116.0f/512.0f)];
    [m_aimFrame1 SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_aimFrame1 SetSize:CGPointMake(131, 116)];
    m_aimFrame2 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame2 SetUVFrom:CGPointMake(316.0f/512.0f, 0) to:CGPointMake((float)(316+131)/512.0f, 116.0f/512.0f)];
    [m_aimFrame2 SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_aimFrame2 SetSize:CGPointMake(131, 116)];
    m_aimFrame3 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame3 SetUVFrom:CGPointMake(321.0f/512.0f, 199.0f/512.0f) to:CGPointMake((float)(321+131)/512.0f, (float)(116.0f+199)/512.0f)];
    [m_aimFrame3 SetAnchor:CGPointMake(0.5f, 0.5f)];
    [m_aimFrame3 SetSize:CGPointMake(131, 116)];
    m_levels = [[NSMutableArray alloc] init];
    Sprite* levelSpr = nil;
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 0) to:CGPointMake(320.0f/1024.0f, 217.0f/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(322.0f/1024.0f, 0) to:CGPointMake((322.0f+320.0f)/1024.0f, 217.0f/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(644.0f/1024.0f, 0) to:CGPointMake((644.0f+320.0f)/1024.0f, 217.0f/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 219.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (219.0f+217.0f)/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 438.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (438.0f+217.0f)/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 657.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (657.0f+217.0f)/1024.0f)];
    [levelSpr SetSize:CGPointMake(320, 217)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    m_bigSnake1 = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [m_bigSnake1 SetUVFrom:CGPointMake(344.0f/1024.0f, 304.0f/1024.0f) to:CGPointMake((344.0f+320.0f)/1024.0f, (512.0f+304.0f)/1024.0f)];
    [m_bigSnake1 SetSize:CGPointMake(320, 512)];
    m_bigSnake2 = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [m_bigSnake2 SetUVFrom:CGPointMake(686.0f/1024.0f, 302.0f/1024.0f) to:CGPointMake((686.0f+320.0f)/1024.0f, (512.0f+302.0f)/1024.0f)];
    [m_bigSnake2 SetSize:CGPointMake(320, 512)];
    m_failMark = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_failMark SetUVFrom:CGPointMake(243.0f/512.0f, 244.0f/512.0f) to:CGPointMake((243.0f+26.0f)/512.0f, (244.0f+25.0f)/512.0f)];
    [m_failMark SetSize:CGPointMake(26, 25)];
    
    m_progressUI = [[ProgressUI alloc] init];
    [m_progressUI SetMark:0];
    
    m_state = STATE_RUNNING;
    m_mark = 0;
    m_failTimes = 0;
    
    [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._bgm withLoop:INFINITE_LOOP];
}


- (void)onEnd
{
    [m_lvInfo release];
    [m_leafs removeAllObjects];
    [m_leafs release];
    [m_snakeBody release];
    [m_snakeHead release];
    [m_bg2 release];
    [m_bg release];
    [m_aimFrame1 release];
    [m_aimFrame2 release];
    [m_aimFrame3 release];
    [m_levels removeAllObjects];
    [m_levels release];
    [m_bigSnake1 release];
    [m_bigSnake2 release];
    [m_failMark release];
    [m_progressUI release];
    
    [[RenderCore sharedInstance] CleanTextures];
}


- (void)onFrame:(float)elapse
{
    m_curAngle += [TaskSet sharedInstance]._rotateSpeed;
    
    [m_snakeHead Update:elapse];
    [m_progressUI Update:elapse];
    
    if( m_state == STATE_GAMEOVER )
    {
        m_gameOverTime++;
        
        if( m_gameOverTime > 50 )
        {
            [[SoundManager sharedInstance] StopSound:[TaskSet sharedInstance]._bgm];
            
            [self Stop];
            [[TaskSet sharedInstance]._endTask Start];
        }
    }
}


- (void)onDraw:(float)elapse
{
    [m_bg DrawAt:CGPointMake(0, 0) withSize:CGPointMake(320, 480)];
    
    if( m_state == STATE_COMPLETE )
    {
        if( m_bigSnakeTime < 50 )
        {
            [m_bigSnake1 DrawAt:CGPointMake(0, 100-m_bigSnakeTime*6)];
        }
        else if( m_bigSnakeTime < 70 )
        {
            [m_bigSnake1 DrawAt:CGPointMake(0, -200)];
        }
        if( m_bigSnakeTime > 70 )
        {
            [[m_levels objectAtIndex:0] DrawAt:CGPointMake(0, 20)];
        }
        else
        {
            [[m_levels objectAtIndex:m_mark] DrawAt:CGPointMake(0, 20)];
        }
        
        if( m_bigSnakeTime >= 50 )
        {       
            [m_bigSnake2 DrawAt:CGPointMake(0, -512 + ( m_bigSnakeTime - 50 ) * 13)];
        }
        
        m_bigSnakeTime++;
        
        if( m_bigSnakeTime > 140 )
        {
            [self restart];
        }
    }
    else 
    {
        [[m_levels objectAtIndex:m_mark] DrawAt:CGPointMake(0, 20)];
    }
    
    [m_bg2 DrawAt:CGPointMake(0, 237) withSize:CGPointMake(320, 323)];
    [m_progressUI Draw:CGPointMake(45, 20)];
    
    if( m_sunFlashTime > 0 )
    {
        [m_aimFrame1 DrawAt:CGPointMake(160, 258)];
        m_sunFlashTime--;
    }
    else
    {
        [m_aimFrame2 DrawAt:CGPointMake(160, 258)];
    }
    
    int i;
    
    SubLeafInfo* subLeaf = nil;
    float leafAngle;
    
    BOOL aimLeaf = NO;
    for( i = 0; i < m_lvInfo._leafCnt; i++ )
    {
        Sprite* spr = nil;
        subLeaf = [m_lvInfo._subLeaves objectAtIndex:i];
        
        leafAngle = m_curAngle + subLeaf._offset * m_angleInterval;
        leafAngle = [self normalizeAngle:leafAngle];
        
        spr = [m_leafs objectAtIndex:subLeaf._type];
        [spr SetAnchor:CGPointMake( 0.5f, 2.422f )];
        [spr SetColorR:1.0f andG:1.0f andB:1.0f andAlpha:1.0f];
        [spr DrawAt:CGPointMake(160, 386) withAngle:-leafAngle];
        
        if( subLeaf._type == m_lvInfo._matchLeafType && !aimLeaf )
        {
            spr = [m_leafs objectAtIndex:subLeaf._type];
            [spr SetAnchor:CGPointMake(0.5f, 0.5f)];
            [spr SetColorR:0.0f andG:0.0f andB:0.0f andAlpha:1.0f];
            [spr DrawAt:CGPointMake(160, 386) withAngle:m_lvInfo._aimAngle];
            
            aimLeaf = YES;
        }
    }
    
    [m_snakeBody DrawAt:CGPointMake(160, 386) withAngle:-m_curAngle];
    [m_snakeHead Draw];
    
    for( i = 0; i < m_failTimes; i++ )
    {
        [m_failMark DrawAt:CGPointMake(235+i*28, 450)];
    }
    
}


- (BOOL)onTouchEvent:(NSArray*)events
{
    TouchEvent *evt = [events objectAtIndex:0];
    
    if( evt != nil && m_state == STATE_RUNNING )
    {
        if( evt.TOUCH_TYPE == TOUCH )
        {
            int index = [self matchLeaf];
            
            if( index >= 0 )
            {
                if( m_mark < 5 )
                {
                    m_mark++;
                    [m_progressUI SetMark:m_mark];
                    
                    m_lvInfo = [[LevelFactory sharedInstance] CreateLevel:0];
                    
                    m_sunFlashTime = 14;
                    
                    [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._matchSE withLoop:1];
                }
                else
                {
                    [self levelComplete];
                }
                
                return true;
            }
            else
            {
                // wrong
                [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._touchSE withLoop:1];
                
                m_failTimes++;
                
                if( m_failTimes >= 3 )
                {
                    m_state = STATE_GAMEOVER;
                }
            }
        }
    }
    
    return NO;
}



//---------------------------- private function -----------------------------


- (void)restart
{
    [m_lvInfo release];
    m_lvInfo = [[LevelFactory sharedInstance] CreateLevel:0];
    m_state = STATE_RUNNING;
    m_mark = 0;
    m_failTimes = 0;
    m_sunFlashTime = 0;
    [m_progressUI SetMark:0];
    
    [TaskSet sharedInstance]._rotateSpeed += 0.005f;
}

- (int)matchLeaf
{
    int cnt = m_lvInfo._leafCnt;
    SubLeafInfo* subLeaf;
    float leafAngle;
    
    for( int i = 0; i < cnt; i++ )
    {
        subLeaf = [m_lvInfo._subLeaves objectAtIndex:i];
        
        leafAngle = m_curAngle + subLeaf._offset * m_angleInterval;
        leafAngle = [self normalizeAngle:leafAngle];
        
        // find the leaf match the pattern
        float absAngle = leafAngle;
        if( absAngle < 0 )
        {
            absAngle = -absAngle;
        }
        
        if( absAngle < m_lvInfo._epsion && subLeaf._type == m_lvInfo._matchLeafType )
        {
            return i;
        }
    }
    
    return -1;
}

- (void)levelComplete
{
    m_state = STATE_COMPLETE;
    m_bigSnakeTime = 0;
    
    [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._eatSE withLoop:1];
}

- (float)normalizeAngle:(float)angle
{
    float ang = angle;
    
    while( ang >= L_ROUND )
    {
        ang -= L_ROUND;
    }
    
    if( ang > ( L_ROUND / 2.0f ) )
    {
        ang = ang - L_ROUND;
    }
    
    return ang;
}



@end
