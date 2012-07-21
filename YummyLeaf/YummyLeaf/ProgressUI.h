//
//  ProgressUI.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIFramework.h"

@interface ProgressUI : NSObject
{
    int m_mark;
    
    Sprite* m_sandglass;
    Sprite* m_leftBar;
    Sprite* m_rightBar;
    MovieClip* m_snake;
}

- (void)Update:(float)elapse;

- (void)Draw:(CGPoint)pos;

- (void)SetMark:(int)mark;

@end
