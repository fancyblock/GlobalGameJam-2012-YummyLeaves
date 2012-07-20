//
//  LogoTask.m
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogoTask.h"
#import "TaskSet.h"

@implementation LogoTask


- (void)onBegin
{
    m_bg = [[GraphicFactory sharedInstance] CreateSprite:@"ggj2012logo.png"];
    
    [m_bg SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
    m_time = 0.0f;
    
    // initial the sound
    [TaskSet sharedInstance]._touchSE = [[SoundManager sharedInstance] LoadSound:@"wrong.wav"];
    [TaskSet sharedInstance]._eatSE = [[SoundManager sharedInstance] LoadSound:@"eat.wav"];
    [TaskSet sharedInstance]._matchSE = [[SoundManager sharedInstance] LoadSound:@"right.wav"];
    [TaskSet sharedInstance]._bgm = [[SoundManager sharedInstance] LoadSound:@"bgm.mp3"];
    
}

- (void)onEnd
{
    [m_bg release];
    [[RenderCore sharedInstance] CleanTextures];
}

- (void)onFrame:(float)elapse
{
    m_time += 0.1f;
    
    if( m_time > 15.0f )
    {
        [self Stop];
        
        [[TaskSet sharedInstance]._beginTask Start];
    }
}

- (void)onDraw:(float)elapse
{
    [m_bg DrawAt:CGPointMake(0, 0) withSize:CGPointMake(320, 480)];
}


@end
