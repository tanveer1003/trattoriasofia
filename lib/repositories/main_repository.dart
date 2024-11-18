import 'package:trattoriasofia/helpers/functions.dart';
import 'package:trattoriasofia/models/slide_mode.dart';

Future<List<SlideModel>?> getSlides() async {
  try {
    var rs = await Functions.netCall("sliders/?format=json", auth: false);
    List<SlideModel> slides = [];
    for (int a = 0; a < rs!["data"].length; a++) {
      slides.add(SlideModel.fromJson(rs["data"][a]));
    }
    return slides;
  } catch (e) {
    print("catach error");
    print(e);
    return null;
    //throw (e);
  }
}
