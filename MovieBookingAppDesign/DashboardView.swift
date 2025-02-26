//
//  DashboardView.swift
//  MovieBookingAppDesign
//
//  Created by Aditya Patole on 18/02/25.
//
import SwiftUI

struct DashboardView: View {
    @Namespace private var profileAnimation
    @State var posterExpanded = false
    
    var photoHeight: CGFloat {
        posterExpanded ? 130 : UIScreen.main.bounds.width * (1585 / 1295)
    }
    var photoWidth: CGFloat {
        posterExpanded ? 180 : UIScreen.main.bounds.width
    }
    
    var body: some View {
        VStack {
            if posterExpanded {
                closeHeaderView
            } else {
                headerView
            }
            HStack {
                Image("bad_guys_poster")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(posterExpanded ? CGSize(width: 1.8, height: 1.8) : CGSize(width: 1, height: 1),
                                 anchor: posterExpanded ? UnitPoint(x: 0.5, y: 0) : .center)
                    .frame(width: photoWidth, height: photoHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                if posterExpanded {
                    collapsedBodyView
                }
            }
            
            if !posterExpanded {
                expandedBodyView
            }
            Spacer()
        }
    }
    
    var closeHeaderView: some View {
        HStack {
            Button(action: {
                print("Buy Tickets tapped")
                withAnimation() {
                    posterExpanded = false
                }
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundStyle(Color.white)
                    .frame(width: 16, height: 16)
            }
            .padding(.leading, 24)
            .padding(.top, 8)
            Spacer()
        }
        .padding(.bottom, 28)
    }
    
    var headerView: some View {
        HStack {
            Text("Now Showing")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 24)
            Image(systemName: "chevron.down")
            Spacer()
            Image(systemName: "person.crop.circle")
                .resizable().frame(width: 36, height: 36)
                .padding(.trailing, 24)
        }
    }
    
    var expandedBodyView: some View {
        VStack {
            VStack {
                Image("bad_guys_logo")
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "TitleLogo", in: profileAnimation)
                    .frame(width: 150)
                Text("2025 • Animation • 96 min")
                    .font(.subheadline)
                    .matchedGeometryEffect(id: "SubTitleText", in: profileAnimation)
                    .padding(.top, 12)
                HStack {
                    Image("ic_imdb")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    Text("7.7")
                        .font(.subheadline)
                }
                .matchedGeometryEffect(id: "IMDBRating", in: profileAnimation)
                .padding(.top, 6)
            }
            HStack {
                Button(action: {
                    print("Buy Tickets tapped")
                    withAnimation() {
                        posterExpanded = true
                    }
                }) {
                    Text("Buy Tickets")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background(Color.yellow)
                        .clipShape(Capsule())
                }
                .padding(.top, 24)
                Button(action: {
                    print("Play tapped")
                }) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(18)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                .padding(.top, 24)
            }
        }
    }
    
    var collapsedBodyView: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Image("bad_guys_logo")
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "TitleLogo", in: profileAnimation)
                    .frame(width: 70)
                Text("2025 • Animation • 96 min")
                    .font(.caption)
                    .matchedGeometryEffect(id: "SubTitleText", in: profileAnimation)
                    .padding(.top, 6)
                HStack {
                    Image("ic_imdb")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    Text("7.7")
                        .font(.subheadline)
                }
                .matchedGeometryEffect(id: "IMDBRating", in: profileAnimation)
                .padding(.top, 6)
            }
            Spacer()
        }
        .padding(.leading, 12)
    }
}

#Preview {
    DashboardView()
}
