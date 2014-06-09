//
//  MainViewController.m
//  01Homework
//
//  Created by albertoc on 6/8/14.
//  Copyright (c) 2014 AC. All rights reserved.
//

#import "MainViewController.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>


@interface MainViewController () <TTTAttributedLabelDelegate>

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *likesAttributedLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIView *commentViewContainer;

@property (strong, nonatomic) IBOutlet TTTAttributedLabel *postAttributedLabel;

- (IBAction)onPost:(id)sender;
- (IBAction)onLikePost:(id)sender;
- (IBAction)onComment:(id)sender;
- (IBAction)onShare:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@property (assign) BOOL likedPost;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  
    self.likedPost = NO;

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
  NSString *text;

  self.contentView.layer.cornerRadius = 2;
  
  // 1,675 people like this.
  self.likesAttributedLabel.font = [UIFont systemFontOfSize:14];
  self.likesAttributedLabel.textColor = [UIColor blackColor];
  self.likesAttributedLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  self.likesAttributedLabel.numberOfLines = 1;
  text = @"1,675 people like this.";
  [self.likesAttributedLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
  
      NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"1,675 people"];
      
      UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:12];
      CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
      if (font) {
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
        CFRelease(font);
      }
      return mutableAttributedString;
  }];
  
  self.postAttributedLabel.enabledTextCheckingTypes = NSTextCheckingAllTypes;
  self.postAttributedLabel.delegate = self;
  self.postAttributedLabel.font = [UIFont systemFontOfSize:12];
  self.postAttributedLabel.textColor = [UIColor darkGrayColor];
  self.postAttributedLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.postAttributedLabel.numberOfLines = 0;
  
  text = @"From collarless shorts to high-waisted parts, #Her's costume designer, Casey Storm, explains how he created his fasion looks for the future: http://bit.ly/1jV9zMB";
  
  [self.postAttributedLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
  
      NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"#Her's"];

      UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:12];
      CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
      if (font) {
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
        CFRelease(font);
      }
      return mutableAttributedString;
  }];

}

- (IBAction)onPost:(id)sender {
  NSLog(@"TODO: Submit POST");

  [self.commentTextField resignFirstResponder];
  self.commentTextField.text = nil;
}

- (IBAction)onLikePost:(id)sender {
  NSLog(@"TODO: Like POST");

  _likedPost = !_likedPost;
  
  self.likeButton.selected = _likedPost;
}

- (IBAction)onComment:(id)sender {
  NSLog(@"TODO: Comment On POST");
}

- (IBAction)onShare:(id)sender {
  NSLog(@"TODO: Share POST");
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
      self.commentViewContainer.frame =
          CGRectMake(0, self.view.frame.size.height - kbSize.height -
                     self.commentViewContainer.frame.size.height,
                     self.commentViewContainer.frame.size.width,
                     self.commentViewContainer.frame.size.height);

                   }
                   completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {

  NSDictionary *userInfo = [notification userInfo];

  NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
  NSTimeInterval animationDuration = durationValue.doubleValue;
  NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
  UIViewAnimationCurve animationCurve = curveValue.intValue;

  [UIView animateWithDuration:animationDuration
                        delay:0.0
                      options:(animationCurve << 16)
                   animations:^{
                     self.commentViewContainer.frame =
                     CGRectMake(0, self.view.frame.size.height - self.commentViewContainer.frame.size.height - 44,
                                self.commentViewContainer.frame.size.width,
                                self.commentViewContainer.frame.size.height);

                   }
                   completion:nil];
  
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
  NSLog(@"%@", url);
}
@end
