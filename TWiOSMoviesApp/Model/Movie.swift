import UIKit

struct MovieData: Codable {
  var card_id: String
  var start_time: Int
  var end_time: Int
  var priority: Double
  var hide_on_use: Bool
  var hide_on_use_for_seconds: Int
  var card_template: String
  var poi_lat_long: String
  var distance_threshold_in_meters: Int
  var content: Movie

  public static func decode(withResponse data: Data?) -> [MovieData]? {
    let jsonDecoder = JSONDecoder()
    if let data = data {
      do {
        let movies = try jsonDecoder.decode([MovieData].self, from: data)
        return movies
      } catch let parsingError {
        print("Error", parsingError)
      }
    }
    return nil
  }
  
}

struct Movie: Codable {
  var title: String
  var description: String
  var movie_logo: String
  var rating: Double
  var actions: [SubModule]

}

struct SubModule: Codable {
  var description: String
  var deeplink: String
}

