import UIKit

class StepperView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        let stepperControls = UIButton()
        stepperControls.translatesAutoresizingMaskIntoConstraints = false
        stepperControls.setImage(UIImage(named: "Path"), for: .normal)
        stepperControls.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        stepperControls.layer.cornerRadius = 16
        stepperControls.layer.borderWidth = 1
        stepperControls.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        self.addSubview(stepperControls)
        
        NSLayoutConstraint.activate([
               stepperControls.widthAnchor.constraint(equalToConstant: 32),
               stepperControls.heightAnchor.constraint(equalToConstant: 32),
               stepperControls.topAnchor.constraint(equalTo: self.topAnchor),
               stepperControls.leadingAnchor.constraint(equalTo: self.leadingAnchor)
           ])
    }
}

// Kullanımı:
let stepper = StepperView()
