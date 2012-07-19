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
        
        [m_leafs addObject:leafSpr];
        
        [leafSpr release];
        [li release];
    }
    
    m_snakeHead = [[GraphicFactory sharedInstance] CreateMovieClip:@"snake_head_leaf.png" withInterval:0.167f];
    [m_snakeHead AddFrame:CGRectMake(0, 0, 117.0f/256.0f, 65.0f/256.0f) withAnchor:CGPointMake(0, 0 )];
    [m_snakeHead AddFrame:CGRectMake(119.0f/256.0f, 0, 117.0f/256.0f, 65.0f/256.0f) withAnchor:CGPointMake(0, 0 )];
    [m_snakeHead AddFrame:CGRectMake(0, 67.0f/256.0f, 117.0f/256.0f, 65.0f/256.0f) withAnchor:CGPointMake(0, 0 )];
    [m_snakeHead AddFrame:CGRectMake(0, 134.0f/256.0f, 117.0f/256.0f, 65.0f/256.0f) withAnchor:CGPointMake(0, 0 )];
    [m_snakeHead SetPosition:CGPointMake( 88, 284 )];     //[TEMP] 284
    m_snakeBody = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_snakeBody SetUVFrom:CGPointMake(0, 0) to:CGPointMake(181.0f/512.0f, 181.0f/512.0f)];
    [m_snakeBody SetAnchor:CGPointMake(0.5f, 0.5f)];
    m_bg = [[GraphicFactory sharedInstance] CreateSprite:@"bg.png"];
    [m_bg SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    m_bg2 = [[GraphicFactory sharedInstance] CreateSprite:@"bg2.png"];
    [m_bg2 SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    m_aimFrame1 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame1 SetUVFrom:CGPointMake(183.0f/512.0f, 0) to:CGPointMake((float)(183+131)/512.0f, 116.0f/512.0f)];
    [m_aimFrame1 SetAnchor:CGPointMake(0.5f, 0.5f)];
    m_aimFrame2 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame2 SetUVFrom:CGPointMake(316.0f/512.0f, 0) to:CGPointMake((float)(316+131)/512.0f, 116.0f/512.0f)];
    [m_aimFrame2 SetAnchor:CGPointMake(0.5f, 0.5f)];
    m_aimFrame3 = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_aimFrame3 SetUVFrom:CGPointMake(321.0f/512.0f, 199.0f/512.0f) to:CGPointMake((float)(321+131)/512.0f, (float)(116.0f+199)/512.0f)];
    [m_aimFrame3 SetAnchor:CGPointMake(0.5f, 0.5f)];
    m_levels = [[NSMutableArray alloc] init];
    Sprite* levelSpr = nil;
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 0) to:CGPointMake(320.0f/1024.0f, 217.0f/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(322.0f/1024.0f, 0) to:CGPointMake((322.0f+320.0f)/1024.0f, 217.0f/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(644.0f/1024.0f, 0) to:CGPointMake((644.0f+320.0f)/1024.0f, 217.0f/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 219.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (219.0f+217.0f)/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 438.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (438.0f+217.0f)/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    levelSpr = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [levelSpr SetUVFrom:CGPointMake(0, 657.0f/1024.0f) to:CGPointMake(320.0f/1024.0f, (657.0f+217.0f)/1024.0f)];
    [m_levels addObject:levelSpr];
    [levelSpr release];
    m_bigSnake1 = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [m_bigSnake1 SetUVFrom:CGPointMake(344.0f/1024.0f, 304.0f/1024.0f) to:CGPointMake((344.0f+320.0f)/1024.0f, (512.0f+304.0f)/1024.0f)];
    m_bigSnake2 = [[GraphicFactory sharedInstance] CreateSprite:@"achieve_bg.png"];
    [m_bigSnake2 SetUVFrom:CGPointMake(686.0f/1024.0f, 302.0f/1024.0f) to:CGPointMake((686.0f+320.0f)/1024.0f, (512.0f+302.0f)/1024.0f)];
    m_failMark = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_failMark SetUVFrom:CGPointMake(243.0f/512.0f, 244.0f/512.0f) to:CGPointMake((243.0f+26.0f)/512.0f, (244.0f+25.0f)/512.0f)];
    
    m_progressUI = [[ProgressUI alloc] init];
    [m_progressUI SetMark:0];
    
    m_state = STATE_RUNNING;
    m_mark = 0;
    m_failMark = 0;
    
    [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._bgm withLoop:INFINITE_LOOP];
    
}


- (void)onEnd
{
    //TODO 
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
        //TODO 
    }
    else 
    {
        //TODO 
    }
    
    //-----------------------------------
    /*
    if( m_state == STATE_COMPLETE )
    {
        if( m_bigSnakeTime < 50 )
        {
            m_bigSnake1.Draw( 0, 100 - m_bigSnakeTime * 6 );
        }
        else if( m_bigSnakeTime < 70 )
        {
            m_bigSnake1.Draw( 0, -200 );
        }
        
        if( m_bigSnakeTime > 70 )
        {
            m_levels[0].Draw( 0, 20 );
        }
        else
        {
            m_levels[m_mark].Draw( 0, 20 );
        }
        
        if( m_bigSnakeTime >= 50 )
        {       
            m_bigSnake2.Draw( 0, -512 + ( m_bigSnakeTime - 50 ) * 13 );
        }
        
        m_bigSnakeTime++;
        
        if( m_bigSnakeTime > 140 )
        {
            restart();
        }
    }
    else
    {
        m_levels[m_mark].Draw( 0, 20 );
    }
    
    m_bg2.Draw( 0, 237, 320, 323 );
    m_progressUI.Draw( 45, 20 );
    
    if( m_sunFlashTime > 0 )
    {
        m_aimFrame1.Draw( 160, 258 );
        m_sunFlashTime--;
    }
    else
    {
        m_aimFrame2.Draw( 160, 258 );
    }
    //m_aimFrame3.Draw( 160, 258 );
    
    int i;
    for( i = 0; i < m_failTimes; i++ )
    {
        m_failMark.Draw( 225 + i * 28, 530 );
    }
    
    SubLeafInfo subLeaf;
    float leafAngle;
    
    boolean aimLeaf = false;
    for( i = 0; i < m_lvInfo._leafCnt; i++ )
    {
        subLeaf = m_lvInfo._subLeaves[i];
        
        leafAngle = m_curAngle + subLeaf._offset * m_angleInterval;
        leafAngle = normalizeAngle( leafAngle );
        
        m_leafs[subLeaf._type].SetAnchor( 16, 155 );
        m_leafs[subLeaf._type].Draw( 160, 386, -leafAngle );
        
        if( subLeaf._type == m_lvInfo._matchLeafType && !aimLeaf )
        {
            m_leafs[subLeaf._type].SetAnchor( 16, 32 );
            m_leafs[subLeaf._type].Draw( 160.0f, 386.0f, m_lvInfo._aimAngle );
            
            aimLeaf = true;
        }
    }
    
    m_snakeBody.Draw( 160.0f, 386.0f, -m_curAngle );
    m_snakeHead.Draw();
     */
}


- (BOOL)onTouchEvent:(NSArray*)events
{
    //TODO 
    
    return NO;
}



//---------------------------- private function -----------------------------



@end
