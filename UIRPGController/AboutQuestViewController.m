//
//  AboutQuestViewController.m
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "AboutQuestViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AboutQuestViewController ()
@property (strong, nonatomic) IBOutlet UIButton *sampleButton;

@end

@implementation AboutQuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sampleButtonPressed:(id)sender {
    [self playVideo:self];
}

- (IBAction)playVideo:(id)sender
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"smooth" withExtension:@"mp4"];
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:fileURL];
    [self presentMoviePlayerViewControllerAnimated:moviePlayer];
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
