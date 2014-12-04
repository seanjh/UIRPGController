//
//  ResumeHeroTableViewController.m
//  UIRPGController
//
//  Created by Sean on 10/7/14.
//  Copyright (c) 2014 Sean Herman. All rights reserved.
//

#import "ResumeHeroTableViewController.h"
#import "GameManager.h"

@interface ResumeHeroTableViewController ()
@property GameManager *sharedManager;

@end

@implementation ResumeHeroTableViewController

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"Displaying hero details");
    
    self.sharedManager = [GameManager sharedManager];
}
- (IBAction)resumeButtonPressed:(id)sender {
    NSLog(@"Resuming adventure");
    [self.sharedManager loadGame];
}

- (IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Deleting Game");
    /*UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Deleting Game"
                                                       message:@"Are you sure you want to delete this game? All progress will be lost."
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil];
    [theAlert addButtonWithTitle:@"Delete"];
    [theAlert show];*/
    [self.sharedManager deleteGame];

}

/*- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The %@ button was tapped.", [theAlert buttonTitleAtIndex:buttonIndex]);
    switch (buttonIndex) {
        case 0: {
            NSLog(@"Delete action cancelled. Do nothing!");
            break;
        }
        case 1: {
            NSLog(@"Delete confirmed.");
            ResumeHeroTableViewController *yourViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MakeHeroNavigationController"];
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ANYid" source:self destination:yourViewController];
            [segue perform];
            break;
        }
        default:
            break;
    }
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //return [self.sectionTitles count];
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger result;
    switch (section) {
        case 0: {
            result = 5;
            break;
        }
        case 1: {
            result = 1;
            break;
        }
        case 2: {
            result = 1;
            break;
        }
        default: {
            result = 0;
        }
    }
    return result;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"attributeCell"];
            NSArray *tmp = [self.sharedManager.theHero getAttributeValueAndNameStringsAtIndex:indexPath.row];
            cell.textLabel.text = [tmp objectAtIndex:0];
            cell.detailTextLabel.text = [tmp objectAtIndex:1];
            break;
        }
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"resumeButtonCell"];
            //cell.textLabel.text = @"Resume Adventure";
            break;
        }
            
        case 2: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"deleteButtonCell"];
            break;
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
