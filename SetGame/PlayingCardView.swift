//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Светлана Лобан on 6/16/18.
//  Copyright © 2018 Светлана Лобан. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {
    
    var shape: String = "oval" { didSet {setNeedsDisplay(); setNeedsLayout()}}
    var shading: String = "solid" { didSet {setNeedsDisplay(); setNeedsLayout()}}
    var number: Int = 1 { didSet {setNeedsDisplay(); setNeedsLayout()}}
    var color: UIColor = UIColor.red { didSet {setNeedsDisplay(); setNeedsLayout()}}
    var isSelected: Bool = false { didSet {setNeedsDisplay();}}
    var isMatched: Bool = false { didSet {setNeedsDisplay();}}
    var isFaceUp: Bool = true { didSet {setNeedsDisplay();}}
    var isNew: Bool = false
    
    
    override func draw(_ rect: CGRect) {
        if isFaceUp {
            drawCardFace()
        } else {
            //         drawBack()
            
            if let cardBackImage = UIImage(named: "card-back",
                                           in: Bundle(for: self.classForCoder),
                                           compatibleWith: traitCollection) {
                cardBackImage.draw(in: bounds)
            }
            
        }
    }
    
    func drawCardFace() {
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        switch shape {
        case "oval":
            drawOval()
        case "diamond":
            drawDiamond()
        case "squiggle":
            drawSquiggle()
        default:
            drawOval()
        }
        
        //print ("\(isMatched)")
        if isMatched {
            layer.borderColor = UIColor.green.cgColor
        } else if isSelected {
            layer.borderColor = UIColor.red.cgColor
        } //else {
        //layer.borderColor = UIColor.green.cgColor
        //}
        setLayer()
    }
    
    func setLayer() {
        layer.borderWidth = ratioLineWidth
        layer.cornerRadius = cornerRadius
    }
    func drawOval() {
        let path = UIBezierPath()
        path.addArc(withCenter: origin.offsetBy(dx: ratioWidth/4, dy: 0), radius: ratioWidth/4, startAngle: CGFloat.pi/2, endAngle: -CGFloat.pi/2, clockwise: false)
        path.addLine(to: CGPoint(x: origin.x-ratioWidth/4, y: origin.y-ratioWidth/4))
        path.addArc(withCenter: origin.offsetBy(dx: -ratioWidth/4, dy: 0), radius: ratioWidth/4, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
        path.close()
        drawCard(with: path)
    }
    
    func drawDiamond() {
        let path = UIBezierPath()
        path.move(to: origin.offsetBy(dx: -ratioWidth/2, dy: 0))
        path.addLine(to: origin.offsetBy(dx: 0, dy: -ratioHeight/2))
        path.addLine(to: origin.offsetBy(dx: ratioWidth/2, dy: 0))
        path.addLine(to: origin.offsetBy(dx: 0, dy: ratioHeight/2))
        path.close()
        
        drawCard(with: path)
    }
    
    func drawSquiggle() {
        let leftPath = UIBezierPath()
        leftPath.move(to: origin.offsetBy(dx: 0, dy: ratioHeight*0.85))
        leftPath.addQuadCurve(to: origin.offsetBy(dx: -ratioWidth*0.32, dy: ratioHeight*0.9), controlPoint: controlPointQuad)
        leftPath.addCurve(to: origin.offsetBy(dx: 0, dy: ratioHeight*0.15), controlPoint1: cubicControlPoint1, controlPoint2: cubicControlPoint2)
        let rightPath = UIBezierPath(cgPath: leftPath.cgPath)
        rightPath.apply(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        rightPath.apply(CGAffineTransform.identity.translatedBy(x: bounds.width, y: bounds.height))
        rightPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: bounds.height*0.2))
        leftPath.append(rightPath)
        leftPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -bounds.height*0.1))
        drawCard(with: leftPath)
    }
    
    func drawCard(with path: UIBezierPath) {
        
        path.lineWidth = ratioLineWidth
        
        if number != 2 {
            // draw central
            shade(path: path)
        }
        if number == 2 {
            //draw higher and lower
            path.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -0.9*interval))
            shade(path: path)
            path.apply(CGAffineTransform.identity.translatedBy(x: 0, y: 1.8*interval))
            shade(path: path)
        } else if number == 3 {
            //draw higher and lower
            path.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -interval))
            shade(path: path)
            path.apply(CGAffineTransform.identity.translatedBy(x: 0, y: 2*interval))
            shade(path: path)
        }
        
    }
    
    private func shade(path: UIBezierPath) {
        color.setFill()
        color.setStroke()
        if shading == "striped" {
            UIGraphicsGetCurrentContext()?.saveGState()
            path.addClip()
            let stripe = UIBezierPath()
            let  dashedLine = [ ratioLineWidth/2, ratioLineWidth]
            stripe.setLineDash(dashedLine, count: dashedLine.count, phase: 0)
            stripe.lineWidth = bounds.height
            stripe.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            stripe.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
            stripe.stroke()
            UIGraphicsGetCurrentContext()?.restoreGState()
            path.stroke()
        } else if shading == "solid" {
            path.fill()
        } else {
            path.stroke() //outlined
        }
    }
    
    // MARK: Deal a card animation
    
    func animateDeal(from deckCenter: CGPoint, delay: TimeInterval) {
        let currentCenter = center
        let currentBounds = bounds
        
        center =  deckCenter
        alpha = 1
        bounds = CGRect(x: 0.0, y: 0.0, width: 0.6 * bounds.width,
                        height: 0.6 * bounds.height)
        isFaceUp = false
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1,
            delay: delay,
            options: [],
            animations:
            {
                self.center = currentCenter
                self.bounds = currentBounds
        },
            completion:
            { position in
                UIView.transition(
                    with: self,
                    duration: 0.3,
                    options: [.transitionFlipFromLeft],
                    animations:
                    {
                        self.isFaceUp = true
                }
                )
        }
        )
    }
    
    // MARK: Fly a card animation
    
    var addDiscardPile : (() -> Void)?
    
    func animateFly(to discardPileCenter: CGPoint, delay: TimeInterval) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1,
            delay: delay,
            options: [],
            animations:
            {
                self.center = discardPileCenter
        },
            completion:
            { position in
                UIView.transition(
                    with: self,
                    duration: 0.75,
                    options: [.transitionFlipFromLeft],
                    animations:
                    {
                        self.isFaceUp = false
                        self.transform = CGAffineTransform.identity
                            .rotated(by: CGFloat.pi / 2.0)
                        self.bounds = CGRect(x: 0.0, y: 0.0,
                                             width: 0.7*self.bounds.width,
                                             height: 0.7*self.bounds.height)
                },
                    completion:
                    { finished in
                        self.addDiscardPile?()
                }
                )
        }
        )
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
}

extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusBoundsHeight: CGFloat = 0.08
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizetoBoundsSize: CGFloat = 0.75
        
        static let heightScale: CGFloat = 0.2
        static let widthScale: CGFloat = 0.68
        static let lineWidthScale: CGFloat = 0.04
        
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var origin: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var ratioHeight: CGFloat {
        return bounds.height*SizeRatio.heightScale
    }
    
    private var ratioWidth: CGFloat {
        return bounds.width*SizeRatio.widthScale
    }
    
    private var ratioLineWidth: CGFloat {
        return bounds.width*SizeRatio.lineWidthScale
    }
    
    private var interval: CGFloat {
        return bounds.size.height * (SizeRatio.heightScale
            + SizeRatio.cornerRadiusBoundsHeight)
    }
    private var controlPointQuad: CGPoint {
        return CGPoint(x: bounds.width*0.35, y: bounds.height*0.6)
    }
    
    private var cubicControlPoint1: CGPoint {
        return CGPoint(x: bounds.width*0.06, y: bounds.height*0.7)
    }
    
    private var cubicControlPoint2: CGPoint {
        return CGPoint(x: bounds.width*0.06, y: bounds.height*0.3)
    }
    
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
