//
//  NSDReposViewController.m
//  gitClient
//
//  Created by NullStackDev on 15.08.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "NSDReposViewController.h"
#import "NSDRepo.h"
#import "NSDRepo+InitWithDictionary.h"
#import "NSDRepoCell.h"
@interface NSDReposViewController ()
{
    NSMutableArray<NSDRepo *> * array;
    NSUInteger pageNumber;
    BOOL end;
}
@end

@implementation NSDReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = [NSMutableArray new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    pageNumber = 2;
    [self startView]
    ;
    
}

-(void)setReposURL:(NSString *)reposURL{
    _reposURL = reposURL;
    
    int count = 0;
    int index = -1;
    for (unsigned int i=0; i < [reposURL length]; ++i) {
        if ([reposURL characterAtIndex:i] == '/') {
            ++count;
            if (count == 4) {
                index = i;
                break;
            }
        }
    }
    NSString * res = [reposURL substringFromIndex:index+1];
    NSUInteger location = [res rangeOfString:@"/"].location;
    NSString * retVal ;
    retVal = [res substringToIndex:location];
    
    
    //https://api.github.com/users/metalll/repos
    [self setTitle:[retVal stringByAppendingString:@"'s repos"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"rCell";
    
    if(indexPath.row>=array.count-4&&array.count>20){
        if(!end){
            [self moreDownload];}
    }

    NSDRepoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NSDRepoCell" owner:self options:0] lastObject];
        
    }
    NSDRepo * __weak processedRepo = [array objectAtIndex:indexPath.row];
    
    
//    @property (weak, nonatomic) IBOutlet UIImageView *repoImageView;
//    @property (weak, nonatomic) IBOutlet UILabel *forkCount;
//    
//    @property (weak, nonatomic) IBOutlet UITextView *repoName;
//    @property (weak, nonatomic) IBOutlet UILabel *starCount;
    
    if(processedRepo.isFork){
        cell.repoImageView.image = [UIImage imageNamed:@"fork"];
    }else{
        cell.repoImageView.image = [UIImage imageNamed:@"repo"];
    }
    
    cell.forkCount.text =[ NSString stringWithFormat:@"%@", processedRepo.forks];
    cell.repoName.text = processedRepo.repoName;
    cell.starCount.text = [ NSString stringWithFormat:@"%@", processedRepo.stars];
    
    
    
    
    
    
    return cell;
}

- (NSString *) reformatURlWithString:(NSString *)string{
    NSString * retVal;
    NSUInteger location = [string rangeOfString:@"{"].location;
     retVal = [string substringToIndex:location];
    
    
    
    return retVal;
}

-(void)startView{
    
    [self.gitApi performRequestWithURLString:self.reposURL andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
       
        NSDictionary * responceDic  =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        for(int i=0;i<[(NSArray *)responceDic count];i++)
        {
            [array addObject:[[NSDRepo alloc] initWithDictionary:responceDic andIndex:i]];
        }
        [_tableView reloadData];
    }];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[tableView cellForRowAtIndexPath:indexPath]setSelected:YES];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[array objectAtIndex:indexPath.row] repoUrl]]] ;
    
     [[tableView cellForRowAtIndexPath:indexPath]setSelected:NO];
    
}


-(void)moreDownload{
    
    //?page=2&per_page=100
    NSString *appString = [@"?page=" stringByAppendingString:[NSString stringWithFormat:@"%d",pageNumber]];
    
    NSLog(@"%@",[self.reposURL stringByAppendingString:appString]);
    pageNumber++;
    
    [self.gitApi performRequestWithURLString:[self.reposURL stringByAppendingString:appString] andMethod:@"GET" andParams:nil andAcceptJSONResponse:YES andSendBodyAsJSON:NO andCompletion:^(NSData *data, NSString *errorString) {
        if(errorString == nil&&data!=nil){
            NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            // if([responceDic isEqualToDictionary:[NSDictionary new]]) {end = YES;}
            if(responceDic.count<=1){end=YES;}
           
            for(int i=0;i<responceDic.count;i++){
              [ array addObject:[[NSDRepo alloc] initWithDictionary:responceDic andIndex:i]];
            }
        }
        
        else{
            end = YES;
        }
        
        [_tableView reloadData];
    }];
    
    
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return !_hideLeftMenu;
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
