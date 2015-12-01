
#import <UIKit/UIKit.h>

/*
 * Completion block definition for songs search
 */
typedef void (^SongSearchCompletion) (BOOL success, NSArray * songs, NSError * error);

/*
 * Completion block definition for image downloads
 */
typedef void (^ImageDownloadCompletion) (BOOL success, UIImage * image, NSError * error);