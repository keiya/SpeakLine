//
//  AppController.h
//  SpeakLine
//
//  Created by Keiya Chinen on 10/01/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *textField;
//	IBOutlet NSComboBox *comboBox;
	NSSpeechSynthesizer *speechSynth;
	

}
//-(IBAction)setCombobox:(id) sender;
-(IBAction)sayIt: (id)sender;
-(IBAction)recIt: (id)sender;
-(IBAction)stopIt:(id)sender;

@end
