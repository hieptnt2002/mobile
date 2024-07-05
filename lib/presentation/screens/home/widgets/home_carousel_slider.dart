import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final _carouselImages = [
    'https://clinic.dmm.com/img/pc/top/pic_topCarousel_aga-male@2x.jpg?id=830d1b7b2862cafceda6',
    'https://clinic.dmm.com/img/pc/top/pic_topCarousel_jcb_card@2x.jpg?id=feb2ba07ef690116c89a',
    'https://image.dmm-corp.com/c0yc4kihyhgi2dx2krl2tsmzfgmw',
    'https://clinic.dmm.com/img/pc/top/pic_topCarousel_medical-diet@2x.jpg?id=6caef13c3e0b35bad69c',
  ];
  var _activeIndex = 0;
  final _carouselController = CarouselController();

  void jumpToNextSlide() => _carouselController.nextPage();
  void jumpToPreviousSlide() => _carouselController.previousPage();
  void jumpToSlide(int index) => _carouselController.jumpToPage(index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarousel(),
        const SizedBox(height: 12),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              onPageChanged: (index, reason) {
                setState(() {
                  _activeIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return _buildImage(_carouselImages[index]);
            },
            itemCount: _carouselImages.length,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: jumpToPreviousSlide,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: jumpToNextSlide,
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _activeIndex,
      count: _carouselImages.length,
      effect: const JumpingDotEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: AppColors.textColor,
        dotColor: Colors.white,
      ),
      onDotClicked: (index) {
        jumpToSlide(index);
      },
    );
  }
}
