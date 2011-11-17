//
//  DetrisAppDelegate.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/14/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "view/GameFieldView.h"

@interface ApplicationDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    GameFieldView *fView;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet GameFieldView *fView;

@end
