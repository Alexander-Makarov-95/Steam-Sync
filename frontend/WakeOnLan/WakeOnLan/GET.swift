//
//  GET.swift
//  WakeOnLan
//
//  Created by Alexander Makarov on 14/5/2023.
////
//
//import UIKit
//
//struct Game: Codable {
//    let game_id: Int
//    let name: String
//    let image_url: String
//}
//
//func fetchGames(completion: @escaping ([Game]?, Error?) -> Void) {
//    if let url = URL(string: "http://192.168.1.2:3000/games") {
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(nil, error)
//            } else if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let games = try decoder.decode([Game].self, from: data)
//                    completion(games, nil)
//                } catch {
//                    completion(nil, error)
//                }
//            }
//        }
//        task.resume()
//    } else {
//        let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//        completion(nil, error)
//    }
//}
//
