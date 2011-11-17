//
//  DetrisShape.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "Shape.h"
#import "Cell.h"

@implementation Shape

@synthesize cells, center;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    self.cells = nil;
    [super dealloc];
}

+(Shape *) parseRowDescriptions: (NSArray *)rowDescriptions
{
    if( rowDescriptions == nil || [rowDescriptions count] == 0 )
    {
        return nil;
    }
    
    Shape *result = [Shape alloc];
    result.cells = [NSMutableArray arrayWithCapacity:[rowDescriptions count]];
    for( int idx = 0; idx < [rowDescriptions count]; idx++ )
    {
        NSArray *strCellColors = [[rowDescriptions objectAtIndex:idx] componentsSeparatedByString:@":"];
        NSMutableArray *rowOfCells = [NSMutableArray arrayWithCapacity:[strCellColors count]];
        for(int idx = 0; idx < [strCellColors count]; idx++)
        {
            [rowOfCells addObject:[Cell parseCellDefinition:[strCellColors objectAtIndex:idx]]];
        }
        
        [result.cells addObject:rowOfCells];
    }
    
    return result;
}

-(Cell *) getCellAtX: (NSUInteger) xCoord
                andY: (NSUInteger) yCoord
{
    if( self.cells == nil || [self.cells count] == 0 )
    {
        return nil;
    }
    
    if( [self.cells count] - 1 < yCoord )
    {
        return nil;
    }
    
    NSMutableArray *rowCells = [self.cells objectAtIndex: yCoord];
    
    if( rowCells == nil || [rowCells count] == 0 )
    {
        return nil;
    }
    
    if( [rowCells count] - 1 < xCoord )
    {
        return nil;
    }
    
    return [rowCells objectAtIndex: xCoord];
}

-(NSUInteger) height
{
    if( self.cells == nil )
    {
        return 0;
    }
    
    return [self.cells count];
}

-(NSUInteger) width
{
    if( self.cells == nil || [self.cells count] == 0 )
    {
        return 0;
    }
    
    return [(NSMutableArray *) [self.cells objectAtIndex:0] count];
}

@end
