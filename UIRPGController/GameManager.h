//
//  GameManager.h
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"
#import "Room.h"
#import "GameAssistant.h"

@interface GameManager : NSObject

@property (nonatomic,strong) Hero *theHero;
@property (nonatomic,strong) Room *currentRoom;
@property (nonatomic) BOOL inProgress;

+ (id)sharedManager;
- (void)createNewGameWithHero:(Hero *)entity;
- (void)deleteGame;
- (void)saveGame;
- (void)loadGame;
- (void)exitRoom;
- (void)generateNewRoom;
- (NSString *)getRoomDescription;

@end
