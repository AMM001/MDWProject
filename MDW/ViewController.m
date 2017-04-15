//
//  ViewController.m
//  MDW
//
//  Created by marko on 4/12/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _speakers = [NSMutableArray new];
    _sessions = [NSMutableArray new];
    
    [_SpeakersTableView setDelegate:self];
    [_SpeakersTableView setDataSource:self];

    [MDWNetworkManager fetchSpeakersData:_speakers :_SpeakersTableView];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_speakers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:2];
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:3];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:1];
    
    //[titleLabel setHtml:@"<Font name=\"verdana\" size=\"6\" color=\"Blue\">Opening</Font>"];
    nameLabel.text = [[_speakers objectAtIndex:indexPath.row] firstName];
    titleLabel.text = [[_speakers objectAtIndex:indexPath.row] title];
    
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[_speakers objectAtIndex:indexPath.row] imageURL]]];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            UIImage *userImage =[UIImage imageWithData:imageData];
            
            if (userImage != nil) {
                imageView.image =userImage;
            }
            //else
            
        });
    });
    
    
    
    return cell;
    
}


@end
