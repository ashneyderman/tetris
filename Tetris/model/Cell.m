//
//  Cell.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/27/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "Cell.h"

@implementation Cell

@synthesize on, color;

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    self.color = nil;
    [super dealloc];
}

+(Cell *) parseCellDefinition: (NSString *) cellDefinition
{
    if( cellDefinition == nil )
    {
        return nil;
    }
    
    Cell *result = [Cell alloc];
    if( [@"red" isEqualToString: cellDefinition] )
    {
        result.color = [NSColor redColor];
        result.on = YES;
    }
    else if( [@"green" isEqualToString: cellDefinition] )
    {
        result.color = [NSColor greenColor];
        result.on = YES;
    }
    else if( [@"blue" isEqualToString: cellDefinition] )
    {
        result.color = [NSColor blueColor];
        result.on = YES;
    }
    else
    {
        result.color = [NSColor windowBackgroundColor];
        result.on = NO;
    }
    
    return result;
}

-(void) copyState: (Cell *) fromCell
{
    self.color = fromCell.color;
    self.on = fromCell.isOn;
}

-(Cell *) defaultState
{
    self.color = [NSColor windowBackgroundColor];
    self.on = NO;
    
    return self;
}

-(NSString *) description
{
    return [[NSString alloc] initWithFormat:@"colors: %@/%@", self.color, BOOL_STR(self.isOn) ];
}

@end
