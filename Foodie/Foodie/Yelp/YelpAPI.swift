//
//  YelpAPI.swift
//  Foodie
//
//  Created by Carson Wang on 12/6/22.
//

import Foundation

// this call YelpAPI and get data we want

class YelpAPI {
    // use singleton to share data
    public static let shared = YelpAPI()
    public var yelp: [YelpModel] = []
    
    // headers for auth
    let headers = [
      "accept": "application/json",
      "authorization": "Bearer 9ytg-PUbhPwJOciweH4mtMIXll3lu-jcCymCSg1TqsZcPhkOxUDBEay5ufF_KxXznC2YESAtj9Aan3rndtP_e1Tca5yjew6Lh3swJG4Mmfh4jKkiALF50ymfLRuPY3Yx"
    ]
    
    // this method allow other file to call and get up to date data
    func getImages(onSuccess: @escaping ([YelpModel]) -> Void){
        // call the location first to get current location
        LocationDetail.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async { [self] in
                // set url for YelpAPI
                if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&term=food&sort_by=best_match&limit=50"){
                    // request from uel
                    var urlRequest = URLRequest(url: url)
                    urlRequest.allHTTPHeaderFields = self?.headers
                    urlRequest.httpMethod = "GET"
                        URLSession.shared.dataTask(with: urlRequest) {data, response, error in
                            if let data = data {
                                do{
                                    // use JSONDecoder to decode data
                                    let image = try JSONDecoder().decode(YelpModel.self, from: data)
                                    let searchResult = [image]
                                    onSuccess(searchResult)
                                } catch {
                                    print(error)
                                    exit(1)
                                }
                            }
                        }.resume()
                }
            }
        }
    }
}
