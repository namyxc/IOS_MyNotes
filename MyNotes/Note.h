//
//  Note.h
//  
//
//  Created by rentit on 2015. 12. 18..
//
//

#import <Realm/Realm.h>

#define kNoteChangedNotification @"kNoteChangedNotification"

@interface Note : RLMObject

@property NSString *contentText;
@property NSString *subject;
@property NSDate *date;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Note>
RLM_ARRAY_TYPE(Note)
