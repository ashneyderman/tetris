//
//  DetrisScore.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameScore : NSObject {
@private
    int numberOfSingles;
    int numberOfDoubles;
    int numberOfTripples;
    int numberOfQuads;
}

@property int numberOfSingles;
@property int numberOfDoubles;
@property int numberOfTripples;
@property int numberOfQuads;

-(int) singleNumberScore;

@end
