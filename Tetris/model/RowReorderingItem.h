//
//  RowEliminationItem.h
//  Detris
//
//  Created by Aleksandr Shneyderman on 10/3/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RowReorderingItem : NSObject {
@private
    
    int rangeStart;
    int rangeEnd;
    int moveToRow;
    
}

@property int rangeStart;
@property int rangeEnd;
@property int moveToRow;

@end
