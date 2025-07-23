import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeOfDay = _getTimeOfDayStatus(now.hour);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: timeOfDay['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeOfDay['emoji'],
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '我的状态',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF4A5568),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '今日状态：${timeOfDay['status']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('MM月dd日').format(now),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getTimeOfDayStatus(int hour) {
    if (hour >= 6 && hour < 9) {
      return {
        'emoji': '🌅',
        'status': '晨光初现',
        'color': const Color(0xFFFAB1A0),
      };
    } else if (hour >= 9 && hour < 12) {
      return {
        'emoji': '☀️',
        'status': '活力满满',
        'color': const Color(0xFFFDCB6E),
      };
    } else if (hour >= 12 && hour < 14) {
      return {
        'emoji': '🌞',
        'status': '午后时光',
        'color': const Color(0xFFE17055),
      };
    } else if (hour >= 14 && hour < 18) {
      return {
        'emoji': '🌤️',
        'status': '专注工作',
        'color': const Color(0xFF74B9FF),
      };
    } else if (hour >= 18 && hour < 21) {
      return {
        'emoji': '🌆',
        'status': '黄昏思考',
        'color': const Color(0xFFA29BFE),
      };
    } else if (hour >= 21 && hour < 24) {
      return {
        'emoji': '🌙',
        'status': '夜晚沉思',
        'color': const Color(0xFF6C5CE7),
      };
    } else {
      return {
        'emoji': '🌌',
        'status': '深夜探索',
        'color': const Color(0xFF2D3436),
      };
    }
  }
}