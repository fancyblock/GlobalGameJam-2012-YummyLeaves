//
//  LevelFactory.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelInfo.h"

@interface LevelFactory : NSObject
{
    //TODO 
}

+ (LevelFactory*)sharedInstance;

- (LevelInfo*)CreateLevel:(int)level;

@end
