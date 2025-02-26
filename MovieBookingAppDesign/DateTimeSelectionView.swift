//
//  DateTimeSelectionView.swift
//  MovieBookingAppDesign
//
//  Created by Aditya Patole on 26/02/25.
//

import SwiftUI

struct DateTimeSelectionView: View {
    @State private var visibleCircles = [false, false, false, false, false]
    @State private var visibleTimeSlots = [false, false, false]
    
    let animationDuration = 0.5
    let overlapFactor = 0.8
    @Binding var selectedDate: Int
    @Binding var selectedTime: Int
    var weekTextInitials = ["T", "W", "T", "F"]
    
    var body: some View {
        VStack(spacing: 0) {
            dateSelector
                .padding(.horizontal, 24)
                .padding(.top, 4)
                .padding(.bottom, 40)
                .onAppear {
                    animateCircles()
                }
            
            VStack(spacing: 0) {
                TimeView(timeValue: 1045, availability: 55, selectedTime: $selectedTime)
                    .padding(.horizontal, 24)
                    .offset(y: visibleTimeSlots[0] ? -50 : 0)
                    .animation(.easeOut(duration: animationDuration), value: visibleTimeSlots[0])
                TimeView(timeValue: 1445, availability: 70, selectedTime: $selectedTime)
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                    .offset(y: visibleTimeSlots[1] ? -50 : 0)
                    .animation(.easeOut(duration: animationDuration), value: visibleTimeSlots[1])
                TimeView(timeValue: 2000, availability: 40, selectedTime: $selectedTime)
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                    .offset(y: visibleTimeSlots[2] ? -50 : 0)
                    .animation(.easeOut(duration: animationDuration), value: visibleTimeSlots[2])
            }
            .offset(y: 50)
            .opacity(selectedDate != -1 ? 1 : 0)
            .background(timeBackgrounView)
            .animation(.easeIn, value: selectedDate)
        }
        .padding(.top, 36)
    }
    
    var timeBackgrounView: some View {
        if selectedDate == -1 {
            return AnyView(
                Text("Select a day to see the\n available showtimes")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
            )
        }
        return AnyView(EmptyView())
    }
    
    var dateSelector: some View {
        HStack(alignment: .top, spacing: 10) {
            ForEach(0..<5, id: \.self) { index in
                Button(action: {
                    selectedDate = index
                    selectedTime = -1
                    animateTimeSlots()
                }) {
                    if index == 4 {
                        Image(systemName: "chevron.down")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 24)
                            .foregroundStyle(Color.white)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(Circle())
                    } else {
                        VStack {
                            Text("\(index + 11)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(selectedDate == index ? Color.black : Color.white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 18)
                                .background(selectedDate == index ? Color.yellow : Color.gray.opacity(0.4))
                                .clipShape(Circle())
                            Text(weekTextInitials[index])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(selectedDate == index ? Color.white : Color.gray)
                        }
                    }
                }
                .scaleEffect(visibleCircles[index] ? 1 : 0)
                .opacity(visibleCircles[index] ? 1 : 0)
                .animation(.easeOut(duration: animationDuration), value: visibleCircles[index])
            }
        }
    }
    
    func animateCircles() {
        for i in 0..<5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * (animationDuration * (1 - overlapFactor))) {
                visibleCircles[i] = true
            }
        }
    }
    
    func animateTimeSlots() {
        for i in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * (animationDuration * (1 - overlapFactor))) {
                visibleTimeSlots[i] = true
            }
        }
    }
}

struct TimeView: View {
    var timeValue: Int
    var availability: CGFloat
    @Binding var selectedTime: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Button(action: {
                    selectedTime = timeValue
                }) {
                    Rectangle()
                        .foregroundStyle(selectedTime == timeValue ? Color.white : Color.gray.opacity(0.5))
                        .clipShape(CustomRoundedCorner(cornerRadii: [(.topLeft, 32),
                                                                     (.topRight, 6),
                                                                     (.bottomLeft, 32),
                                                                     (.bottomRight, 6)
                                                                    ]))
                        .frame(width: (availability / 100) * (UIScreen.main.bounds.width - 48))
                        .overlay(alignment: .leading) {
                            Text("\(convertToTimeFormat(timeValue))")//convertToTimeFormat(timeValue))
                                .foregroundStyle(selectedTime == timeValue ? Color.black : Color.white)
                                .fontWeight(.bold)
                                .padding(.leading, 32)
                        }
                }
                Rectangle()
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .clipShape(CustomRoundedCorner(cornerRadii: [(.topRight, 32),
                                                                 (.topLeft, 6),
                                                                 (.bottomRight, 32),
                                                                 (.bottomLeft, 6)
                                                                ]))
            }
            .frame(height: 64)
        }
    }
    
    func convertToTimeFormat(_ time: Int) -> String {
        let hours = time / 100
        let minutes = time % 100
        
        var formattedHours = hours % 12
        formattedHours = formattedHours == 0 ? 12 : formattedHours
        
        let period = hours < 12 ? "AM" : "PM"
        
        return String(format: "%d:%02d %@", formattedHours, minutes, period)
    }
}

struct DateTimeSelectionView_Previews: PreviewProvider {
    @State static var selectedDate = -1
    @State static var selectedTime = -1
    
    static var previews: some View {
        DateTimeSelectionView(selectedDate: $selectedDate, selectedTime: $selectedTime)
    }
}
