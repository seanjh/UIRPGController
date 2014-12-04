//
//  AttackViewController.m
//  UIRPGController
//
//  Created by Sean on 10/11/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "AttackViewController.h"
#import "EnemiesTableViewController.h"

@interface AttackViewController ()

@property (strong, nonatomic) IBOutlet UILabel *healthSummaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *enemyCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *manaSummaryLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *healthProgressBar;
@property (strong, nonatomic) IBOutlet UIProgressView *manaProgressBar;
@property (strong, nonatomic) IBOutlet UIButton *attackEnemyButton;
@property (strong, nonatomic) IBOutlet UIButton *castSpellButton;
@property (strong, nonatomic) IBOutlet UIView *enemiesContainer;
@property (strong,nonatomic) EnemiesTableViewController *enemiesTable;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *castCooldownIndicator;

@end

@implementation AttackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.battleController = [[BattleController alloc] init];
    [self updateViewData];
}

- (void) updateViewData {
    [self updateEnemiesCount];
    [self updateHeroAttributes];
    // Make sure the top of the list shows living enemies (if any).
    [self.battleController pushDownDeadEnemies];
    [self reloadEnemiesTable];
}

- (void) updateEnemiesCount {
    self.enemyCountLabel.text = [NSString stringWithFormat:@"%lu", [self.battleController getEnemyCount]];
}

- (void) updateHeroAttributes {
    self.healthSummaryLabel.text = [self.battleController getHeroHealthSummary];
    self.healthProgressBar.progress = [self.battleController getHeroHealthPercent];
    self.manaSummaryLabel.text = [self.battleController getHeroManaSummary];
    self.manaProgressBar.progress = [self.battleController getHeroManaPercent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Add the container's tableviewcontroller as a property of this VC.
    if ([segue.identifier isEqualToString:@"enemiesEmbedSegue"]) {
        self.enemiesTable = (EnemiesTableViewController *) segue.destinationViewController;
    }
}

- (void) reloadEnemiesTable {
    // Save the selection and reload to show the updated enemy health.
    NSIndexPath *indexPath = [self.enemiesTable.tableView indexPathForSelectedRow];
    [self.enemiesTable.tableView reloadData];
    [self.enemiesTable.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (IBAction)pressedAttackButton:(id)sender {
    // Get the selected row index. indexPath position 0 is sections, and position 1 is rows.
    long index = [[self.enemiesTable.tableView indexPathForSelectedRow] indexAtPosition:1];
    // Apply damage to the selected enemy at row number index.
    BOOL attackDidSucceed = [self.battleController attackEnemyAtIndex:index];
    if (attackDidSucceed) {
        [self updateViewData];
    }
}

- (IBAction)pressedCastSpellButton:(id)sender {
    BOOL attackDidSucceed = [self.battleController attackEnemiesWithSpell];
    if (attackDidSucceed) {
        [self deactivateCastSpellButtonWithDelay:5];
        [self updateViewData];
    }
}

- (void) refreshHeroAttributesOverIntervalWithStart:(int)start andFinish:(int)finish {
    for (int i = 0; i < (finish - start); i++) {
        [self performSelector:@selector(updateHeroAttributes) withObject:self afterDelay:start + i];
    }
}

- (void)deactivateCastSpellButtonWithDelay:(int)delay {
    [self.castCooldownIndicator startAnimating];
    // TODO: FIX
    [self refreshHeroAttributesOverIntervalWithStart:0 andFinish:30];
    [self performSelector:@selector(activateCastSpellButton) withObject:self afterDelay:delay];
    self.castSpellButton.enabled = NO;
    self.castSpellButton.alpha = 0.5;
}

- (void)activateCastSpellButton {
    [self.castCooldownIndicator stopAnimating];
    self.castSpellButton.enabled = YES;
    self.castSpellButton.alpha = 1.0;
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
