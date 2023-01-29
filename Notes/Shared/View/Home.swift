//
//  Home.swift
//  NoteMacOS
//
//  Created by huang on 2023/1/29.
//

import SwiftUI

struct Home: View {
    
    // Showing CardColor on button Click
    @State var showColors: Bool = false
    
    // Button animation
    @State var animationButton: Bool = false
    
    var body: some View {
        HStack(spacing: 0){
            // sideBar
            if isMacOS() {
                Group{
                    sideBar()
                    Rectangle().fill(Color.gray.opacity(0.15))
                        .frame(width: 1)
   
                }
            }
            MainContent()
        }
        #if os(macOS)
        .ignoresSafeArea()
        #endif
        .frame(width: isMacOS() ? getRect().width / 1.5 : nil, height: isMacOS() ? getRect().height - 250 : nil, alignment: .leading)
        #if os(iOS)
        .overlay(sideBar())
        #endif
        .background(Color("BG").ignoresSafeArea())
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func sideBar() -> some View {
        VStack{
            
            if isMacOS() {
                Text("Pocket")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            if isMacOS() {
                AddBtn().zIndex(1)
            }
            
            VStack(spacing: 15){
                let colors = [Color("Skin"),Color("Orange"),Color("Purple"),Color("Blue"),Color("green")]
                ForEach(colors, id: \.self){ color in
                    Circle().fill(color)
                        .frame(width: isMacOS() ? 20 : 25, height:  isMacOS() ? 20 : 25)
                    
                }
            }
            .padding(.top, 20)
            .frame(height: showColors ? nil : 0)
            .opacity(showColors ? 1 : 0)
            .zIndex(0)
            if !isMacOS() {
                AddBtn().zIndex(1)
            }
        }
        #if os(macOS)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
        .zIndex(0)
        #else
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
        .padding()
        .background(BlurView(style: .systemUltraThinMaterial)
            .opacity(showColors ? 1 : 0)
            .ignoresSafeArea())
        #endif
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 6){
            HStack(spacing: 8){
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)

                TextField("search", text: .constant(""))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            .overlay(
                Rectangle().fill(Color.gray.opacity(0.15))
                    .frame(height: 1)
                    .padding(.horizontal, -25)
                    .offset(y: 6),
                
                
                alignment: .bottom
            )
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
     
                    Text("Notes")
                        .font(isMacOS() ? .system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Columns...
                    let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOS() ? 25 : 15), count: isMacOS() ? 3 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 25){
                        ForEach(notes){ note in
                           
                            // cardView...
                            CardView(note: note)
                        }
                    }
                }
                .padding(.top, isMacOS() ? 45 : 30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 40 : 15)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func CardView(note: Note) -> some View {
        VStack{
            Text(note.note)
                .font(isMacOS() ? .title3: .body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text(note.date, style: .date).foregroundColor(.black).opacity(0.8)
                Spacer(minLength: 0)
                Button(action: {}, label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                })
            }
            .padding(.top, 55)
        }
        .padding()
        .background(note.carColor)
        .cornerRadius(18)
    }
        
    @ViewBuilder
    func AddBtn() -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                showColors.toggle()
                animationButton.toggle()
            }
            
            // Resetting the button
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring()){
                    animationButton.toggle()
                }
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .scaleEffect(animationButton ? 1.1 : 1)
                .padding(isMacOS() ? 12 : 15)
                .background(Color.black)
                .clipShape(Circle())
         }
        .rotationEffect(.init(degrees: showColors ? 45 : 0))
        .scaleEffect(animationButton ? 1.1 : 1)
        .padding(.top, 30)

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
    }
    
    func isMacOS()->Bool{
        #if os(iOS)
        return false
        #else
        return true
        #endif
    }
}

// Hiding Focus Ring...

#if os(macOS)
extension NSTextField{
    open override var focusRingType:NSFocusRingType{
        get{.none}
        set{}
    }
}
#endif
