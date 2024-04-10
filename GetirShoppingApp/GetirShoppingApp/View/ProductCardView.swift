import UIKit

class ProductCardView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 242/255, green: 240/255, blue: 250/255, alpha: 1).cgColor // #F2F0FA
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Open Sans", size: 12)
        label.textColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1) // #191919
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Open Sans", size: 12)
        label.textColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 1) // #697488
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Open Sans", size: 14)
        label.textColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1) // #5D3EBC
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepperContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.1
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    let stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        stackView.layer.shadowRadius = 3
        stackView.layer.shadowOpacity = 0.1
        stackView.layer.cornerRadius = 8
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Open Sans", size: 12)
        label.textColor = UIColor.white
        label.text = "0"
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1) // #5D3EBC
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func plusButtonTapped() {
        // Adet bilgisini artır
        guard let quantity = Int(quantityLabel.text ?? "0") else { return }
        quantityLabel.text = "\(quantity + 1)"
        updateStepperLayout()
    }

    @objc private func minusButtonTapped() {
           // Adet bilgisini azalt
           guard var quantity = Int(quantityLabel.text ?? "0"), quantity > 0 else { return }
           quantity -= 1
           quantityLabel.text = "\(quantity)"
           updateStepperLayout()
       }
    
    private func setupViews() {
           addSubview(imageView)
           addSubview(priceLabel)
           addSubview(nameLabel)
           addSubview(attributeLabel)
           addSubview(stepperStackView)
           
           stepperStackView.addArrangedSubview(plusButton)
           stepperStackView.addArrangedSubview(quantityLabel)
           stepperStackView.addArrangedSubview(minusButton)
           
           NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: topAnchor),
               imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
               imageView.heightAnchor.constraint(equalToConstant: 103.67),
               
               priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
               priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
               
               nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
               nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
               
               attributeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
               attributeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               attributeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
               
               stepperStackView.widthAnchor.constraint(equalToConstant: 32),
               stepperStackView.heightAnchor.constraint(equalToConstant: 96),
               stepperStackView.topAnchor.constraint(equalTo: topAnchor, constant: -8),
               stepperStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
           ])
           
           // İlk başta sadece artı butonunu göster
           quantityLabel.isHidden = true
           minusButton.isHidden = true
           
           plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
           minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
       }
    private func updateStepperLayout() {
          guard let quantity = Int(quantityLabel.text ?? "0") else { return }
          
          if quantity > 0 {
              // Adet 0 değilse artı butonu, adet bilgisi ve eksi butonunu göster
              quantityLabel.isHidden = false
              minusButton.isHidden = false
              
              if quantity > 1 {
                  // Adet 1'den fazla ise eksi butonunun görüntüsünü değiştir
                  minusButton.setImage(UIImage(named: "Item"), for: .normal)
              } else {
                  minusButton.setImage(UIImage(named: "delete"), for: .normal)
              }
          } else {
              quantityLabel.isHidden = true
              minusButton.isHidden = true
          }
        let containerHeight: CGFloat = quantity > 0 ? 96 : 32
            stepperContainerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
      }
}
