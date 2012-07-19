//
//  TaskSet.h
//  HIFramework
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIFramework.h"
#import "LevelInfo.h"

#define _angleInterval 0.262f;
#define _matchEpsion 0.04f;


@interface TaskSet : NSObject
{
    //TODO 
}

+ (TaskSet*)sharedInstance;

@property (nonatomic, retain) Task* _logoTask;
@property (nonatomic, retain) Task* _beginTask;
@property (nonatomic, retain) Task* _gameTask;
@property (nonatomic, retain) Task* _endTask;

@property (nonatomic, retain) LevelInfo* _curLevel;
@property (nonatomic, readwrite) float _rotateSpeed;

@property (nonatomic, readwrite) int _touchSE;
@property (nonatomic, readwrite) int _matchSE;
@property (nonatomic, readwrite) int _eatSE;
@property (nonatomic, readwrite) int _bgm;

@end
