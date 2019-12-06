

import UIKit
protocol ViewModelDelegate: class {
  func reloadTable()
}

class MoviesViewModel {
  var movies: [MovieData] = []
  weak var delegate: ViewModelDelegate?
  func getMovies() {
    WebServiceHandler.getMovies { [weak self](movies) in
      if let movies_ = movies {
        self?.movies = movies_
        self?.delegate?.reloadTable()
      }
    }
  }
}
