//
//  CurrentShape.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/25/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

#define PI 3.14159265

@interface CurrentShape : NSObject {
@private
    
    Shape *shape;
    NSInteger spinAngle;
    CGPoint coords;
    
}

@property (assign) Shape *shape;
@property NSInteger spinAngle;
@property CGPoint coords;

+(CurrentShape *) withShape:(Shape *) shape
                         at:(CGPoint) coords;

-(NSUInteger) rotateClockWise_90;
-(NSUInteger) rotateCounterClockWise_90;
-(CGPoint) moveRight;
-(CGPoint) moveLeft;
-(CGPoint) moveDown;

-(CGPoint) transformCellAtX: (CGFloat) x
                       andY: (CGFloat) y;

-(CGPoint) transformCellAtX: (CGFloat) x
                       andY: (CGFloat) y
                 withCoords: (CGPoint) argCoords
                   andAngle: (NSInteger) argSpinAngle;

//-(NSArray *) busyCellCoords;

@end
