//
//  DetailView.swift
//  Sketch+Paws
//
//  Created by becky wong on 12/12/21.
//

import SwiftUI

struct DetailView: View {
    let pose: Pose
    @State private var timerOpen = false
    var body: some View {
        ZStack {
            Color("Secondary")
                .ignoresSafeArea()
            ScrollView (showsIndicators: false){
                VStack(spacing:20) {
                    Image(pose.icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text(pose.name)
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Highlight"))
                    Text(pose.asana)
                        .italic()
                        .fontWeight(.medium)
                    Text(pose.description)
                    Text("How to:")
                        .foregroundColor(Color("Highlight"))
                        .fontWeight(.medium)
                    ForEach(pose.steps, id:\.self){
                        step in
                        Text(step)
                    }
                    Text("Top tip:")
                        .foregroundColor(Color("Highlight"))
                        .fontWeight(.medium)
                    Text(pose.topTip)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
            }
            TimerPanelView(timerOpen: $timerOpen)
        }.onTapGesture {
            timerOpen = false
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pose: Pose(
            name: "Downward-Facing Dog",
            asana: "Adho Mukha Shvanasana",
            icon: "cat_01",
            description: "Did someone say dog? Can't we call this a downward-facing cat instead? It's OK – this is a friendly dog, it's not interested in chasing cats. In fact, Downward-Facing Dog is the lynchpin of a yoga asana practice: if you're going to befriend any of these poses, make sure it's this canine classic.",
            steps: ["From a kneeling position, place your hands shoulder-distance apart and spread your fingers.","Tuck your toes and lift your hips up towards the ceiling so you create an inverted V shape.", "Balance the weight between hands and feet and think about tilting your tailbone up towards the ceiling.", "Send your gaze towards your feet and breathe!"],
            topTip: "bend your knees in order to create more length through the spine."
        )
        )
    }
}


struct TimerPanelView: View {
    
    @StateObject var yogaTimer = YogaTimer()
    @Binding var timerOpen: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                timerOpen ? AnyView(TimerOpenView(yogaTimer: yogaTimer)) : AnyView(TimerClosedView())
            }
            .foregroundColor(Color("Secondary"))
            .frame(maxWidth: .infinity, maxHeight: timerOpen ? 420 : 80)
            .background(Color("Highlight"))
            .cornerRadius(6)
        }
        .ignoresSafeArea()
        .onTapGesture {
            timerOpen.toggle()
        }
    }
}

struct TimerOpenView: View {
    
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View{
        VStack {
            Text(yogaTimer.setTitleText())
                .fontWeight(.medium)
            Spacer()
            Text(yogaTimer.setDescriptionText())
                .multilineTextAlignment(.center)
            Spacer()
            
            if !yogaTimer.timerEnded {
                CountdownView(yogaTimer: yogaTimer)
            Spacer()
            
            }
            
            if yogaTimer.timerActive {
                TimerPausedButtonView(yogaTimer: yogaTimer)
            } else {
                TimerActiveButtonView(yogaTimer: yogaTimer)
            }
        }.padding(50)
       
    }
}

struct TimerClosedView: View {
    var body: some View {
        Text("Try it out")
            .fontWeight(.medium)
            .padding(20)
        Spacer()
    }
}

struct CountdownView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Text(yogaTimer.timerDuration < 10 ? "00:0\(yogaTimer.timerDuration)" : "00:\(yogaTimer.timerDuration)")
            .font(.system(size:80))
    }
}

struct TimerPausedButtonView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Button {
            yogaTimer.pauseTimer()
        } label : {
            Text("Pause the timer")
                .padding(70)
        }
        .frame(width: 300, height:50)
        .background(Color("Highlight"))
        .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("Secondary"), lineWidth: 3)
        )
    }
}

struct TimerActiveButtonView: View {
    @ObservedObject var yogaTimer: YogaTimer
    var body: some View {
        Button{
            yogaTimer.startTimer()
        } label:{
            Text(yogaTimer.timerPaused || yogaTimer.timerEnded ? "Restart Timer" : "Start the timer")
                .padding(70)
        }
        .frame(width: 300, height:50)
        .background(Color("Secondary"))
        .foregroundColor(Color("Primary"))
        .cornerRadius(30)
    }
}
