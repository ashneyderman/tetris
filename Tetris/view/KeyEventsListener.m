//
//  KeyEventsListener.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/21/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "KeyEventsListener.h"


@implementation KeyEventsListener

@synthesize gameModel;

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)keyDown:(NSEvent *)theEvent
{
    switch( [theEvent keyCode] )
    {
        case 123: // arrow left
            [gameModel moveCurrentShapeLeft];
            break;
            
        case 124: // arrow right
            [gameModel moveCurrentShapeRight];
            break; 
            
        case 125: // arrow down
            [gameModel rotateCurrentShapeCW_90];
            break;
            
        case 126: // arrow up
            [gameModel rotateCurrentShapeCCW_90];
            break;
            
        case 49: // space bar
            if( gameModel.paused == NO )
            {
                [gameModel pause];
            }
            else
            {
                [gameModel resume];
            }
            break;
    }
    
}

@end
