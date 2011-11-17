//
//  DetrisShape.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

/*
A shape object is a representation of the falling shape in the game. 
It has its own coordinate system very similar to taht of the field object
where corners have coordinates that end with .5 and the middle of the cell
has a discrete valued coordinate. This is explained better by the ASCII art
below.
 
width = 2
height = 3
center = ( 1, 2 )
spinAgnle = 0
 
    0.5 1.5 2.5 3.5
       1   2   3
3.5      * - * - *
3        |   |   |
2.5      * - * - *
2        | + |
1.5      * - *
1        |   |
0.5      * - *
 
width = 2
height = 2
center = ( 1.5, 1.5 ) 
spinAngle = 0
 
    0.5 1.5 2.5
       1   2
2.5  * - * - *
2    |   |   |
1.5  * - + - *
1    |   |   |
0.5  * - * - *
 
Each figure defines its center coordinate, the coordinate around which 
the given shape will rotate. This is how the first figure will look like 
if rotated clock-wise:

width = 2
height = 3
center = ( 1, 2 )
spinAgnle = -90
 
    0.5 1.5 2.5 3.5
       1   2   3
3.5  
3    
2.5  * - * - * - *
2    |   | + |   |
1.5  * - * - * - *
1            |   |
0.5          * - *

And here is the counter clock-wise rotation:
width = 2
height = 3
center = ( 1, 2 )
spinAgnle = 90

 
    0.5 1.5 2.5 3.5
       1   2   3
3.5  * - *
3    |   |
2.5  * - * - * - *
2    |   | + |   |
1.5  * - * - * - *
1            
0.5          
 
 
*/

@interface Shape : NSObject {
@private
    
    NSMutableArray *cells;
    CGPoint center;

}

@property (assign) NSMutableArray *cells;
@property CGPoint center;

+(Shape *) parseRowDescriptions: (NSArray *)rowDescriptions;

-(Cell *) getCellAtX: (NSUInteger) xCoord
                andY: (NSUInteger) yCoord;

-(NSUInteger) width;
-(NSUInteger) height;

@end
