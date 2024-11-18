import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trattoriasofia/models/slide_mode.dart';
import 'package:trattoriasofia/widgets/appbar_list.dart';
import 'package:trattoriasofia/widgets/base_text.dart';
import 'package:trattoriasofia/widgets/text_primary.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HoursLocationScreen extends StatefulWidget {
  const HoursLocationScreen({super.key});

  @override
  State<HoursLocationScreen> createState() => _HoursLocationScreenState();
}

class _HoursLocationScreenState extends State<HoursLocationScreen> {
  List<SlideModel> slides = [
    SlideModel()
      ..title = "HOURS & LOCATION"
      ..url = "URL 1"
      ..image =
          "https://popmenucloud.com/cdn-cgi/image/width%3D1920%2Cheight%3D1920%2Cfit%3Dscale-down%2Cformat%3Dauto%2Cquality%3D60/mktfsulh/343c58aa-5614-457f-b30c-f5dca4109b3b.jpg"
      ..thumbnail = "THUMBNAIL URL 1"
      ..description = "Description 1",
    SlideModel()
      ..title = "HOURS & LOCATION"
      ..url = "URL 2"
      ..image =
          "https://popmenucloud.com/cdn-cgi/image/width%3D1920%2Cheight%3D1920%2Cfit%3Dscale-down%2Cformat%3Dauto%2Cquality%3D60/mktfsulh/e346b6bc-a063-4089-ae4d-47db99ab3413.jpg"
      ..thumbnail = "THUMBNAIL URL 2"
      ..description = "Description 2",
    /*
    SlideModel()
      ..title = "Slide 3"
      ..url = "URL 3"
      ..image = "IMAGE URL 3"
      ..thumbnail = "THUMBNAIL URL 3"
      ..description = "Description 3",
      */
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarList("Hours & Location"),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
              onPageChanged: (index, _) {
                setState(() {
                  _loading = true;
                });
              },
            ),
            items: slides.map((slide) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                      slide.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          _loading = false;
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Center(
                    child: PrimaryText(
                      slide.title,
                      color: Colors.white,
                    ),
                  ),
                  if (_loading != true)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
          /*
          Container(
            height: 180,
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                /*
                FutureBuilder<List<SlideModel>?>(
                    future: getSlides(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<SlideModel>?> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No data available.');
                          } else {
                            return 
                            */
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: slides.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: width,
                            height: 400,
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            child: Align(
                              alignment: Alignment.center,
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                    'assets/placeholder_image.png'),
                                image: NetworkImage(
                                  //Helper.BaseAssetUrl +
                                  slides[index].image,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: PrimaryText(
                            slides[index].title,
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  },
                )
                /*
                          }
                      }
                    }),
                    */
              ],
            ),
          ),
          */
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText("OUR LOCATION"),
              const SizedBox(height: 30),
              PrimaryText("HOUSTON"),
              BaseText("911 W 11th St."),
              BaseText("HOUSTON, TX 77008"),
              const SizedBox(
                height: 12,
              ),
              BaseText("(713) 804-0429"),
              const SizedBox(
                height: 12,
              ),
              BaseText("trattoriasofia@berghospitality.com"),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseText(
                "Make a Reservation",
                size: 19,
                fontWeight: FontWeight.bold,
              ),
              Container(
                height: 420,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InputView(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.red.shade700,
                        width: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  BaseText(
                    "OpenTable",
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryText("HOURS"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText("Sunday:"),
                  BaseText("11:00 am"),
                  BaseText(" - "),
                  BaseText("9:00 pm"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText("Monday"),
                  BaseText(" - "),
                  BaseText("Thursday:"),
                  BaseText("11:00 am"),
                  BaseText(" - "),
                  BaseText("10:00 pm"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText("Friday"),
                  BaseText(" - "),
                  BaseText("Saturday:"),
                  BaseText("11:00 am"),
                  BaseText(" - "),
                  BaseText("11:00 pm"),
                ],
              ),
            ],
          ),
          /*
          Container(
            width: 400,
            height: 200,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: const Text('To the lake!'),
            icon: const Icon(Icons.directions_boat),
          )
          */
        ],
      ),
    );
  }
}

class InputView extends StatefulWidget {
  @override
  _InputViewState createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  DateTime _selectedDate = DateTime(2024, 5, 28);
  String _selectedTime = '7:00 PM';
  int _selectedPeople = 2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 10.0),
                const SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                    }
                  },
                  child: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 10.0),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedTime,
                      onChanged: (value) {
                        setState(() {
                          _selectedTime = value!;
                        });
                      },
                      items: ['7:00 AM', '7:30 AM', '7:00 PM', '7:30 PM']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              color: Colors.grey,
              height: 1,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 10.0),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedPeople,
                      onChanged: (value) {
                        setState(() {
                          _selectedPeople = value!;
                        });
                      },
                      items: List.generate(20, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value person${value > 1 ? 's' : ''}'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for Find a table button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  child: const Text(
                    'Find a table',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
