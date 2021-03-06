//
//  TrendingSectionView.swift
//  StackIT
//
//  Created by Jullian Mercier on 2020-08-10.
//

import SwiftUI

struct TrendingSectionView: View {
    @EnvironmentObject var viewManager: ViewManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Trending")
                .foregroundColor(Color.gray)
                .font(.subheadline)
                .padding(.leading)
            
            Divider()
                .background(Color.gray)
                .opacity(0.1)
                .padding(.leading)
            
            ForEach(Trending.allCases, id: \.self) { trending in
                HStack {
                    Image(systemName: trending.iconName)
                        .renderingMode(.template)
                        .foregroundColor(.yellow)
                    Text(trending.title)
                    Spacer()
                }
                .padding(.leading)
                .padding(.bottom, 5)
                .onTapGesture {
                    self.viewManager.fetchQuestionsSubject.send(.questions(subsection: .trending(trending: trending), .active))
                }
            }
        }.padding([.top])
    }
}

struct TrendingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingSectionView()
    }
}
