//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic,strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
