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

#import "JSMQuayboardButton.h"
#import "JSMQuayboardBar.h"

@implementation JSMQuayboardButton

@synthesize title;
@synthesize value;
@synthesize position;
@synthesize label;
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame {
    if( ( self = [super initWithFrame:frame] ) ) {
		// Configure the button
		self.backgroundColor = UIColor.clearColor;
		// Set up the background image
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		self.imageView.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
		[self addSubview:self.imageView];
		// Set up the text label
		self.label = [[UILabel alloc] initWithFrame:CGRectZero];
		self.label.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
		self.label.backgroundColor = UIColor.clearColor;
		self.label.shadowColor = UIColor.whiteColor;
		self.label.shadowOffset = CGSizeMake( 0, 1 );
		self.label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.label];
		// Set the initial state
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
			[self displayNormalStatePad];
		else
			[self displayNormalStatePhone];
    }
    return self;
}

- (void)setTitle:(NSString *)_title {
	title = _title;
	label.text = _title;
}

#pragma mark -
#pragma mark Background Image

- (void)displayNormalStatePhone {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPhone.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 11, 8, 11, 8 ) resizingMode:UIImageResizingModeStretch];
	else
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 11, 8, 11, 8 )];
	self.imageView.frame = CGRectMake( -3, -6, self.frame.size.width+6, self.frame.size.height+12 );
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
		self.imageView.image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
	else
		self.imageView.image = [image resizableImageWithCapInsets:edgeInsets];
	self.imageView.frame = imageFrame;
	// Text Label
	self.label.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
	self.label.font = [UIFont boldSystemFontOfSize:45];
	self.label.frame = labelFrame;
}

- (void)displayNormalStatePad {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPad.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 ) resizingMode:UIImageResizingModeStretch];
	else
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 )];
	self.imageView.frame = CGRectMake( -6, -6, self.frame.size.width+12, self.frame.size.height+12 );
	// Text Label
	self.label.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
	self.label.font = [UIFont systemFontOfSize:25];
	self.label.frame = CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height );
}

- (void)displayHighlightedStatePad {
	// Background Image
	UIImage *image = [JSMQuayboardBar __JSMBundledImageNamed:@"keyBackgroundPadHighlighted.png"];
	if( [image respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 ) resizingMode:UIImageResizingModeStretch];
	else
		self.imageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake( 13, 14, 13, 14 )];
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
