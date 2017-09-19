//
//  NSString+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (MHF)

//@property (readonly, nonatomic) NSString *mhf_sanitizedFilenameString;
//@property (readonly, nonatomic) NSString *mhf_trimmedString;
@property (readonly, nonatomic) NSString *mhf_whitespaceAndNewlineCoalescedString;

//- (void)enumerateContentLineRangesInRange:(struct _NSRange)arg1 usingBlock:(CDUnknownBlockType)arg2;
//- (void)enumerateParagraphsInRange:(struct _NSRange)arg1 usingBlock:(CDUnknownBlockType)arg2;
//- (id)mhf_stringByReplacingCharactersInSet:(id)arg1 withString:(id)arg2;
//- (id)mhf_stringByReplacingNewlineCharactersWithWhiteSpace;
//- (id)mhf_substringFromIndex:(NSUInteger)arg1;
- (id)mhf_substringToIndex:(NSUInteger)arg1;
//- (id)mhf_substringWithRange:(struct _NSRange)arg1;
//- (NSUInteger)lengthOfLongestLine;
//- (id)md5;
//- (NSUInteger)numberOfLines;
//- (struct _NSRange)paragraphRangeForRange:(struct _NSRange)arg1 contentEnd:(NSUInteger *)arg2;
@end

