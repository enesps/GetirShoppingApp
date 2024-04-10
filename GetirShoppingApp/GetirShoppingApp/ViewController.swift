import UIKit
struct Product {
    let name: String
    let price: Double
    let image: UIImage
    // Diğer gerekli özellikler buraya eklenebilir
}
class ViewController: UIViewController {
    let mockData = [
           ["Market", "Product Name 1", "Attribute 1", "₺10,00"],
           ["Market", "Product Name 2", "Attribute 2", "₺20,00"],
           ["Market", "Product Name 3", "Attribute 3", "₺30,00"],
           ["Market", "Product Name 4", "Attribute 4", "₺40,00"],
           ["Market", "Product Name 5", "Attribute 5", "₺50,00"]
       ]
    let horizontalCellIdentifier = "ProductCardCellHorizontal"
     let verticalCellIdentifier = "ProductCardCellVertical"
     
     lazy var horizontalCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.backgroundColor = UIColor.white
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: horizontalCellIdentifier)
         return collectionView
     }()
     
     lazy var verticalCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumInteritemSpacing = 16
         layout.minimumLineSpacing = 16
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.backgroundColor = UIColor.white
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.showsVerticalScrollIndicator = false
         collectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: verticalCellIdentifier)
         return collectionView
     }()
     
    private let productCardReuseIdentifier = "ProductCardCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Örnek kullanım
        let cardButton = CardButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cardButton)
        // Navigation Bar'ın sağ öğesi olarak eklemek için aşağıdaki kodu kullanabilirsiniz
        // navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cardButton)

//        navigationController?.navigationBar.backgroundColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
//        navigationController?.navigationBar.isTranslucent = false // Transparanlık özelliğini kapattık

        title = "Ürünler"
        // Navigation bar'ın sağ tarafına bir düğme oluşturma
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupViews()
        
        // Register cell classes
        horizontalCollectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: productCardReuseIdentifier)
        verticalCollectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: productCardReuseIdentifier)
        
        // Set delegates
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
      }
    private func setupViews() {
        view.addSubview(horizontalCollectionView)
              view.addSubview(verticalCollectionView)
              
              NSLayoutConstraint.activate([
                  horizontalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
                  horizontalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -1),
                  horizontalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
                  horizontalCollectionView.heightAnchor.constraint(equalToConstant: 185),
                  
                  verticalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 305),
                  verticalCollectionView.widthAnchor.constraint(equalToConstant: 375),
                  verticalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                  verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
              ])
    }
    
      // MARK: - UICollectionViewDataSource methods
     
  }
extension ViewController :  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Assuming some dummy data for demonstration
        return mockData.count // Change as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellIdentifier, for: indexPath) as! ProductCardCollectionViewCell
            cell.configure(with: mockData[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: verticalCellIdentifier, for: indexPath) as! ProductCardCollectionViewCell
            cell.configure(with: mockData[indexPath.item])
            return cell
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView {
                return CGSize(width: 120, height: 185)
            } else {
                let width = (375 - 16 * 4) / 3 // 16*4: padding ve aralıklar
                return CGSize(width: width, height: 185)
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
class ProductCardCollectionViewCell: UICollectionViewCell {
    let productCardView = ProductCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(productCardView)
        productCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            productCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            productCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(with data: [String]) {
        productCardView.priceLabel.text = "23.59TL"
        productCardView.attributeLabel.text = "Yemek"
        productCardView.nameLabel.text = " Atistirmalik"
        productCardView.imageView.image = UIImage(named: "card-image")
    }
}
