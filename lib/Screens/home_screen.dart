import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:towfactor_ios/Controllers/backup_code_controller.dart';
import 'package:towfactor_ios/Controllers/token_controller.dart';
import 'package:towfactor_ios/Models/Error_response.dart';
import 'package:towfactor_ios/Models/data_model.dart';
import 'package:towfactor_ios/Screens/LoginScreen.dart';
import 'package:towfactor_ios/Screens/no_internet.dart';
import 'package:towfactor_ios/Service/Service.dart';
import 'package:towfactor_ios/Utilities/Storage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../Utilities/Utilities.dart';
import '../Widgets/expandable_floating_button.dart';
import '../main.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  String selectedValue = 'Select';
  Timer? _timer;
  int _start = 0;
  String token = '- - - - ';
  String? sessionToken;
  String? deviceId = 'device_id';
  bool isLoading = true;
  bool shimmerEnabled = true;
  DropListModel dropListModel = new DropListModel([]);
  OptionItem optionItemSelected = OptionItem(title: "Select User");

  @override
  void initState() {
    _initializeVariables();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backUpCodeProvider = Provider.of<BackupCodeController>(context);
    return Scaffold(
          body: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              children: [
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: PopupMenuButton(
                      surfaceTintColor: Colors.transparent,
                      color: Colors.white,
                      icon: Icon(Icons.more_horiz, color: Colors.blue),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: Text('Logout'),
                          value: 'logout',
                        ),
                      ],
                      onSelected: (value) async {
                        if (value == 'logout') {
                          bool result = await Storage().clearStorage();
                          if (result) {
                            Get.offAll(LoginScreen());
                          } else {
                            Utilities.showSnackbar(
                                'Alert', 'Failed to clear data');
                          }
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Center(
                            child: Image(
                              image: new AssetImage(
                                  'assets/images/round_logo_frame.jpg'),
                              width: MediaQuery.of(context).size.width /
                                  1.5, // Set the desired width
                              height: MediaQuery.of(context).size.width /
                                  1.5, // Set the desired height
                            ),
                          ),
                          Center(
                            child: Image(
                              image: new AssetImage(
                                  'assets/images/updated_logo.png'),
                              width: MediaQuery.of(context).size.width / 5.5,
                              height: MediaQuery.of(context).size.width / 5.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<TokenController>(builder: (context,provider,child){
              return Column(
                children: [
                  isLoading ? buildEffect(context,provider) : dropDown(provider, context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                width: 130,
                                child: SfRadialGauge(
                                  axes: [
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 60,
                                      showLabels: false,
                                      showTicks: false,
                                      startAngle: 270,
                                      endAngle: 270,
                                      axisLineStyle: AxisLineStyle(
                                        thickness: 0.05,
                                        color: Colors.white,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          value: _start.toDouble(),
                                          width: 0.95,
                                          pointerOffset: 0.05,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          color: Colors.red,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                  child: provider.isLoading
                                      ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Colors.grey[300],
                                      ))
                                      : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'HMIS',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        optionItemSelected.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        provider.userToken,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        )),
                  ),
                ],
              );
            },),
        
          ],
        )
    ),

    floatingActionButton: ExpandableFloatingButton(
      distance: 50.0,
      children: [
        ActionButton(
          onPressed: () {
            print('ABC');
            backUpCodeProvider.getBackupCodes("ntest", sessionToken!, deviceId!);
          } ,
          icon: const Icon(Icons.security_rounded,color: Colors.blue,),
        ),
      ],
    )
  );
  }

  Widget buildEffect(BuildContext context,TokenController provider) {
    return Shimmer.fromColors(
        enabled: shimmerEnabled,
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: dropDown(provider, context));
  }

  Widget dropDown(TokenController tokenController, BuildContext context) {
    return SelectDropList(
      itemSelected: optionItemSelected,
      dropListModel: dropListModel,
      showIcon: true,
      showArrowIcon: true,
      showBorder: true,
      paddingTop: 0,
      textColorTitle: Colors.white,
      arrowIconSize: 30,
      arrowColor: Colors.white,
      heightBottomContainer: 120,
      containerDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
        border: Border.all(
          color: Colors.blue,
          width: 1.0,
        ),
      ),
      icon: const Icon(Icons.verified_user_sharp, color: Colors.white),
      onOptionSelected: (optionItem) async {
        optionItemSelected = optionItem;

        await tokenController.getUserToken(optionItemSelected.title, sessionToken!, deviceId!);
          if(tokenController.requestStatus){
           await startTimer(tokenController);
            setState(() {});
          }
        setState(() {
          _start = 0;
        });


      },
    );
  }

  Future<void> _initializeVariables() async {
    String? device = await Utilities.getDeviceID();
    String? token = await Storage().getToken();
    setState(() {
      deviceId = device;
      sessionToken = token;
    });
    fetchData();
  }

  Future<void> startTimer(TokenController controller) async{
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start > 60) {
                controller.resetUserToken();
                timer.cancel();
              } else {
                _start = _start + 1;
              }
            }));
  }

  Future<void> fetchData() async {
    setState(() {
      shimmerEnabled = true; // Enable shimmer effect while fetching data
    });

    // Fetch data from the API
    await Service().fetchData(deviceId!, 'cxvacxvcwajkcjacababajcba').then((resp) {
      if (resp is DataModel) {
        List<ListElement> data = resp.list;
        List<OptionItem> optionItems = [];
        for (var item in data) {
          OptionItem optionItem = OptionItem(id: item.userId, title: item.userId);
          optionItems.add(optionItem);
        }
        dropListModel = DropListModel(optionItems);
      } else if (resp is ErrorResponse) {
        Utilities.showSnackbar('Error', resp.message.toString());
      } else {
        Utilities.showSnackbar('400', 'Request Failed');
      }
    }).catchError((error, stackTrace) {
      Utilities.showSnackbar('Exception', error.toString());
    }).whenComplete(() {
      // Disable shimmer effect after data is fetched (whether successful or not)
      setState(() {
        shimmerEnabled = false;
        isLoading = false;
      });
    });
  }

  Future<void> onRefresh() async {
      print(deviceId);
      print(sessionToken);
    if (_timer == null || !_timer!.isActive) {
      // Check if the previous timer is over or not
      try {
        // Fetch data from the API
        fetchData();

        // If fetching data is successful, reset the timer and UI
        setState(() {
          _start = 0;
        });
      } catch (error) {
        // Handle error (show snackbar, etc.)
        Utilities.showSnackbar('Error', error.toString());
      }
    } else {
      // Notify the user that they need to wait until the previous refresh is complete
      Utilities.showSnackbar('Wait', 'Refresh only if the Token is expired');
    }
  }
}
