//
//  LoadingViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/22/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "LoadingViewController.h"
#import "TableViewController.h"
#import "chefObject.h"

@interface LoadingViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fullChefList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fullChefList = [[NSMutableArray alloc] init];
    
    //NSString *serverIp = @"http://192.168.1.32:8001/data/chefs?comuna=las%20condes";
    NSString *serverIp = @"http://186.106.211.230:8001/data/chefs?comuna=las%20condes";
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:serverIp]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"PREPARING SEGUE");
    
    if ([[segue identifier] isEqualToString:@"loadingSuccess"]) {
        UINavigationController *nav = segue.destinationViewController;
        TableViewController *tableViewController = (TableViewController *)nav.topViewController;
        
        tableViewController.fullChefList = [NSMutableArray arrayWithArray:_fullChefList];
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
    }
}


//Conection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    [self performSegueWithIdentifier:@"loadingFailure" sender:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert from JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if(res != nil)
    {
        for(NSDictionary *chefDict in res)
        {
            chefObject *chef = [[chefObject alloc] initWithDictionary:chefDict];
            [self.fullChefList addObject:chef];
        }
        //self.fullChefList = [NSMutableArray arrayWithArray:res];
       // NSLog(@"RESPONSE===%@",res);
    }
    [self performSegueWithIdentifier:@"loadingSuccess" sender:self];
}

@end
