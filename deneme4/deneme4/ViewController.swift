import UIKit

struct ProductCard {
  let imageName: String
  let productName: String
  let productAttribute: String
  let price: String
}

class ProductCell: UICollectionViewCell {
  static let reuseIdentifier = "productCell"

  private let productImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let productNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let productAttributeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    label.numberOfLines = 1
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(productImageView)
    addSubview(productNameLabel)
    addSubview(productAttributeLabel)
    addSubview(priceLabel)

    NSLayoutConstraint.activate([
      productImageView.topAnchor.constraint(equalTo: topAnchor),
      productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      productImageView.heightAnchor.constraint(equalToConstant: 153),

      productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4),
      leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor, constant: 8),
      trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 8),

      productAttributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
      leadingAnchor.constraint(equalTo: productAttributeLabel.leadingAnchor, constant: 8),
      trailingAnchor.constraint(equalTo: productAttributeLabel.trailingAnchor, constant: 8),

      priceLabel.topAnchor.constraint(equalTo: productAttributeLabel.bottomAnchor, constant: 4),
      leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 8),
      bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
    ])
  }

  func configure(with product: ProductCard) {
    productImageView.image = UIImage(named: product.imageName)
    productNameLabel.text = product.productName
    productAttributeLabel.text = product.productAttribute
    priceLabel.text = product.price
  }
}

class ViewController: UIViewController {
  
  private let horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  private let verticalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 8
    layout.minimumLineSpacing = 8
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
    private var productData: [ProductCard] = [
    ProductCard(imageName: "card-image", productName: "Ürün Adı 1", productAttribute: "Özellik 1", price: "100 TL"),
    ProductCard(imageName: "card-image", productName: "Ürün Adı 2", productAttribute: "Özellik 2", price: "200 TL"),
    ProductCard(imageName: "card-image", productName: "Ürün Adı 3", productAttribute: "Özellik 3", price: "300"),
                ProductCard(imageName: "card-image", productName: "Ürün Adı 4", productAttribute: "Özellik 4", price: "400 TL"),
                ProductCard(imageName: "card-image", productName: "Ürün Adı 5", productAttribute: "Özellik 5", price: "500 TL"),
              ]
              
              override func viewDidLoad() {
                super.viewDidLoad()
                setupViews()
                setupData()
              }
              
              private func setupViews() {
                view.addSubview(horizontalCollectionView)
                view.addSubview(verticalCollectionView)
                  NSLayoutConstraint.activate([
                    horizontalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    // leadingAnchor is on safeAreaLayoutGuide
                    horizontalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    horizontalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    horizontalCollectionView.heightAnchor.constraint(equalToConstant: 153),
                    
                    verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 8),
                    verticalCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    verticalCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    verticalCollectionView.bottomAnchor.constraint(equalTo: verticalCollectionView.bottomAnchor),
                  ])
                
                // Collection view delegate and data source methods
                horizontalCollectionView.delegate = self
                horizontalCollectionView.dataSource = self
                verticalCollectionView.delegate = self
                verticalCollectionView.dataSource = self
                
                // Register cell
                horizontalCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
                verticalCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
              }
              
              private func setupData() {
                // Generate random product data
                let productNames = ["Elma", "Muz", "Portakal", "Armut", "Karpuz", "Çilek", "Kivi", "Ananas", "Mango"]
                let productAttributes = ["Kırmızı", "Yeşil", "Sarı", "Tatlı", "Ekşi", "Büyük", "Küçük", "Organik"]
                let prices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                
                for _ in 0..<10 {
                  let randomImageName = "image\(Int.random(in: 1...5))"
                  let randomProductName = productNames.randomElement()!
                  let randomProductAttribute = productAttributes.randomElement()!
                  let randomPrice = prices.randomElement()!
                  
                  productData.append(ProductCard(imageName: randomImageName, productName: randomProductName, productAttribute: randomProductAttribute, price: "\(randomPrice) TL"))
                }
                
                horizontalCollectionView.reloadData()
                verticalCollectionView.reloadData()
              }
            }

            extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
              func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return productData.count
              }
              
              func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
                cell.configure(with: productData[indexPath.row])
                return cell
              }
            }
