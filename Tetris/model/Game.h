//
//  DetrisGame.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/16/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../view/GameFieldView.h"
#import "GameField.h"
#import "GameScore.h"
#import "CurrentShape.h"

@class GameFieldView;

@interface Game : NSObject {
@private
    NSTimer *ticker;
    BOOL paused;
    GameField *localField;
    GameScore *localScore;
    
    NSArray *shapesRepo;
    CurrentShape *currentShape;
    GameFieldView *fieldView;
}

@property (assign) NSTimer *ticker;
@property (getter = isPaused) BOOL paused;
@property (assign) GameField *localField;
@property (assign) GameScore *localScore; 
@property (assign) NSArray *shapesRepo;
@property (assign) CurrentShape *currentShape;
@property (assign) GameFieldView *fieldView;

+(Game *) defaultGameConfig;

-(BOOL) moveCurrentShapeDown;
-(BOOL) moveCurrentShapeLeft;
-(BOOL) moveCurrentShapeRight;
-(BOOL) rotateCurrentShapeCW_90;
-(BOOL) rotateCurrentShapeCCW_90;
-(void) dropCurrentShape;

-(id) start;
-(id) pause;
-(id) resume;
-(id) stop;

@end
