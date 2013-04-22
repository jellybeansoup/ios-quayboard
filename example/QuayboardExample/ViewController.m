//
// Copyright © 2013 Daniel Farrelly
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// *	Redistributions of source code must retain the above copyright notice, this list
//		of conditions and the following disclaimer.
// *	Redistributions in binary form must reproduce the above copyright notice, this
//		list of conditions and the following disclaimer in the documentation and/or
//		other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// So the keyboard shows up immediately
	[_textView becomeFirstResponder];

	// Create the Quayboard bar
	JSMQuayboardBar *textViewAccessory = [[JSMQuayboardBar alloc] initWithFrame:CGRectZero];
	textViewAccessory.delegate = self;
	_textView.inputAccessoryView = textViewAccessory;

	// Add some keys whose values match their labels
	[textViewAccessory addKeyWithValue:@"1"];
	[textViewAccessory addKeyWithValue:@"2"];
	[textViewAccessory addKeyWithValue:@"3"];
	[textViewAccessory addKeyWithValue:@"4"];
	[textViewAccessory addKeyWithValue:@"5"];
	
	// Maybe a key whose labels and values aren't the same
	JSMQuayboardButton *tabButton = [textViewAccessory addKeyWithTitle:@"⇥" andValue:@"\t"];
	tabButton.accessibilityValue = tabButton.value;
	
	// Or build and add a custom key
	JSMQuayboardButton *customKey = [[JSMQuayboardButton alloc] initWithFrame:CGRectZero];
	customKey.title = @"▾";
	customKey.accessibilityValue = NSLocalizedString(@"Hide Keyboard",@"Accessibility value for key in Quayboard that hides the keyboard.");
	[customKey addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
	[textViewAccessory addKey:customKey];

	/*
	 Note that I'm setting a custom accessibility value on the last two keys.
	 Some characters (such as the arrow in this case) are not pronounceable,
	 so it's important for accessibility that you provide a value that defines
	 the action or value provided by the key.
	 */
	
	// Deal with events and changes
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
}

#pragma mark - IBActions

- (IBAction)clearTextView:(id)sender {
	[_textView resignFirstResponder];
}

#pragma mark - Quayboard Bar Delegate

- (void)quayboardBar:(JSMQuayboardBar *)quayboardBar keyWasPressed:(JSMQuayboardButton *)key {
	// Find the range of the selected text
	NSRange range = _textView.selectedRange;
	
	// Get the relevant strings
	NSString *firstHalfString = [_textView.text substringToIndex:range.location];
	NSString *insertingString = key.value;
	NSString *secondHalfString = [_textView.text substringFromIndex:range.location+range.length];
	
	// Update the textView's text
	_textView.scrollEnabled = NO;
	_textView.text = [NSString stringWithFormat: @"%@%@%@", firstHalfString, insertingString, secondHalfString];
	_textView.scrollEnabled = YES;

	// More the selection to after our inserted text
	range.location += insertingString.length;
	range.length = 0;
	_textView.selectedRange = range;
}

#pragma mark - Respond to the keyboard being displayed and hidden

- (void)keyboardWillShow:(NSNotification *)notification {
	// Get the view's frame
	CGRect viewFrame = _textView.frame;
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
	[UIView animateWithDuration:animationDuration animations:^{
		// Set the values
		_textView.frame = viewFrame;
	}];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	// Adjust the height of the frame
	CGRect viewFrame = _textView.frame;
	// Get the keyboard's frame
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
	// Adjust the height of the frame
	viewFrame.size.height = viewFrame.size.height + keyboardFrame.size.height;
	// Get the duration of the animation.
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
	// Animate the resize of the text view's frame in sync with the keyboard's appearance.
	[UIView animateWithDuration:animationDuration animations:^{
		// Set the values
		_textView.frame = viewFrame;
	}];
}

@end
