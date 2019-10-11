//
//  BookMarkModel.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import CoreData

final class BookmarkModel {
    
    static let shared = BookmarkModel()
    
//    func getBookmarkList(success : @escaping ([BookMarkVO]) -> Void) {
//        guard let bookmarkCDEs = PersistenceManager.shared.getData(classType: ClassType.BookMarkCDE) as? [BookMarkCDE] else {return}
//        success(bookmarkCDEs.toBookMarkVOs())
//    }
//    
//    func getMoviesInBookMark(success : @escaping ([MovieVO]) -> Void) {
//        guard let bookmarkCDEs = PersistenceManager.shared.getData(classType: ClassType.BookMarkCDE) as? [BookMarkCDE] else {return}
//        let movieVOs = bookmarkCDEs.toBookMarkVOs().map { (bookmarkVO) -> MovieVO in
//            return (MovieModel.shared.getMovieCDEById(movieID: bookmarkVO.id!)?.toMovieVO())!
//        }
//        success(movieVOs)
//    }
//    
//    func addToCoreData(bookmarkVO : BookMarkVO) {
//        let bookmarkCDE = BookMarkCDE(context: PersistenceManager.shared.persistanceContainer.viewContext)
//        bookmarkCDE.id = Int32(bookmarkVO.id ??  0)
//        bookmarkCDE.movie = bookmarkVO.movie?.toMovieCDE()
//        PersistenceManager.shared.saveContext()
//    }
//    
//    func getBookMarkByID(id : Int) -> BookMarkCDE?{
//        let fetchRequest : NSFetchRequest<BookMarkCDE> = BookMarkCDE.fetchRequest()
//        let predicate = NSPredicate(format: "id == %d", id)
//        fetchRequest.predicate = predicate
//        
//        do {
//            let data = try PersistenceManager.shared.persistanceContainer.viewContext.fetch(fetchRequest)
//            if data.isEmpty {
//                return nil
//            }
//            return data[0]
//        } catch {
//            print("failed to fetch movie genre vo \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    func deleBookMarkById(id : Int, success  : @escaping () -> Void) {
//        let bookmarkCDE = getBookMarkByID(id: id)
//        PersistenceManager.shared.persistanceContainer.viewContext.delete(bookmarkCDE!)
//        PersistenceManager.shared.saveContext()
//        success()
//    }
}
