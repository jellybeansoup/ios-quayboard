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

#import <UIKit/UIKit.h>
#import "JSMQuayboardButton.h"

@class JSMQuayboardBar;

/**
 * The delegate of a JSMQuayboardBar object must adopt the JSMQuayboardBarDelegate protocol. Optional methods of the protocol allow the delegate
 * to respond to events triggered by the collection of keys in the quayboard object.
 */

@protocol JSMQuayboardBarDelegate <NSObject>

@optional

/**
 * Tells the delegate that the specified key was pressed.
 * @param quayboardBar The quayboard object containing the pressed key.
 * @param key The key that was pressed.
 * @return void
 */

- (void)quayboardBar:(JSMQuayboardBar *)quayboardBar keyWasPressed:(JSMQuayboardButton *)key;

@end

/**
 * An instance of JSMQuayboardBar is a means for displaying an additional row of keys as a keyboard accessory view set on either a text view or a text field.
 */

@interface JSMQuayboardBar : UIView {
	__unsafe_unretained id <JSMQuayboardBarDelegate> _delegate;
	NSArray *_keys;
}

/**
 * @name Managing the Delegate
 */

/**
 * The object that acts as the delegate of the receiving table view.
 *
 * The delegate must adopt the JSMQuayboardBarDelegate protocol. The delegate is not retained.
 */

@property (nonatomic, assign) id <JSMQuayboardBarDelegate> delegate;

/**
 * @name Manage Keys
 */

/**
 * The collection of keys currently visible in the bar.
 */

@property (nonatomic, strong) NSArray *keys;

/**
 * Create and add a key to the bar with the given value. The value is used as the title by default.
 * @param value The string to be used as a text value inserted into the text field upon triggering.
 * @return The created key. This can be used to further customise the key's behaviour.
 */

- (JSMQuayboardButton *)addKeyWithValue:(NSString *)value;

/**
 * Create and add a key to the bar with the given title and value.
 * @param title The visible label for the key.
 * @param value The string to be used as a text value inserted into the text field upon triggering.
 * @return The created key. This can be used to further customise the key's behaviour.
 */

- (JSMQuayboardButton *)addKeyWithTitle:(NSString *)title andValue:(NSString *)value;

/**
 * Adds a given key to the right side of the bar.
 * @param key An instance of a Quayboard key to be inserted into the bar.
 * @return void
 */

- (void)addKey:(JSMQuayboardButton *)key;

/**
 * @name Bundled Images
 */

/**
 * Fetches an image from the quayboard resources bundle for the given name.
 * @warning This method should not be called directly. It is meant for use within the JSMQuayboardBar and JSMQuayboardButton classes only.
 * @param name The name of the image to try and match.
 * @return The image object matching the name.
 */

+ (UIImage *)__JSMBundledImageNamed:(NSString *)name;

@end
