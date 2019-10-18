//
//  UserModel.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 08/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyJSON

final class UserModel {
    
    static let shared = UserModel()
    init() {}
    
    func getNewToken(success : @escaping (LoginAndRequestTokenResponse)-> Void,
                     failure : @escaping (String)-> Void) {
        
        NetworkClient.shared.request(url: MovieAPI.authentication.requestToken.urlString(), success: { (data) in
            
            
            data.decode(modelType: LoginAndRequestTokenResponse.self, success: { (loginRequestTokenResponse) in
                success(loginRequestTokenResponse)
            }) { (err) in
                print("an error occure while getting new token : \(err)")
                failure(err)
            }
            
        }) { (err) in
            print("an error occure while getting new token : \(err)")
            failure(err)
        }
    }
    
    func login(userInfoLogin : UserVO,
               success : @escaping () -> Void,
               failure : @escaping (String) -> Void) {
        
        let params = userInfoLogin.toDictionary()
        
        NetworkClient.shared.request(url: MovieAPI.authentication.tokenValidateWithLogin.urlString(), method: .post, parameters: params, success: { (data) in
            
            data.decode(modelType: LoginAndRequestTokenResponse.self, success: { (loginRequestTokenResponse) in
                if let isSuccessLogin = loginRequestTokenResponse.success {
                    //                    CommonManger.shared.saveStringToNSUserDefault(value: loginRequestTokenResponse.requestToken!, key: CommonManger.SESSION_ID)
                    if isSuccessLogin {
                        self.getAccountDetail(success: {
                            success()
                        }) { (err) in
                            failure(err)
                        }
                    } else {
                        failure("incorrect password or username")
                    }
                } else {
                    failure("incorrect password or username")
                }
            }) { (err) in
                print("an error occure while getting new token : \(err)")
                failure(err)
            }
            
        }) { (error) in
            print("an error occure while login . . , \(error)")
            failure(error)
        }
    }
    
    func getAccountDetail(success : @escaping () -> Void,
                          failure : @escaping (String) -> Void) {
        NetworkClient.shared.request(url: MovieAPI.account.account.urlStringWithSessionID(), success: { (data) in
            data.decode(modelType: AccountDetailVO.self, success: { (accoutDetail) in
                CommonManger.shared.saveObjectToNSUserDefault(value: accoutDetail.toData()!, key: CommonManger.ACCOUNT_DETAIL)
                UserManager.shared.accountDetail = accoutDetail
                success()
            }) { (err) in
                print("an error occure while getting account detail . . , \(err)")
                failure(err)
            }
        }) { (err) in
            print("an error occure while getting account detail . . , \(err)")
            failure(err)
        }
    }
    
    //MARK:- Rate List
    func getRatedMovie(success : @escaping ([MovieVO]) -> Void,
                       failure : @escaping (String) -> Void) {
        NetworkClient.shared.request(url:  String(format: MovieAPI.account.getRatedMovies.urlStringWithSessionID(), "\(UserManager.shared.accountDetail?.id ?? 0)"), success: { (data) in
            
            if let movieList = data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self){
                success(movieList)
            } else {
                failure("an error occure while encoding data to obj")
            }
        }) { (err) in
            print(err)
            failure(err)
        }
    }
    
    func addMovieToRatedList(movieID : Int,
                             value : Double,
                             success : @escaping () -> Void,
                             failure : @escaping (String) -> Void) {
        let requestBodyForAddToRatedList = RateMovieRequest(value: value)
        let param = requestBodyForAddToRatedList.toDictionary()
        NetworkClient.shared.request(url: String(format: MovieAPI.movie.rating.urlStringWithSessionID(), "\(movieID)"), method: .post, parameters: param, success: { (data) in
            if let manageListResponse = data.decode(modelType: ManageListResponse.self) {
                print(manageListResponse.statusMessage as Any)
                self.addRemoveMovieInRatedList(willAdd: true, movieID: movieID)
                success()
            }
        }) { (err) in
            print(err)
            failure(err)
        }
    }
    
    func removeMovieFromRatedList(movieID : Int,
                                  success : @escaping () -> Void,
                                  failure : @escaping (String) -> Void) {
        NetworkClient.shared.request(url: String(format: MovieAPI.movie.rating.urlStringWithSessionID(), "\(movieID)"), method: .delete, success: { (data) in
            if let manageListResponse = data.decode(modelType: ManageListResponse.self) {
                print(manageListResponse.statusMessage as Any)
                self.addRemoveMovieInRatedList(willAdd: false, movieID: movieID)
                success()
            }
        }) { (err) in
            failure(err)
        }
    }
    
    
    //MARK:- Watch List
    func getWatchListMovies(success : @escaping ([MovieVO]) -> Void,
                            failure : @escaping (String) -> Void) {
        NetworkClient.shared.request(url:  String(format: MovieAPI.account.getMovieWatchList.urlStringWithSessionID(), "\(UserManager.shared.accountDetail?.id ?? 0)"), success: { (data) in
            if let movieList = data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self){
                success(movieList)
            } else {
                failure("an error occure while encoding data to obj")
            }
        }) { (err) in
            print(err)
            failure(err)
        }
    }
    
    
    
    func addToWatchListMovie(movieID : Int,
                             success : @escaping () -> Void,
                             failure : @escaping (String) -> Void) {
        let requestBodyForAddToWatchList = AddWatchListRequest(mediaType: "movie", mediaId: movieID, watchlist: true)
        let param = requestBodyForAddToWatchList.toDictionary()
        
        if let accountid = UserManager.shared.accountDetail?.id {
            NetworkClient.shared.request(url: String(format: MovieAPI.account.addToWatchList.urlStringWithSessionID(), "\(accountid)"),method: .post,parameters: param, success: { (data) in
                let manageWatchListMovieResponse = data.decode(modelType: ManageListResponse.self)
                if (manageWatchListMovieResponse?.isSuccess())! {
                    self.addRemoveMovieInWatchList(willAdd: true, movieID: movieID)
                    success()
                } else {
                    failure("already added movie")
                }
            }) { (err) in
                print(err)
                failure(err)
            }
        } else {
            failure("Need to Login at least one time")
        }
    }
    
    func removeFromWatchListMovie(movieID : Int,
                                  success : @escaping () -> Void,
                                  failure : @escaping (String) -> Void) {
        let requestBodyForAddToWatchList = AddWatchListRequest(mediaType: "movie", mediaId: movieID, watchlist: false)
        let param = requestBodyForAddToWatchList.toDictionary()
        
        print(param)
        
        if let accountid = UserManager.shared.accountDetail?.id {
            NetworkClient.shared.request(url: String(format: MovieAPI.account.addToWatchList.urlStringWithSessionID(), "\(accountid)"),method: .post,parameters: param, success: { (data) in
                let manageWatchListMovieResponse = data.decode(modelType: ManageListResponse.self)
                print(manageWatchListMovieResponse?.statusMessage! as Any)
                if !(manageWatchListMovieResponse?.isSuccess())! {
                    self.addRemoveMovieInWatchList(willAdd: false, movieID: movieID)
                    success()
                } else {
                    failure("already deleted movie")
                }
            }) { (err) in
                print(err)
                failure(err)
            }
        } else {
            failure("Need to Login at least one time")
        }
    }
}

//MARK:- REALM

extension UserModel {
    func getwatchListMovieFromRealm() -> [MovieVO]{
        return MovieModel.shared.getMovieVOsByKey(key: "true", property: "isAddedWatchList")
    }
    
    func getRatedListMovieFromRealm() -> [MovieVO] {
        return MovieModel.shared.getMovieVOsByKey(key: "true", property: "isRated")
    }
    
    func addRemoveMovieInWatchList(willAdd : Bool,movieID : Int) {
        guard var movieVO = MovieModel.shared.getMovieVOById(movieID: movieID) else { return }
        movieVO.isAddedWatchList = willAdd
        DBManager.sharedInstance.addData(object: movieVO.toMovieRO())
    }
    
    func addRemoveMovieInRatedList(willAdd : Bool, movieID : Int){
        guard var movieVO = MovieModel.shared.getMovieVOById(movieID: movieID) else { return }
        movieVO.isRated = willAdd
        DBManager.sharedInstance.addData(object: movieVO.toMovieRO())
    }
}
