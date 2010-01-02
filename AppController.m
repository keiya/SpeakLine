//
//  AppController.m
//  SpeakLine
//
//  Created by Keiya Chinen on 10/01/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController

-(id)init
{
	[super init];
	speechSynth = [[NSSpeechSynthesizer alloc] init];
	return self;
}

/*
 -(IBAction)setCombobox:(id)sender
{

	NSLog(@"windowControllerDidLoadNib");

	NSArray* lists  = [NSSpeechSynthesizer availableVoices];
	NSLog(@"%d", [lists count]);
	[comboBox addItemsWithObjectValues:lists];

//	NSLog([[myOutlet dataSource] className]);
} */
-(IBAction)sayIt: (id)sender
{
//	NSLog(@"init %@", [comboBox stringValue]);
	
//	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:(@"%@",[comboBox objectValueOfSelectedItem])];

	NSString *string = [textField stringValue];
	
	if ([string length] == 0) {
		NSLog(@"string from %@ is of zero-length", textField);
		return;
	}
	[speechSynth startSpeakingString:string];
	NSLog(@"Have started to say: %@", string);
}

-(IBAction)recIt: (id)sender
{
	NSString *string = [textField stringValue];
	
	if ([string length] == 0) {
		NSLog(@"string from %@ is of zero-length", textField);
		return;
	}
	NSSavePanel* aPanel = [NSSavePanel savePanel];
	[aPanel setRequiredFileType:(NSString *) @"aiff"];
	if( [aPanel runModal] == NSFileHandlingPanelOKButton ){
		//NSArray *myArray;
		//myArray = [NSArray arrayWithObjects:myTableView1Data_A, myTableView1Data_B, NULL];
		//[myArray writeToFile:[aPanel filename] atomically:YES];
		[speechSynth startSpeakingString:string toURL:[NSURL URLWithString:[aPanel filename]]];
		NSLog(@"Saved: %@", string);
	}	
}

-(IBAction)stopIt: (id)sender
{
	NSLog(@"stopping");
	[speechSynth stopSpeaking];
}

@end
