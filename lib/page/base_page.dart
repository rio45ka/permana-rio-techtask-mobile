import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/viewmodel/base_viewmodel.dart';

class BasePage<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BasePage({@required this.builder, this.onModelReady});

  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends BaseViewModel> extends State<BasePage<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
