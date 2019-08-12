
import QuartzCore

class RadialGradientLayer: CALayer {
    var gradientCenter = CGPoint.zero
    override func draw(in context: CGContext) {
        super.draw(in: context)
        let locationsCount = 2
        let locations : [CGFloat] = [0.0, 1.0]
        let colors : [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient.init(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locationsCount) {
            let radius = min(bounds.size.width, bounds.size.height)
            
            context.drawRadialGradient(gradient, startCenter: gradientCenter, startRadius: 0, endCenter: gradientCenter, endRadius: radius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
    }
}
