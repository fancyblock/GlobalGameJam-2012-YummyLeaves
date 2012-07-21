//
//  ProgressUI.m
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProgressUI.h"

@implementation ProgressUI


- (id)init
{
    [super init];
    
    m_sandglass = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_sandglass SetUVFrom:CGPointMake(0, 183.0f/512.0f) to:CGPointMake((230.0f)/512.0f, (183.0f+54.0f)/512.0f)];
    [m_sandglass SetSize:CGPointMake(230, 54)];
    
    m_leftBar = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_leftBar SetUVFrom:CGPointMake(0, 267.0f/512.0f) to:CGPointMake(212.0f/512.0f, (267.0f+26.0f)/512.0f)];
    [m_leftBar SetSize:CGPointMake(212.0f, 26.0f)];
    
    m_rightBar = [[GraphicFactory sharedInstance] CreateSprite:@"deco.png"];
    [m_rightBar SetUVFrom:CGPointMake(0, 239.0f/512.0f) to:CGPointMake(212.0f/512.0f, (239.0f+26.0f)/512.0f)];
    
    m_snake = [[GraphicFactory sharedInstance] CreateMovieClip:@"snake_head_leaf.png" withInterval:0.3f];
    [m_snake AddFrame:CGRectMake(0, 201.0f/256.0f, 33.0f/256.0f, 33.0f/256.0f) 
           withAnchor:CGPointMake(0, 0) 
             withSize:CGPointMake(33, 33)];
    [m_snake AddFrame:CGRectMake(35.0f/256.0f, 201.0f/256.0f, 33.0f/256.0f, 33.0f/256.0f) 
           withAnchor:CGPointMake(0, 0) 
             withSize:CGPointMake(33, 33)];
    
    return self;
}

- (void)dealloc
{
    [m_sandglass release];
    [m_leftBar release];
    [m_rightBar release];
    [m_snake release];
    
    [super dealloc];
}

- (void)Update:(float)elapse
{
    [m_snake Update:elapse];
}

- (void)Draw:(CGPoint)pos
{
    int i = pos.x;
    int j = pos.y;
    
    [m_rightBar DrawAt:CGPointMake(i+9, j+10) withSize:CGPointMake(212, 29)];
    [m_leftBar DrawAt:CGPointMake(i+9, j+10) withSize:CGPointMake(i-10+m_mark*29, 29)];
    
    [m_sandglass DrawAt:CGPointMake(i, j)];
    [m_snake SetPosition:CGPointMake(i + 24 + m_mark * 29, j + 8)];
    [m_snake Draw];
}

- (void)SetMark:(int)mark
{
    m_mark = mark;
}

@end
