//
//  SearchListView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/23/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI
import Combine

struct SearchListView: View {
    @ObservedObject var viewModel: MapViewModel
    
    // Unfortunately, we can't modify the SwiftUI List view directly yet
    // Luckily, we can use appearance on tableview stuff.
    // Hopefully, this will change on the next iOS version
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes =
            [.foregroundColor: UIColor.init(red: 101.0 / 255.0,
                                            green: 195.0 / 255.0,
                                            blue: 102.0 / 255.0,
                                            alpha: 0.3),
             .font : UIFont(name:"ArialRoundedMTBold", size: 40)!]
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                Image(systemName: "globe").resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.green)
                    .opacity(0.05)
                    .padding(.top, 50)
                
                VStack {
                    SearchBar(text: $viewModel.searchTerm)
                    .padding(.top, 10)
                    
                        List {
                            mapListSection
                        }
                        // get rid of the keyboard when user interacts with the list
                        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        })
                    }
                }
            .navigationBarTitle(Text("Open Maps"))
        }
        .accentColor(Color(red: 101.0 / 255.0, green: 195.0 / 255.0, blue: 102 / 255.0, opacity: 0.6))
    }
    
    // Show the results or the error
    var mapListSection: some View {
        Section {
            if viewModel.mapError != nil {
                Text(viewModel.mapError.debugDescription)
            }
            else{
                ForEach(viewModel.dataSource, id: \.annotations.osm.url) { result in
                    
                    NavigationLink(destination: MapDetailView(mapResult: result, searchTerm: self.viewModel.searchTerm)) {
                        SearchCell(mapResult: result)
                    }
                }
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MapViewModel(mapFetcher: MapFetcher())
        return SearchListView(viewModel: viewModel)
    }
}
