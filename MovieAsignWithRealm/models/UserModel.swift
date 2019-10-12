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
    
//    https://api.themoviedb.org/3/account/8660473/watchlist/movies?api_key=3ea4500e51ab3b0358547f472e44d5fc&session_id=1c9cf3211a9cd464048cf6a9a001bd6166f98ded
//    String(format: MovieAPI.account.getMovieWatchList.urlStringWithSessionID(), "\(UserManager.shared.accountDetail?.id ?? 0)")
    
    func getWatchListMovies(success : @escaping ([MovieVO]) -> Void,
                            failure : @escaping (String) -> Void) {
        NetworkClient.shared.request(url:  String(format: MovieAPI.account.getMovieWatchList.urlStringWithSessionID(), "\(UserManager.shared.accountDetail?.id ?? 0)"), success: { (data) in
            
            let json = JSON(data)
//            let value = json[MovieResponseKey.results.keyString()]
            let jsonString = json.rawString()
            print(jsonString)
//
//            Data(jsonString!.utf8).decode(modelType: [MovieVO].self, success: { (movieList) in
//                print(movieList.count)
//                success(movieList)
//            }) { (err) in
//                print(err)
//            }
            
            data.decode(modelType: BaseResponse.self, success: { (baseResponse) in
                print(baseResponse.results?.count)
                success(baseResponse.results!)
            }) { (err) in
                print(err)
                failure(err)
            }
            
//            data.filterByKey(key: MovieResponseKey.results.keyString()).decode(modelType: [MovieVO].self, success: { (movieList) in
//                print(movieList.count)
//                success(movieList)
//            }) { (err) in
//                print(err)
//            }

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
        print(param)

//        let param : [String : Any ] = [
//                   "media_type" : "movie",
//                   "media_id" : "\(movieID)",
//                   "watchlist" : true
//               ]
        
        if let accountid = UserManager.shared.accountDetail?.id {
            NetworkClient.shared.request(url: String(format: MovieAPI.account.addToWatchList.urlStringWithSessionID(), "\(accountid)"),method: .post,parameters: param, success: { (data) in
                let manageWatchListMovieResponse = data.decode(modelType: ManageWatchListResponse.self)
                if (manageWatchListMovieResponse?.isSuccess())! {
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
//        let param : [String : Any ] = [
//            "media_type" : "movie",
//            "media_id" : "\(movieID)",
//            "watchlist" : false
//        ]
        if let accountid = UserManager.shared.accountDetail?.id {
            NetworkClient.shared.request(url: String(format: MovieAPI.account.addToWatchList.urlStringWithSessionID(), "\(accountid)"),method: .post,parameters: param, success: { (data) in
                let manageWatchListMovieResponse = data.decode(modelType: ManageWatchListResponse.self)
                print(manageWatchListMovieResponse?.statusMessage!)
                if !(manageWatchListMovieResponse?.isSuccess())! {
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
    
    func getRatedMovies(success : @escaping () -> Void,
                        failure : @escaping (String) -> Void) {
        
    }
}

