

#import "SoundPlayer.h"

@implementation SoundPlayer

@synthesize audioPlayer;

+ (SoundPlayer *)sharedSoundPlayer {
  static SoundPlayer *_sharedInstance;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedInstance = [[self alloc] init];
  });
  
  return _sharedInstance;
}


- (void)playSound:(NSString *)soundToPlay withAudioFormat:(NSString *)audioFormat {
  
  NSURL *fileURL = [[NSBundle mainBundle] URLForResource:soundToPlay withExtension:audioFormat];
  NSError *error;
  NSLog(@"%@", fileURL);
  AVAudioPlayer *newAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
  
  if (error == nil) {
    self.audioPlayer = newAudioPlayer;
    
    [audioPlayer prepareToPlay];
    [audioPlayer setDelegate:self];
    [audioPlayer play];
  } else {
    NSLog(@"%@", error);
  }

}

@end
