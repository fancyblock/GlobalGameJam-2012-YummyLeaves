//
//  LevelFactory.m
//  YummyLeaf
//
//  Created by He jia bin on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelFactory.h"
#import "stdlib.h"

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


- (id)init
{
    [super init];
    
    m_resLib = [[NSMutableArray alloc] init];
    
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"snake_head_leaf.png"];
    [m_resLib addObject:@"deco.png"];
    
    m_uLib[0] = 119; m_vLib[0] = 67;
    m_uLib[1] = 153; m_vLib[1] = 67;
    m_uLib[2] = 187; m_vLib[2] = 67;
    m_uLib[3] = 221; m_vLib[3] = 67;
    m_uLib[4] = 119; m_vLib[4] = 133;
    m_uLib[5] = 153; m_vLib[5] = 133;
    m_uLib[6] = 187; m_vLib[6] = 133;
    m_uLib[7] = 221; m_vLib[7] = 133;
    m_uLib[8] = 449; m_vLib[8] = 0;
    
    return self;
}


- (LevelInfo*)CreateLevel:(int)level
{
    srand( time(NULL) );
    
    LevelInfo* levelInfo = [[LevelInfo alloc] init];
    
    NSMutableArray* subleavesList = [[NSMutableArray alloc] init];
    levelInfo._subLeaves = subleavesList;
    [subleavesList release];
    levelInfo._leafCnt = 0;
    levelInfo._aimAngle = (float)(rand()) / (float)(RAND_MAX);
    
    SubLeafInfo* subLeaf = nil;
    for( int i = 0; i < 23; i++ )
    {
        if( (float)(rand()) / (float)(RAND_MAX) > 0.25f )
        {
            subLeaf = [self CreateSubLeaf:( rand() % 9 )];
            [levelInfo._subLeaves addObject:subLeaf];
            subLeaf._offset = i;
            
            [subLeaf release];
            levelInfo._leafCnt++;
        }
    }
    
    subLeaf = [levelInfo._subLeaves objectAtIndex:rand() % levelInfo._leafCnt];
    levelInfo._matchLeafType = subLeaf._type;
    
    return levelInfo;
}


- (SubLeafInfo*)CreateSubLeaf:(int)type
{
    SubLeafInfo* leafInfo = [[SubLeafInfo alloc] init];
    
    leafInfo._type = type;
    leafInfo._offset = 0;
    leafInfo._res = [m_resLib objectAtIndex:type];
    leafInfo._u = m_uLib[type];
    leafInfo._v = m_vLib[type];
    
    return leafInfo;
}


@end
