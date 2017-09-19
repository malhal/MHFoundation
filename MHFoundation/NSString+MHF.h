//
//  NSString+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MHF)

//@property (readonly, nonatomic) NSString *mhf_sanitizedFilenameString;
//@property (readonly, nonatomic) NSString *mhf_trimmedString;
@property (readonly, nonatomic) NSString *mhf_whitespaceAndNewlineCoalescedString;

//- (void)enumerateContentLineRangesInRange:(struct _NSRange)arg1 usingBlock:(CDUnknownBlockType)arg2;
//- (void)enumerateParagraphsInRange:(struct _NSRange)arg1 usingBlock:(CDUnknownBlockType)arg2;
//- (id)mhf_stringByReplacingCharactersInSet:(id)set withString:(id)string;
//- (id)mhf_stringByReplacingNewlineCharactersWithWhiteSpace;
//- (id)mhf_substringFromIndex:(NSUInteger)index;
- (id)mhf_substringToIndex:(NSUInteger)index;
//- (id)mhf_substringWithRange:(NSRange)range;
//- (NSUInteger)lengthOfLongestLine;
//- (id)md5;
//- (NSUInteger)numberOfLines;
//- (struct _NSRange)paragraphRangeForRange:(struct _NSRange)arg1 contentEnd:(NSUInteger *)arg2;
@end

NS_ASSUME_NONNULL_END
