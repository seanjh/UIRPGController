//
//  ViewController.m
//  UIRPGController
//
//  Created by Sean on 10/6/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "MakeHeroViewController.h"
#import "GameManager.h"

@interface MakeHeroViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIButton *beginButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UINavigationItem *myNavItem;
@property GameManager *sharedManager;

@end

@implementation MakeHeroViewController

-(void)viewWillAppear:(BOOL)animated {
    // Wipe out the placeholder text
    self.nameLabel.text = @"";
    self.sharedManager = [GameManager sharedManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginButtonPressed:(id)sender {
    Hero *newHero = [[Hero alloc] initWithNameString:self.nameTextField.text];
    [self.sharedManager createNewGameWithHero:newHero];
    NSLog(@"Creating new game for character %@", newHero);
}

- (IBAction)nameTextFieldEditingChanged:(id)sender {
    if (!self.beginButton.enabled) {
        NSLog(@"Got some input. Unlocking begin button and showing welcome label.");
        self.beginButton.enabled = TRUE;
        self.welcomeLabel.hidden = FALSE;
    }
    
    self.nameLabel.text = self.nameTextField.text;
}


@end
