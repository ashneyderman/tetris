//
//  KeyEventsListener.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/21/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../model/Game.h"

@interface KeyEventsListener : NSResponder {
@private
    
    Game *gameModel;
    
}

@property (assign) Game *gameModel;

- (void)keyDown:(NSEvent *)theEvent;

@end
