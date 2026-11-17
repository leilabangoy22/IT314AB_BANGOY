// lib/models.dart

class Subject {
  final int subjectId;
  final String subjectCode;
  final String subjectName;
  final int units;
  final String description;

  Subject({required this.subjectId, required this.subjectCode, required this.subjectName, required this.units, required this.description});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subject_id'],
      subjectCode: json['subject_code'] ?? '',
      subjectName: json['subject_name'] ?? '',
      units: int.tryParse(json['units']?.toString() ?? '0') ?? 0,
      description: json['description'] ?? '',
    );
  }
}

class Schedule {
  final int scheduleId;
  final int subjectId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String room;
  final int slotCapacity;

  Schedule({required this.scheduleId, required this.subjectId, required this.dayOfWeek, required this.startTime, required this.endTime, required this.room, required this.slotCapacity});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['schedule_id'],
      subjectId: json['subject_id'],
      dayOfWeek: json['day_of_week'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      room: json['room'] ?? '',
      slotCapacity: int.tryParse(json['slot_capacity']?.toString() ?? '0') ?? 0,
    );
  }
}

class Enrollment {
  final int enrollmentId;
  final int studentId;
  final int subjectId;
  final int scheduleId;
  final String status; 

  Enrollment({required this.enrollmentId, required this.studentId, required this.subjectId, required this.scheduleId, required this.status});

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      enrollmentId: json['enrollment_id'],
      studentId: json['student_id'],
      subjectId: json['subject_id'],
      scheduleId: json['schedule_id'],
      status: json['status'] ?? 'Enrolled',
    );
  }
}

class Grade {
  final int gradeId;
  final int studentId;
  final String subject;
  final double score;
  final String remarks;

  Grade({required this.gradeId, required this.studentId, required this.subject, required this.score, required this.remarks});

  factory Grade.fromJson(Map<String, dynamic> json) {
    // FIX: Safely parse the score whether it comes as a String or a num
    final rawScore = json['score'];
    double parsedScore = 0.0;
    if (rawScore != null) {
      if (rawScore is num) {
        parsedScore = rawScore.toDouble();
      } else {
        parsedScore = double.tryParse(rawScore.toString()) ?? 0.0;
      }
    }

    return Grade(
      gradeId: json['grade_id'],
      studentId: json['student_id'],
      subject: json['subject'] ?? '',
      score: parsedScore,
      remarks: json['remarks'] ?? '',
    );
  }
}