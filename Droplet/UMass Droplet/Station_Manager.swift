import Foundation
import CoreLocation

class Station_Manager{

//Write a function that decodes JSON from test.json file in the same folder as this program and then returns the decoded JSON in responseBody format

    // func getStationList() -> ResponseBody {
    //     var data: ResponseBody?
    //     do {
    //     if let filePath = Bundle.main.path(forResource: "test", ofType: "json") {
    //         let fileUrl = URL(fileURLWithPath: filePath)
    //         data = try ResponseBody(from: fileUrl)
    //         let decodedData = try JSONDecoder().decode(sampleRecord.self, from: data)
    //         return data
    //     }
    // } catch {
    //     print("error: \(error)")
    // }
    // return data
    // }

    func getStationList(){
        let jsonData = readLocalJSONFile(forName: "test")
        if let data = jsonData {
        if let sampleRecordObj = parse(jsonData: data) {
        //You can read sampleRecordObj just like below.
            print(sampleRecordObj)
        }
        print("Done")
        }
    }

    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
            else{
                print("File not found")
            }
        } catch {
            print("error: \(error)")
        }

        return nil
    }

    func parse(jsonData: Data) -> ResponseBody? {
        do {
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        print("Reach")
        return nil
    }
}


//Station_Manager().getStationList()


struct ResponseBody: Decodable {
    var buildingName: String
    var lon: Double
    var lat: Double
    var stationList: StationCollection

    struct StationCollection: Decodable {
        var stationID: Int
        var floor: Int
        var status: String
        var notes: String
    }
}
