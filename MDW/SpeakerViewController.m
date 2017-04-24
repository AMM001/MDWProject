//
//  SpeakerViewController.m
//  MDW
//
//  Created by JETS on 4/18/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SpeakerViewController.h"

@interface SpeakerViewController ()

@end

@implementation SpeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    [_speakersTableView setDelegate:self];
    [_speakersTableView setDataSource:self];
    
    self.title=@"MDW";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.speakersTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
   
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:1];
    UILabel *descriptionLabel = (UILabel*) [cell viewWithTag:2];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:3];
    
    nameLabel.text = @"SpeakerName";
    descriptionLabel.text = @"JETS ITI";
    imageView.image=[UIImage imageNamed:@"speaker.png"];

    return cell;
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }

*/
@end
