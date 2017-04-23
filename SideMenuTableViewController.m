//
//  SideMenuTableViewController.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SideMenuTableViewController.h"

@interface SideMenuTableViewController ()

@end

@implementation SideMenuTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.tableView sizeToFit];
    self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"leftSideMenuBackground.png"]];
    cellIdentifiers=@[@"agenda",@"myagenda",@"speakers",@"exhibitors",@"profile",@"logout",@"footer"];
   
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString  *cellIdentifier=[cellIdentifiers objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"leftSideMenuBackground.png"]];
        cell.textLabel.textColor=[UIColor whiteColor];

    
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==7) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.google.com"]];
    }



}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue isKindOfClass:[SWRevealViewControllerSegueSetController class]]) {
        UIViewController *dvc=[segue destinationViewController];
        UINavigationController *navCtrl=(UINavigationController*)self.revealViewController.frontViewController;
        [navCtrl setViewControllers:@[dvc] animated:NO];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated:YES];

    }
    
    
}

@end
