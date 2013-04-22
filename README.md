#Quayboard

A keyboard accessory view that blends in with the default iOS keyboard, providing an additional set of customisable keys.

![Screenshot in iOS Simulator](https://raw.github.com/jellybeansoup/ios-quayboard/master/example/screenshot.png)

##Installation

There are a couple of ways to include Quayboard in your Xcode project.

###Subproject

This method is demonstrated in the included example project (example/QuayboardExample.xcodeproj).

1. Drag the `Quayboard.xcodeproj` file into your Project Navigator (⌘1) from the Finder. This should add Quayboard as a subproject of your own project (denoted by the fact that it appears as in a rectangle and you should be able to browse the project structure).

2. In your Project's target, under the Build Phases tab, add `libQuayboard.a` under 'Link Binary with Libraries'.

3. While you're in the Build Phases tab, add `libQuayboard.a` and `QuayboardResources.bundle` under 'Target Dependencies'.

4. Expand the Quayboard subproject and drag the `QuayboardResources.bundle` into your 'Copy Bundle Resources' build phase.

5. Under the Build Settings tab of you Project's target, do a search for 'Header Search Paths'. Add the path to the `/src/Quayboard/` folder of the Quayboard project. This should look something like `"$(SRCROOT)/../src/Quayboard/"`, replaceing the `..` with the relative path from your project to the Quayboard project.

6. Build your project (⌘B). All going well you should get a 'Build Succeeded' notification. This signifies that you're ready to implement Quayboard in your project.

###Cocoapods

Quayboard can be installed *very* easily if you use [Cocoapods](http://cocoapods.org) with your projects. The podspec is included in the Github repository, and is also available through [cocoapods.org](http://cocoapods.org/?q=quayboard).

Simply add the project to your `Podfile` by adding the line:

```ruby 
pod 'Quayboard'
```

And run `pod update` in terminal to update the pods you have included in your project.

You can also specify a version to include, such as 0.1.0:

```ruby
pod 'Quayboard', '0.1.0'
```

For more information on how to add projects using Cocoapods, read [their documentation on Podfiles](http://docs.cocoapods.org/podfile.html).

##Implementing Quayboard

At the top of the header file for the view controller you want to implement Quayboard in, include Quayboard:

```objc
#import "Quayboard.h"
```

The view controller should also implement `JSMQuayboardBarDelegate` in order to receive notification that a key was pressed.

```objc
@interface MyViewController : UIViewController <JSMQuayboardBarDelegate>
```

In the `viewDidLoad` method, create an instance of `JSMQuayboardBar`, set the delegate of the instance as `self` and set it as the `inputAccessoryView` of the UITextField or UITextView you wish to implement on. For the purposes of this explanation, we're going to use a UITextView.

```objc
JSMQuayboardBar *quayboardBar = [[JSMQuayboardBar alloc] initWithFrame:CGRectMake( 0, 0, viewSize.width, height )];
quayboardBar.delegate = self;
self.textView.inputAccessoryView = quayboardBar;
```

You can then implement as many keys as you like. They will be evenly distributed across the length of the keyboard.

```objc
[quayboardBar addKeyWithValue:@"1"];
[quayboardBar addKeyWithValue:@"2"];
[quayboardBar addKeyWithValue:@"3"];
[quayboardBar addKeyWithValue:@"4"];
[quayboardBar addKeyWithValue:@"5"];
[quayboardBar addKeyWithTitle:@"⇥" andValue:@"\t"];
```

If you're using a symbol as a title (like with the tab key above), you should consider setting an accessibility value on the key so that sight-impaired users can easily use your Quayboard. Implementing this is super simple and only takes a few moments. Touches like this take very little effort but have big returns for some of your potential users!

```objc
JSMQuayboardKey *tabKey = [quayboardBar addKeyWithTitle:@"⇥" andValue:@"\t"];
tabKey.accessibilityValue = @"Tab";
```

The final step is to implement the delegate method so that the textview is updated as expected. Here's an example (as shown in the example project) for updating a UITextView when a key is pressed:

```objc
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
```

Now Build and Run (⌘R). You should be presented with the Quayboard bar when you select the textview that you implemented it on. Pressing the keys will update the textview. Success feels good. Reward yourself with a Crunchie bar or something.

##Released under the BSD License

Copyright © 2013 Daniel Farrelly

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

*	Redistributions of source code must retain the above copyright notice, this list
	of conditions and the following disclaimer.
*	Redistributions in binary form must reproduce the above copyright notice, this
	list of conditions and the following disclaimer in the documentation and/or
	other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.