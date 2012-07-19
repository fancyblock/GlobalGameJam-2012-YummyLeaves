//
//  LevelInfo.m
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelInfo.h"

@implementation LevelInfo

@synthesize _epsion;
@synthesize _leafCnt;
@synthesize _aimAngle;
@synthesize _subLeaves;
@synthesize _rotateSpeed;
@synthesize _matchLeafType;

- (id)init
{
    [super init];
    
    self._rotateSpeed = 0.015f;
    self._epsion = 0.08f;
    self._aimAngle = 0.0f;
    self._leafCnt = 0;
    self._matchLeafType = 0;
    self._subLeaves = [[NSMutableArray alloc] init];
    
    return self;
}

@end
