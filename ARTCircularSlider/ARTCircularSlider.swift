//
//  ARTCircularSlider.swift
//  ARTCircularSlider
//
//  Created by Artwalk on 10/30/14.
//  Copyright (c) 2014 Artwalk. All rights reserved.
//

import UIKit

//import QuartzCore
//import CoreImage

//@IBDesignable
class ARTCircularSlider : UIControl {
    
    var _lineWidth = CGFloat(12)
    let _unfilledColor = UIColor.grayColor()
    let _filledColor = UIColor.purpleColor()
    
    var _centerPoint:CGPoint!
    var _halfHeight:CGFloat!
    var _halfWidth:CGFloat!
    var _radius:CGFloat!
    
    let _maximumValue:CGFloat = 100.0
    let _minimumValue:CGFloat = 0.0
    
    var _fixedAngle:CGFloat!
    
    var _angle:CGFloat = 0
    var _curValue:CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }
    
    // Drawing
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var ctx = UIGraphicsGetCurrentContext()
        
        CGContextAddArc(ctx, _halfWidth, _halfHeight, _radius, 0, CGFloat(M_PI*2), 0)
        drawCircle(ctx, color: _unfilledColor)
        
        CGContextAddArc(ctx, _halfWidth, _halfHeight, _radius, CGFloat(M_PI*3/2), CGFloat(3*M_PI/2)-toRad(_angle), 0)
        drawCircle(ctx, color: _filledColor)
        
        println("\(_angle)")
    }
    
    func configView () {
        let size = frame.size
        _halfHeight = size.height/2
        _halfWidth = size.width/2
        _centerPoint = CGPointMake(_halfWidth, _halfHeight)
        _radius = size.width/2 - _lineWidth - 10
        backgroundColor = UIColor.clearColor()
    }
    
    func drawCircle (ctx:CGContextRef, color:UIColor  ) {
        color.setStroke()
        CGContextSetLineWidth(ctx, _lineWidth)
        CGContextSetLineCap(ctx, kCGLineCapButt)
        CGContextDrawPath(ctx, kCGPathStroke)
    }
    
    // UIControl
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        let lastPoint = touch.locationInView(self)
        moveHandle(lastPoint)
        
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        
    }
    
    func moveHandle(point:CGPoint) {
        var curAngle = floor(angleFromNorth(_centerPoint, p2: point, angle: false))
        _angle = CGFloat(360-90) - curAngle
        _curValue = valueFromAngle()
        self.setNeedsDisplay()
    }
    
    // helper
    func angleFromNorth(p1:CGPoint, p2:CGPoint ,angle:Bool) -> CGFloat {
        var p = CGPointMake(p2.x-p1.x, p2.y-p1.y)
        let vmag = sqrt(p.x*p.x + p.y*p.y)
        p.x /= vmag
        p.y /= vmag
        let radians = atan2(p.y, p.x)
        let result = toDeg(radians)
        
        return result >= 0 ? result : result+360
    }
    
    func valueFromAngle() -> CGFloat {
        _curValue =  _angle < 0 ? -_angle : (270 + 90 - _angle)
        _fixedAngle = _curValue
        
        return (_curValue * (_maximumValue - _minimumValue))/CGFloat(360)
    }
    
    func toDeg(v:CGFloat) -> CGFloat {
        return CGFloat(180.0) * v / CGFloat(M_PI)
    }
    
    func toRad (v:CGFloat) -> CGFloat {
        return CGFloat(M_PI) * v / CGFloat(180)
    }
}
