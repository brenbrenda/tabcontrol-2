 import Foundation 
public class GeoIPService {
 public var Url:String = "http://wsgeoip.lavasoft.com/ipservice.asmx"
 public var Host:String = "wsgeoip.lavasoft.com"
public func dataToBase64(data:NSData)->String{
    
        let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return result;
    }
    public func dataToBase64(data: Data)->String {
        let result = data.base64EncodedString()
        return result
    }
    public func byteArrayToBase64(data:[UInt])->String{
        let nsdata = NSData(bytes: data, length: data.count)
        let data  = Data.init(referencing: nsdata)
        if let str = String.init(data: data, encoding: String.Encoding.utf8){
            return str
        }
        return "";
    }
    public func timeToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    public func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func base64ToByteArray(base64String: String) -> [UInt8] {
        let data = Data.init(base64Encoded: base64String)
        let dataCount = data!.count
        var bytes = [UInt8].init(repeating: 0, count: dataCount)
        data!.copyBytes(to: &bytes, count: dataCount)
        return bytes
    }
    func stringFromXMLString(xmlToParse:String)->String {
        do
        {
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            let xmlElement = xmlResult?.element
            let str = xmlElement?.text
            let xmlElementFirst = xmlElement?.children[0] as!TextElement
            return xmlElementFirst.text
        }
        catch
        {
        }
        //NOT IMPLETEMENTED!
        var returnValue:String!
        return returnValue
    }
    func stringFromXML(data:Data)-> String
    {
        
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return ""
        }
        if xmlToParse!.count == 0 {
            return ""
        }
        let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
        
    }
    func stringArrFromXMLString(xmlToParse :String)->[String?]{
        let xml  = SWXMLHash.lazy(xmlToParse)
        let xmlRoot  = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse : XMLIndexer? =  xmlBody?.children.first
        let xmlResult : XMLIndexer?  = xmlResponse?.children.last
        
        var strList = [String?]()
        let childs = xmlResult!.children
        for child in childs {
            let text = child.element?.text
            strList.append(text)
        }
        
        return strList
    }
    func stringArrFromXML(data:Data)->[String?]{
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return [String?]()
        }
        if xmlToParse!.count == 0 {
            return [String?]()
        }
        
        let  stringVal = stringArrFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
    }
    
    func byteArrayToBase64(bytes: [UInt8]) -> String {
        
        let data = Data.init(bytes: bytes)
        let base64Encoded = data.base64EncodedString()
        return base64Encoded;
       
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let data = Data.init(base64Encoded: base64String){
            var bytes = [UInt8](repeating: 0, count: data.count)
            data.copyBytes(to: &bytes, count: data.count)
            return bytes;
        }
        return nil // Invalid input
    }
  
public func GetIpLocation(sIp:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<GetIpLocation xmlns=\"http://lavasoft.com/\">"
soapReqXML += "<sIp>"
soapReqXML += sIp
soapReqXML += "</sIp>"
soapReqXML += "</GetIpLocation>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://lavasoft.com/GetIpLocation"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func GetIpLocation_2_0(sIp:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<GetIpLocation_2_0 xmlns=\"http://lavasoft.com/\">"
soapReqXML += "<sIp>"
soapReqXML += sIp
soapReqXML += "</sIp>"
soapReqXML += "</GetIpLocation_2_0>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://lavasoft.com/GetIpLocation_2_0"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func GetLocation()-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<GetLocation xmlns=\"http://lavasoft.com/\">"
soapReqXML += "</GetLocation>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://lavasoft.com/GetLocation"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func GetCountryISO2ByName(countryName:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<GetCountryISO2ByName xmlns=\"http://lavasoft.com/\">"
soapReqXML += "<countryName>"
soapReqXML += countryName
soapReqXML += "</countryName>"
soapReqXML += "</GetCountryISO2ByName>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://lavasoft.com/GetCountryISO2ByName"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func GetCountryNameByISO2(iso2Code:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<GetCountryNameByISO2 xmlns=\"http://lavasoft.com/\">"
soapReqXML += "<iso2Code>"
soapReqXML += iso2Code
soapReqXML += "</iso2Code>"
soapReqXML += "</GetCountryNameByISO2>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://lavasoft.com/GetCountryNameByISO2"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
}
