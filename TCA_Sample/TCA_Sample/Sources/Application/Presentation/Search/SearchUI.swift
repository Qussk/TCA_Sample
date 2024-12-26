//
//  MainUI.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchUI: View {
    let store: StoreOf<SearchFeature> = Store(initialState: SearchFeature.State()) { SearchFeature() }
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                SerchBarView(store: store)
                SearchTabView(store: store)
                
                Spacer()
            }
            .onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }
}

private struct SerchBarView: View {
    let store: StoreOf<SearchFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("닉네임을 입력하세요.", text: viewStore.$latestQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.h5)
                    .tint(Color.green)
            }
            .padding(.horizontal, 18)
            .padding(.top, 30)
        }
    }
}

private struct SearchTabView: View {
    var store: StoreOf<SearchFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .frame(height: 50)
                    .padding(.horizontal, 18)
                
                HStack(spacing: 10) {
                    ForEach(0..<viewStore.searchTitle.count, id: \.self) { index in
                        Button(action: {
                            viewStore.send(.tabSelected(index))
                        }) {
                            Text(viewStore.searchTitle[index])
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(viewStore.isSelectTab == index ? Color.white : Color.white
                                )
                                .foregroundColor(viewStore.isSelectTab == index ? Color.mint : Color.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(viewStore.isSelectTab == index ? Color.mint : Color.clear, lineWidth: 2)
                                )
                                .cornerRadius(15)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 18)
            }
        }
        .padding(.top, 10)
    }
}


#Preview {
    SearchUI()
}
