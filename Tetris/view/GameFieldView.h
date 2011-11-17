//
//  FieldView.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/21/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../model/Game.h"

@class Game;

@interface GameFieldView : NSBox {
@private
    Game *gameModel;
}

@property (assign) Game *gameModel;

- (void)redraw;

@end
