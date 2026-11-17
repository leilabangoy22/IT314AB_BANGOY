import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});
  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  List<Grade> grades = [];
  List<Map<String, dynamic>> students = [];
  List<Subject> subjects = []; 
  bool isLoading = true;
  
  int? filterStudentId;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final gradeData = await ApiService.getGrades();
      final studentData = await ApiService.getStudents();
      final subjectData = await ApiService.getSubjects();
      setState(() {
        grades = gradeData;
        students = studentData;
        subjects = subjectData;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _showGradeDialog({Grade? grade}) {
    int? selectedStudentId = grade?.studentId ?? (students.isNotEmpty ? students.first['dbId'] as int : null);
    String selectedSubjectName = grade?.subject ?? '';
    List<Subject> studentEnrolledSubjects = [];
    bool isLoadingSubjects = true;

    final scoreCtrl = TextEditingController(text: grade?.score.toString() ?? '');
    final remarksCtrl = TextEditingController(text: grade?.remarks ?? '');

    // Helper to fetch only enrolled subjects for the selected student
    Future<void> fetchEnrolledSubjects(int studentId) async {
      try {
        final enrollments = await ApiService.getStudentEnrollments(studentId);
        final allSubjects = await ApiService.getSubjects();
        
        final enrolledSubjectIds = enrollments
            .where((e) => e.status == 'Enrolled')
            .map((e) => e.subjectId)
            .toSet();
            
        final filteredSubjects = allSubjects
            .where((s) => enrolledSubjectIds.contains(s.subjectId))
            .toList();
            
        if (mounted) {
          setState(() {
            studentEnrolledSubjects = filteredSubjects;
            isLoadingSubjects = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => isLoadingSubjects = false);
      }
    }

    if (selectedStudentId != null) {
      fetchEnrolledSubjects(selectedStudentId);
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(grade == null ? 'Add Grade' : 'Edit Grade'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: 'Select Student'),
                      value: selectedStudentId,
                      items: students.map((s) => DropdownMenuItem<int>(
                        value: s['dbId'] as int,
                        child: Text('${s['name']} (ID: ${s['dbId']})', overflow: TextOverflow.ellipsis),
                      )).toList(),
                      onChanged: (val) {
                        setDialogState(() { 
                          selectedStudentId = val;
                          selectedSubjectName = '';
                          isLoadingSubjects = true;
                          studentEnrolledSubjects = []; 
                        });
                        if (val != null) {
                          fetchEnrolledSubjects(val).then((_) {
                            setDialogState(() {}); 
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    // Subject dropdown only shows enrolled subjects
                    isLoadingSubjects 
                      ? const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator())
                      : DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: const InputDecoration(labelText: 'Subject (Enrolled Only)'),
                          value: studentEnrolledSubjects.any((s) => s.subjectName == selectedSubjectName) ? selectedSubjectName : null,
                          items: studentEnrolledSubjects.map((s) => DropdownMenuItem<String>(
                            value: s.subjectName,
                            child: Text(s.subjectName, overflow: TextOverflow.ellipsis),
                          )).toList(),
                          onChanged: (val) {
                            setDialogState(() { selectedSubjectName = val!; });
                          },
                        ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: scoreCtrl, 
                      decoration: const InputDecoration(
                        labelText: 'Score (1.00 - 5.00)',
                        helperText: '1.00 is Highest, 5.00 is Lowest',
                      ), 
                      keyboardType: const TextInputType.numberWithOptions(decimal: true)
                    ),
                    TextField(controller: remarksCtrl, decoration: const InputDecoration(labelText: 'Remarks')),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedStudentId == null || selectedSubjectName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select student and subject')));
                      return;
                    }

                    final parsedScore = double.tryParse(scoreCtrl.text);
                    if (parsedScore == null || parsedScore < 1.0 || parsedScore > 5.0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Grade must be between 1.00 and 5.00')));
                      return;
                    }

                    try {
                      if (grade == null) {
                        await ApiService.addGrade(selectedStudentId!, selectedSubjectName, parsedScore, remarksCtrl.text);
                      } else {
                        await ApiService.updateGrade(grade.gradeId, selectedStudentId!, selectedSubjectName, parsedScore, remarksCtrl.text);
                      }
                      if (mounted) Navigator.pop(context);
                      loadData();
                    } catch (e) {
                      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Grade> displayedGrades = filterStudentId == null 
        ? grades 
        : grades.where((g) => g.studentId == filterStudentId).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Grades Management', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => _showGradeDialog())],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'View Grades Per Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              value: filterStudentId,
              items: [
                const DropdownMenuItem(value: null, child: Text('Show All Students')),
                ...students.map((s) => DropdownMenuItem<int>(
                  value: s['dbId'] as int, 
                  child: Text(s['name'] ?? 'Unknown', overflow: TextOverflow.ellipsis)
                ))
              ],
              onChanged: (val) {
                setState(() { filterStudentId = val; });
              },
            ),
          ),
          
          Expanded(
            child: displayedGrades.isEmpty 
              ? const Center(child: Text('No grades found.'))
              : ListView.builder(
                  itemCount: displayedGrades.length,
                  itemBuilder: (context, index) {
                    final g = displayedGrades[index];
                    final studentName = students.firstWhere(
                      (s) => s['dbId'] == g.studentId, 
                      orElse: () => {'name': 'Unknown Student'}
                    )['name'];

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text('$studentName | ${g.subject}'),
                        subtitle: Text('Score: ${g.score} | ${g.remarks}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showGradeDialog(grade: g)),
                            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
                              await ApiService.deleteGrade(g.gradeId);
                              loadData();
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}