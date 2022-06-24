import 'package:flutter/material.dart';

class AccountItemWidget extends StatelessWidget {
  final String name;
  final String address;
  final String stateCode;
  final String province;
  final String email;
  final String? imageSrc;
  final imageUrlRegex = RegExp(r'(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|png)');
  AccountItemWidget(
      {Key? key,
      required this.name,
      required this.address,
      required this.stateCode,
      required this.province,
      required this.email,
      required this.imageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (imageUrlRegex.hasMatch(imageSrc ?? ''))
                FadeInImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                    placeholder: const AssetImage('assets/corrupted.png'),
                    image: NetworkImage(imageSrc!))
              else
                Image.asset(
                  'assets/corrupted.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Name : '),
                      Text(name),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Row(
                    children: [
                      const Text('Email : '),
                      Text(email),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Row(
                    children: [
                      const Text('Address : '),
                      Text(address, maxLines: 1),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Row(
                    children: [
                      const Text('state Code : '),
                      Text(stateCode),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Row(
                    children: [
                      const Text('Province : '),
                      Text(province),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      );
}
