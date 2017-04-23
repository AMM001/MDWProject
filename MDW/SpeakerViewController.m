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
    _myLabel.text=_speakerName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }

*/
@end
