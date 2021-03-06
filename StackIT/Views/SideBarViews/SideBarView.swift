//
//  SideBarView.swift
//  StackIT
//
//  Created by Jullian Mercier on 2020-08-06.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var viewManager: ViewManager
    @State private var isActive = true
    @State private var search: String = .init()
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: QuestionsSummaryView(),
                               isActive: $isActive,
                               label: EmptyView.init).buttonStyle(PlainButtonStyle())
                
                ScrollView(showsIndicators: false) {
                    AccountSectionView()
                    TrendingSectionView()
                    TagSectionView()
                }
                .padding(.top, 5)
                .frame(minWidth: 250, maxWidth: 250, minHeight: 650, maxHeight: .infinity)
                .onAppear {
                    viewManager.fetchTagsSubject.send(.tags)
                }
            }
        }
        .navigationTitle(String.init())
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                }

            }
            
            ToolbarItem(placement: .principal) {
                ZStack(alignment: .trailing) {
                    TextField("", text: $search, onCommit: {
                        NSApplication.shared.endEditing()
                        guard !search.isEmpty else { return }
                        self.viewManager.fetchQuestionsSubject.send(.questions(subsection: .search(keywords: search), .active))
                    }).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.template)
                        .foregroundColor(Color.gray.opacity(0.6))
                        .padding()
                }.frame(width: 500, height: 30)
            }
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
