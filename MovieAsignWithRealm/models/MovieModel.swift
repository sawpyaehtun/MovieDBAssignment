//
//  MovieModel.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

final class MovieModel: BaseViewModel {
    
    static let shared = MovieModel()
    
    func getMovieDetail(movieId : Int, success : @escaping (MovieVO) -> Void,faulire : @escaping (String) -> Void) {
        
        NetworkClient.shared.request(url: String(format: MovieAPI.movie.detail.urlString(), "\(movieId)"), success: { (data) in
            data.decode(modelType: MovieVO.self, success: { (movie) in
                success(movie)
            }) { (err) in
                print("fail while getting movie detail due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching search movies result due to \(err)")
            faulire(err)
        }
    }
    
    func getSimilarMovie(pageId : Int = 1, movieId : Int, success : @escaping ([MovieVO]) -> Void,faulire : @escaping (String) -> Void) {
        NetworkClient.shared.request(url: String(format: MovieAPI.movie.similar.urlStringWithPageID()+"\(pageId)", "\(movieId)"), success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                success(movieList)
            }) { (err) in
                print("fail while fetching similar movie due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching search movies result due to \(err)")
            faulire(err)
        }
    }
    
    func searchMovie(movieName : String, success : @escaping ([MovieVO]) -> Void, faulire : @escaping (String) -> Void) {
        NetworkClient.shared.request(url: MovieAPI.search.movie.urlString() + "&language=en-US&query=\(movieName)&page=1&include_adult=false", success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                success(movieList)
            }) { (err) in
                print("fail while fetching similar movie due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching search movies result due to \(err)")
            faulire(err)
        }
    }
    
    func fetchAllmovie(success : @escaping ([MovieVO]) -> Void, faulire: @escaping (String) -> Void) {
        
        if let genres = DBManager.sharedInstance.getDataFromDB(roName: .GenreRO), genres.isEmpty {
            GenreModel.shared.fetchGeners(success: { (genreVOs) in
                print(genreVOs.count)
            }) { (err) in
                print(err)
            }
        }
        
        let dispatchGroup = DispatchGroup()
        var errorString = ""
        
        dispatchGroup.enter()
        fetchTopRatedMovie(success: {
            dispatchGroup.leave()
        }) { (err) in
            errorString.append(err)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchPopularMovie(success: {
            dispatchGroup.leave()
        }) { (err) in
            errorString.append(err)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchUpcomingMovie(success: {
            dispatchGroup.leave()
        }) { (err) in
            errorString.append(err)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchNowPlayingMovie(success: {
            dispatchGroup.leave()
        }) { (err) in
            errorString.append(err)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            let movieVOs = self.getMovie()
            success(movieVOs)
            faulire(errorString)
        }
        
    }
    
    func fetchTopRatedMovie(pageId : Int = 1, success : @escaping () -> Void, faulire: @escaping (String) -> Void) {
        
        NetworkClient.shared.request(url: MovieAPI.movie.topRated.urlStringWithPageID()+"\(pageId)", success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                self.specifyCategoryAndSave(movieList: movieList, currentCetegory: Category.topRated.rawValue)
                success()
            }) { (err) in
                print("fail while fetching similar movie due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching top rated movies due to \(err)")
            faulire(err)
        }
    }
    
    func fetchNowPlayingMovie(pageId : Int = 1, success : @escaping () -> Void, faulire: @escaping (String) -> Void) {
        
        NetworkClient.shared.request(url: MovieAPI.movie.nowPlaying.urlStringWithPageID()+"\(pageId)", success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                self.specifyCategoryAndSave(movieList: movieList, currentCetegory: Category.nowPlaying.rawValue)
                success()
            }) { (err) in
                print("fail while fetching similar movie due to \(err)")
                faulire(err)
            }
        }) { (err) in
            print("fail fatching now playing movies due to \(err)")
            faulire(err)
        }
    }
    
    func fetchPopularMovie(pageId : Int = 1, success : @escaping () -> Void, faulire: @escaping (String) -> Void) {
        
        NetworkClient.shared.request(url: MovieAPI.movie.popular.urlStringWithPageID()+"\(pageId)", success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                self.specifyCategoryAndSave(movieList: movieList, currentCetegory: Category.popular.rawValue)
                success()
            }) { (err) in
                print("fail while fetching similar movie due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching popular movies due to \(err)")
            faulire(err)
        }
    }
    
    func fetchUpcomingMovie(pageId : Int = 1, success : @escaping () -> Void, faulire: @escaping (String) -> Void) {
        
        NetworkClient.shared.request(url: MovieAPI.movie.upComing.urlStringWithPageID()+"\(pageId)", success: { (data) in
            
            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
                self.specifyCategoryAndSave(movieList: movieList, currentCetegory: Category.upComing.rawValue)
                success()
            }) { (err) in
                print("fail while fetching upcoming movies due to \(err)")
                faulire(err)
            }
            
        }) { (err) in
            print("fail fatching top upcoming movies due to \(err)")
            faulire(err)
        }
    }
    
    private func specifyCategoryAndSave(movieList : [MovieVO], currentCetegory : Int) {
        movieList.forEach({ movieVO in
            //MARK: CONVERT TO MUTABLE
            var movie = movieVO
            
            //MARK: GET MOVIE REALM OBJ FROM REALM DB BY MOVIDE-ID
            if let movieRO = self.getMovieROById(movieID: movie.id ?? 0) {
                
                //MARK: GET CATEGORY LIST FORM MOVIE REALM OBJ
                let categoryROList = movieRO.categories
                
                //MARK: CHECK CATEGORY LIST OF MOVIE REALM OBJ
                if categoryROList.isEmpty {
                    movie.categories = [currentCetegory]
                    self.saveToRealm(movieVO: movie)
                } else {
                    if categoryROList.contains(where: { (categoryROItem) -> Bool in
                        return categoryROItem.id == currentCetegory
                    }){
                        /* current category is contain in category list of existing movie realm object.*/
//                                                        self.saveToRealm(movieVO: movie)
                    } else {
                        /* current category is not contain in category list.
                         - So need to update the object in realm */
                        var categoryIDList = Array(categoryROList.map({ (categoryItem) -> Int in
                            return categoryItem.id
                        }))
                        
                        categoryIDList.append(currentCetegory)
                        movie.categories = categoryIDList
                        self.saveToRealm(movieVO: movie)
                    }
                }
            } else {
                movie.categories = [currentCetegory]
                self.saveToRealm(movieVO: movie)
            }
        })
    }
    
    func updateMovie(movieRO : MovieRO, dictionary : [String : Any?]) {
        DBManager.sharedInstance.update(object: movieRO, dictiionary: dictionary)
    }
    
    func getMovie()-> [MovieVO]{
        let movieROs = DBManager.sharedInstance.getDataFromDB(roName: .MovieRO) as!  [MovieRO]
        return movieROs.toMovieVOs()
    }
    
    func saveToRealm(movieVO : MovieVO) {
        DBManager.sharedInstance.addData(object: movieVO.toMovieRO())
    }
    
    func saveToRealm(movieVOs : [MovieVO]) {
        let movieROs = movieVOs.toMovieROs()
        DBManager.sharedInstance.addData(objectArray: movieROs)
    }
    
    func getMovieROById(movieID : Int) -> MovieRO? {
        guard let movieRO = DBManager.sharedInstance.getObjectById(id: movieID, roName: .MovieRO) as? MovieRO else { return nil}
        return movieRO
    }
    
    func getMovieVOById(movieID : Int) -> MovieVO {
        return (getMovieROById(movieID: movieID)?.toMovieVO())!
    }
    
    func getMovieVOsByKey(key : String, property : String) -> [MovieVO]{
        return (DBManager.sharedInstance.getObjArrayByKey(key: key, property: property, roName: .MovieRO)?.toMovieVOs()) ?? []
    }
}
