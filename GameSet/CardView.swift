//
//  CardView.swift
//  GameSet
//
//  Created by Ivanych Puy on 07.06.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//

import UIKit
@IBDesignable
class CardView: UIView {
    
    var qty: Int = 3 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var figure: Card.Figure = .squiggle { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var filling: Card.Filling = .solid { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var color: UIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize {
        didSet { setNeedsDisplay() }
    }
    
//    private lazy var upperLeftCornerLabel: UILabel = createCornerLabel()
//    private lazy var lowerRightCornerLabel: UILabel = createCornerLabel()
    
    @objc func adjustFaceCardScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1.0
        default: break
        }
    }
    
//    private func createCornerLabel() -> UILabel {
//        let label = UILabel()
//        label.numberOfLines = 0
//        addSubview(label)
//        return label
//    }
    
//    private var cornerString: NSAttributedString {
//        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
//    }

//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
//        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        roundedRect.addClip()
//        UIColor.white.setFill()
//        roundedRect.fill()
//        if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
//            faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
//        }
        
        let _ = filler(Of: pathFigure())
    }
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
//    private func configureCornerLabel(_ label: UILabel) {
//        label.attributedText = cornerString
//        label.frame.size = CGSize.zero
//        label.sizeToFit()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        configureCornerLabel(upperLeftCornerLabel)
//        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
//
//        configureCornerLabel(lowerRightCornerLabel)
//        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
//        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset).offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }
    
//    обновление на случай использования масштабирования в "доступность"
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }

//
//
    func pathDiamond(In rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.close()
        
        return path
    }
    
    func pathSquiggle(In rect: CGRect) -> UIBezierPath {
        print(rect.maxY - rect.minY*2, rect.minY, rect.maxY)
        let path = UIBezierPath ()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), controlPoint: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), controlPoint: CGPoint(x: rect.midX, y: rect.minY - rect.height ))
        return path
    }
    
    func pathOval(In rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath(ovalIn: rect)
        
        return path
    }
    
    func pathFigure() -> UIBezierPath {
        let path = UIBezierPath()
        for num in 1...qty {
            switch figure {
            case .oval:
                path.append(pathOval(In: rect(Number: num, Of: qty)))
            case .diamond:
                path.append(pathDiamond(In: rect(Number: num, Of: qty)))
            case .squiggle:
                path.append(pathSquiggle(In: rect(Number: num, Of: qty)))
            }
        }
        
        return path
    }
    
    func filler(Of path: UIBezierPath) -> UIBezierPath{
        switch filling {
        case .solid:
            color.setFill()
            path.fill()
        case .striped:
            color.setFill()
        case .unfilled:
            color.setStroke()
            path.stroke()
        }
        return path
    }
}

extension CardView {
    private static let padding: CGFloat = 5.0
    
//    некий фрейм для одной фигуры
    private func rect(Number n: Int, Of m: Int) -> CGRect {
        let width = bounds.maxX - CardView.padding * 2
        let height = (bounds.maxY - CardView.padding * CGFloat(1 + m)) / CGFloat(m)
        let minX = bounds.minX + CardView.padding
        let minY = bounds.minY + CardView.padding * CGFloat(n) + height * CGFloat(n - 1)
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
}

extension CGRect {
    
    
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) ->  CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
