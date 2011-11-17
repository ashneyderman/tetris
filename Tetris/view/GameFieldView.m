//
//  FieldView.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/21/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "GameFieldView.h"
#import "../model/Game.h"
#import "../model/Shape.h"
#import "../model/Cell.h"

@implementation GameFieldView

@synthesize gameModel;

- (id)initWithFrame:(NSRect)frame
{
    NSBox *result = [super initWithFrame:frame];
    
    [result setBorderColor:[NSColor grayColor]];
    [result setBorderType: NSGrooveBorder];
    
    return result;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self redraw];
}

- (void)redraw
{
    //NSLog( @"--------------------------------------------------------------------" );
    NSRect bounds = [self bounds];
    [[NSColor windowBackgroundColor] set];
	NSRectFill(bounds);
    
    NSUInteger noOfCellsLong = [[gameModel localField] height] + 5;
    NSUInteger noOfCellsWide = [[gameModel localField] width];
    
    CGFloat cellWidth  = bounds.size.width / noOfCellsWide;
    CGFloat cellHeight = bounds.size.height / noOfCellsLong;
    CGFloat cellSize = floor(MIN( cellWidth, cellHeight ));
    
    [[NSColor grayColor] set];
    NSFrameRect(NSMakeRect(0, 0, cellSize * noOfCellsWide, cellSize * noOfCellsLong));
    
    // draw the field's data
    GameField *gameField = [gameModel localField]; 
    for( int y = 0; y < [gameField height]; y++)
    {
        for( int x = 0; x < [gameField width]; x++ )
        {
            Cell *cell_x_y = [gameField getCellAtX:x andY:y];
            if(cell_x_y.isOn )
            {
                NSRect cellRect = NSMakeRect( x * cellSize, y * cellSize, cellSize, cellSize );
                [cell_x_y.color set];
                NSRectFill(cellRect);
            }
        }
    }
    
    // draw currently falling shape
    if( gameModel.currentShape == nil )
    {
        return;
    }
    
    CurrentShape *currentShape = gameModel.currentShape;
    //NSLog( @"......................" );
    //NSLog( @"spinAngle: %ld; sin: %f; cos: %f;", currentShape.spinAngle, 
    //                                             sin(((double) currentShape.spinAngle) * 3.14159265 / (double) 180), 
    //                                             cos(((double) currentShape.spinAngle) * 3.14159265 / (double) 180));
    Shape *shapeContent = currentShape.shape;
    for( NSUInteger y = 0; y < [shapeContent height]; y++ )
    {
        for( NSUInteger x = 0; x < [shapeContent width]; x++ )
        {
            Cell *cell_x_y = [shapeContent getCellAtX:x andY:y];
            if( cell_x_y.isOn )
            {
                CGPoint trCoord = [ currentShape transformCellAtX:x
                                                             andY:y ];
                
                NSRect cellRect = NSMakeRect( trCoord.x * cellSize, 
                                              trCoord.y * cellSize, 
                                              cellSize, 
                                              cellSize );
                [cell_x_y.color set];
                NSRectFill(cellRect);    
            }
        }
    }
}

@end
