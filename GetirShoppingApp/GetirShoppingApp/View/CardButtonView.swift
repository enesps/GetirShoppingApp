import UIKit

class CardButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        let cornerRadius: CGFloat = 8
        self.layer.cornerRadius = cornerRadius

        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        let icon = UIImageView(image: UIImage(named: "Icon"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 34).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        iconView.addSubview(icon)
        self.addSubview(iconView)
        
        
        let amount = UIView()
        amount.layer.cornerRadius = cornerRadius
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.widthAnchor.constraint(equalToConstant: 57).isActive = true
        amount.heightAnchor.constraint(equalToConstant: 34).isActive = true
        amount.backgroundColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textAlignment = .center
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1)
        amount.addSubview(label)
        
        self.addSubview(amount)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: self.topAnchor),
            amount.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            amount.topAnchor.constraint(equalTo: self.topAnchor),
            amount.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            amount.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: amount.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: amount.centerYAnchor)
        ])
    }
}

// Kullanımı:
let cardButton = CardButton()
