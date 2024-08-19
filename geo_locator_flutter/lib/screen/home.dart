import 'package:flutter/material.dart';
import 'package:geo_locator_flutter/service/my_geo_locator.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  bool isVisible = false;
  String latitude = '00.0000';
  String longitude = '00.0000';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Geo Location'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => onClickEvent(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Geo Location',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Text(
                          'Click the button to fetch location',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    isLoading
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              color: Colors.blueGrey,
                            ),
                          )
                        : SizedBox.square(
                            dimension: 35,
                            child: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.navigate_next_rounded,
                                  size: 17,
                                )))
                  ],
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 50,
                      color: Colors.grey.shade300,
                    ),
                    const Text(
                      'Location Info',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Latitude',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      latitude,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Longitude',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      longitude,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Divider(color: Colors.grey.shade300),
              GestureDetector(
                onTap: () => onClickEvent(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.restart_alt_sharp,
                        size: 30,
                        color: Colors.grey.shade700,
                      )),
                ),
              )
            ],
          )),
    );
  }

  void onClickEvent() async {
    setState(() {
      isVisible = false;
      isLoading = true;
    });

    Position position = await MyGeoLocator().determinePosition();

    setState(() {
      isLoading = false;
      isVisible = true;
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }
}
