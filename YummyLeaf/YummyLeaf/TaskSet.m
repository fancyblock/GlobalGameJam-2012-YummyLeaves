//
//  TaskSet.m
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskSet.h"

@implementation TaskSet

static TaskSet* m_instance = nil;

@synthesize _endTask;
@synthesize _gameTask;
@synthesize _logoTask;
@synthesize _beginTask;

@synthesize _curLevel;
@synthesize _rotateSpeed;

@synthesize _touchSE;



+ (TaskSet*)sharedInstance
{
    if( m_instance == nil )
    {
        m_instance = [[TaskSet alloc] init];
    }
    
    return m_instance;
}

@end
