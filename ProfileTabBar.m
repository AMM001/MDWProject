//
//  ProfileTabBar.m
//  MDW
//
//  Created by JETS on 5/7/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ProfileTabBar.h"

@implementation ProfileTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
}



@end
