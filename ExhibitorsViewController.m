//
//  ExhibitorsViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ExhibitorsViewController.h"

@interface ExhibitorsViewController ()

@end

@implementation ExhibitorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_ExhibitorsTable setDelegate:self];
    [_ExhibitorsTable setDataSource:self];
   // self.ExhibitorsTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:2];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:3];
    
    
    nameLabel.text = @"ExihibtorName";
    imageView.image=[UIImage imageNamed:@"exihiptors.png"];
    
    return cell;
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
