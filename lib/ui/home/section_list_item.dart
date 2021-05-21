import 'package:flutter/material.dart';
import 'package:iris/model/index.dart';

// Section列表展示子元素
class SectionListItem extends StatelessWidget {
  // section 内容
  final Section section;
  // 点击方法
  final Function(Section) onTapped;
  SectionListItem({Key key, this.section, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => onTapped(section),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              // 整体采用默认图片
                              image: Image.asset("imgs/section-default").image,
                              alignment: Alignment.center),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(section.name)],
                    )
                  ]),
                  Spacer(),
                  Icon(Icons.navigate_next),
                  SizedBox(width: 8)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
