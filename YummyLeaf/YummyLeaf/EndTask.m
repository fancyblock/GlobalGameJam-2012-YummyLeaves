//
//  EndTask.m
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EndTask.h"
#import "TaskSet.h"

@implementation EndTask

- (void)onBegin
{
    m_bg = [[GraphicFactory sharedInstance] CreateSprite:@"gameover.png"];
    [m_bg SetUVFrom:CGPointMake(0, 0) to:CGPointMake(1, 1)];
}

- (void)onEnd
{
    [m_bg release];
    [[RenderCore sharedInstance] CleanTextures];
}

- (void)onFrame:(float)elapse
{
    //TODO 
}

- (void)onDraw:(float)elapse
{
    [m_bg DrawAt:CGPointMake(0, 0) withSize:CGPointMake(320, 480)];
}

- (BOOL)onTouchEvent:(NSArray*)events
{
    TouchEvent* evt = [events objectAtIndex:0];
    
    if( evt.TOUCH_TYPE == UNTOUCH )
    {
        [self Stop];
        [[TaskSet sharedInstance]._beginTask Start];
        
        [[SoundManager sharedInstance] PlaySound:[TaskSet sharedInstance]._touchSE withLoop:1];
        
        return YES;
    }
    
    return NO;
}

@end
