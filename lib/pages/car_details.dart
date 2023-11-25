import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int itemId;
  final String title;

  const DetailPage({Key? key, required this.itemId, required this.title})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<CarDetail>> carDetails;

  @override
  void initState() {
    super.initState();
    carDetails = fetchCarDetails(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<CarDetail>> snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Year: ${snapshot.data![index].year}'),
                      subtitle: Text(
                          'Make: ${snapshot.data![index].make}\nModel: ${snapshot.data![index].model}\nType: ${snapshot.data![index].type}\nID: ${snapshot.data![index].id}'),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return const CircularProgressIndicator();
          },
          future: carDetails,
        ),
      ),
    );
  }
}

class CarDetail {
  final String year;
  final String make;
  final String model;
  final String type;
  final String id;

  CarDetail(
      {required this.year,
      required this.make,
      required this.model,
      required this.type,
      required this.id});

  factory CarDetail.fromJson(Map<String, dynamic> json) {
    return CarDetail(
        year: json['year'],
        make: json['make'],
        model: json['model'],
        type: json['type'],
        id: json['id']);
  }
}

Future<List<CarDetail>> fetchCarDetails(int itemId) async {
  final String apiKey = 'f9748f64d0msh0db9bc2d0d0c998p191da9jsn2473fd06052f';
  final String apiUrl = 'https://car-data.p.rapidapi.com/cars';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'X-RapidAPI-Key': apiKey,
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var carsJson = jsonDecode(response.body) as List;
    debugPrint(carsJson.toString());

    return carsJson.map((car) => CarDetail.fromJson(car)).toList();
  } else {
    throw Exception('Failed to load car details');
  }
}
