//
//  TetrisAppDelegate.h
//  Tetris
//
//  Created by Aleksandr Shneyderman on 10/25/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TetrisAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
