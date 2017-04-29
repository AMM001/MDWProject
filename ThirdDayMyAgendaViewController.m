//
//  ThirdDayMyAgendaViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ThirdDayMyAgendaViewController.h"
#import "SessionDTO.h"
#import "DBHandler.h"
#import "AgendaDTO.h"
#import "DateConverter.h"
@interface ThirdDayMyAgendaViewController ()

@end

@implementation ThirdDayMyAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);

    _thirdDaySessions =[NSMutableArray new];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_thirdDayTable setDelegate:self];
    [_thirdDayTable setDataSource:self];
    // self.thirdDayTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];}
}

-(void)viewDidAppear:(BOOL)animated{
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [MDWNetworkManager fetchAllSessionsData:_thirdDaySessions :self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_thirdDaySessions count];
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
    sessionToView=[_thirdDaySessions objectAtIndex:indexPath.row];
    //firstLabel.text = [sessionToView name];
    //     html firstLabel Rendered
    NSAttributedString *renderedTextFirstLabel=[[NSAttributedString alloc]initWithData:[[sessionToView name]
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    firstLabel.attributedText=renderedTextFirstLabel;
    
    //secondLabel.text = [sessionToView location];
    //     html secondLabel Rendered
    NSAttributedString *renderedTextSecondLabel=[[NSAttributedString alloc]initWithData:[[sessionToView location]
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    secondLabel.attributedText=renderedTextSecondLabel;
    
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:sessionToView.startDate],
                       [DateConverter stringFromDate:sessionToView.endDate]];
    
    //     html ThirdLabel Rendered
    NSAttributedString *renderedTextThirdLabel=[[NSAttributedString alloc]initWithData:[date
    dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    thirdLabel.attributedText=renderedTextThirdLabel;
    imageView.image=[UIImage imageNamed:@"myagenda.png"];

        
        return cell;
    }
/////Roma///////////////////////////

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"sessionDetails" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"sessionDetails"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        SessionDetailsViewController *destination=segue.destinationViewController;
        
        destination.session=[_thirdDaySessions objectAtIndex:indexPath.row];
        
        
    }
}

////////////EndRoma////////////////////////
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
    [_thirdDaySessions removeAllObjects];
    
    AgendaDTO * thirdDayAgenda = [[DBHandler getDB] getAgendaByDayNumber:3];
    _thirdDaySessions =[NSMutableArray new];
    for(SessionDTO *session in thirdDayAgenda.sessions) {
        if (session.status==1||session.status==2) {
            [_thirdDaySessions addObject:session];
        }
    }
    [_thirdDayTable reloadData];
}
@end
