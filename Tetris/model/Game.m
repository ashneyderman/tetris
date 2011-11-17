//
//  DetrisGame.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/16/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "Game.h"
#import "GameField.h"
#import "Shape.h"
#import "GameScore.h"

@implementation Game

@synthesize ticker, paused, localField, localScore, currentShape, shapesRepo, fieldView;

- (id)init
{
    self = [super init];
    if (self) {
        self.paused = YES;
    }
    
    return self;
}

- (void) dealloc
{
    self.localScore = nil;
    self.localField = nil;
    self.shapesRepo = nil;
    self.fieldView = nil;
    
    [super dealloc];
}

-(void) makeCurrentShapePermanentOnField
{
    if( self.currentShape == nil )
    {
        return;
    }
    
    Shape *protoShape = self.currentShape.shape;
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            Cell *cell = [protoShape getCellAtX:x andY:y];
            if( !cell.isOn )
            {    
                continue;
            }
            
            CGPoint projectedTx = [self.currentShape transformCellAtX:x 
                                                                 andY:y
                                                           withCoords:self.currentShape.coords
                                                             andAngle:self.currentShape.spinAngle];
            
            [self.localField copyCellStateToX:(NSUInteger) nearbyint(projectedTx.x)
                                         andY:(NSUInteger) nearbyint(projectedTx.y)
                                     fromCell:cell];

            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f] -> cell: %@",x,y,
            //      currentShape.coords.x, currentShape.coords.y,
            //      projectedTx.x, nearbyint(projectedTx.y),
            //      [self.localField getCellAtX:(NSUInteger) projectedTx.x
            //                             andY:projectedTx.y]);
        }
    }
}

-(void) swapCurrentShape
{
    [self makeCurrentShapePermanentOnField];
    [self.localField eliminateFilledRows];
    unsigned long idx = rand() / (RAND_MAX / [[self shapesRepo] count]);
    Shape *nextShape = (Shape *) [[self shapesRepo] objectAtIndex: idx];
    CGPoint startPoint = { [self.localField width] / 2 , [self.localField height] + floor( nextShape.center.y ) };
    [self setCurrentShape:[CurrentShape withShape:nextShape 
                                               at:startPoint]];
}

+(NSArray *) defaultShapesRepo
{
    Shape *shape0 = [Shape parseRowDescriptions:[NSArray arrayWithObjects:
                                                             @"red:green"
                                                           , @"blue:-"
                                                           , @"red:-" 
                                                           , nil]];
    CGPoint shape0_center = { 0, 1 };
    shape0.center = shape0_center;
    
    Shape *shape1 = [Shape parseRowDescriptions:[NSArray arrayWithObjects:
                                                             @"blue:red:blue"
                                                           , @"-:green:-"
                                                           , @"-:blue:-" 
                                                           , nil]];
    CGPoint shape1_center = { 1, 1 };
    shape1.center = shape1_center;
    
    Shape *shape2 = [Shape parseRowDescriptions:[NSArray arrayWithObjects:
                                                             @"blue"
                                                           , @"green"
                                                           , @"red" 
                                                           , nil]];

    CGPoint shape2_center = { 0, 1 };
    shape2.center = shape2_center;

    Shape *shape3 = [Shape parseRowDescriptions:[NSArray arrayWithObjects:
                                                             @"blue:red"
                                                           , @"red:blue"
                                                           , nil]];
    CGPoint shape3_center = { 0.5, 0.5 };
    shape3.center = shape3_center;

    return [NSArray arrayWithObjects: shape0
                                    , shape1
                                    , shape2
                                    , shape3
                                    , nil];
}

+(Game *) defaultGameConfig
{
    Game *result = [Game alloc];

    [result setLocalField:[GameField parseRowDescriptions: [NSArray arrayWithObjects: 
                                                             @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"  
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"  
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"
                                                           , @"-:-:-:-:-:-:-:-:-:-:-:-"  
                                                           , nil]]];
    [result setLocalScore:[[GameScore alloc] init]];
    [result setShapesRepo:[Game defaultShapesRepo]];
    [result swapCurrentShape];

    return result;
}

-(BOOL) canMoveCurrentShapeDown
{
    //NSLog(@"vvvvvvvvvvvvvvv");
    CGPoint projectedCoords = { currentShape.coords.x, currentShape.coords.y - 1 };
    Shape *protoShape = currentShape.shape;
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            if( ![protoShape getCellAtX:x andY:y].isOn )
            {    
                continue;
            }
            
            CGPoint projectedTx = [currentShape transformCellAtX:x 
                                                            andY:y
                                                      withCoords:projectedCoords
                                                        andAngle:currentShape.spinAngle];
            
            
            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f]",x,y,
            //                             currentShape.coords.x, currentShape.coords.y,
            //                             projectedTx.x, nearbyint(projectedTx.y));
            
            if( [ self.localField coordIsOutOfBounds:projectedTx ] )
            {
                //NSLog(@"########");
                return NO;
            }
            
            if( [ self.localField getCellAtX: (NSInteger) nearbyint( projectedTx.x )
                                        andY: (NSInteger) nearbyint( projectedTx.y )].isOn )
            {
                //NSLog(@"********");
                return NO;
            }
        }
    }
    
    return YES;
}

-(BOOL) moveCurrentShapeDown
{
    if( self.paused )
    {
        return NO;
    }
    
    if( ![self canMoveCurrentShapeDown] )
    {
        [self swapCurrentShape];
        return NO;
    }

    [self.currentShape moveDown];
    [self.fieldView setNeedsDisplay:YES];
    
    return YES;
}

-(BOOL) canMoveCurrentShapeLeft
{
    //NSLog(@"<<<<<<<<<<<<<");
    Shape *protoShape = currentShape.shape;
    CGPoint projectedCoords = { currentShape.coords.x - 1, currentShape.coords.y };
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            CGPoint projectedTx = [currentShape transformCellAtX:x 
                                                            andY:y
                                                      withCoords:projectedCoords
                                                        andAngle:currentShape.spinAngle];
            
            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f]",x,y,
            //      currentShape.coords.x, currentShape.coords.y,
            //      projectedTx.x, nearbyint(projectedTx.y));
            
            
            if( [ self.localField coordIsOutOfBounds:projectedTx ] )
            {
                //NSLog(@"no_0");
                return NO;
            }
            
            if( [ localField getCellAtX: (NSInteger) projectedTx.x
                                   andY: (NSInteger) projectedTx.y ].isOn )
            {
                //NSLog(@"no_1");
                return NO;
            }
        }
    }
    
    //NSLog(@"ok");
    return YES;
}

-(BOOL) moveCurrentShapeLeft
{
    if( self.paused )
    {
        return NO;
    }

    if( ![self canMoveCurrentShapeLeft] )
    {
        return NO;
    }

    [[self currentShape] moveLeft];
    [[self fieldView] setNeedsDisplay:YES];

    return YES;    
}

-(BOOL) canMoveCurrentShapeRight
{
    //NSLog(@">>>>>>>>>>>>>>");
    Shape *protoShape = currentShape.shape;
    CGPoint proposedCoords = { currentShape.coords.x + 1, currentShape.coords.y };
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            CGPoint projectedTx = [currentShape transformCellAtX:x 
                                                            andY:y
                                                      withCoords:proposedCoords
                                                        andAngle:currentShape.spinAngle];
            
            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f]",x,y,
            //      currentShape.coords.x, currentShape.coords.y,
            //      projectedTx.x, nearbyint(projectedTx.y));

            if( [ self.localField coordIsOutOfBounds:projectedTx ] )
            {
                //NSLog(@"no_0");
                return NO;
            }

            if( [ localField getCellAtX: (NSInteger) projectedTx.x
                                   andY: (NSInteger) projectedTx.y ].isOn )
            {
                //NSLog(@"no_1");
                return NO;
            }
        }
    }
    
    //NSLog(@"ok");
    return YES;
}

-(BOOL) moveCurrentShapeRight
{
    if( self.paused )
    {
        return NO;
    }

    if( ![self canMoveCurrentShapeRight] )
    {
        return NO;
    }

    [[self currentShape] moveRight];
    [[self fieldView] setNeedsDisplay:YES];    

    return YES;
}

-(BOOL) canRotateCurrentShapeCW_90
{
    //NSLog(@"wwwwwwwwwwwww");
    Shape *protoShape = currentShape.shape;
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            CGPoint projectedTx = [currentShape transformCellAtX:x 
                                                            andY:y
                                                      withCoords:currentShape.coords
                                                        andAngle:(currentShape.spinAngle - 90)];
            
            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f]",x,y,
            //      currentShape.coords.x, currentShape.coords.y,
            //      projectedTx.x, nearbyint(projectedTx.y));
            
            
            if( [ self.localField coordIsOutOfBounds:projectedTx ] )
            {
                //NSLog(@"no_0");
                return NO;
            }
            
            if( [ localField getCellAtX: (NSInteger) projectedTx.x
                                   andY: (NSInteger) projectedTx.y ].isOn )
            {
                //NSLog(@"no_1");
                return NO;
            }
        }
    }
    
    //NSLog(@"ok");
    return YES;
}

-(BOOL) rotateCurrentShapeCW_90
{
    if( self.paused )
    {
        return NO;
    }
    
    if( ![self canRotateCurrentShapeCW_90] )
    {
        return NO;
    } 

    [[self currentShape] rotateClockWise_90];
    [[self fieldView] setNeedsDisplay:YES];

    return YES;    
}

-(BOOL) canRotateCurrentShapeCCW_90
{
    //NSLog(@"cccccccccc");
    Shape *protoShape = currentShape.shape;
    for( NSUInteger y = 0; y < [protoShape height]; y++ )
    {
        for( NSUInteger x = 0; x < [protoShape width]; x++ )
        {
            CGPoint projectedTx = [currentShape transformCellAtX:x 
                                                            andY:y
                                                      withCoords:currentShape.coords
                                                        andAngle:(currentShape.spinAngle + 90)];
            
            //NSLog(@"x:%ld,y:%ld [%f,%f] -> [%f,%f]",x,y,
            //      currentShape.coords.x, currentShape.coords.y,
            //      projectedTx.x, nearbyint(projectedTx.y));
            
            
            if( [ self.localField coordIsOutOfBounds:projectedTx ] )
            {
                //NSLog(@"no_0");
                return NO;
            }
            
            if( [ localField getCellAtX: (NSInteger) projectedTx.x
                                   andY: (NSInteger) projectedTx.y ].isOn )
            {
                //NSLog(@"no_1");
                return NO;
            }
        }
    }
    
    //NSLog(@"ok");
    return YES;
}

-(BOOL) rotateCurrentShapeCCW_90
{
    if( self.paused )
    {
        return NO;
    }

    if( ![self canRotateCurrentShapeCCW_90] )
    {
        return NO;
    }

    [[self currentShape] rotateCounterClockWise_90];
    [[self fieldView] setNeedsDisplay:YES];

    return YES;
}

-(void) dropCurrentShape
{
    // FIXME: implement
}

-(id) start
{
    return [self resume];
}

-(id) stop
{
    [self pause];
    return self;
}

-(id) pause
{
    if( self.ticker != nil )
    {
        [self.ticker invalidate];
    }
    
    self.ticker = nil;
    self.paused = YES;
    
    return self;
}

-(id) resume
{
    self.ticker = [NSTimer scheduledTimerWithTimeInterval: 0.2 
                                                   target: self 
                                                 selector: NSSelectorFromString(@"moveCurrentShapeDown") 
                                                 userInfo: nil
                                                  repeats: YES];
    self.paused = NO;
    
    return self;
}

@end
