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
   
    
    _speakers = [NSMutableArray new];
    
//    RLMResults *results = [SpeakerDTO allObjects];
//    
//    _speakers = [NSMutableArray new];
//    
//    for (RLMObject *object in results) {
//        [_speakers addObject:object];
//    }
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    [_speakersTableView setDelegate:self];
    [_speakersTableView setDataSource:self];
    
    self.title=@"MDW";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.speakersTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    
    [MDWNetworkManager fetchSpeakersData:_speakers :_speakersTableView];
    
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
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:1];
    UILabel *descriptionLabel = (UILabel*) [cell viewWithTag:2];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:3];
    
//    nameLabel.text = @"SpeakerName";
//    descriptionLabel.text = @"JETS ITI";
    NSMutableString *fullName = [NSMutableString new];
    [fullName appendString:[[_speakers objectAtIndex:indexPath.row] firstName]];
    [fullName appendString:@" "];
    [fullName appendString:[[_speakers objectAtIndex:indexPath.row] middleName]];
    [fullName appendString:@" "];
    [fullName appendString:[[_speakers objectAtIndex:indexPath.row] lastName]];
    
    //  fullName Rendering
    NSAttributedString *renderedTextNameLabel=[[NSAttributedString alloc]initWithData:[fullName
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    nameLabel.attributedText=renderedTextNameLabel;
    
    //nameLabel.text = fullName;
    descriptionLabel.text = [[_speakers objectAtIndex:indexPath.row] title];
    
    if([[_speakers objectAtIndex:indexPath.row] imageData] == nil){
        
        if([[_speakers objectAtIndex:indexPath.row] imageURL] == nil){
            
            imageView.image=[UIImage imageNamed:@"speaker.png"];
            
        }else{
        
            [MDWNetworkManager fetchImageWithURL:[[_speakers objectAtIndex:indexPath.row] imageURL]
                                     UIImageView:imageView
                                     setForObject:[_speakers objectAtIndex:indexPath.row] ];
        }
    
    }else{
        
        UIImage * img = [[UIImage alloc] initWithData:[[_speakers objectAtIndex:indexPath.row] imageData]];
        imageView.image = img;
    }
    
    

    return cell;
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"speakerDetails" sender:self];
}*/
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }

*/
@end
