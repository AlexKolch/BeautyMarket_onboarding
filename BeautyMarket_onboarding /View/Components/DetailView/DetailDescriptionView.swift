//
//  DetailDescriptionView.swift
//  BeautyMarket_onboarding 
//
//  Created by Алексей Колыченков on 10.03.2025.
//

import SwiftUI

struct DetailDescriptionView: View {
    
    let desriptionText: String
    let userName: String
    let subheadline: String
    var onAddToCartPressed: (() -> Void)?
    var onShuffledPressed: (() -> Void)?
    var onMorePressed: (() -> Void)?
    var onSharePressed: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(desriptionText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            Text(subheadline)
            buttonsRow
        }
        .foregroundStyle(.myLightGray)
        .font(.callout)
        .fontWeight(.medium)
    }
}

private extension DetailDescriptionView {
    var madeForYouSection: some View {
        HStack {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.myGreen)
            Text("For ") + Text(userName).bold().foregroundStyle(.myWhite)
        }
    }
    
    var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.black.opacity(0.001)) //увеличили область отклика
                    .onTapGesture {
                        print("share tap")
                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        print("more tap")
                    }
            }
            .font(.headline)
            .offset(x: -8) //чтобы невелировать .padding(8) который задавали для увеличения области отклика
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .onTapGesture {
                        print("shuffle tap")
                    }
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 32))
                    .onTapGesture {
                        print("creditcard tap")
                    }
            }
            .padding(.trailing)
            .foregroundStyle(.myGreen)
        }
    }
}

#Preview {
    ZStack {
        Color.myBlack.ignoresSafeArea()
        DetailDescriptionView(desriptionText: Product.mock.description, userName: "Alex", subheadline: "Some headline goes here").padding()
    }
 
}
