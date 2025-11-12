//
//  AllListProtocols.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//


typealias Ables = UIViewAble & SegueAble & NavConUIAble
 import ICTMDBViewKit
 import GenericCollectionViewKit



protocol ViewToPresenterAllListProtocol: AnyObject,
    GenericCollectionDataSourceProtocol,
    GenericCollectionDelegateSourceProtocol,
                                      GenericCollectionLayoutProviderProtocol{
    var view : PresenterToViewAllListProtocol? {get}
    func viewDidLoad()
  
    func getAllList(at type:ListType)
}


protocol PresenterToViewAllListProtocol : AnyObject,Ables{
    func relaodCollectionView()
    func prepareCollectionView()
    func sendErrorState(state:(isHidden:Bool,message:String))
    func startLoading()
    func finishLoading()
   
}


protocol PresenterToInteractorAllListProtocol {
    var presenter: InteractorToPresenterAllListProtocol? {get set}
    func loadTvShows(type:ListType,page:Int)

}


protocol InteractorToPresenterAllListProtocol {
    func sendData(_ data:DataResult<TvShow> )
    func sendError()
}


protocol PresenterToRouterAllListProtocol {
    func toDetail(view:PresenterToViewAllListProtocol?,id:Int?)
}
