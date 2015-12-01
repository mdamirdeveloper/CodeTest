//
//  CodeTestTests.m
//  CodeTestTests
//
//  Created by TAE on 12/1/15.
//  Copyright © 2015 TAE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Item.h"
#import "SearchOperation.h"
#import "DownloadImageOperation.h"
#import "ServicesManager.h"
@interface CodeTestTests : XCTestCase

@end

@implementation CodeTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItemParse {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString * songStr = @"{\"wrapperType\":\"track\", \"kind\":\"song\", \"artistId\":1000, \"collectionId\":1001, \"trackId\":1002, \"artistName\":\"artist\", \"collectionName\":\"collection\", \"trackName\":\"track\",  \"artworkUrl30\":\"artwork30\", \"artworkUrl60\":\"artwork60\", \"artworkUrl100\":\"artwork100\", \"trackPrice\":1.0, \"releaseDate\":\"2015-12-01T00:00:00Z\"}";
    NSError * error;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[songStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    XCTAssertNil(error,@"Found error : %@",[error description]);
    Item * song = [[Item alloc] initWithDictionary:dict];
    XCTAssertNotNil(song, @"Error creating Item object");
    XCTAssertTrue([song.artistName isEqualToString:@"artist"],@"Error parsing artist name");
    XCTAssertTrue([song.trackName isEqualToString:@"track"],@"Error parsing track");
    XCTAssertTrue([song.albumName isEqualToString:@"collection"],@"Error parsing album name");
    XCTAssertTrue((song.trackPrice.doubleValue == 1.0),@"Error parsing price");
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss'Z'"];
    NSDate * date = [dateFormatter dateFromString:@"2015-12-01T00:00:00Z"];
    XCTAssertTrue([song.releaseDate isEqual:date],@"Error parsing release date");
    XCTAssertTrue([song.artworkUrl30 isEqualToString:@"artwork30"],@"Error parsing 30x30 Artwork");
    XCTAssertTrue([song.artworkUrl60 isEqualToString:@"artwork60"],@"Error parsing 60x60 Artwork");
    XCTAssertTrue([song.artworkUrl100 isEqualToString:@"artwork100"],@"Error parsing 100x100 Artwork");
}

- (void)testSearchOperation {
    SongSearchCompletion completionBlock = ^(BOOL success, NSArray *songs, NSError *error) {
        XCTAssert(@"Completed");
    };
    NSURL * url = [NSURL URLWithString:@"test"];
    SearchOperation * searchOp = [[SearchOperation alloc] initWithUrl:url completion:completionBlock];
    XCTAssertEqual(searchOp.searchUrl, url, @"Error setting search url");
    XCTAssertEqual(searchOp.completion, completionBlock, @"Error setting completion block");
}

- (void)testImageDownloadOperation {
    ImageDownloadCompletion completionBlock = ^(BOOL success, UIImage * image, NSError *error) {
        XCTAssert(@"Completed");
    };
    NSURL * url = [NSURL URLWithString:@"test"];
    DownloadImageOperation * downloadOp = [[DownloadImageOperation alloc] initWithUrl:url completion:completionBlock];
    XCTAssertEqual(downloadOp.imageUrl, url, @"Error setting image download url");
    XCTAssertEqual(downloadOp.completion, completionBlock, @"Error setting completion block");
}

- (void)testServicesManager{
    XCTAssertNotNil([ServicesManager sharedServicesManager],@"Services Manager not created");
    XCTAssertTrue([[ServicesManager sharedServicesManager] isKindOfClass:[ServicesManager class]],@"Instance type incorrect");
}
@end
