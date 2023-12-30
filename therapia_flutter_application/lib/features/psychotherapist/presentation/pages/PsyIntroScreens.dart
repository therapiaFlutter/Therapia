import 'package:flutter/material.dart';
import 'package:therapia_flutter_application/Pages/Testpsy.dart';
import 'package:therapia_flutter_application/core/widgets/OnboardingPageModel.dart';
import 'package:therapia_flutter_application/core/widgets/NavigateAnimation.dart';
import 'package:therapia_flutter_application/Pages/welcome_page.dart';
import 'package:therapia_flutter_application/features/psychotherapist/presentation/widgets/PsyBottomnavbar.dart';


class PsyIntroScreens extends StatelessWidget {
  const PsyIntroScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Join a Caring Communit',
          description:
              "Join a community of caring professionals. Share experiences, collaborate, and learn together. Together, we create a network of healing.",
          image: Image.asset("lib/core/assets/images/Group therapy-bro.png"),
        ),
        OnboardingPageModel(
          title: 'Your Expertise Matters',
          description:
              "Share your wisdom through educational posts. Help students navigate life's challenges with your valuable insights.",
          image: Image.asset("lib/core/assets/images/Online document-bro.png"),
        ),
        OnboardingPageModel(
          title: 'Easy Scheduling',
          description:
              "Simplify your schedule. View, manage, and organize appointments effortlessly. Be there for your students when they need you.",
          image: Image.asset("lib/core/assets/images/Online calendar-amico.png"),
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {Key? key, required this.pages, this.onSkip, this.onFinish})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          gradient: widget.pages[_currentPage].bgColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(27.0),
                            child: item.image,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  item.title,
                                  style: item.titleStyle,
                                ),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 8.0),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: item.descriptionStyle,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map(
                      (item) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width:
                            _currentPage == widget.pages.indexOf(item) ? 30 : 8,
                        height: 8,
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5D5AE0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: const Color(0xFF272665),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(psyNavBar()));
                        }
                      },
                      child: const Text("Skip"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: const Color(0xFF272665),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          Navigator.of(context).push(
                              NavigateAnimation.customPageRoute(psyNavBar()));
                        } else {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Start"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == widget.pages.length - 1
                                ? Icons.arrow_forward
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
