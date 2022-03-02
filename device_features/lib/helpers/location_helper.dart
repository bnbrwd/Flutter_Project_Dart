const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double logitude}){

    final url = 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$logitude&zoom=16&size=600x300&maptype=roadmap&
&markers=color:blue%7Clabel:S%7C$latitude,$logitude&markers=color:green%7Clabel:G%7C$latitude,$logitude
&markers=color:red%7Clabel:C%7C$latitude,$logitude
&key=YOUR_API_KEY';



  }
}