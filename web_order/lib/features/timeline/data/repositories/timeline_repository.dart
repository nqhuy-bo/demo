import '../models/timeline_node.dart';

class TimelineRepository {
  const TimelineRepository();

  List<TimelineNode> fetchTimelineNodes() => const [
        TimelineNode(
          year: 2016,
          title: 'Khởi đầu',
          description: 'Ra mắt phiên bản beta và thu hút những người dùng đầu tiên.',
          image: 'https://images.unsplash.com/photo-1471879832106-c7ab9e0cee23?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2018,
          title: 'Mở rộng',
          description: 'Mở rộng đội ngũ lên 50 người và ra mắt sản phẩm tại Đông Nam Á.',
          image: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2020,
          title: 'Bứt phá',
          description: 'Đạt 1 triệu người dùng và nhận đầu tư Series B từ đối tác chiến lược.',
          image: 'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2023,
          title: 'Toàn cầu',
          description: 'Mở văn phòng tại châu Âu và Bắc Mỹ, sản phẩm đạt 10 triệu người dùng.',
          image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2024,
          title: 'Bền vững',
          description: 'Mang lại giá trị bền vững.',
          image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2025,
          title: 'Khát vọng',
          description: 'Vương xa hơn.',
          image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?auto=format&fit=crop&w=1600&q=80',
        ),
        TimelineNode(
          year: 2026,
          title: 'Thành công',
          description: 'Mang lại giá trị tích cực.',
          image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?auto=format&fit=crop&w=1600&q=80',
        ),
      ];
}
