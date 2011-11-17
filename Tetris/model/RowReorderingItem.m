//
//  RowEliminationItem.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 10/3/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "RowReorderingItem.h"


@implementation RowReorderingItem

@synthesize rangeStart, rangeEnd, moveToRow;

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    [super dealloc];
}

-(NSString *) description
{
    return [[NSString alloc] initWithFormat:@"moveTo: %d, block [%d - %d]", self.moveToRow, self.rangeStart, self.rangeEnd];
    
}

@end
