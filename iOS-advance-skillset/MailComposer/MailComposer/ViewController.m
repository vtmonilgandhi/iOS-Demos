//
//  CEBViewController.m
//  Email Tutorial
//
//  Created by Monil Gandhi on 26/09/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController

- (IBAction)sendEmailAction:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Sample Subject"];
        [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[@"testingEmail@example.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (IBAction)sendMessageAction:(UIButton *)sender
{
  [self showSMS:@"Hiiii"];

}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
  switch (result) {
    case MessageComposeResultCancelled:
      break;

    case MessageComposeResultFailed:
    {
      NSLog(@"Failed to send SMS!");
      break;
    }

    case MessageComposeResultSent:
      break;

    default:
      break;
  }

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showSMS:(NSString*)file {

  if(![MFMessageComposeViewController canSendText]) {
     NSLog(@"Your device doesn't support SMS!");
    return;
  }

  NSArray *recipents = @[@"12345678", @"72345524"];
  NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", file];

  MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
  messageController.messageComposeDelegate = self;
  [messageController setRecipients:recipents];
  [messageController setBody:message];

  // Present message view controller on screen
  [self presentViewController:messageController animated:YES completion:nil];
}
@end
