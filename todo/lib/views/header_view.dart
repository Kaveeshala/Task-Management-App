import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view_models/app_view_model.dart';
import 'package:todo/views/bottom_sheets/delete_bottom_sheet_view.dart';
import 'package:todo/views/bottom_sheets/setting_bottom_sheet_view.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child){
      return Row(
        children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("Welcome Back", style: TextStyle(fontSize:23, fontWeight: FontWeight.w100, color: viewModel.clrLvl4 ),)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(viewModel.username, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: viewModel.clrLvl4),)),
                ),
              )
            ],
                    ),
          )),
          //Trash Icon
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              viewModel.bottomSheildBuilder(
                const DeleteBottomSheetView(), context);
            },
            child: Icon(Icons.delete, 
            color: viewModel.clrLvl3, size: 40,))
          ),
          //Setting Icon
          Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              viewModel.bottomSheildBuilder(const SettingBottomSheetView(), context);
            },
            child: Icon(Icons.settings, 
            color: viewModel.clrLvl3, size: 40,))
          ),

        
      ],);
    });
  }
}