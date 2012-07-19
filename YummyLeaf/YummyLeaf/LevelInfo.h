//
//  LevelInfo.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelInfo : NSObject

@property (nonatomic, readwrite) float _rotateSpeed;
@property (nonatomic, readwrite) float _epsion;
@property (nonatomic, readwrite) float _aimAngle;

@property (nonatomic, readwrite) int _leafCnt;
@property (nonatomic, readwrite) int _matchLeafType;
@property (nonatomic, retain) NSMutableArray* _subLeaves;

@end
