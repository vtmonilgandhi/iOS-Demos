//
//  TextStashViewController.m
//  Attributor
//
//  Created by Monil Gandhi on 05/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "TextStashViewController.h"

@interface TextStashViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *oulineCharactersLabel;

@end

@implementation TextStashViewController

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
  _textToAnalyze = textToAnalyze;
  if (self.view.window) [self updateUI];
}

- (void) updateUI {
  
  self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu Colorful Characters", (unsigned long)[[self charctersWithAttributes:NSForegroundColorAttributeName] length]];
  
  self.oulineCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined Characters", (unsigned long)[[self charctersWithAttributes:NSStrokeWidthAttributeName] length]];
  
  
}

- (NSAttributedString *)charctersWithAttributes: (NSString *)AttributeName {
  
  NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
  int index = 0;
  while (index < [self.textToAnalyze length]) {
    NSRange range;
    id value = [self.textToAnalyze attribute:AttributeName atIndex:index
                              effectiveRange:&range];
    if (value) {
      [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
      index = (int)(range.location + range.length);
    } else {
      index++;
    }
  }
  return characters;
}

@end


























