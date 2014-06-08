//
//  MainViewController.m
//  01Homework
//
//  Created by albertoc on 6/8/14.
//  Copyright (c) 2014 AC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  [self configureView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)configureView {
  self.contentView.layer.cornerRadius = 2;
}

- (void)willShowKeyboard:(NSNotification *)notification {
  NSDictionary *userInfo = [notification userInfo];
  
  // Get the keyboard height and width from the notification
  // Size varies depending on OS, language, orientation
  CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
  
  // Get the animation duration and curve from the notification
  NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration = durationValue.doubleValue;
  NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
  UIViewAnimationCurve animationCurve = curveValue.intValue;
  
  // Move the view with the same duration and animation curve so that it will match with the keyboard animation
  [UIView animateWithDuration:animationDuration
                        delay:0.0
                      options:(animationCurve << 16)
                   animations:^{
//                     self.commentImageView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentImageView.frame.size.height, self.commentImageView.frame.size.width, self.commentImageView.frame.size.height);
                   }
                   completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
  // TODO
}
@end
