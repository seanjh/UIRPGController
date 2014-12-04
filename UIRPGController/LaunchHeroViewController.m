//
//  LaunchHeroViewController.m
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "LaunchHeroViewController.h"
#import "GameManager.h"

@interface LaunchHeroViewController ()
@property (nonatomic, strong) GameManager *sharedManager;

@end

@implementation LaunchHeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sharedManager = [GameManager sharedManager];
}

- (void) viewDidAppear:(BOOL)animated {
    if ([self.sharedManager.theHero isInProgress]) {
        NSLog(@"Redirecting to resume Hero view.");
        //[self performSegueWithIdentifier:@"showResumeHero" sender:self];
        [self performSegueWithIdentifier:@"segueResume" sender:nil];
    } else {
        NSLog(@"Redirecting to create Hero view");
        //[self performSegueWithIdentifier:@"showMakeHero" sender:self];
        [self performSegueWithIdentifier:@"segueMake" sender:nil];
    }
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
