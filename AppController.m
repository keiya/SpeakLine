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
	[speechSynth setDelegate:self];
	voiceList = [[NSSpeechSynthesizer availableVoices] retain];
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
	[stopButton setEnabled:YES];
	[startButton setEnabled:NO];
	[tableView setEnabled:NO];
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

-(void)speechSynthesizer: (NSSpeechSynthesizer *)sender
	   didFinishSpeaking:(BOOL)complete
{
	NSLog(@"Complete = %d", complete);
	[stopButton setEnabled:NO];
	[startButton setEnabled:YES];
	[tableView setEnabled:YES];
}

-(int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [voiceList count];
}

-(id)tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
		   row:(int)row
{
	NSString *v = [voiceList objectAtIndex:row];
	NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
	return [dict objectForKey:NSVoiceName];
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
	int row = [tableView selectedRow];
	if (row == -1) {
		return;
	}
	NSString *selectedVoice = [voiceList objectAtIndex:row];
	[speechSynth setVoice:selectedVoice];
	NSLog(@"new voice = %@", selectedVoice);
}

-(void)awakeFromNib
{
	NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
	int defaultRow = [voiceList indexOfObject:defaultVoice];
	[tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:defaultRow] byExtendingSelection:NO];
	[tableView scrollRowToVisible:defaultRow];
}

@end
