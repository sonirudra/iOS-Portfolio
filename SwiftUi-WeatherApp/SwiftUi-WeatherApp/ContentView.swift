import SwiftUI

struct ContentView: View {
    @State private var isNight: Bool = false
    
    let weekDays: [DayModel] = [
        DayModel(dayOfWeekShort: "TUE", dayWeatherImageName: "cloud.sun.fill", dayTemprature: 26),
        DayModel(dayOfWeekShort: "TUE", dayWeatherImageName: "cloud.rain.fill", dayTemprature: 26),
        DayModel(dayOfWeekShort: "TUE", dayWeatherImageName: "sun.rain.fill", dayTemprature: 26),
        DayModel(dayOfWeekShort: "TUE", dayWeatherImageName: "tornado", dayTemprature: 26),
        DayModel(dayOfWeekShort: "TUE", dayWeatherImageName: "cloud.sun.rain.fill", dayTemprature: 26),
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                CityNameView(cityName: "Surat, IN")
                
                MainCityWeatherView(weatherImageName: "cloud.sun.fill", temprature: 27)
                
                HStack(spacing: 20) {
                    ForEach(weekDays, id: \.self) { weekday in
                        WeatherDayView(dayOfWeek: weekday)
                    }
                }
                Spacer()
                Button(action: {
                    isNight.toggle()
                }, label: {
                    if #available(iOS 17.0, *) {
                        WeatherButton(title: "Change Day Time", textColor: .blue, backgeoundColor: .white)
                    } else {
                        // Fallback on earlier versions
                    }
                })
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: DayModel
    
    var body: some View {
        VStack(spacing: 5) {
            Text(dayOfWeek.dayOfWeekShort)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.white)
            Image(systemName: dayOfWeek.dayWeatherImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 40)
            Text("\(dayOfWeek.dayTemprature)°")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

struct CityNameView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 30, weight: .semibold, design: .default))
            .foregroundStyle(.white)
            .padding(.all, 12)
    }
}

struct MainCityWeatherView: View {
    var weatherImageName: String
    var temprature: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: weatherImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
            
            Text("\(temprature)°C")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 60)
    }
}

@available(iOS 17.0, *)
struct WeatherButton: View {
    var title: String
    var textColor: any ShapeStyle
    var backgeoundColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .foregroundStyle(textColor)
            .frame(width: 280, height: 50)
            .background(backgeoundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
