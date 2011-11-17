//
//  CurrentShape.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/25/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "CurrentShape.h"

@implementation CurrentShape

@synthesize shape, coords, spinAngle;

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    [shape release];
    [super dealloc];
}

-(NSString *) description
{
    return [[NSString alloc] initWithFormat:@"x:%f, y:%f, angle:%d", coords.x, coords.y, spinAngle];
}

+(CurrentShape *) withShape:(Shape *) shape
                         at:(CGPoint) coords
                       with:(NSUInteger) spingAngle
{
    CurrentShape *result = [[CurrentShape alloc] autorelease];
    
    result.shape = shape;
    result.coords = coords;
    result.spinAngle = spingAngle;
    
    return result;
}

+(CurrentShape *) withShape:(Shape *) shape
                         at:(CGPoint) coords
{
    CurrentShape *result = [CurrentShape alloc];
    
    result.shape = shape;
    result.coords = coords;
    result.spinAngle = 0;
    
    return result;
}

-(NSUInteger) rotateClockWise_90
{
    NSUInteger oldAngle = self.spinAngle;
    self.spinAngle = (oldAngle - 90);
    return oldAngle;
}

-(NSUInteger) rotateCounterClockWise_90
{
    NSUInteger oldAngle = self.spinAngle;
    self.spinAngle = (oldAngle + 90);
    return oldAngle;
}

-(CGPoint) moveRight
{
    CGPoint oldPoint = self.coords;
    CGPoint newPoint = { oldPoint.x + 1, oldPoint.y };
    self.coords = newPoint;
    return oldPoint;
}

-(CGPoint) moveLeft
{
    CGPoint oldPoint = self.coords;
    CGPoint newPoint = { oldPoint.x - 1, oldPoint.y };
    self.coords = newPoint;
    return oldPoint;
}

-(CGPoint) moveDown
{
    CGPoint oldPoint = self.coords;
    CGPoint newPoint = { oldPoint.x, oldPoint.y - 1 };
    self.coords = newPoint;
    return oldPoint;
}

-(CGPoint) transformCellAtX: (CGFloat) x
                       andY: (CGFloat) y
                 withCoords: (CGPoint) argCoords
                   andAngle: (NSInteger) argSpinAngle
{
    CGPoint result = { argCoords.x + x, argCoords.y + y };
    
    /*
     
     result = T * [ p - center ] + center
     
                -             -
               |  cos_Q  sin_Q |    
     where T = |               |
               | -sin_Q  cos_Q |
                -             -
     
              -   -
             |  x  |
     and p = |     |
             |  y  |
              -   -
     
     */
    
    CGPoint center = self.shape.center;
    
    double sin_Q = sin(((double) argSpinAngle) * PI / (double) 180);
    double cos_Q = cos(((double) argSpinAngle) * PI / (double) 180);
    
    double delta_X = x - center.x;
    double delta_Y = y - center.y;
    
    result.x = nearbyint( cos_Q * delta_X - sin_Q * delta_Y + center.x + argCoords.x );
    result.y = nearbyint( sin_Q * delta_X + cos_Q * delta_Y + center.y + argCoords.y );
    
    return result;    
}

-(CGPoint) transformCellAtX: (CGFloat) x
                       andY: (CGFloat) y
{
    return [self transformCellAtX:x
                             andY:y
                       withCoords:self.coords
                         andAngle:self.spinAngle];
}

@end
