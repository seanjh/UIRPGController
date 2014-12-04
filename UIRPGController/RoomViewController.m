//
//  RoomViewController.m
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "RoomViewController.h"
#import "GameManager.h"

@interface RoomViewController ()
@property GameManager *sharedManager;
@property (strong, nonatomic) IBOutlet UITextView *roomSurveyTextBox;
@property (strong, nonatomic) IBOutlet UIButton *exitRoomButton;

@end

@implementation RoomViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.sharedManager = [GameManager sharedManager];
    if (!self.sharedManager.inProgress) {
        // Make a new room
        [self.sharedManager generateNewRoom];
    }
    [self.sharedManager saveGame];
    
    NSLog(@"Room description: %@", [self.sharedManager getRoomDescription]);
    self.roomSurveyTextBox.text = [self.sharedManager getRoomDescription];
    
    if ([self.sharedManager.currentRoom canExit]) {
        self.exitRoomButton.enabled = YES;
        self.exitRoomButton.alpha = 1.0;
    } else {
        self.exitRoomButton.enabled = NO;
        self.exitRoomButton.alpha = 0.5;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)exitRoomButtonPressed:(id)sender {
    [self.sharedManager exitRoom];
    [self performSegueWithIdentifier:@"roomSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
