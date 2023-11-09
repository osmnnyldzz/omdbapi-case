//
//  BaseViewModel.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 8.11.2023.
//

class BaseViewModel {
    /// Loading indicator göstermek için kullanıyoruz.
    var showLoading: () -> () = {}
    /// Loading indicator gizlemek için kullanıyoruz.
    var hideLoading: () -> () = {}
}
