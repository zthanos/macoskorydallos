// MARK: - OpenWeatherResponseElement
struct OpenWeatherResponseElement: Codable {
    let openWeatherResponseDescription: String
    let icon: String
    let dayOfTheWeek: String
    let formatedDate: String
    let temprature: String

    enum CodingKeys: String, CodingKey {
        case openWeatherResponseDescription = "description"
        case icon, dayOfTheWeek, formatedDate, temprature
    }
}


typealias OpenWeatherResponse = [OpenWeatherResponseElement]
