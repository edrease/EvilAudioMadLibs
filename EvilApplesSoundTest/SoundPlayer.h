

#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer : NSObject <AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

+ (SoundPlayer *)sharedSoundPlayer;

- (void)playSound:(NSString *)soundToPlay withAudioFormat:(NSString *)audioFormat;

@end
