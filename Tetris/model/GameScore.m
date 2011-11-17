//
//  DetrisScore.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "GameScore.h"

@implementation GameScore

@synthesize numberOfSingles, numberOfDoubles, numberOfTripples, numberOfQuads;

- (id)init
{
    self = [super init];
    
    if (self) 
    {
        self.numberOfSingles = 0;
        self.numberOfDoubles = 0;
        self.numberOfTripples = 0;
        self.numberOfQuads = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(int) singleNumberScore
{
    return (self.numberOfSingles * 5  + self.numberOfSingles) + 
           (self.numberOfDoubles * 15 + self.numberOfDoubles) +
           (self.numberOfDoubles * 25 + self.numberOfDoubles) + 
           (self.numberOfDoubles * 35 + self.numberOfDoubles);
}

@end
