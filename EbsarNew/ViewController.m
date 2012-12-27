//
//  ViewController.m
//  EbsarNew
//
//  Created by App on 26/12/2012.
//  Copyright (c) 2012 MushyApp. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize selectedImage = _selectedImage;
@synthesize imageString = _imageString;
@synthesize urlString = _urlString;
@synthesize tweetText = _tweetText;
@synthesize audioRecorder;
@synthesize audioPlayer;
@synthesize twitterAccount = _twitterAccount;
@synthesize buttonTweet;
//@synthesize webView =_webView;




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTwitter];

    /**
    NSString *twUrl = @"https://twitter.com/";
    NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:
                              [_twitterAccount dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"username"]]];
    NSString * username = [tempDict objectForKey:@"username"];
    
    NSString *fullUrl = [twUrl stringByAppendingString:username];
    NSLog(@"%@",fullUrl);
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    [_tweetButton setEnabled:NO];
     */
	// Do any additional setup after loading the view, typically from a nib.
    
}

/**
 Controll the action when the user click on a capture button
 */
- (IBAction)captureImage:(UIBarButtonItem*)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"مصدر الصورة"
                                                    message:@"اختر مصدر الصورة"
                                                   delegate:self
                                          cancelButtonTitle:@"تراجع"
                                          otherButtonTitles:@"إلتقط صورة",@"أختر صورة من الالبومات",nil];
    alert.tag = 1;
    [alert show];
    //[alert release];
    //UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //NSLog(@"Hellow");
}

- (IBAction)tweet:(id)sender {
    
    [self initTwitter];
    NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:
                              [_twitterAccount dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"username"]]];
   // NSString *tempUserID = [[tempDict objectForKey:@"properties"] objectForKey:@"user_id"];
    NSLog(@"%@",[tempDict objectForKey:@"username"]);
    /*
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:_selectedImage];
        [tweetSheet setInitialText:_tweetText];
        [tweetSheet addURL:[NSURL URLWithString:_urlString]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
     */
}

- (void) initTwitter
{
    
    // Create an account store
    ACAccountStore *twitter = [[ACAccountStore alloc] init];
    
    // Create an account type
    ACAccountType *twAccountType = [twitter accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Request Access to the twitter account
    [twitter requestAccessToAccountsWithType:twAccountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             // Create an Account
             ACAccount *twAccount = [[ACAccount alloc] initWithAccountType:twAccountType];
             NSArray *accounts = [twitter accountsWithAccountType:twAccountType];
             twAccount = [accounts objectAtIndex:0];
             _twitterAccount = twAccount;
         }
     }];
     
    
}

- (void) tweetThis
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:_selectedImage];
        [tweetSheet setInitialText:_tweetText];
        [tweetSheet addURL:[NSURL URLWithString:_urlString]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/**
Capture the user input when the user select the the type of camera source 
 **/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"hey");
    //NSLog(@"Index is %d",buttonIndex);
     // if camera is selected lunch image picker from camera source
    if (alertView.tag == 1) {

    if(buttonIndex == 1) {

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    // if the album is selected lunch the ablum picker
    if (buttonIndex == 2) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];

    }
        
    }
    
    if(alertView.tag == 2 )
    {
        // End and go to tweet 
        if (buttonIndex == 0) {
            _tweetText = [[alertView textFieldAtIndex:0] text];
        }
        
        // Start Recording audio
        if(buttonIndex == 1)
        {
            // Start Recording
            NSLog(@"it's recording");
            [self recordAudio];
            
            //show alart
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"مقطع صوتي"
                                                            message:@"يتم التسجيل"
                                                           delegate:self
                                                  cancelButtonTitle:@"انقر لإنهاء التسجيل"
                                                  otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
            
        }
        
    }
    
    if(alertView.tag == 3)
    {
        //It recording alartbox
        //Once It's clicked Stoped recording
        if (buttonIndex == 0) {
            NSLog(@"Hey");
            
            if(audioRecorder.recording){
                
                [self.audioRecorder stop];
            }else if (audioPlayer.playing) {
                
                [audioPlayer stop];
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"حفظ المقطع الصوي"
                                                            message:@"احفظ المقطع الصوتي"
                                                           delegate:self
                                                  cancelButtonTitle:@"حفظ مقطع الصوتي"
                                                  otherButtonTitles:@"إستمع إلى المقطع",nil];
            alert.tag = 4;
            [alert show];
            
            
            
           
            
        }
        
    }
    
    if (alertView.tag == 4) {
        if(buttonIndex == 1)
        {
            [self playAudio];
            
            //copy the same one tag 4
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"حفظ المقطع الصوي"
                                                            message:@"احفظ المقطع الصوتي"
                                                           delegate:self
                                                  cancelButtonTitle:@"حفظ مقطع الصوتي"
                                                  otherButtonTitles:@"إستمع إلى المقطع",nil];
            alert.tag = 4;
            [alert show];

            
        }
        
        if (buttonIndex == 0) {
            [self uploadAudio];
 
        }
    }
}






/**
 When the image is picked saved the picture
 */
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Image has been picked");
    _selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self afterImageIsPicked];
    

     

}

- (void) afterImageIsPicked
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"سجل مقطع صوتي" message:@"اضغط علي زر التسجيل وتكلم" delegate:self cancelButtonTitle:@"انهاء" otherButtonTitles:@"سجل مقطع صوتي", nil];
    alert.tag = 2;
    [alert show];

}

- (void) recordAudio
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt: 1],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:16000.0],
                                    AVSampleRateKey,
                                    [NSNumber numberWithInt:kAudioFormatAppleIMA4],
                                    AVFormatIDKey,
                                    nil];
    
    NSError *error = nil;
    
    self.audioRecorder = [[AVAudioRecorder alloc]
                          initWithURL:soundFileURL
                          settings:recordSettings
                          error:&error];
    
    if (error){
        
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        
        [self.audioRecorder prepareToRecord];
    }
    
    [self.audioRecorder record];
}

-(void) playAudio
{
    if (!self.audioRecorder.recording){
        
        
        NSLog(@"Playing");
        if (self.audioPlayer){
            
            
        }
        
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc]
                            initWithContentsOfURL:self.audioRecorder.url
                            error:&error];
        
        self.audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [self.audioPlayer play];
    }
}

- (void) uploadAudio
{
    NSURL *trackURL = self.audioRecorder.url;
    
    SCShareViewController *shareViewController;
    SCSharingViewControllerComletionHandler handler ;
    
    handler = ^(NSDictionary *trackInfo, NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            //NSLog(@"Uploaded track: %@", trackInfo);
            _urlString = [trackInfo objectForKey:@"permalink_url"];
            buttonTweet.enabled = YES;

        }
    };
    shareViewController = [SCShareViewController
                           shareViewControllerWithFileURL:trackURL
                           completionHandler:handler];
    [shareViewController setTitle:@"Sound Clip"];
    //[shareViewController setCoverImage:_selectedImage];

    [shareViewController setPrivate:NO];
    [shareViewController setDelegate:self];
    //[self presentModalViewController:shareViewController animated:YES];
    [self presentViewController:shareViewController animated:YES completion:nil];
    

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tweetButton:(id)sender {
    [self tweetThis];
}
@end
