//
//  ViewController.h
//  EbsarNew
//
//  Created by App on 26/12/2012.
//  Copyright (c) 2012 MushyApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import "SCUI.h"
#import <Accounts/Accounts.h>


@interface ViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

{
    
    UIImage *selectedImage;
    NSString *imageString;
    NSString *urlString;
    NSString *twettText;
  
 
    
    

}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonTweet;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) UIImage *selectedImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Button_capture;
@property (strong, nonatomic) NSString *imageString;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *tweetText;

@property (nonatomic, retain) AVAudioRecorder *audioRecorder;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) ACAccount *twitterAccount;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetIt;
@property (weak, nonatomic) IBOutlet UIToolbar *tweetButton;

- (IBAction)doListen:(id)sender;

- (IBAction)captureImage:(UIBarButtonItem*)sender;
- (void) afterImageIsPicked;
- (void) recordAudio;
- (void) playAudio;
- (UIImage *)imageWithColor:(UIColor *)color;
- (IBAction)tweetButton:(id)sender;



@end
