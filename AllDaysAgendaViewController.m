//
//  AllDaysAgendaViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "AllDaysAgendaViewController.h"
#import "MDWNetworkManager.h"
#import "SessionDTO.h"
#import "DateConverter.h"
@interface AllDaysAgendaViewController (){
    
    UIRefreshControl *refreshControl;
}

@end

@implementation AllDaysAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allSessions = [NSMutableArray new];
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_AllDaysTable setDelegate:self];
    [_AllDaysTable setDataSource:self];
    // self.AllDaysTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];}
}

/*-(void)refreshMyTable{
 [self.AllDaysTable reloadData];
 [refreshControl endRefreshing];
 }*/

-(void)viewDidAppear:(BOOL)animated{
    ////////////////Refresh Controller////////////////
    
    refreshControl=[[UIRefreshControl alloc]init];
    
    [refreshControl addTarget:self action:@selector(refreshing) forControlEvents:UIControlEventValueChanged];
    [self.AllDaysTable addSubview:refreshControl];
    
    
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [MDWNetworkManager fetchAllSessionsData:_allSessions :self : YES];
}
////////refresh Method////
-(void)refreshing{
    [MDWNetworkManager fetchAllSessionsData:_allSessions :self : YES];
    [refreshControl endRefreshing];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_allSessions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *firstLabel = (UILabel*) [cell viewWithTag:2];
    UILabel *secondLabel = (UILabel*) [cell viewWithTag:3];
    UILabel *thirdLabel = (UILabel*) [cell viewWithTag:4];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:5];
    UILabel *imageNoLabel = (UILabel*) [cell viewWithTag:6];
    
    if ([[[_allSessions objectAtIndex:indexPath.row] sessionType] isEqualToString:@"Session"]){
        imageView.image=[UIImage imageNamed:@"session.png"];
    }else if([[[_allSessions objectAtIndex:indexPath.row] sessionType] isEqualToString:@"Workshop"]){
        imageView.image=[UIImage imageNamed:@"workshop.png"];
    }else if([[[_allSessions objectAtIndex:indexPath.row] sessionType] isEqualToString:@"Break"]){
        imageView.image=[UIImage imageNamed:@"breakicon.png"];
    }
    else if([[[_allSessions objectAtIndex:indexPath.row] sessionType] isEqualToString:@"Hackathon"]){
        imageView.image=[UIImage imageNamed:@"hacathon.png"];
    }
    
    //    firstLabel.text = @"First Label";
    //    secondLabel.text = @"Second Label";
    //    thirdLabel.text = @"Third Label";
    SessionDTO * sessionToView =nil;
    sessionToView=[_allSessions objectAtIndex:indexPath.row];
    //firstLabel.text = [sessionToView name];
    
    //    firstLabel Rendering
    NSAttributedString *renderedTextFirstLabel=[[NSAttributedString alloc]initWithData:[[sessionToView name]
                                                                                        dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    firstLabel.attributedText=renderedTextFirstLabel;
    
    
    //secondLabel.text = [sessionToView location];
    
    //    secondLabel Rendering
    NSAttributedString *renderedTextSecondLabel=[[NSAttributedString alloc]initWithData:[[sessionToView location]
                                                                                         dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    secondLabel.attributedText=renderedTextSecondLabel;
    
    //     thirdLabel Rendering
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:sessionToView.startDate],
                       [DateConverter stringFromDate:sessionToView.endDate]];
    //thirdLabel.text = date;
    NSAttributedString *renderedTextThirdLabel=[[NSAttributedString alloc]initWithData:[date
                                                                                        dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    thirdLabel.attributedText=renderedTextThirdLabel;
    
    
    imageNoLabel.text=[NSString stringWithFormat:@"%@",
                       [DateConverter dayStringFromDate:sessionToView.startDate]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"sessionDetails" sender:indexPath];
}

-(void)showAlertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(void)showProgressbar{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
   // [self.view setUserInteractionEnabled:NO];
    [_indicator startAnimating];
}
-(void)dismissProgressbar{
    [_indicator stopAnimating];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    //[self.view setUserInteractionEnabled:YES];
}
-(void)refreshView{
    [_AllDaysTable reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"sessionDetails"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        SessionDetailsViewController *destination=segue.destinationViewController;
        
        destination.session=[_allSessions objectAtIndex:indexPath.row];
        
        
    }
}
@end
