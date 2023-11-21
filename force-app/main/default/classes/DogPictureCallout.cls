public with sharing class DogPictureCallout {
    @AuraEnabled
    public static string getDogPicture(){
      Http http = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://dog.ceo/api/breeds/image/random');
      req.setMethod('GET');
      HttpResponse res = http.send(req);
      return res.getBody();
    }
}