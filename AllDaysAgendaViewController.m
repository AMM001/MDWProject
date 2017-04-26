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
@interface AllDaysAgendaViewController ()

@end

@implementation AllDaysAgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allSessions = [NSMutableArray new];
    [MDWNetworkManager fetchAllSessionsData:_allSessions :_AllDaysTable];
    
    
    
    
    
    
    
//    SessionDTO *s = [SessionDTO new];
//    s.sessionType=@"type 1";
//    s.name=@"s1";
//    s.id=1;
//    s.liked = true;
//    s.sessionDescription=@"sdjkfdsjkbfjdsbfbdsfsdns";
//    SpeakerDTO *sp = [SpeakerDTO new];
//    sp.id=1;
//    sp.firstName=@"markosp";
//    RLMString *ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    sp = [SpeakerDTO new];
//    sp.id=2;
//    sp.firstName=@"samysp";
//    
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    sp = [SpeakerDTO new];
//    sp.id=3;
//    sp.firstName=@"eslamsp";
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    [_allSessions addObject:s];
//    
//    s = [SessionDTO new];
//    s.sessionType=@"type 2";
//    s.name=@"s2";
//    s.id=2;
//    s.liked = true;
//    sp = [SpeakerDTO new];
//    sp.id=4;
//    sp.firstName=@"markosp";
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    sp = [SpeakerDTO new];
//    sp.id=5;
//    sp.firstName=@"samysp";
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    sp = [SpeakerDTO new];
//    sp.id=6;
//    sp.firstName=@"eslamsp";
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    ss =[RLMString new];
//    ss.string = @"012545";
//    [sp.mobiles addObject:ss];
//    sp.gender=true;
//    [s.speakers addObject:sp];
//    [_allSessions addObject:s];

    
    
    
    
    
    
    
    
    
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_AllDaysTable setDelegate:self];
    [_AllDaysTable setDataSource:self];
    // self.AllDaysTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];}
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

    imageView.image=[UIImage imageNamed:@"myagenda.png"];
    
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
