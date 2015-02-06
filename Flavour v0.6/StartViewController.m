//
//  StartViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "StartViewController.h"
#import "globals.h"

@interface StartViewController ()
@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _startButton.hidden = true;
    self.comunas = [[NSMutableArray alloc] init];
    
    NSString *serverIp = [globals getComunasIp];
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:serverIp]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSArray *animationArray=[NSArray arrayWithObjects:
                             [UIImage imageNamed:@"portada.jpg"],
                             [UIImage imageNamed:@"restDemo.jpg"],
                             nil];
    
    _bgImageView.backgroundColor=[UIColor purpleColor];
    _bgImageView.animationImages=animationArray;
    _bgImageView.animationDuration=3;
    _bgImageView.animationRepeatCount=0;
    
    [_bgImageView startAnimating];
    
   [self performSelector:@selector(moveImage) withObject:nil afterDelay:3.0f];
}

- (void)moveImage
{
    // Move the image
    [self moveImage:_bgImageView duration:3.0
              curve:UIViewAnimationCurveLinear x:50.0 y:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ComunaViewController *comunaViewController = [segue destinationViewController];
    comunaViewController.pickerData = _comunas;
    
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
        self.comunas = [NSMutableArray arrayWithArray:res];
        _startButton.hidden = false;
    }
    
}

//moving images

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}


@end
