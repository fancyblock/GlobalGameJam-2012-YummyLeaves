//
//  ProgressUI.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressUI : NSObject
{
    int m_mark;
    
    //TODO 
}

- (void)Update:(float)elapse;

- (void)Draw:(CGPoint)pos;

- (void)SetMark:(int)mark;

@end
