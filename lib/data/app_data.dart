import 'package:flutter/material.dart';

/// Static mock content for the clickable prototype (styles, plans, quotes,
/// segments). Real data / AI wiring replaces this later.
class AppData {
  AppData._();

  /// Curated style "vibes" — evocative, magazine-style names.
  static const List<String> styles = [
    'Soft Mediterranean',
    'Walnut Cocoon',
    'Midnight Deco Warmth',
    'Collected Mid-Century',
    'Luxe Minimalism',
    'Modern Farmhouse',
    'Terracotta Adobe',
    'Elegant Oxblood',
    'Velvet Emerald',
    'Coastal Linen',
    'Japandi Calm',
    'Moody Navy Luxe',
  ];

  static const List<RoomType> roomTypes = [
    RoomType('Living room', Icons.weekend_outlined),
    RoomType('Bedroom', Icons.bed_outlined),
    RoomType('Kitchen', Icons.countertops_outlined),
    RoomType('Dining', Icons.dining_outlined),
    RoomType('Bathroom', Icons.bathtub_outlined),
    RoomType('Office', Icons.chair_alt_outlined),
    RoomType('Outdoor', Icons.deck_outlined),
    RoomType('Kids', Icons.toys_outlined),
  ];

  /// Real user complaints about competitor apps (used on the "problem" screen).
  static const List<String> problemQuotes = [
    'It looks nothing like my actual room.',
    'Every style comes out looking exactly the same.',
    'Eight taps just to make one small change.',
    'It looks like a stock photo, not my home.',
  ];

  static const List<Segment> segments = [
    Segment(
      'Homeowner planning a redesign',
      'See your rooms in a whole new light before you spend a rupee.',
      Icons.home_outlined,
    ),
    Segment(
      'Renter refreshing a space',
      'Reimagine your place with changes you can actually make.',
      Icons.chair_outlined,
    ),
    Segment(
      'Interior designer',
      'Pitch concepts to clients in seconds, not days.',
      Icons.architecture_outlined,
    ),
    Segment(
      'Real-estate staging',
      'Stage empty listings to sell faster.',
      Icons.real_estate_agent_outlined,
    ),
  ];

  static const List<PlanOption> plans = [
    PlanOption(
      id: 'yearly',
      title: 'Yearly',
      priceLine: '₹3,499 / year',
      perLine: 'about ₹67 / week',
      badge: 'Best value · save 62%',
      highlighted: true,
    ),
    PlanOption(
      id: 'weekly',
      title: 'Weekly',
      priceLine: '₹179 / week',
      perLine: 'billed weekly, cancel anytime',
      badge: null,
      highlighted: false,
    ),
  ];

  static const List<String> proFeatures = [
    'Unlimited room-faithful renders',
    'Every curated style & vibe',
    'Watermark-free, full-resolution exports',
    'Keep-what-I-own redesign mode',
    'Priority generation speed',
  ];
}

class RoomType {
  const RoomType(this.label, this.icon);
  final String label;
  final IconData icon;
}

class Segment {
  const Segment(this.title, this.subtitle, this.icon);
  final String title;
  final String subtitle;
  final IconData icon;
}

class PlanOption {
  const PlanOption({
    required this.id,
    required this.title,
    required this.priceLine,
    required this.perLine,
    required this.badge,
    required this.highlighted,
  });
  final String id;
  final String title;
  final String priceLine;
  final String perLine;
  final String? badge;
  final bool highlighted;
}
