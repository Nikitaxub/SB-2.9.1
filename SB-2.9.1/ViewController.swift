//
//  ViewController.swift
//  SB-2.9.1
//
//  Created by xubuntus on 24.11.2021.
//

import Spring

class ViewController: UIViewController {

    @IBOutlet var avatarView: SpringImageView!
    
    @IBOutlet var nextAnimationButton: UIButton!
    
    @IBOutlet var infoLabel: UILabel!
    
    private let scaleXY: ClosedRange<CGFloat> = 0.5...5
    private let velocity: ClosedRange<CGFloat> = 0.5...2
    private let duration: ClosedRange<CGFloat> = 0.2...2
    
    private var firstRun = true
    
    private var nextPresetName = "\(Spring.AnimationPreset.allCases[Int.random(in: 0...Spring.AnimationPreset.allCases.count - 1)])"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRandomAnimation()
        updateInfo()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        nextAnimationButton.layer.cornerRadius = view.frame.width / 40
    }

    @IBAction func runNextAnimation() {
        addRandomAnimation()
        avatarView.animate()
        if !firstRun {
            updateInfo()
        } else {
            firstRun.toggle()
        }
        nextPresetName = "\(Spring.AnimationPreset.allCases[Int.random(in: 0...Spring.AnimationPreset.allCases.count - 1)])"
        nextAnimationButton.setTitle("Run \(nextPresetName)", for: .normal)
    }
    
    private func addRandomAnimation() -> Void {
        let animationCurve = Spring.AnimationCurve.allCases[Int.random(in: 0...Spring.AnimationCurve.allCases.count - 1)]
        avatarView.animation = nextPresetName
        avatarView.curve = "\(animationCurve)"
        avatarView.duration = CGFloat.random(in: duration)
        avatarView.scaleX = CGFloat.random(in: scaleXY)
        avatarView.scaleY = CGFloat.random(in: scaleXY)
        avatarView.velocity = CGFloat.random(in: velocity)
    }
    
    private func updateInfo() -> Void {
        infoLabel.text = """
        Animation: \(avatarView.animation)
        Curve: \(avatarView.curve)
        Duration: \(String(format: "%.2f", avatarView.duration))
        ScaleX: \(String(format: "%.2f", avatarView.scaleX))
        ScaleY: \(String(format: "%.2f", avatarView.scaleY))
        Velocity: \(String(format: "%.2f", avatarView.velocity))
        """
    }
}
