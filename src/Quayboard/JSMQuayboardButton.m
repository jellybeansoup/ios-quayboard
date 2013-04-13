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

#import "JSMQuayboardButton.h"
#import "JSMQuayboardBar.h"

@implementation JSMQuayboardButton

- (id)initWithFrame:(CGRect)frame {
    if( ( self = [super initWithFrame:frame] ) ) {

		// Configure the button
		self.backgroundColor = UIColor.clearColor;

		// Set up the background image
		_backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_backgroundImageView.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
		[self addSubview:_backgroundImageView];

		// Set up the text label
		_label = [[UILabel alloc] initWithFrame:CGRectZero];
		_label.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
		_label.backgroundColor = UIColor.clearColor;
		_label.shadowColor = UIColor.whiteColor;
		_label.shadowOffset = CGSizeMake( 0, 1 );
		_label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.label];

		// Accessibility
		self.accessibilityTraits = UIAccessibilityTraitKeyboardKey;

		// Set the initial state
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
			[self displayNormalStatePad];
		else
			[self displayNormalStatePhone];

    }
    return self;
}

- (NSString *)title {
	return _label.text;
}

- (void)setTitle:(NSString *)title {
	_label.text = title;
}

#pragma mark -
#pragma mark Background Image

- (void)displayNormalStatePhone {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPhone.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 11, 8, 11, 8 ) resizingMode:UIImageResizingModeStretch];
	else
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 11, 8, 11, 8 )];
	_backgroundImageView.frame = CGRectMake( -3, -6, self.frame.size.width+6, self.frame.size.height+12 );
	// Text Label
	self.label.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
	self.label.font = [UIFont boldSystemFontOfSize:20];
	self.label.frame = CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height );
}

- (void)displayHighlightedStatePhone {
	[self.superview bringSubviewToFront:self];
	// Position defines highlighted states
	NSString *imageName = @"keyBackgroundPhoneHighlightCenter.png";
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake( 85, 24, 8, 24 );
	CGRect imageFrame = CGRectMake( -21, -75, self.frame.size.width+42, self.frame.size.height+80 );
	CGRect labelFrame = CGRectMake( -14, -60, self.frame.size.width+28, 48 );
	if( self.position == 1 ) {
		imageName = @"keyBackgroundPhoneHighlightLeft.png";
		edgeInsets = UIEdgeInsetsMake( 85, 14, 9, 32 );
		imageFrame = CGRectMake( -10, -75, self.frame.size.width+40, self.frame.size.height+80 );
		labelFrame = CGRectMake( -5, -60, self.frame.size.width+28, 48 );
	}
	else if( self.position == 2 ) {
		imageName = @"keyBackgroundPhoneHighlightRight.png";
		edgeInsets = UIEdgeInsetsMake( 85, 32, 9, 14 );
		imageFrame = CGRectMake( -30, -75, self.frame.size.width+40, self.frame.size.height+80 );
		labelFrame = CGRectMake( -23, -60, self.frame.size.width+28, 48 );
	}
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:imageName];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		_backgroundImageView.image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
	else
		_backgroundImageView.image = [image resizableImageWithCapInsets:edgeInsets];
	_backgroundImageView.frame = imageFrame;
	// Text Label
	self.label.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
	self.label.font = [UIFont boldSystemFontOfSize:45];
	self.label.frame = labelFrame;
}

- (void)displayNormalStatePad {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPad.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 ) resizingMode:UIImageResizingModeStretch];
	else
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 )];
	_backgroundImageView.frame = CGRectMake( -6, -6, self.frame.size.width+12, self.frame.size.height+12 );
	// Text Label
	self.label.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
	self.label.font = [UIFont systemFontOfSize:25];
	self.label.frame = CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height );
}

- (void)displayHighlightedStatePad {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPadHighlighted.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 ) resizingMode:UIImageResizingModeStretch];
	else
		_backgroundImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 )];
}

#pragma mark -
#pragma mark Touches

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	// Switch to highlighted image
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
		[self displayHighlightedStatePad];
	else
		[self displayHighlightedStatePhone];
	return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	return [super continueTrackingWithTouch:touch withEvent:event];
	// Switch to normal image
	CGPoint location = [touch locationInView:self];
	if( location.x < 0 || location.x > self.frame.size.width || location.y < 0 || location.y > self.frame.size.height ) {
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
			[self displayNormalStatePad];
		else
			[self displayNormalStatePhone];
	}
	else {
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
			[self displayHighlightedStatePad];
		else
			[self displayHighlightedStatePhone];
	}
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	// Switch to normal image
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
		[self displayNormalStatePad];
	else
		[self displayNormalStatePhone];
	[super endTrackingWithTouch:touch withEvent:event];
}

@end
