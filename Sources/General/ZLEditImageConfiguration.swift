//
//  ZLEditImageConfiguration.swift
//  ZLPhotoBrowser
//
//  Created by long on 2021/12/17.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

@objc public protocol ZLImageStickerContainerDelegate where Self: UIView {
    
    @objc var selectImageBlock: ( (UIImage) -> Void )? { get set }
    
    @objc var hideBlock: ( () -> Void )? { get set }
    
    @objc func show(in view: UIView)
    
}

public class ZLEditImageConfiguration: NSObject {

    @objc public enum EditTool: Int {
        case draw
        case clip
        case imageSticker
        case textSticker
        case mosaic
        case filter
        case adjust
    }
    
    @objc public enum AdjustTool: Int {
        case brightness
        case contrast
        case saturation
    }
    
    private var pri_tools: [ZLEditImageConfiguration.EditTool] = [.draw, .clip, .imageSticker, .textSticker, .mosaic, .filter, .adjust]
    /// Edit image tools. (Default order is draw, clip, imageSticker, textSticker, mosaic, filtter)
    /// Because Objective-C Array can't contain Enum styles, so this property is invalid in Objective-C.
    /// - warning: If you want to use the image sticker feature, you must provide a view that implements ZLImageStickerContainerDelegate.
    public var tools: [ZLEditImageConfiguration.EditTool] {
        set {
            pri_tools = newValue
        }
        get {
            if pri_tools.isEmpty {
                return [.draw, .clip, .imageSticker, .textSticker, .mosaic, .filter]
            } else {
                return pri_tools
            }
        }
    }
    
    private var pri_drawColors: [UIColor] = [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
    /// Draw colors for image editor.
    @objc public var drawColors: [UIColor] {
        set {
            pri_drawColors = newValue
        }
        get {
            if pri_drawColors.isEmpty {
                return [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
            } else {
                return pri_drawColors
            }
        }
    }
    
    /// The default draw color. If this color not in editImageDrawColors, will pick the first color in editImageDrawColors as the default.
    @objc public var defaultDrawColor = zlRGB(241, 79, 79)
    
    private var pri_clipRatios: [ZLImageClipRatio] = [.custom]
    /// Edit ratios for image editor.
    @objc public var clipRatios: [ZLImageClipRatio] {
        set {
            pri_clipRatios = newValue
        }
        get {
            if pri_clipRatios.isEmpty {
                return [.custom]
            } else {
                return pri_clipRatios
            }
        }
    }
    
    private var pri_textStickerTextColors: [UIColor] = [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
    /// Text sticker colors for image editor.
    @objc public var textStickerTextColors: [UIColor] {
        set {
            pri_textStickerTextColors = newValue
        }
        get {
            if pri_textStickerTextColors.isEmpty {
                return [.white, .black, zlRGB(241, 79, 79), zlRGB(243, 170, 78), zlRGB(80, 169, 56), zlRGB(30, 183, 243), zlRGB(139, 105, 234)]
            } else {
                return pri_textStickerTextColors
            }
        }
    }
    
    /// The default text sticker color. If this color not in textStickerTextColors, will pick the first color in textStickerTextColors as the default.
    @objc public var textStickerDefaultTextColor = UIColor.white
    
    private var pri_filters: [ZLFilter] = ZLFilter.all
    /// Filters for image editor.
    @objc public var filters: [ZLFilter] {
        set {
            pri_filters = newValue
        }
        get {
            if pri_filters.isEmpty {
                return ZLFilter.all
            } else {
                return pri_filters
            }
        }
    }
    
    @objc public var imageStickerContainerView: (UIView & ZLImageStickerContainerDelegate)? = nil
    
    private var pri_adjustTools: [ZLEditImageConfiguration.AdjustTool] = [.brightness, .contrast, .saturation]
    /// Adjust image tools. (Default order is brightness, contrast, saturation)
    /// Valid when the tools contain EditTool.adjust
    /// Because Objective-C Array can't contain Enum styles, so this property is invalid in Objective-C.
    public var adjustTools: [ZLEditImageConfiguration.AdjustTool] {
        set {
            pri_adjustTools = newValue
        }
        get {
            if pri_adjustTools.isEmpty {
                return [.brightness, .contrast, .saturation]
            } else {
                return pri_adjustTools
            }
        }
    }
    
}

// MARK: chaining
extension ZLEditImageConfiguration {
    
    @discardableResult
    public func tools(_ tools: [ZLEditImageConfiguration.EditTool]) -> ZLEditImageConfiguration {
        self.tools = tools
        return self
    }
    
    @discardableResult
    public func drawColors(_ colors: [UIColor]) -> ZLEditImageConfiguration {
        drawColors = colors
        return self
    }
    
    public func defaultDrawColor(_ color: UIColor) -> ZLEditImageConfiguration {
        defaultDrawColor = color
        return self
    }
    
    @discardableResult
    public func clipRatios(_ ratios: [ZLImageClipRatio]) -> ZLEditImageConfiguration {
        clipRatios = ratios
        return self
    }
    
    @discardableResult
    public func textStickerTextColors(_ colors: [UIColor]) -> ZLEditImageConfiguration {
        textStickerTextColors = colors
        return self
    }
    
    @discardableResult
    public func textStickerDefaultTextColor(_ color: UIColor) -> ZLEditImageConfiguration {
        textStickerDefaultTextColor = color
        return self
    }
    
    @discardableResult
    public func filters(_ filters: [ZLFilter]) -> ZLEditImageConfiguration {
        self.filters = filters
        return self
    }
    
    @discardableResult
    public func imageStickerContainerView(_ view: (UIView & ZLImageStickerContainerDelegate)?) -> ZLEditImageConfiguration {
        imageStickerContainerView = view
        return self
    }
    
}

// MARK: 裁剪比例
public class ZLImageClipRatio: NSObject {
    
    public var title: String
    
    public let whRatio: CGFloat
    
    let isCircle: Bool
    
    @objc public init(title: String, whRatio: CGFloat, isCircle: Bool = false) {
        self.title = title
        self.whRatio = isCircle ? 1 : whRatio
        self.isCircle = isCircle
        super.init()
    }
    
}

extension ZLImageClipRatio {
    
    static func ==(lhs: ZLImageClipRatio, rhs: ZLImageClipRatio) -> Bool {
        return lhs.whRatio == rhs.whRatio && lhs.title == rhs.title
    }
    
}

extension ZLImageClipRatio {
    
    @objc public static let custom = ZLImageClipRatio(title: "custom", whRatio: 0)
    
    @objc public static let circle = ZLImageClipRatio(title: "circle", whRatio: 1, isCircle: true)
    
    @objc public static let wh1x1 = ZLImageClipRatio(title: "1 : 1", whRatio: 1)
    
    @objc public static let wh3x4 = ZLImageClipRatio(title: "3 : 4", whRatio: 3.0/4.0)
    
    @objc public static let wh4x3 = ZLImageClipRatio(title: "4 : 3", whRatio: 4.0/3.0)
    
    @objc public static let wh2x3 = ZLImageClipRatio(title: "2 : 3", whRatio: 2.0/3.0)
    
    @objc public static let wh3x2 = ZLImageClipRatio(title: "3 : 2", whRatio: 3.0/2.0)
    
    @objc public static let wh9x16 = ZLImageClipRatio(title: "9 : 16", whRatio: 9.0/16.0)
    
    @objc public static let wh16x9 = ZLImageClipRatio(title: "16 : 9", whRatio: 16.0/9.0)
    
}
