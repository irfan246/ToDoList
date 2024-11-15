import 'package:intl/intl.dart';

import './editScreen.dart';
import './inputForm.dart';
import './dataList.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> dataList = [];
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

  void addList(String date, String title, String price, String category) {
    if (date.isNotEmpty &&
        title.isNotEmpty &&
        price.isNotEmpty &&
        category.isNotEmpty) {
      setState(() {
        dataList.add({
          'date': date,
          'title': title,
          'price': price,
          'category': category
        });
      });
    }
  }

  void editList(int index) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return EditScreen(
            initialDate: dataList[index]['date']!.toString(),
            initialTitle: dataList[index]['title']!.toString(),
            initialPrice: dataList[index]['price']!.toString(),
            initialCategory: dataList[index]['category']!.toString());
      },
    ));

    if (result == 'delete') {
      setState(() {
        dataList.removeAt(index);
      });
    } else if (result != null) {
      final updatedData = (result as Map<String, String?>)
          .map((key, value) => MapEntry(key, value ?? ''));

      setState(() {
        dataList[index] = updatedData;
      });
    }
  }

  String formatPrice(String price) {
    final int priceInt =
        int.tryParse(price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return currencyFormat.format(priceInt);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Catatan Keuangan",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[200],
        ),
        body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return DataList(
              title: dataList[index]['title'].toString(),
              price: formatPrice(dataList[index]['price'].toString()),
              date: dataList[index]['date'].toString(),
              cardColor: (dataList[index]['category'] == 'Income')
                  ? const Color(0xFFDCEDC8)
                  : const Color(0xFFFFCDD2),
              onClick: () {
                editList(index);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const InputForm();
              },
            ));

            if (result != null) {
              addList(result['date'], result['title'], result['price'],
                  result['category']);
            }
          },
          backgroundColor: Colors.blue[100],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
