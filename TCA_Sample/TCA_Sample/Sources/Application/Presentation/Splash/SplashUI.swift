//
//  SplashUI.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI
import ComposableArchitecture

struct SplashUI: View {
    let store: StoreOf<SplashFeature> = Store(initialState: SplashFeature.State()) { SplashFeature() }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 12) {
                    Text("👽")
                    Text("TAC_Sample")
                        .fontColor(.h3 ,color: .white)
                }
                .padding(.top, 300)
                
                Spacer()
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .onAppear {
                viewStore.send(.viewAppeared)
            }
        }
    }
}

#Preview {
    SplashUI()
}
