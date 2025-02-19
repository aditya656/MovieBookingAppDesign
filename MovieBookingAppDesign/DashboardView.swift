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
    
    var body: some View {
        VStack {
            if posterExpanded {
                closeHeaderView
                collapsedBodyView
//                .zIndex(5)
            } else {
                headerView
                expandedBodyView
            }
//            ZStack {
//                expandedBodyView
//                    .opacity(posterExpanded ? 0 : 1)
//                    .zIndex(posterExpanded ? 0 : 100)
//                collapsedBodyView
//                    .opacity(posterExpanded ? 1 : 0)
//                    .zIndex(posterExpanded ? 100 : 0)
//            }
//            .background(Color.green)
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
        .padding(.bottom, 24)
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
        ZStack {
            Image("bad_guys_poster")
                .resizable()
                .matchedGeometryEffect(id: "PosterAnimation", in: profileAnimation)
                .transition(.offset(y: 1))
                .scaledToFit()
//                .frame(width: 100)
                .clipShape(RoundedCorners(radius: 48, corners: [.topLeft, .topRight]))
                
                
                
            VStack {
                VStack {
                    Image("bad_guys_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    Text("2025 • Animation • 96 min")
                        .font(.subheadline)
                        .padding(.top, 12)
                    HStack {
                        Image("ic_imdb")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        Text("7.7")
                            .font(.subheadline)
                    }
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
                            .clipShape(Capsule()) // Rounded button
                    }
                    .padding(.top, 24)
                    Button(action: {
                        print("Play tapped")
                    }) {
                        Image(systemName: "play.fill") // Play icon
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(18)
                            .background(Color.gray) //.opacity(0.8))
                            .clipShape(Circle()) // Circular button
                    }
                    .padding(.top, 24)
                }
            }
            .offset(y: 200)
            
        }
    }
    
    var collapsedBodyView: some View {
        HStack(spacing: 16) {
            Image("bad_guys_poster")
                .resizable()
                .matchedGeometryEffect(id: "PosterAnimation", in: profileAnimation)
                .scaledToFit()
                .frame(width: 180, height: 130)
                .scaleEffect(CGSize(width: 1.4, height: 1.4), anchor: UnitPoint(x: 0.5, y: -1))
                .clipShape(RoundedRectangle(cornerRadius: 24))
            
            VStack(alignment: .leading) {
                Image("bad_guys_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                Text("2025 • Animation • 96 min")
                    .font(.caption)
                    .padding(.top, 6)
                HStack {
                    Image("ic_imdb")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    Text("7.7")
                        .font(.subheadline)
                }
                .padding(.top, 6)
            }
            Spacer()
        }
        .padding(.leading, 12)
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = 10
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    DashboardView()
}
