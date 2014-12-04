//
//  Room.m
//  UIRPGController
//
//  Created by Sean on 10/8/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "Room.h"

@interface Room ()
@property (nonatomic,strong) NSString *roomType;
@property (nonatomic,strong) NSString *roomDescription;
@property (nonatomic,strong) NSString *roomEnemiesDescription;

@end

@implementation Room

NSString * const ROOM_SAVE_STRING = @"currentRoom";

-(id) init {
    return [self initWithRandomEnemies];
}

-(id) initWithRandomEnemies {
    long enemyNum = [GameAssistant generateRandomNumberBetweenMin:0 Max:10];
    NSLog(@"The new room will have %ld enemies.", enemyNum);
    self.enemies = [[NSMutableArray alloc] init];

    int i;
    Enemy *newEnemy;
    for (i = 0; i < enemyNum; i++) {
        newEnemy = [[Enemy alloc] init];
        [self.enemies addObject:newEnemy];
    }
    //self.enemies = [tmpArray copy];
    NSLog(@"The new room enemies are %@", self.enemies);
    
    self.surveyDescription = [self surveyRoom];
    
    return self;
}

// via http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.enemies = [decoder decodeObjectForKey:@"enemies"];
        self.surveyDescription = [decoder decodeObjectForKey:@"surveyDescription"];
    }
    NSLog(@"Decoded room enemies are %@", self.enemies);
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    //NSArray *enemies = [self.enemies copy];
    [encoder encodeObject:self.enemies forKey:@"enemies"];
    //[encoder encodeObject:enemies forKey:@"enemies"];
    [encoder encodeObject:self.surveyDescription forKey:@"surveyDescription"];
}

+ (void)saveRoom:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+ (id)loadRoomWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    Room *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+ (void)deleteRoomWithKey:(NSString *)key {
    NSLog(@"Deleting the current room");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

+ (NSArray *)roomDescriptionsArray {
    static NSArray *_desc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _desc = @[@". A diagonal column of light from a window above cuts through the pitch black.",
                   @", dimly lit with torches on each wall, each haloed in motes of dust.",
                   @". The air is humid and cold, with only a faint glimmer of light from beneath the doors in front and behind.",
                   @", with a damp, moldy, mattress with white and blue striped ticking resting atop a pile of bones.",
                   @". You notice an oubliette in the floor, with faint moaning sounds emanating from its grate."
                  ];
    });
    return _desc;
}

+ (NSArray *)roomWordArray {
    static NSArray *_desc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _desc = @[@"room",
                  @"chamber",
                  @"cellar"];
    });
    return _desc;
}

- (NSString *)surveyRoom {
    NSArray *roomTypeArray = [Room roomWordArray];
    NSArray *roomDescArray = [Room roomDescriptionsArray];
    long typeIndex = [GameAssistant generateRandomNumberBetweenMin:0 Max:([roomTypeArray count] -1)];
    long descIndex = [GameAssistant generateRandomNumberBetweenMin:0 Max:([roomDescArray count] -1)];
    NSMutableString *output = [[NSMutableString alloc] init];
    [output appendString:[NSString stringWithFormat:@"You step into a %@", [roomTypeArray objectAtIndex:typeIndex]]];
    [output appendString:[roomDescArray objectAtIndex:descIndex]];
    [output appendString:[NSString stringWithFormat:@"You stand facing %lu enemies.", [self.enemies count]]];
    return output;
}

- (BOOL)canExit {
    bool result = YES;
    for (Enemy *enemy in self.enemies) {
        if ([enemy isAlive]) {
            result = NO;
            break;
        }
    }
    return result;
}

@end
