//
//  Room.h
//  UIRPGController
//
//  Created by Sean on 10/8/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"
#import "GameAssistant.h"

@interface Room : NSObject

@property (nonatomic,strong) NSMutableArray *enemies;
@property (nonatomic,strong) NSString *surveyDescription;

extern NSString * const ROOM_SAVE_STRING;

// via http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
- (id)initWithRandomEnemies;
+ (void)saveRoom:(id)object key:(NSString *)key;
+ (id)loadRoomWithKey:(NSString *)key;
+ (void)deleteRoomWithKey:(NSString *)key;
- (BOOL)canExit;

@end
