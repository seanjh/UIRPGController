//
//  GameEntity.m
//  UIRPGController
//
//  Created by Sean on 10/10/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "GameEntity.h"
#import "GameAssistant.h"

@interface GameEntity ()

@end

@implementation GameEntity

const int COOLDOWN_DEFAULT = 10;
const int XP_LEVEL_MULTIPLIER = 1000;
const int HEALTH_MANA_LEVEL_MULTIPLIER = 100;
const int DAMAGE_MAX_LEVEL_MULTIPLIER = 5;
NSString * const GAME_ENTITY_SAVE_STRING = @"gameEntity";

-(id)init {
    return [self initWithNameString:@""];
}

-(id)initWithNameString:(NSString *)entityName {
    return [self initWithNameString:entityName andLevelNumber:1];
}

-(id)initWithNameString:(NSString *) entityName andLevelNumber:(int) levelNumber {
    self.name = entityName;
    self.level = levelNumber;
    self.health = self.level * HEALTH_MANA_LEVEL_MULTIPLIER;
    self.mana = self.level * HEALTH_MANA_LEVEL_MULTIPLIER;
    self.xpToLevel = self.level * XP_LEVEL_MULTIPLIER;
    switch (self.level) {
        case 1: {
            self.cooldownSeconds = 10;
            break;
        }
        case 2: {
            self.cooldownSeconds = 9;
            break;
        }
        case 3: {
            self.cooldownSeconds = 8;
            break;
        }
        case 4: {
            self.cooldownSeconds = 7;
            break;
        }
        case 5: {
            self.cooldownSeconds = 6;
            break;
        }
        default: {
            self.cooldownSeconds = 5;
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        NSNumber *tmp = [decoder decodeObjectForKey:@"level"];
        self.level = [tmp intValue];
        tmp = [decoder decodeObjectForKey:@"health"];
        self.health = [tmp intValue];
        tmp = [decoder decodeObjectForKey:@"mana"];
        self.mana = [tmp intValue];
        tmp = [decoder decodeObjectForKey:@"xp"];
        self.xpToLevel = [tmp intValue];
        tmp = [decoder decodeObjectForKey:@"cooldown"];
        self.cooldownSeconds = [tmp intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.level] forKey:@"level"];
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.health] forKey:@"health"];
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.mana] forKey:@"mana"];
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.xpToLevel] forKey:@"xp"];
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.cooldownSeconds] forKey:@"cooldown"];
}

// via http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
+ (void)saveGameEntity:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

// via http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
+ (id)loadGameEntityWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    GameEntity *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+ (void)deleteGameEntityWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

- (NSDictionary *)serializeGameEntity {
    return [[NSDictionary alloc] initWithObjectsAndKeys:self.name, @"name", @(self.level), @"level", @(self.health), @"health", @(self.mana), @"mana", @(self.xpToLevel), @"xp", nil];
}

- (void)alterGameEntityByAttribute:(Attribute)attribute andAlterValue:(int)value {
    //Name, Health, Mana, Level, XP
    switch (attribute) {
        case Health: {
            self.health += value;
            break;
        }
        case Mana: {
            self.mana += value;
            break;
        }
        case Level: {
            self.level += value;
            break;
        }
        case XP: {
            self.xpToLevel += value;
            break;
        }
        default: {
            @throw [NSException exceptionWithName:@"InvalidAttributeException"
                                           reason:@"Attribute does not exist" userInfo:nil];
            break;
        }
    }
}

- (void)alterGameEntityHealthByInt:(int)value {
    [self alterGameEntityByAttribute:Health andAlterValue:value];
    if (self.health > [self getMaxHealthThisLevel]) {
        self.health = [self getMaxHealthThisLevel];
    }
    
}
- (void)alterGameEntityManaByInt:(int)value {
    [self alterGameEntityByAttribute:Mana andAlterValue:value];
    if (self.mana > [self getMaxManaThisLevel]) {
        self.mana = [self getMaxManaThisLevel];
    }
}

- (void)alterGameEntityXPByInt:(int) value {
    [self alterGameEntityByAttribute:XP andAlterValue:value];
    if (self.xpToLevel <= 0) {
        [self levelUp];
    }
}

- (void)levelUp {
    [self alterGameEntityByAttribute:Level andAlterValue:1];
    // Push up the XP threshold. Include any existing (negative) balance.
    [self alterGameEntityByAttribute:XP andAlterValue:[self getXPThisLevel]];
}

- (BOOL)isInProgress {
    return ![self.name isEqualToString:@""];
}

- (BOOL)isAlive {
    return self.health > 0;
}

-(int)getXPThisLevel {
    return self.level * XP_LEVEL_MULTIPLIER;
}

- (int)getMaxHealthThisLevel {
    return self.level * HEALTH_MANA_LEVEL_MULTIPLIER;
}

- (int)getMaxManaThisLevel {
    return self.level * HEALTH_MANA_LEVEL_MULTIPLIER;
}

- (BOOL)canAttack {
    return YES;
}
- (long)getAttack {
    return [GameAssistant generateRandomNumberBetweenMin:0 Max:(self.level * DAMAGE_MAX_LEVEL_MULTIPLIER)];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"GameEntity:\n\tName=%@ Level=%d Health=%d Mana=%d XP Earned=%d (%d needed)", self.name, self.level, self.health, self.mana, ([self getXPThisLevel] - self.xpToLevel), [self getXPThisLevel]];
}

@end
