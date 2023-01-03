import SwiftUI


struct FooView: View {
    
    @State private var isSwitched: Bool = false
    @Namespace private var ns
    
    var body: some View {
        HStack {
            
            if !isSwitched {
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .matchedGeometryEffect(id: "animation", in: ns)
                  
            }
            
            Spacer()
            
            Button("Switch") {
                withAnimation {
                    isSwitched.toggle()
                }
            }
            
            Spacer()
            
            VStack {
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                
                if isSwitched {
                    Circle()
                        .fill(Color.green)
                        .matchedGeometryEffect(id: "animation", in: ns)
                    
                }
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                
            }
            
        }
    }
}

struct Foo_Previews: PreviewProvider {
    static var previews: some View {
        FooView()
    }
}
