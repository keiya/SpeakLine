//
//  AppController.h
//  SpeakLine
//
//  Created by Keiya Chinen on 10/01/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject <NSSpeechSynthesizerDelegate>
{
	IBOutlet NSTextField *textField;
	IBOutlet NSButton *stopButton;
	IBOutlet NSButton *startButton;
//	IBOutlet NSComboBox *comboBox;
	IBOutlet NSTableView *tableView;
	NSArray *voiceList;
	NSSpeechSynthesizer *speechSynth;
	

}
//-(IBAction)setCombobox:(id) sender;
-(IBAction)sayIt: (id)sender;
-(IBAction)recIt: (id)sender;
-(IBAction)stopIt:(id)sender;



@end
