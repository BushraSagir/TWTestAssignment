import Alamofire

class WebServiceHandler: NSObject {
  class func getMovies(completion: @escaping ([MovieData]?) -> ()) {
    let moviesURL: String = "https://twhiring-40b28.firebaseapp.com/interview_ios.json"    
    Alamofire.request(moviesURL, method: .get, parameters: nil, encoding: JSONEncoding.default)
      .responseJSON { response in
        switch response.result{
        case .success( _):
          let json = try! JSONSerialization.jsonObject(with: response.data ?? Data(), options: [])
          let jsonDict = json as! NSDictionary
          let movieData = (jsonDict["data"] as! NSDictionary)["cards"]
          let data = try? JSONSerialization.data(withJSONObject:movieData as Any)
          do{
            let jsonResponse = try JSONSerialization.data(withJSONObject:movieData as Any)
            print(jsonResponse)
          } catch let parsingError {
            print("Error", parsingError)
          }
          let movies = MovieData.decode(withResponse: data)
          completion(movies)
        case .failure(let error):
          print("error \(error)")
        }
    }
  }
}
