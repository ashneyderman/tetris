//
//  PlayField.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
#import "Cell.h"

/*
 
13.5 * - * - * - * - * - * - * - * - * - * - * - * 
13   |   |   |   |   |   |   |   |   |   |   |   |
12.5 * - * - * - * - * - * - * - * - * - * - * - *
12   |   |   |   |   |   |   |   |   |   |   |   |
11.5 * - * - * - * - * - * - * - * - * - * - * - *
11   |   |   |   |   |   |   |   |   |   |   |   |
10.5 * - * - * - * - * ~ * ~ * - * - * - * - * - *
10   |   |   |   |   \ = \ = \   |   |   |   |   |
9.5  * - * - * - * - * ~ * ~ * - * - * - * - * - *
9    |   |   |   |   \ + \   |   |   |   |   |   |
8.5  * - * - * - * - * ~ * - * - * - * - * - * - *
8    |   |   |   |   \ = \   |   |   |   |   |   |
7.5  * - * - * - * - * ~ * - * - * - * - * - * - *
7    |   |   |   |   |   |   |   |   |   |   |   |
6.5  * - * - * - * - * - * - * - * - * - * - * - *
6    |   |   |   |   |   |   |   |   |   |   |   |
5.5  * - * - * - * - * - * - * - * - * - * - * - *
5    |   |   |   |   |   |   |   |   |   |   |   |
4.5  * - * - * - * - * - * - * - * - * - * - * - *
4    |   |   |   |   |   |   |   |   |   |   |   |
3.5  * - * - * - * - * - * - * - * - * - * - * - *
3    |   |   |   |   |   |   |   |   |   |   |   |
2.5  * - * - * - * - * - * - * - * - * - * - * - *
2    |   |   |   |   |   |   |   |   |   |   |   |
1.5  * - * - * - * - * - * - * - * - * - * - * - *
1    |   |   |   |   |   |   |   |   |   |   |   |
.5   * - * - * - * - * - * - * - * - * - * - * - *
0    |   |   |   |   |   |   |   |   |   |   |   |
-.5  * - * - * - * - * - * - * - * - * - * - * - *
       0   1   2   3   4   5   6   7   8   9   10 
    -.5 0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 

 
The figure coordinates are then the coordinates of its
center and in this particular case are (4, 9)
 
 */
@interface GameField : NSObject {
@private

    // content
    NSMutableArray *cells;
    
}

+(GameField *) parseRowDescriptions: (NSArray *)rowDescriptions;

-(BOOL) coordIsOutOfBounds: (CGPoint) coord;
                                    
-(Cell *) getCellAtX: (NSUInteger) xCoord
                andY: (NSUInteger) yCoord;

-(void) copyCellStateToX: (NSUInteger) xCoord
                    andY: (NSUInteger) yCoord
                fromCell: (Cell *) fromCell;

-(void) eliminateFilledRows;

-(NSUInteger) height;
-(NSUInteger) width;

-(CGFloat) minX;
-(CGFloat) maxX;
-(CGFloat) minY;
-(CGFloat) maxY;

@property (assign) NSMutableArray *cells;

@end
