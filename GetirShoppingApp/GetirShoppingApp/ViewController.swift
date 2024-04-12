import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Yatay koleksiyon görünümü
    let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Padding
        collectionView.showsHorizontalScrollIndicator = false // Yatay kaydırma çubuğunu gizle
        collectionView.clipsToBounds = false // İçeriği kesme
        collectionView.contentInsetAdjustmentBehavior = .never // İçerik ayarlamalarını devre dışı bırak
        collectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCardCollectionViewCell")
        return collectionView
    }()
    
    // Dikey koleksiyon görünümü
    let verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Padding
        collectionView.showsVerticalScrollIndicator = false // Dikey kaydırma çubuğunu gizle

//        collectionView.contentInsetAdjustmentBehavior = .always // İçerik ayarlamalarını devre dışı bırak
        collectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCardCollectionViewCell")
        return collectionView
    }()
    lazy var verticalCollectionView1: UICollectionView = {
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
        collectionView.register(ProductCardCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCardCollectionViewCell")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ürünler"
        let cardButton = CardButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cardButton)
//        cardButton.isHidden = true
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        // Yatay koleksiyon görünümünü ekle
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            horizontalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -1),
            horizontalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        // Dikey koleksiyon görünümünü ekle
        view.addSubview(verticalCollectionView)

        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            verticalCollectionView.widthAnchor.constraint(equalToConstant: 375),
            verticalCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 16) ,// Yatay koleksiyonun altına yerleştir
            verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Burada koleksiyon görünümündeki öğe sayısını döndür
        return 10 // Örnek olarak 10 öğe olsun
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCardCollectionViewCell", for: indexPath) as! ProductCardCollectionViewCell
        // Hücreyi özelleştirme işlemlerini burada yapabilirsiniz
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Her hücrenin boyutunu burada ayarlayabilirsiniz
        if collectionView == horizontalCollectionView {
            return CGSize(width: 92, height: 190)
        } else {
            let collectionViewWidth = collectionView.frame.width - 32 // Sol ve sağ kenar boşlukları çıkarılarak koleksiyon genişliği hesaplanır
            let cellWidth = (collectionViewWidth - 16 * 2) / 3 // Her satırda üç hücre olacak şekilde hücre genişliği hesaplanır
            return CGSize(width: cellWidth, height: 190)
        }
    }
}

class ProductCardCollectionViewCell: UICollectionViewCell {
    let productCardView = ProductCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        productCardView.priceLabel.text = "₺0,00"
        productCardView.attributeLabel.text = "Yemek"
        productCardView.nameLabel.text = " Atistirmalik"
        productCardView.imageView.image = UIImage(named: "card-image")
    }
    
    private func setupViews() {
        addSubview(productCardView)
        productCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productCardView.topAnchor.constraint(equalTo: topAnchor),
            productCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productCardView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
