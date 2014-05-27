//
//  UIColor+RZExtensions.m
//
//  Created by Nick Donaldson on 5/20/14.

// Copyright 2014 Raizlabs and other contributors
// http://raizlabs.com/
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIColor+RZExtensions.h"

NS_ENUM(NSInteger, RZColorContrastColorIndex)
{
    r = 0,
    g,
    b,
    a
};

@implementation UIColor (RZExtensions)

+ (UIColor *)rz_colorFrom8BitRed:(uint8_t)r green:(uint8_t)g blue:(uint8_t)b
{
    return [self rz_colorFrom8BitRed:r green:g blue:b alpha:255];
}

+ (UIColor *)rz_colorFrom8BitRed:(uint8_t)r green:(uint8_t)g blue:(uint8_t)b alpha:(uint8_t)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

+ (UIColor *)rz_colorFrom8BitWhite:(uint8_t)white
{
    return [self rz_colorFrom8BitWhite:white alpha:255];
}

+ (UIColor *)rz_colorFrom8BitWhite:(uint8_t)white alpha:(uint8_t)alpha
{
    return [UIColor colorWithWhite:white/255.0 alpha:alpha/255.0];
}

+ (UIColor *)rz_colorFromHex:(uint32_t)hexLiteral
{
    uint8_t r = (uint8_t)(hexLiteral >> 16);
    uint8_t g = (uint8_t)(hexLiteral >> 8);
    uint8_t b = (uint8_t)hexLiteral;
    
    return [self rz_colorFrom8BitRed:r green:g blue:b];
}

+ (UIColor *)rz_colorFromHexString:(NSString *)string
{
    NSParameterAssert(string);
    if ( string == nil ) {
        return nil;
    }
    
    unsigned int hexInteger = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"x#"]];
    [scanner scanHexInt:&hexInteger];
    
    return [self rz_colorFromHex:hexInteger];
}

+ (UIColor *)rz_contrastForColor:(UIColor *)color
{
    const CGFloat *colorValues = CGColorGetComponents(color.CGColor);
    
    CGFloat rValue = colorValues[r];
    CGFloat gValue = colorValues[g];
    CGFloat bValue = colorValues[b];
    
    CGFloat yiq = ( (rValue * 299.0f) + (gValue * 587.0f) + (bValue * 114.0f) ) / 1000.0f;
    
    return ( yiq >= 128.0f ) ? [UIColor blackColor] : [UIColor whiteColor];
}

@end
