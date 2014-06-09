//
//  StartViewController.m
//  01Homework
//
//  Created by albertoc on 6/8/14.
//  Copyright (c) 2014 AC. All rights reserved.
//

#import "StartViewController.h"
#import "MainViewController.h"

@interface StartViewController ()
@property (strong, nonatomic) IBOutlet UIButton *launchButton;


- (IBAction)onLaunch:(id)sender;

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        // UIImage *img = [UIImage imageNamed:@"navbar"];
        // [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.launchButton.layer.borderWidth = 1;
    self.launchButton.layer.borderColor =[[UIColor darkGrayColor] CGColor];
    self.launchButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
  return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}



- (IBAction)onLaunch:(id)sender {
    MainViewController *c = [[MainViewController alloc] init];
    [self.navigationController pushViewController:c animated:YES];
}
@end
