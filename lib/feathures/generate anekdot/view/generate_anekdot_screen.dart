import 'package:auto_route/auto_route.dart';
import 'package:category_b/ui/widgets/base_bottom_sheet.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GenerateAnekdotScreen extends StatelessWidget {
  const GenerateAnekdotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Category B'), centerTitle: true),
      body: Center(
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 100),
                child: BaseBottomSheet(
                  child: Center(
                    child: Text(
                      'анекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тутанекдоты будут тут',
                    ),
                  ),
                ),
              ),
            );
          },
          child: Text('Рандомный анек'),
        ),
      ),
    );
  }
}
