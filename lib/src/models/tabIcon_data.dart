import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/Kubernetes-Logo.png',
      selectedImagePath: 'assets/images/Kubernetes-Logo.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/murakube/node.png',
      selectedImagePath: 'assets/murakube/node_selected.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/murakube/deploy.png',
      selectedImagePath: 'assets/murakube/deploy_selected.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/murakube/sts.png',
      selectedImagePath: 'assets/murakube/sts_selected.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/murakube/pod.png',
      selectedImagePath: 'assets/murakube/pod_selected.png',
      index: 4,
      isSelected: false,
      animationController: null,
    ),
  ];
}
