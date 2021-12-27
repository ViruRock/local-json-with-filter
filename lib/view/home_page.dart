import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:localjsonwithfilter/view/filter_sheet.dart';
import 'package:localjsonwithfilter/viewModel/training_list_vm.dart';
import 'package:localjsonwithfilter/model/training_model.dart';
import 'package:localjsonwithfilter/utils/ui_helper.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Training> trainingList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<TrainingListVM>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: showText(
            message: 'Training', fontSize: 18.0, fontWeight: FontWeight.bold),
        actions: [
          showIconButton(
            onPressed: () {
              showFilterSheet(context: context, trainingListVM: data);
            },
            icon: Icons.filter_list_alt,
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              )
            : data.searchTraining.isEmpty
                ? showText(message: 'No data available', fontSize: 18.0)
                : showList(data),
        // : _showL(data),
      ),
    );
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });

    Provider.of<TrainingListVM>(context, listen: false)
        .loadData()
        .then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  showList(TrainingListVM data) {
    return ListView.builder(
        itemCount: data.searchTraining.length,
        itemBuilder: (ctx, index) {
          return SizedBox(
            height: 200, //fixed height
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showText(
                              message:
                                  data.searchTraining[index].deadline!.dates!,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900),
                          const SizedBox(height: 12.0),
                          showText(
                              message:
                                  data.searchTraining[index].deadline!.timings!,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                          const SizedBox(height: 12.0),
                          const Spacer(),
                          showText(
                              message:
                                  '${data.searchTraining[index].deadline!.place!}, ${data.searchTraining[index].deadline!.location!}',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    const DottedLine(
                      direction: Axis.vertical,
                      lineThickness: 2.0,
                      dashRadius: 6.0,
                      dashGapLength: 6.0,
                      lineLength: 170,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showText(
                              message: data.searchTraining[index].status!,
                              fontSize: 12.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w900),
                          const SizedBox(height: 2.0),
                          showText(
                              message:
                                  '${data.searchTraining[index].name!} (${data.searchTraining[index].ratings})',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900),
                          const SizedBox(height: 12.0),
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: data.searchTraining[index].image!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Icon(Icons.account_circle)),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              showText(
                                  message:
                                      data.searchTraining[index].speaker!.name!,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w800),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Enroll Now')),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  showFilterSheet({
    required BuildContext context,
    required TrainingListVM trainingListVM,
  }) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        builder: (builder) {
          return const FilterSheet();
        });
  }
}
