import 'package:flutter/material.dart';
import 'package:math_training/features/trainings/presentation/widgets/trainings_app_bar.dart';
import 'package:math_training/widgets/info_modal.dart';

class TrainingsListTemplate extends StatefulWidget {
  final String title;
  final List<Widget> trainingPanels;
  const TrainingsListTemplate(
      {super.key, required this.title, required this.trainingPanels});

  @override
  State<TrainingsListTemplate> createState() => _TrainingsListTemplate();
}

class _TrainingsListTemplate extends State<TrainingsListTemplate>
    with AutomaticKeepAliveClientMixin<TrainingsListTemplate> {
  final _scrollController = ScrollController();
  bool _visible = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      _visible = _scrollController.offset > 30;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () {
                            showInfoModal(context);
                          },
                          icon: Icon(
                            color: Theme.of(context).colorScheme.onSurface,
                            Icons.person,
                            size: 32,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              for (var panel in widget.trainingPanels) ...[
                panel,
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
        TrainingsAppBar(title: widget.title, visible: _visible),
      ],
    );
  }
}
