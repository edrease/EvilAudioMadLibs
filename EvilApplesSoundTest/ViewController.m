//
//  ViewController.m
//  EvilApplesSoundTest
//
//  Created by Edrease Peshtaz on 1/28/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SoundPlayer.h"
#import "Constants.h"

NSArray *soundStringArray;
NSArray *promptArray;
NSUInteger promptCount;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark Properties/Outlets

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CATransform3D initialTransform;

- (NSString *)providePromptForSound;

@end

@implementation ViewController

#pragma mark Life Cycle Methods

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Audio Mad Libs!";
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  soundStringArray = @[kAchievement,
                  kAhhNicely,
                  kBoo,
                  kBubble,
                  kBubble1,
                  kCakeFull,
                  kChatIncoming,
                  kClick0,
                  kClick1,
                  kDoom,
                  kDrumRoll,
                  kElevatorBadspeakers,
                  kGavel,
                  kHo,
                  kLaserPrepReverse,
                  kLaserPrep,
                  kNinjaSword,
                  kNinjaWhack,
                  kNinjaWhoosh,
                  kNotice,
                  kSadTrombone,
                  kSelectClassic,
                  kSmallApplause,
                  kSonar,
                  kStartEcho,
                  kWhoosh];
  
  promptArray = @[@"The sound El Chapo made when he got caught",
                  @"The noise your mom made while hitting the bong",
                  @"The sound you hear when you take your shirt off",
                  @"The last noise you'll hear before you die",
                  @"Your child's first sound",
                  @"What Santa Claus' farts sound like",
                  @"The noise that inspired Drake's latest single",
                  @"You must use this as the main sample in an EDM song",
                  @"You get in your car late at night. You hear this noise from the back seat",
                  @"I wish the ocean sounded like this on repeat instead of how it sounds now",
                  @"Eight and a half dentists recommend you make this noise while flossing",
                  @"You hear this sound everytime your dog barks. What did it swallow...?",
                  @"The noise you make sucking in your stomach to get a tight pair of pants on",
                  @"Michael Caine hides his tourettes well. He can't stop making this noise in private",
                  @"Ryan Seacrests 'safeword' noise",
                  @"Robots will take over one day. We won't understand their language but they sound like this",
                  @"When starting out, John Lennon could only make this noise with his guitar",
                  @"Michael Jordan confirmed he would do Space Jam by making this noise",
                  @"The jukebox at my local bar can only play this sound",
                  @"Set your alarm to his noise on repeat. It's good for your skin",
                  @"The most often heard noise while you and bae are fighting"];
  
  UIAlertController *beginningAlert = [UIAlertController alertControllerWithTitle:@"Instructions" message:@"Click on a cell to learn some fun facts! All sounds are sourced and used with permission from the fartz.zip file" preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *yasss = [UIAlertAction actionWithTitle:@"YASSS" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [beginningAlert dismissViewControllerAnimated:true completion:nil];
  }];
  
  [beginningAlert addAction:yasss];
  
  [self presentViewController:beginningAlert animated:true completion:nil];
  
  CGFloat rotationAngleDegrees = -15;
  CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
  CGPoint offSetPositionPoints = CGPointMake(-20, -20);
  
  CATransform3D transform = CATransform3DIdentity;
  transform = CATransform3DRotate(transform, rotationAngleRadians, 0, 0, 1);
  transform = CATransform3DTranslate(transform, offSetPositionPoints.x, offSetPositionPoints.y, 0);
  self.initialTransform = transform;
}

#pragma mark Helper Methods

- (NSString *)providePromptForSound {
  NSUInteger randomNumber = arc4random_uniform(promptArray.count);
  return promptArray[randomNumber];
}

#pragma mark UITableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return soundStringArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  NSString *soundString = soundStringArray[indexPath.row];
  NSString *defaultCellText = [NSString stringWithFormat:@"Click to generate facts about the %@ sound!!!", soundString];
//  cell.tag++;
//  NSInteger *tag = cell.tag;
  cell.backgroundColor = [UIColor blackColor];
  cell.textLabel.textColor = [UIColor whiteColor];
  cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
  cell.textLabel.numberOfLines = 0;
  cell.textLabel.text = defaultCellText;
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
  NSString *string = soundStringArray[indexPath.row];

  NSLog(@"%@",string);
  
  if (string == kAhhNicely || kBoo || kChatIncoming || kClick0 || kClick1 || kDoom || kDrumRoll || kElevatorBadspeakers || kGavel || kHo || kLaserPrepReverse || kLaserPrep || kNinjaSword || kNinjaWhack || kNinjaWhoosh || kNotice || kSmallApplause || kSonar || kStartEcho || kWhoosh) {
    
    [[SoundPlayer sharedSoundPlayer] playSound:string withAudioFormat:kMP3Format];
  }
  
  if (string == kAchievement || kBubble || kBubble1 || kSelectClassic) {
    
    [[SoundPlayer sharedSoundPlayer] playSound:string withAudioFormat:kWavFormat];
  }
  
  if (string == kCakeFull) {
    
    [[SoundPlayer sharedSoundPlayer] playSound:string withAudioFormat:kAIFFormat];
  }
  
  if (string == kSadTrombone) {
    
    [[SoundPlayer sharedSoundPlayer] playSound:string withAudioFormat:kAIFF_Format];
  }

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  NSString *newCellText = self.providePromptForSound;
  
  [UIView animateWithDuration:1 animations:^{
    cell.textLabel.alpha = 0;
    cell.textLabel.text = newCellText;
    cell.textLabel.alpha = 1;
  }];
  
  
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  cell.layer.transform = self.initialTransform;
  cell.layer.opacity = 0.7;
  
  [UIView animateWithDuration:0.3 animations:^{
    cell.layer.transform = CATransform3DIdentity;
    cell.layer.opacity = 1;
  }];
  
}

@end


