//
//  PlayField.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "GameField.h"
#import "RowReorderingItem.h"

@implementation GameField

@synthesize cells;

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    [super dealloc];
}

+(GameField *) parseRowDescriptions: (NSArray *)rowDescriptions
{
    if( rowDescriptions == nil || [rowDescriptions count] == 0 )
    {
        return nil;
    }
    
    GameField *result = [GameField alloc];
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

-(BOOL) coordIsOutOfBounds: (CGPoint) coord
{
    if( nearbyint( coord.x ) < [self minX] ||
        nearbyint( coord.x ) > [self maxX] )
    {
        return YES;
    }
    
    if( nearbyint( coord.y ) < [self minY] )
    {
        return YES;
    }
    
    return NO;
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

-(void) copyCellStateToX: (NSUInteger) xCoord
                    andY: (NSUInteger) yCoord
                fromCell: (Cell *) fromCell
{
    Cell *toCell = [self getCellAtX:xCoord andY:yCoord];
    [toCell copyState:fromCell];
}

-(BOOL) isFilledRow: (int) rowIdx
{
    NSMutableArray *rowCells = [self.cells objectAtIndex:rowIdx];
    
    for( int idx = 0; idx < [rowCells count]; idx++ )
    {
        if( ![(Cell *) [rowCells objectAtIndex:idx] isOn] )
        {
            return NO;
        }
    }
    
    return YES;
}

-(NSArray *) rowReorderingPlan
{
    RowReorderingItem *prevItem = nil;
    RowReorderingItem *currentItem = nil;
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:([self.cells count] / 2)];
    
    for( int rowIdx = 0; rowIdx < [self.cells count]; rowIdx++ )
    {
        BOOL isFullRow = [self isFilledRow: rowIdx]; 
        if( isFullRow && prevItem == nil )
        {
            prevItem = [RowReorderingItem alloc];
            prevItem.rangeStart = rowIdx;
            prevItem.rangeEnd = rowIdx;
        }
        else if( isFullRow && prevItem != nil )
        {
            prevItem.rangeEnd = rowIdx;
        }
        else if( !isFullRow && prevItem != nil )
        {
            currentItem = [RowReorderingItem alloc];
            currentItem.moveToRow = prevItem.rangeStart;
            currentItem.rangeStart = rowIdx;
            currentItem.rangeEnd = rowIdx;
            
            [prevItem dealloc];
            prevItem = nil;
            
            [result addObject: currentItem];
        }
        else if( !isFullRow && prevItem == nil )
        {
            currentItem.rangeEnd = rowIdx;
        }
    }
    
    if( [result count] == 0 )
    {
        [result dealloc];
        return nil;
    }
    
    return result;
}

-(void) eliminateFilledRows
{
    NSArray *rowReorderingPlan = [self rowReorderingPlan];
    if ( rowReorderingPlan == nil ) 
    {
        return;
    }
    
    for( int i = 0; i < [rowReorderingPlan count]; i++ )
    {
        NSLog(@"%@", [rowReorderingPlan objectAtIndex:i]);
    }
    
    int totalRowsToBlankOut = 0;
    for( int rowReorderingItemIdx = 0; rowReorderingItemIdx < [rowReorderingPlan count]; rowReorderingItemIdx++ )
    {
        RowReorderingItem *item = [rowReorderingPlan objectAtIndex: rowReorderingItemIdx];
        totalRowsToBlankOut += (item.rangeEnd - item.rangeStart + 1);
        
        for( int rowIdx = 0; rowIdx < (item.rangeEnd - item.rangeStart + 1); rowIdx++)
        {
            NSMutableArray *toRow = [self.cells objectAtIndex:(rowIdx + item.moveToRow)];
            NSMutableArray *fromRow = [self.cells objectAtIndex:(rowIdx + item.rangeStart)];
            for( int cellIdx = 0; cellIdx < [toRow count]; cellIdx++ )
            {
                [(Cell *) [toRow objectAtIndex:cellIdx] copyState: [fromRow objectAtIndex:cellIdx]];
            }
        }
    }

    // at the end we need to blank out all the rows on the top. The number of 
    // rows to blank out is exactly the number of rows we eliminated.
    int totalRows = (int) [self.cells count];
    for( int idx = 0; idx < totalRowsToBlankOut; idx++ )
    {
        NSMutableArray *rowCells = [self.cells objectAtIndex:(totalRows - idx - 1)];
        for(int cellIdx = 0; cellIdx < [rowCells count]; cellIdx++ )
        {
            [(Cell *) [rowCells objectAtIndex:cellIdx] defaultState];
        }
    }
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

-(CGFloat) minX
{
    return -0.5;
}

-(CGFloat) maxX
{
    return ((CGFloat) ([self width] - 0.5));
}

-(CGFloat) minY
{
    return 0;
}

-(CGFloat) maxY
{
    return ((CGFloat) [self height]);
}

-(NSString *) description
{
    return [[NSString alloc] initWithFormat: @"field %@", self.cells];
}

@end
