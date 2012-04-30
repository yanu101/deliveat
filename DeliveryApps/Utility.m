//
//  Utility.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@implementation Utility
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static CGFloat animatedDistance = 0;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

+ (void)scrollScreenBeginEditingInView:(UIView*)view inTextField:(UITextField*)textField show:(BOOL)isShow {
    if(isShow) {
        CGRect textFieldRect = [view.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect = [view.window convertRect:view.bounds fromView:view];
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
        
        CGFloat heightFraction = numerator / denominator;
        
        if (heightFraction < 0.0) {
            heightFraction = 0.0;
        }else if (heightFraction > 1.0) {
            heightFraction = 1.0;
        }
        
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        
        CGRect viewFrame = view.frame;
        viewFrame.origin.y -= animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [view setFrame:viewFrame];
        
        [UIView commitAnimations];
    } else {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [view setFrame:viewFrame];
        
        [UIView commitAnimations];
        
    }
    
}
+ (CGFloat)scrollScreenBeginEditingInView:(UIView*)view inTextField:(UITextField*)textField withTableView:(UITableView*)table show:(BOOL)isShow {
    if(isShow) {
        
        
        CGRect textFieldRect = [view.window convertRect:textField.bounds fromView:textField];
        CGRect viewRect = [view.window convertRect:view.bounds fromView:view];
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
        
        CGFloat heightFraction = numerator / denominator;
        
        if (heightFraction < 0.0) {
            heightFraction = 0.0;
        }else if (heightFraction > 1.0) {
            heightFraction = 1.0;
        }
        
        animatedDistance = PORTRAIT_KEYBOARD_HEIGHT;//floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        CGRect viewFrame = view.frame;
        //        [table setFrame:viewFrame];
        
        viewFrame.origin.y -= animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        NSArray* components = view.subviews;
        for(UIView* vi in components) {
            CGRect viFrame = vi.frame;
            if([vi isEqual:table]) {
                
                float h = view.frame.size.height - animatedDistance - 50;
                viFrame.size.height = h;
            } else if([[vi class] isEqual:[UIImageView class]]) {
                viFrame.origin.y -=100;
            } else if([[vi class] isEqual:[UIActivityIndicatorView class]]) {
                viFrame.origin.y -=150;
            } else {
                viFrame.origin.y -=animatedDistance;
            }
            
            [vi setFrame:viFrame];
        }
        //        [view setFrame:viewFrame];
        
        [UIView commitAnimations];
        
    } else {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        NSArray* components = view.subviews;
        for(UIView* vi in components) {
            CGRect viFrame = vi.frame;
            if([vi isEqual:table]) {
                NSLog(@"view.frame.size.height + animatedDistance : %f", (view.frame.size.height + animatedDistance));
                float h = 367;//view.frame.size.height + animatedDistance;
                viFrame.size.height = h;
            } else if([[vi class] isEqual:[UIImageView class]]) {
                viFrame.origin.y +=100;
            } else if([[vi class] isEqual:[UIActivityIndicatorView class]]) {
                viFrame.origin.y +=150;
            } else {
                viFrame.origin.y +=animatedDistance;
            }
            //            viFrame.origin.y +=animatedDistance;
            [vi setFrame:viFrame];
        }
        //        [table setFrame:viewFrame];
        //        [view setFrame:viewFrame];
        
        [UIView commitAnimations];
        
    }
    
}
+(NSString*)decodeEntities:(NSString*)html {
	@try {
		if(!html || (html == [NSNull null])) {
            return @"";
		}
		NSMutableString *s = [NSMutableString stringWithString:html];
		[s replaceOccurrencesOfString:@"&lt;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&gt;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&nbsp;" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&auml;" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&ouml;" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&quot;" withString:@"\'" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		[s replaceOccurrencesOfString:@"&#xd;" withString:@"\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
		return [NSString stringWithString:s];
	}
	@catch (NSException * e) {
		return html;
	}
	
}
+ (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title 
                                                        message:message 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles:nil];
    [alertView show];
    return;
}
//+ (void)markScreenInView:(UIView*)view show:(BOOL)isShow {
//    
//    if(isShow) {
//        CGRect windowFrame = view.frame;
//        
//        CALayer *sublayer = [CALayer layer];
//        sublayer.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.4].CGColor;
//        sublayer.frame = CGRectMake(0, 0, windowFrame.size.width-0, windowFrame.size.height-0);
//        [view.layer addSublayer:sublayer];
//    } else {
//        NSArray* sublayers = view.layer.sublayers;
//        CALayer* sublayer_ = [sublayers objectAtIndex:[sublayers count]-1];
//        [sublayer_ removeFromSuperlayer];
//    }
//}
@end
