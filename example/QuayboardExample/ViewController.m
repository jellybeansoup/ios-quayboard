//
// Copyright © 2013 Daniel Farrelly
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.textView becomeFirstResponder];

	// Create the Quayboard bar
	JSMQuayboardBar *textViewAccessory = [[JSMQuayboardBar alloc] initWithFrame:CGRectZero];
	textViewAccessory.delegate = self;
	self.textView.inputAccessoryView = textViewAccessory;

	// Add some keys whose values match their labels
	[textViewAccessory addKeyWithValue:@"1"];
	[textViewAccessory addKeyWithValue:@"2"];
	[textViewAccessory addKeyWithValue:@"3"];
	[textViewAccessory addKeyWithValue:@"4"];
	[textViewAccessory addKeyWithValue:@"5"];
	
	// Maybe a key whose labels and values aren't the same
	[textViewAccessory addKeyWithTitle:@"⇥" andValue:@"\t"];

	// Or build and add a custom key
	JSMQuayboardButton *customKey = [[JSMQuayboardButton alloc] initWithFrame:CGRectZero];
	customKey.title = @"▾";
	[customKey addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
	[textViewAccessory addKey:customKey];
	
	// Deal with events and changes
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
}

#pragma mark - IBActions

- (IBAction)clearTextView:(id)sender {
	[self.textView resignFirstResponder];
}

#pragma mark - Quayboard Bar Delegate

- (void)quayboardBar:(JSMQuayboardBar *)quayboardBar keyWasPressed:(JSMQuayboardButton *)key {
	// Find the range of the selected text
	NSRange range = self.textView.selectedRange;
	
	// Get the relevant strings
	NSString *firstHalfString = [self.textView.text substringToIndex:range.location];
	NSString *insertingString = key.value;
	NSString *secondHalfString = [self.textView.text substringFromIndex:range.location+range.length];
	
	// Update the textView's text
	self.textView.scrollEnabled = NO;
	self.textView.text = [NSString stringWithFormat: @"%@%@%@", firstHalfString, insertingString, secondHalfString];
	self.textView.scrollEnabled = YES;

	// More the selection to after our inserted text
	range.location += insertingString.length;
	range.length = 0;
	self.textView.selectedRange = range;
}

#pragma mark - Respond to the keyboard being displayed and hidden

- (void)keyboardWillShow:(NSNotification *)notification {
	// Get the view's frame
	CGRect viewFrame = self.textView.frame;
	// Get the keyboard's frame
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
	// Adjust the height of the frame
	viewFrame.size.height = viewFrame.size.height - keyboardFrame.size.height;
	// Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
	// Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    // Set the values
    self.textView.frame = viewFrame;
    // Commit the animation
	[UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	// Adjust the height of the frame
	CGRect viewFrame = CGRectMake( 0, 0, self.view.frame.size.width, self.view.frame.size.height );
	// Get the duration of the animation.
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
	// Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    // Set the values
    self.textView.frame = viewFrame;
    // Commit the animation
	[UIView commitAnimations];
}

@end
