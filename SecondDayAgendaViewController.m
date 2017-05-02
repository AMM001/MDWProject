//
//  SecondDayAgendaViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SecondDayAgendaViewController.h"
#import "SessionDTO.h"
#import "DBHandler.h"
#import "AgendaDTO.h"
#import "DateConverter.h"
@interface SecondDayAgendaViewController (){
    
    UIRefreshControl *refreshControl;

}

@end

@implementation SecondDayAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);

    _secondDaySessions =[NSMutableArray new];
   
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_SecondDayTable setDelegate:self];
    [_SecondDayTable setDataSource:self];
    // self.SecondDayTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];}
}
-(void)viewDidAppear:(BOOL)animated{
    
    ///////////refresh Control//////////
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshing) forControlEvents:UIControlEventValueChanged];
    [self.SecondDayTable addSubview:refreshControl];
    

    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [MDWNetworkManager fetchAllSessionsData:_secondDaySessions :self];
}
////////refresh Method////
-(void)refreshing{
    
    [MDWNetworkManager fetchAllSessionsData:_secondDaySessions :self];
    [refreshControl endRefreshing];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_secondDaySessions count];
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
    
    
    
    //    firstLabel.text = @"First Label";
    //    secondLabel.text = @"Second Label";
    //    thirdLabel.text = @"Third Label";
    SessionDTO * sessionToView =nil;
    sessionToView=[_secondDaySessions objectAtIndex:indexPath.row];
    //firstLabel.text = [sessionToView name];
    //     html Rendering
    //     html Rendering
    NSAttributedString *renderedText=[[NSAttributedString alloc]initWithData:[[sessionToView name]
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    firstLabel.attributedText=renderedText;

    //secondLabel.text = [sessionToView location];
    //     html secondLabel
    NSAttributedString *renderedTextSecondLabel=[[NSAttributedString alloc]initWithData:[[sessionToView location]
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    secondLabel.attributedText=renderedTextSecondLabel;
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:sessionToView.startDate],
                       [DateConverter stringFromDate:sessionToView.endDate]];
    //thirdLabel.text = date;
    
    //     html ThirdLabel
    NSAttributedString *renderedTextThirdLabel=[[NSAttributedString alloc]initWithData:[date
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    thirdLabel.attributedText=renderedTextThirdLabel;
    imageView.image=[UIImage imageNamed:@"myagenda.png"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"sessionDetails" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"sessionDetails"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        SessionDetailsViewController *destination=segue.destinationViewController;
        
        destination.session=[_secondDaySessions objectAtIndex:indexPath.row];
        
        
    }
}
-(void)showAlertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(void)showProgressbar{
    [_indicator startAnimating];
}
-(void)dismissProgressbar{
    [_indicator stopAnimating];
}
-(void)refreshView{
    [_secondDaySessions removeAllObjects];
    
    AgendaDTO * secondDayAgenda = [[DBHandler getDB] getAgendaByDayNumber:2];
    for(SessionDTO *session in secondDayAgenda.sessions) {
        [_secondDaySessions addObject:session];
    }
    [_SecondDayTable reloadData];
}
@end
