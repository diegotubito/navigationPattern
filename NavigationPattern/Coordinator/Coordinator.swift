//
//  Coordinator.swift
//  NavigationPattern
//
//  Created by David Diego Gomez on 05/08/2023.
//


import SwiftUI

@MainActor
class Coordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var page: PageView = .home
    @Published var sheet: SheetView?
    @Published var modal: ModalView?
    
    @Published var showAlert: Bool = false
    @Published var showSecondaryAlert: Bool = false
    var alertDetail: AlertDetail?
    var completion: (() -> Void)?
    var primaryTapped: (() -> Void)?
    var secondaryTapped: (() -> Void)?

    func presentPrimaryAlert(title: String, message: String, buttonTitle: String? = nil, completion: (() -> Void)? = nil) {
        alertDetail = AlertDetail(title: title, message: message, alertStyle: .primary, primaryButtonTitle: buttonTitle, secondaryButtonTitle: nil)
        self.completion = completion
        showAlert = true
    }
    
    func presentSecondaryAlert(title: String, message: String, primaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil, primaryTapped: @escaping (() -> Void), secondaryTapped: @escaping (() -> Void)) {
        alertDetail = AlertDetail(title: title, message: message, alertStyle: .secondary, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
        self.primaryTapped = primaryTapped
        self.secondaryTapped = secondaryTapped
        showAlert = true
    }
    
    func presentDesctructiveAlert(title: String, message: String, primaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil, primaryTapped: @escaping (() -> Void), secondaryTapped: @escaping (() -> Void)) {
        alertDetail = AlertDetail(title: title, message: message, alertStyle: .destructive, primaryButtonTitle: primaryButtonTitle, secondaryButtonTitle: secondaryButtonTitle)
        self.primaryTapped = primaryTapped
        self.secondaryTapped = secondaryTapped
        showAlert = true
    }
    
    func root() {
        path = NavigationPath()
    }
    
    func push(_ page: PageView) {
        path.append(page)
    }
    
    func presentSheet(_ sheet: SheetView) {
        self.modal = nil
        self.sheet = sheet
    }
    
    func presentModal(_ modal: ModalView) {
        self.sheet = nil
        self.modal = modal
    }
    
    func closeModal() {
        self.modal = nil
    }
    
    
    struct AlertDetail: Identifiable {
        let id = UUID()
        var title: String
        var message: String
        var alertStyle: AlertStyle?
        var primaryButtonTitle: String?
        var secondaryButtonTitle: String?
    }
    
    enum AlertStyle: Identifiable {
        case primary
        case secondary
        case destructive
        
        var id: UUID {
            switch self {
            case .primary, .secondary, .destructive:
                return UUID()
            }
        }
    }
    
    enum PageView: Hashable {
        case tabbar
        case home
        case pushView
    }
    
    enum SheetView: Identifiable {
        case tac
        
        var id: UUID {
            switch self {
            case .tac:
                return UUID()
            }
        }
    }
    
    enum ModalView: Identifiable {
        case fullscreenView(text: String)

        var id: UUID {
            switch self {
            case .fullscreenView:
                return UUID()
            }
        }
    }
    
    @ViewBuilder
    func getPage(_ page: PageView) -> some View {
        switch page {
        case .tabbar:
            TabBarView()
        case .home:
            HomeView()
        case .pushView:
            HomeView()
        }
    }
    
    @ViewBuilder
    func getSheet(_ sheet: SheetView) -> some View {
        switch sheet {
        case .tac:
            Text("Terms and Conditions")
        }
    }
    
   @ViewBuilder
    func getModal(_ modal: ModalView) -> some View {
        switch modal {
        case .fullscreenView(let text):
            FullscreenView(text: text)
        }
    }
}

