//
//  FirstDayMyAgendaViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "FirstDayMyAgendaViewController.h"
#import "SessionDTO.h"
#import "DBHandler.h"
#import "AgendaDTO.h"
#import "DateConverter.h"
@interface FirstDayMyAgendaViewController ()

@end

@implementation FirstDayMyAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    AgendaDTO * firstDayAgenda = [[DBHandler getDB] getAgendaByDayNumber:1];
    _firstDaySessions =[NSMutableArray new];
    for(SessionDTO *session in firstDayAgenda.sessions) {
        if (session.status==1||session.status==2) {
            [_firstDaySessions addObject:session];
        }
    }
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_FirstDayTable setDelegate:self];
    [_FirstDayTable setDataSource:self];
    // self.FirstDayTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];}
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_firstDaySessions count];
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
    sessionToView=[_firstDaySessions objectAtIndex:indexPath.row];
    firstLabel.text = [sessionToView name];
    secondLabel.text = [sessionToView location];
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:sessionToView.startDate],
                       [DateConverter stringFromDate:sessionToView.endDate]];
    thirdLabel.text = date;
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
        
        destination.session=[_firstDaySessions objectAtIndex:indexPath.row];
        
        
    }
}

@end
