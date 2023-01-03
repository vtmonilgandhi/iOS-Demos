//
//  ViewController.m
//  Attributor
//
//  Created by Monil Gandhi on 05/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"
#import "TextStashViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headLine;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self usePreferredFonts];
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
  
  [title setAttributes:@{ NSStrokeWidthAttributeName: @3,
                          NSStrokeColorAttributeName: self.outlineButton.tintColor}
                 range: NSMakeRange(0, [title length])];
  
  [self.outlineButton setAttributedTitle:title
                                forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
if([segue.identifier isEqualToString:@"Analyze Text"])
{
  if([segue.destinationViewController isKindOfClass:[TextStashViewController class]]){
    TextStashViewController *tsvc = (TextStashViewController *)segue.destinationViewController;
    tsvc.textToAnalyze = self.body.textStorage;
  }
}
  
}

- (void) preferredFontsChanged: (NSNotification *)notification {
  [self usePreferredFonts];
}

- (void) usePreferredFonts {
  self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  self.headLine.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (IBAction)changeBodySelectionColorToMatchBackgroudColorOfButton:(UIButton *)sender
{
  [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                value:sender.backgroundColor
                                range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection
{
  [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3,
                                          NSStrokeColorAttributeName: [UIColor blackColor]}
                                 range:self.body.selectedRange];
}


- (IBAction)unoutlineBodySelection {
  [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                   range:self.body.selectedRange];
}

@end

