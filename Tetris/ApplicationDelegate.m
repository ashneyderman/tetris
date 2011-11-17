//
//  DetrisAppDelegate.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "ApplicationDelegate.h"
#import "model/Game.h"
#import "view/KeyEventsListener.h"

@implementation ApplicationDelegate

@synthesize window, fView;

-(void)awakeFromNib 
{
    KeyEventsListener *keyListener = [KeyEventsListener alloc];
    [[self window] makeFirstResponder: keyListener];
    
    Game *game = [Game defaultGameConfig];
    [[self fView] setGameModel:game];
    [game setFieldView: fView];
    keyListener.gameModel = game;
    [game start];
}

@end
