//
//  RStepper.swift
//  RStepper
//
//  Created by Rajat on 2/6/18.
//  Copyright © 2018 Rajat. All rights reserved.
//

import UIKit

class RStepper: UIControl {
    
    typealias StepperValueDidChange = (RStepper) -> ()
    
    //UI Components
    private var stackView: UIStackView!
    private var incrementButton: UIButton!
    private var decrementButton: UIButton!
    private var labelValue: UILabel!
    
    var stepperValueChanged: StepperValueDidChange?
    
    @IBInspectable var value: CGFloat = 0 {
        didSet{
            if value < minimumValue {
                value = minimumValue
            } else if value > maximumValue {
                value = maximumValue
            }
            self.checkButtonInteraction()
            sendActions(for: .valueChanged)
            self.stepperValueChanged?(self)
            labelValue?.text = Int(value).description
        }
    }
    
    @IBInspectable var minimumValue: CGFloat = 0 {
        didSet{
            if minimumValue > maximumValue {
               let ex = NSException(name: .invalidArgumentException, reason: "Stepper: Minimum value cannot be greater than the maximum value.", userInfo: nil)
                ex.raise()
            }
            if self.value < minimumValue {
                self.value = minimumValue
            }
            self.checkButtonInteraction()
        }
    }
    
    @IBInspectable var maximumValue: CGFloat = 100  {
        didSet {
            if maximumValue < minimumValue {
                let ex = NSException(name: .invalidArgumentException, reason: "Stepper: Maximum value cannot be less than the minimum value.", userInfo: nil)
                    ex.raise()
            }
            if self.value > maximumValue {
                self.value = maximumValue
            }
            self.checkButtonInteraction()
        }
    }
    
    @IBInspectable var stepValue: CGFloat = 1 {
        didSet{
            if stepValue <= 0 {
                let ex = NSException(name: .invalidArgumentException, reason: "Stepper: Step value cannot be less than or equal to zero.", userInfo: nil)
                ex.raise()
            }
        }
    }
    
//    @IBInspectable var autoRepeat: Bool = false
//
//    @IBInspectable var autoRepeatInterval: CGFloat {
//        didSet{
//
//            self.autoRepeat = autoRepeatInterval != 0
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setDefaultState()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setDefaultState()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setDefaultState()
    }
    
    func setDefaultState() {
        
        self.backgroundColor = .clear
        incrementButton = stepperButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24), image: #imageLiteral(resourceName: "plus.png"))
        labelValue = UILabel()
        decrementButton = stepperButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24), image: #imageLiteral(resourceName: "minus.png"))
        labelValue.text = "0"
        //Configure Container StackView
        
        stackView = UIStackView(frame: bounds)
        stackView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        stackView.addArrangedSubview(decrementButton)
        stackView.addArrangedSubview(labelValue)
        stackView.addArrangedSubview(incrementButton)
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        self.addSubview(stackView)
        
        self.checkButtonInteraction()
    }
    
    func stepperButton(frame: CGRect, image: UIImage) -> UIButton {
        let button = UIButton(frame: frame)
        
        button.setImage(image, for: .normal)
        button.autoresizingMask = []
        
        button.addTarget(self, action: #selector(didEndButtonPress(_:)), for: [.touchDragExit,.touchUpInside,.touchCancel])
        button.addTarget(self, action: #selector(didPressButton(_:)), for: [.touchDragEnter,.touchDown])
        
        return button
    }
    
    @objc func didPressButton(_ button: UIButton) {
        self.changeValueForButton(button: button)
//        if self.autoRepeat {
//            didPressButton(button: button)
//
//            self.perform(#selector(didPressButton(button:)), with: button, afterDelay: Double(autoRepeatInterval))
//        }
    }
    
    @objc func didEndButtonPress(_ sender: AnyObject) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    
    func changeValueForButton(button: UIButton) {
        let changeValue = (button == decrementButton) ? -1 * stepValue : stepValue
        let newValue = value + changeValue
        if newValue < minimumValue || newValue > maximumValue {
            return
        }
        value = newValue
    }
    
    func checkButtonInteraction() {
        let atMax = (value >= maximumValue)
        let atMin = (value <= minimumValue)
        
        incrementButton.isUserInteractionEnabled = !atMax
        incrementButton.alpha = atMax ? 0.5 : 1.0
//        incrementButton.isEnabled = !atMax
        
        decrementButton.isUserInteractionEnabled = !atMin
        decrementButton.alpha = atMin ? 0.5 : 1.0
//        decrementButton.isEnabled = !atMin
    }
}
