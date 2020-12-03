 import Foundation 
public class WebService1 {
 public var Url:String = "http://120.125.78.68/WebService1.asmx"
 public var Host:String = "120.125.78.68"
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
  
public func Login(ID:String, PS:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Login xmlns=\"http://tempuri.org/\">"
soapReqXML += "<ID>"
soapReqXML += ID
soapReqXML += "</ID>"
soapReqXML += "<PS>"
soapReqXML += PS
soapReqXML += "</PS>"
soapReqXML += "</Login>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Login"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func Login1(ID:String, PS:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Login1 xmlns=\"http://tempuri.org/\">"
soapReqXML += "<ID>"
soapReqXML += ID
soapReqXML += "</ID>"
soapReqXML += "<PS>"
soapReqXML += PS
soapReqXML += "</PS>"
soapReqXML += "</Login1>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Login1"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func database(data:String, id:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<database xmlns=\"http://tempuri.org/\">"
soapReqXML += "<data>"
soapReqXML += data
soapReqXML += "</data>"
soapReqXML += "<id>"
soapReqXML += id
soapReqXML += "</id>"
soapReqXML += "</database>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/database"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func value(item:String, roomid:Int)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<value xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "<roomid>"
soapReqXML += String(roomid)
soapReqXML += "</roomid>"
soapReqXML += "</value>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/value"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func Query(id:String, mName:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<Query xmlns=\"http://tempuri.org/\">"
soapReqXML += "<id>"
soapReqXML += id
soapReqXML += "</id>"
soapReqXML += "<mName>"
soapReqXML += mName
soapReqXML += "</mName>"
soapReqXML += "</Query>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/Query"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func sendLocation(user:String, latitude:String, longtitude:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<sendLocation xmlns=\"http://tempuri.org/\">"
soapReqXML += "<user>"
soapReqXML += user
soapReqXML += "</user>"
soapReqXML += "<latitude>"
soapReqXML += latitude
soapReqXML += "</latitude>"
soapReqXML += "<longtitude>"
soapReqXML += longtitude
soapReqXML += "</longtitude>"
soapReqXML += "</sendLocation>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/sendLocation"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func save_weather(place:String, AQI:String, PM25:String, PM10:String)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<save_weather xmlns=\"http://tempuri.org/\">"
soapReqXML += "<place>"
soapReqXML += place
soapReqXML += "</place>"
soapReqXML += "<AQI>"
soapReqXML += AQI
soapReqXML += "</AQI>"
soapReqXML += "<PM25>"
soapReqXML += PM25
soapReqXML += "</PM25>"
soapReqXML += "<PM10>"
soapReqXML += PM10
soapReqXML += "</PM10>"
soapReqXML += "</save_weather>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/save_weather"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func wvalue(item:String, place:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<wvalue xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "<place>"
soapReqXML += place
soapReqXML += "</place>"
soapReqXML += "</wvalue>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/wvalue"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func value_voice(data:String, room:Int)-> String{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<value_voice xmlns=\"http://tempuri.org/\">"
soapReqXML += "<data>"
soapReqXML += data
soapReqXML += "</data>"
soapReqXML += "<room>"
soapReqXML += String(room)
soapReqXML += "</room>"
soapReqXML += "</value_voice>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/value_voice"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML(data : responseData);
 if strVal == nil {

    return  ""
 }
 let returnValue:String = strVal!
   return returnValue
}
public func app_101(item:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_101 xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_101>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_101"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func app_102(item:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_102 xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_102>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_102"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func app_206(item:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_206 xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_206>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_206"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
public func app_101_line(item:String)-> [Int]{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_101_line xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_101_line>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_101_line"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVals :[String?] = stringArrFromXML(data : responseData);
 var vals = [Int]()
 for i in 0  ..< strVals.count {
    let xVal = strVals[i]!.toInt()!
    vals.append(xVal) 
 }
 let returnValue:[Int] = vals 
   return returnValue
}
public func app_102_line(item:String)-> [Int]{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_102_line xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_102_line>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_102_line"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVals :[String?] = stringArrFromXML(data : responseData);
 var vals = [Int]()
 for i in 0  ..< strVals.count {
    let xVal = strVals[i]!.toInt()!
    vals.append(xVal) 
 }
 let returnValue:[Int] = vals 
   return returnValue
}
public func app_206_line(item:String)-> [Int]{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_206_line xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_206_line>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_206_line"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVals :[String?] = stringArrFromXML(data : responseData);
 var vals = [Int]()
 for i in 0  ..< strVals.count {
    let xVal = strVals[i]!.toInt()!
    vals.append(xVal) 
 }
 let returnValue:[Int] = vals 
   return returnValue
}
public func app_101_line_date(item:String)-> [String?]{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<app_101_line_date xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</app_101_line_date>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/app_101_line_date"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVals :[String?] = stringArrFromXML(data : responseData);
 var vals = [String?]()
 for i in 0  ..< strVals.count {
    let xVal =  strVals[i]
    vals.append(xVal) 
 }
 let returnValue:[String?] = vals 
   return returnValue
}
public func wvalue_app(item:String)-> Int{
   var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
soapReqXML += " <soap:Body>"
soapReqXML += "<wvalue_app xmlns=\"http://tempuri.org/\">"
soapReqXML += "<item>"
soapReqXML += item
soapReqXML += "</item>"
soapReqXML += "</wvalue_app>"
soapReqXML += "</soap:Body>"
soapReqXML += "</soap:Envelope>"

   let soapAction :String = "http://tempuri.org/wvalue_app"

   let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
 let strVal :String? = stringFromXML( data : responseData);
 if strVal == nil {

    return  0
 }
 let returnValue:Int = strVal!.toInt()!
   return returnValue
}
}