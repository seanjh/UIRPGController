//
//  GameManager.m
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "GameManager.h"

@interface GameManager ()

@end

@implementation GameManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static GameManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //self.theHero = [Hero getHeroFromSave];
        self.theHero = [Hero loadGameEntityWithKey:HERO_SAVE_STRING];
        self.currentRoom = nil;
    }
    return self;
}

-(void) deleteGame {
    NSLog(@"Deleting Hero and room");
    [Hero deleteGameEntityWithKey:HERO_SAVE_STRING];
    [Room deleteRoomWithKey:ROOM_SAVE_STRING];
    self.inProgress = NO;
}

- (void) createNewGameWithHero:(Hero *)entity {
    self.theHero = entity;
}

-(void) saveGame {
    NSLog(@"Saving the hero %@", self.theHero);
    [Hero saveGameEntity:self.theHero key:HERO_SAVE_STRING];
    NSLog(@"Saving the room %@", self.currentRoom);
    [Room saveRoom:self.currentRoom key:ROOM_SAVE_STRING];
}

-(void) loadGame {
    self.theHero = [Hero loadGameEntityWithKey:HERO_SAVE_STRING];
    NSLog(@"Loaded Hero from save %@", self.theHero);
    
    NSLog(@"Loading room from save.");
    self.currentRoom = [Room loadRoomWithKey:ROOM_SAVE_STRING];
    NSLog(@"Loaded Room from save %@", self.currentRoom);
    self.inProgress = YES;
}

-(void)exitRoom {
    [self saveGame];
    self.inProgress = NO;
}

-(void)generateNewRoom {
    self.currentRoom = [[Room alloc] initWithRandomEnemies];
    self.inProgress = YES;
}

- (NSString *)getRoomDescription {
    return self.currentRoom.surveyDescription;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
