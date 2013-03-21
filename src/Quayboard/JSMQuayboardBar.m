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

#import "JSMQuayboardBar.h"

@implementation JSMQuayboardBar

@synthesize delegate;
@synthesize keys;

- (id)initWithFrame:(CGRect)frame {
	// Height is different on each device
	frame = CGRectMake( frame.origin.x, frame.origin.y, frame.size.width, 44 );
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
		frame = CGRectMake( frame.origin.x, frame.origin.y, frame.size.width, 60 );
	// Initiate!
    if( ( self = [super initWithFrame:frame] ) ) {
		self.backgroundColor = [UIColor colorWithRed:0.49 green:0.52 blue:0.57 alpha:1.0];

		NSString *imageName = @"keyboardBackground.png";
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
			imageName = @"keyboardBackgroundPad.png";
		}
		
		UIImage *backgroundImage = [JSMQuayboardBar __JSMBundledImageNamed:imageName];
		if( [backgroundImage respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)] )
			backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake( 2, 0, 0, 0 ) resizingMode:UIImageResizingModeStretch];
		else
			backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake( 2, 0, 0, 0 )];
		UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
		backgroundImageView.autoresizingMask = ( UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth );
		backgroundImageView.frame = CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height );
		[self addSubview:backgroundImageView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
	// Height is different on each device
	frame = CGRectMake( frame.origin.x, frame.origin.y, frame.size.width, 44 );
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
		frame = CGRectMake( frame.origin.x, frame.origin.y, frame.size.width, 60 );
	// And organise everything
	[super setFrame:frame];
	[self arrangeKeys];
}

#pragma mark -
#pragma mark Adding Keys

- (JSMQuayboardButton *)addKeyWithValue:(NSString *)value {
	return [self addKeyWithTitle:value andValue:value];
}

- (JSMQuayboardButton *)addKeyWithTitle:(NSString *)title andValue:(NSString *)value {
	// Create the key
	JSMQuayboardButton *key = [JSMQuayboardButton buttonWithType:UIButtonTypeCustom];
    key.autoresizingMask = ( UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth );
	key.title = title;
	key.value = value;
	// Add to the list
	[self addKey:key];
	// And return
	return key;
}

- (void)addKey:(JSMQuayboardButton *)key {
	// Create a new mutable array
	NSMutableArray *array = [NSMutableArray arrayWithArray:self.keys];
	// Add the key
	[array addObject:key];
	// Update the keys array
	self.keys = array;
}

- (void)setKeys:(NSArray *)_keys {
	// Update the keys array
	keys = _keys;
	// Rearrange the keys
	[self arrangeKeys];
}

#pragma mark -
#pragma mark Triggered Keys

- (void)keyTouchUpInside:(id)sender {
	if( delegate != nil && [delegate respondsToSelector:@selector(quayboardBar:keyWasPressed:)] )
		[delegate quayboardBar:self keyWasPressed:(JSMQuayboardButton *)sender];
}

#pragma mark -
#pragma mark Arranging Keys

- (void)arrangeKeys {
	// Get the size of the view
	CGSize size = self.frame.size;
	// Height and spacing is different on each device
	int spacing = 6;
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
		spacing = 12;
	// Get the key width
	CGFloat keyWidth = ( size.width / self.keys.count ) - spacing;
	CGFloat offset = spacing / 2;
	// Enumerate through the keys
	NSEnumerator *enumerator = self.keys.objectEnumerator;
	JSMQuayboardButton *key;
	while( ( key = enumerator.nextObject ) ) {
		CGFloat left = roundf( offset );
		CGFloat right = roundf( offset + keyWidth );
		// Update this key's frame
		key.frame = CGRectMake( left, 6, right-left, size.height-12 );
		// Position
		if( key == [self.keys objectAtIndex:0] ) {
			key.position = 1;
		}
		else if( key == [self.keys objectAtIndex:self.keys.count-1] ) {
			key.position = 2;
		}
		else {
			key.position = 0;
		}
		// Add to the view
		if( ! [key.superview isEqual:self] ) {
			[self addSubview:key];
			// Assign our default action
			if( key.allControlEvents != UIControlEventTouchUpInside || key.value != nil ) {
				[key addTarget:self action:@selector(keyTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
			}
		}
		// Prepare for the next key
		offset = offset + keyWidth + spacing;
	}
}

#pragma mark -
#pragma mark Background Images

+ (UIImage *)__JSMBundledImageNamed:(NSString*)name {
	UIImage *image;
	// Try getting the image normally
    if( ( image = [UIImage imageNamed:name] ) != nil ) {
		return image;
	}
	// Default to the bundled image
	if( ( image = [UIImage imageNamed:[@"QuayboardResources.bundle" stringByAppendingPathComponent:name]] ) != nil ) {
		return image;
	}
	// Quietly fails
    return nil;
}

@end
