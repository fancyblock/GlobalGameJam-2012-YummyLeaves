//
//  LevelFactory.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelInfo.h"
#import "SubLeafInfo.h"

#define MAX_LEAF    20


@interface LevelFactory : NSObject
{
    NSMutableArray* m_resLib;
    int m_uLib[MAX_LEAF];
    int m_vLib[MAX_LEAF];
}

+ (LevelFactory*)sharedInstance;

- (LevelInfo*)CreateLevel:(int)level;

- (SubLeafInfo*)CreateSubLeaf:(int)type;

@end
