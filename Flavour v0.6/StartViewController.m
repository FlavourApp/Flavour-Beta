//
//  StartViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.responseData = [NSMutableData data];
    
    // Do any additional setup after loading the view.
    int chefId = 3;
    NSString *URL = [ NSString stringWithFormat:@"http://192.168.1.32:8000/flavour/dates?chefId=%d", chefId ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        NSString *keyAsString = (NSString *)key;
        
        if([keyAsString  isEqual: @"dates"])
        {
            NSLog(@"DATES is long %lu",(unsigned long)[value count]);
        }
        //NSLog(@"value: %@", valueAsArray);
    }
    
    // extract specific value...
    //NSArray *results = [res objectForKey:@"results"];
    /*
     for (NSDictionary *result in results) {
     NSString *icon = [result objectForKey:@"icon"];
     NSLog(@"icon: %@", icon);
     }
     */
    
}


@end
