//
//  LevelFactory.m
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelFactory.h"

@implementation LevelFactory

static LevelFactory* m_instance = nil;


+ (LevelFactory*)sharedInstance
{
    if( m_instance == nil )
    {
        m_instance = [[LevelFactory alloc] init];
    }
    
    return m_instance;
}


- (LevelInfo*)CreateLevel:(int)level
{
    LevelInfo* levelInfo = nil;
    
    //TODO 
    
    return levelInfo;
}


@end
