
import UIKit
import Alamofire
import AlamofireImage

class MoviesViewController: UIViewController {
  private enum Constants {
    static let listCellIdentifier = "MoviesListCell"
    static let gridCellIdentifier = "GridMovieCell"
  }

  var isListView = true
  var viewModel = MoviesViewModel()

  @IBOutlet weak var rightBarButton: UIBarButtonItem!
  
  @IBOutlet weak var collectionView: UICollectionView!
  override func viewDidLoad() {
    self.navigationItem.setRightBarButton(rightBarButton, animated: true)
    viewModel.delegate = self
    viewModel.getMovies()
    let names = ["Fruits": "Apple",
                 "Vegetables": "Carrot"]
    let food = names["Meat"] ?? "No food"
    print(food)
    super.viewDidLoad()
  }

  @IBAction func listOrGridButtonPressed(_ sender: UIBarButtonItem) {
    isListView = isListView ? false : true
    navigationItem.rightBarButtonItem?.title = isListView ? "List" : "Grid"
    collectionView.reloadData()
  }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.movies.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let movie = viewModel.movies[indexPath.row].content
    if isListView {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: Constants.listCellIdentifier,
        for: indexPath
        ) as? MoviesListCell else {
          print("Error: No collectionView found")
          return UICollectionViewCell()
      }
      cell.title.text = movie.title
      cell.rating.text = "Rating: " + String(movie.rating)
      let imageUrl = URL(string: movie.movie_logo)
      if let imageurl = imageUrl {
        cell.thumbnail.af_setImage(
          withURL: imageurl,
          placeholderImage: UIImage(named: "placeHolderImage"),
          imageTransition: .crossDissolve(0.2)
        )
      }
      return cell
    }else {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: Constants.gridCellIdentifier,
        for: indexPath
      ) as? MoviesGridCell else {
          print("Error: No collectionView found")
          return UICollectionViewCell()
      }
      let imageUrl = URL(string: movie.movie_logo)
      if let imageurl = imageUrl {
        cell.thumbnail.af_setImage(
          withURL: imageurl,
          placeholderImage: UIImage(named: "placeHolderImage"),
          imageTransition: .crossDissolve(0.2)
        )
      }
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.width
    if isListView {
      return CGSize(width: width, height: 120)
    }else {
      return CGSize(width: (width - 15)/2, height: (width - 15)/2)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
}

extension MoviesViewController: ViewModelDelegate {
  func reloadTable() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
