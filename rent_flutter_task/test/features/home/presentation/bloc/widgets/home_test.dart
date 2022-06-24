import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:rent_flutter_task/core/di/di_configuration.dart';
import 'package:rent_flutter_task/features/home/presentation/views/home_page.dart';
import 'package:rent_flutter_task/features/home/presentation/wedgits/account_item_widget.dart';
import 'package:rent_flutter_task/features/home/presentation/wedgits/header_widget.dart';

void main() {
  setUpAll(() async {
    await configureDependencies(Environment.test);
    await dotenv.load();
  });

  group('Accounts list view', () {
    testWidgets("ListView.builder respects findChildIndexCallback",
        (tester) async {
      bool finderCalled = false;
      int itemCount = 7;
      late StateSetter stateSetter;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            stateSetter = setState;
            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext _, int index) => AccountItemWidget(
                  key: Key('$index'),
                  name: 'name $index',
                  address: 'address $index',
                  stateCode: 'stateCode $index',
                  province: 'province $index',
                  email: 'email $index',
                  imageSrc: 'imageSrc'),
              findChildIndexCallback: (Key key) {
                finderCalled = true;
                return null;
              },
            );
          }),
        ),
      );

      expect(finderCalled, false);
      stateSetter(() => itemCount = 100);
      await tester.pump();
      expect(finderCalled, true);
    });

    testWidgets('list item existed', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext _, int index) => AccountItemWidget(
                key: Key('$index'),
                name: 'name $index',
                address: 'address $index',
                stateCode: 'stateCode $index',
                province: 'province $index',
                email: 'email $index',
                imageSrc: 'imageSrc'),
          ),
        ),
      );

      expect(find.text('name 0'), findsOneWidget);
      expect(find.text('address 0'), findsOneWidget);
      expect(find.text('stateCode 0'), findsOneWidget);
      expect(find.text('province 0'), findsOneWidget);
      expect(find.text('email 0'), findsOneWidget);

      expect(find.text('name 1'), findsOneWidget);
      expect(find.text('address 1'), findsOneWidget);
      expect(find.text('stateCode 1'), findsOneWidget);
      expect(find.text('province 1'), findsOneWidget);
      expect(find.text('email 1'), findsOneWidget);

      expect(find.text('name 2'), findsNothing);
      expect(find.text('address 2'), findsNothing);
      expect(find.text('stateCode 2'), findsNothing);
      expect(find.text('province 2'), findsNothing);
      expect(find.text('email 2'), findsNothing);
    });

    testWidgets('list item existed', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (BuildContext _, int index) => AccountItemWidget(
                key: Key('$index'),
                name: 'name $index',
                address: 'address $index',
                stateCode: 'stateCode $index',
                province: 'province $index',
                email: 'email $index',
                imageSrc: 'imageSrc'),
          ),
        ),
      );

      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pump();

      expect(find.text('name 0'), findsNothing);
      expect(find.text('address 0'), findsNothing);
      expect(find.text('stateCode 0'), findsNothing);
      expect(find.text('province 0'), findsNothing);
      expect(find.text('email 0'), findsNothing);
    });
  });

  testWidgets('header should be existed. ', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));
    await tester.pump(Duration(seconds: 1));
    expect(find.byType(HeaderWidget), findsOneWidget);
  });
}
