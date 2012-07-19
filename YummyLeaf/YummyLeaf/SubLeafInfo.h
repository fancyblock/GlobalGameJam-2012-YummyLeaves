//
//  SubLeafInfo.h
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubLeafInfo : NSObject

@property (nonatomic, readwrite) int _type;
@property (nonatomic, readwrite) int _offset;
@property (nonatomic, readwrite) int _u;
@property (nonatomic, readwrite) int _v;
@property (nonatomic, retain) NSString* _res;

@end
