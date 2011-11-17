//
//  Cell.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/27/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined(BOOL_STR)
#define BOOL_STR(B)	(B == YES ? @"Y" : @"N")
#endif

@interface Cell : NSObject {
@private
    
    BOOL on;
    NSColor *color;
    
}

@property (getter = isOn) BOOL on;
@property (assign) NSColor *color;

+(Cell *) parseCellDefinition: (NSString *) cellDefinition;
-(void) copyState: (Cell *) fromCell;
-(Cell *) defaultState;

@end
