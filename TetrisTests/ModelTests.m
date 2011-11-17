//
//  ModelTests.m
//  Detris
//
//  Created by Aleksandr Shneyderman on 9/16/11.
//  Copyright 2011 AdNovum. All rights reserved.
//

#import "ModelTests.h"
#import "Shape.h"
#import "GameField.h"

@implementation ModelTests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
}
 
- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testGameFieldCreation
{
    GameField *field = [GameField parseRowDescriptions:[NSArray arrayWithObjects: 
                                                          @"red:-:-:-"  // 0
                                                        , @"-:-:-:-"    // 1
                                                        , @"-:-:-:-"    // 2
                                                        , @"-:-:-:-"    // 3 
                                                        , @"-:-:-:-"    // 4
                                                        , @"-:-:-:-"    // 5
                                                        , @"-:-:-:-"    // 6
                                                        , @"-:-:-:-"    // 7
                                                        , @"-:-:-:-"    // 8
                                                        , nil]];
    NSUInteger nine = 9;
    NSUInteger four = 4;
    
    STAssertEquals( nine, [field height], @"Height has to be 9 but was %d", [field height]);
    STAssertEquals( four, [field width], @"Width has to be 4 but was %d", [field width]);

    Cell * cell_0_0 = [field getCellAtX:0 andY:0];
    STAssertTrue(cell_0_0.isOn, @"Cell at 0,0 has to be on" );
    STAssertEquals(cell_0_0.color, [NSColor redColor], @"Cell at 0,0 has to be red but was %@ instead",cell_0_0.color );

}

- (void)testShapeCreation
{
    Shape *shape = [Shape parseRowDescriptions:[NSArray arrayWithObjects: @"green:-:-",
                                                                          @"green:-:-",
                                                                          @"green:green:green",nil]];

    STAssertTrue([shape width] == 3, @"Shape has to be 3 cells wide but was %d\n", [shape width]);
    STAssertTrue([shape height] == 3, @"Shape has to be 3 cells high but was %d\n", [shape height]);
}

//-(void) testRand
//{
//    //unsigned range[] = { 0, 1, 3, 4 };
//    int no_0 = 0;
//    int no_1 = 0;
//    int no_2 = 0;
//    int no_3 = 0;
//    int no_4 = 0;
//    int no_other = 0;
//
//    for(int count = 0; count < 100; count++)
//    {
//        int temp = rand() / (RAND_MAX / 4);
//        if( temp < 0 || temp > 4 ) no_other++;
//        if( temp == 0 ) no_0++;
//        if( temp == 1 ) no_1++;
//        if( temp == 2 ) no_2++;
//        if( temp == 3 ) no_3++;
//        if( temp == 4 ) no_4++;
//    }    
//    
//    NSLog(@"count of 0: %d\n count of 1: %d\n count of 2: %d\n count of 3: %d\n count of 4: %d\n count of others: %d", no_0, no_1, no_2, no_3, no_4, no_other );
//}

@end
