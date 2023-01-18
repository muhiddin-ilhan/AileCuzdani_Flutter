import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/view/family_selection/family_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/components/custom_appBar.dart';
import '../../core/components/custom_material_button.dart';
import '../../core/components/custom_textbox.dart';
import '../../core/components/error_page_widget.dart';
import '../../core/components/family_card.dart';
import '../../core/components/popups/family_create_popup.dart';
import '../../core/components/popups/message_popup.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/navigate_utils.dart';
import '../../core/utils/sizer_utils.dart';

class FamilySelectionView extends StatefulWidget {
  const FamilySelectionView({super.key});

  @override
  State<FamilySelectionView> createState() => _FamilySelectionViewState();
}

class _FamilySelectionViewState extends State<FamilySelectionView> {
  FamilySelectionViewModel viewModel = FamilySelectionViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getAllFamilies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FamilySelectionViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          if (!LoadingUtils.instance.isLoadingActive()) {
            NavigateUtils.logout(context);
          }
          return false;
        },
        child: Scaffold(
          appBar: appBar(context),
          backgroundColor: CustomColors.OFF_WHITE,
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Observer(
              builder: (_) {
                if (viewModel.isError) {
                  return errorPageWidget(
                    context,
                    onReloadTap: () {
                      viewModel.getAllFamilies(context);
                    },
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar(),
                    if (viewModel.currentUser != null)
                      if (viewModel.currentUser!.family != null) ...myFamilyCard(),
                    if (viewModel.familyRequest.isNotEmpty && viewModel.familyRequestFamily.isNotEmpty) ...myFamilyRequest(),
                    ...allFamiliesSection(),
                    const SizedBox(height: 16),
                    SafeArea(
                      child: customMaterialButton(
                        context: context,
                        onTap: () {
                          showFamilyCreatePopup(
                            context,
                            onAcceptTap: () async {
                              await viewModel.createFamily(context);
                            },
                            controller: viewModel.familyNameController,
                          );
                        },
                        isLoading: viewModel.loading,
                        enableLoadingAnim: false,
                        enabled: viewModel.currentUser != null ? viewModel.currentUser!.family_id == null : true,
                        text: "Aile Oluştur",
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(context,
        title: "Aile Seçimi",
        leading: IconButton(
          onPressed: () {
            NavigateUtils.logout(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.getAllFamilies(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ]);
  }

  List<Widget> allFamiliesSection() {
    return [
      const SizedBox(height: 16),
      Observer(builder: (_) {
        if (viewModel.searchedFamilies.isNotEmpty) {
          return const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 3),
            child: Text(
              "Tüm Aileler",
              style: TextStyle(fontFamily: "JosefinSans", color: CustomColors.DARK_GREY),
            ),
          );
        }
        return const SizedBox();
      }),
      Observer(builder: (_) {
        return Expanded(
          child: ListView.separated(
            itemCount: viewModel.searchedFamilies.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (ctx, index) => SizedBox(
                height: viewModel.searchedFamilies[index].id == viewModel.currentUser!.family_id
                    ? 0
                    : viewModel.familyRequest.where((e) => e.family_id == viewModel.searchedFamilies[index].id).isEmpty
                        ? 8
                        : 0),
            itemBuilder: (ctx, index) => viewModel.searchedFamilies[index].id == viewModel.currentUser!.family_id
                ? const SizedBox()
                : viewModel.familyRequest.where((e) => e.family_id == viewModel.searchedFamilies[index].id).isEmpty
                    ? familyCard(
                        viewModel.searchedFamilies[index],
                        onClick: () {
                          if (viewModel.currentUser != null) {
                            if (viewModel.currentUser!.family != null) {
                              showMessagePopup(
                                context,
                                title: "Uyarı",
                                message: "Aile Üyesi Olduğunuz İçin Başka Ailelere Başvuru Yapamazsınız",
                              );
                            } else {
                              showMessagePopup(
                                context,
                                title: "Aileye Katıl",
                                message: "Aileye Katılım İsteği Göndermek İstediğinize Emin misiniz?",
                                onAccessTitle: "Katıl",
                                onRejectTitle: "İptal",
                                onAcceptTap: () {
                                  viewModel.sendFamilyRequest(context, family: viewModel.searchedFamilies[index]);
                                },
                                onRejectTap: () {},
                              );
                            }
                          }
                        },
                      )
                    : const SizedBox(),
          ),
        );
      }),
    ];
  }

  List<Widget> myFamilyCard() {
    return [
      const SizedBox(height: 16),
      const Padding(
        padding: EdgeInsets.only(left: 4, bottom: 3),
        child: Text(
          "Dahil Olduğum Aile",
          style: TextStyle(fontFamily: "JosefinSans", color: CustomColors.DARK_GREY),
        ),
      ),
      Observer(builder: (_) {
        return familyCard(
          viewModel.currentUser!.family!,
          isMineFamily: true,
          onClick: () {
            showMessagePopup(
              context,
              title: "Aileyi Terket",
              message: "Üyesi Olduğunuz Aileden Çıkmak İstediğize Emin misiniz?",
              onAccessTitle: "Evet",
              onRejectTitle: "İptal",
              onAcceptTap: () {
                viewModel.leaveFamily(context, family: viewModel.currentUser!.family!);
              },
              onRejectTap: () {},
            );
          },
        );
      }),
    ];
  }

  List<Widget> myFamilyRequest() {
    return [
      const SizedBox(height: 16),
      const Padding(
        padding: EdgeInsets.only(left: 4, bottom: 3),
        child: Text(
          "Aile Başvurularım",
          style: TextStyle(fontFamily: "JosefinSans", color: CustomColors.DARK_GREY),
        ),
      ),
      Observer(builder: (_) {
        return familyCard(
          viewModel.familyRequestFamily[0],
          isBasvuru: true,
          onClick: () {
            showMessagePopup(
              context,
              title: "Başvuru İptali",
              message: "Aileye Katılım Başvurusunu İptal Etmek İstediğinize Emin misiniz?",
              onAccessTitle: "İptal Et",
              onRejectTitle: "Hayır",
              onAcceptTap: () {
                viewModel.cancelFamilyRequest(context, family: viewModel.familyRequestFamily[0]);
              },
              onRejectTap: () {},
            );
          },
        );
      }),
    ];
  }

  Widget searchBar() {
    return Observer(builder: (_) {
      return Row(
        children: [
          Expanded(
            child: customTextbox(
              context,
              borderRadius: 12,
              elevation: 2,
              prefixIcon: const Icon(Icons.search),
              autoCorrect: false,
              controller: viewModel.searchController,
              hintText: "Ara...",
              textInputAction: TextInputAction.done,
              fontSize: 15,
              height: Sizer.getHeight(context) * 0.05,
              onChanged: (text) {
                viewModel.searchFamily(text);
              },
            ),
          ),
          const SizedBox(width: 6),
          customMaterialButton(
            context: context,
            onTap: () {},
            isLoading: viewModel.loading,
            enableLoadingAnim: false,
            child: const Icon(Icons.search, color: CustomColors.WHITE),
          ),
        ],
      );
    });
  }
}
