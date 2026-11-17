import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({super.key});
  @override
  State<SubjectListScreen> createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  List<Subject> subjects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    try {
      final data = await ApiService.getSubjects();
      setState(() { subjects = data; isLoading = false; });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _showSubjectDialog({Subject? subject}) {
    final codeCtrl = TextEditingController(text: subject?.subjectCode ?? '');
    final nameCtrl = TextEditingController(text: subject?.subjectName ?? '');
    final unitsCtrl = TextEditingController(text: subject?.units.toString() ?? '');
    final descCtrl = TextEditingController(text: subject?.description ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(subject == null ? 'Add Subject' : 'Edit Subject'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'Subject Code')),
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Subject Name')),
            TextField(controller: unitsCtrl, decoration: const InputDecoration(labelText: 'Units'), keyboardType: TextInputType.number),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              try {
                if (subject == null) {
                  await ApiService.createSubject(codeCtrl.text, nameCtrl.text, int.parse(unitsCtrl.text), descCtrl.text);
                } else {
                  await ApiService.updateSubject(subject.subjectId, codeCtrl.text, nameCtrl.text, int.parse(unitsCtrl.text), descCtrl.text);
                }
                if (mounted) Navigator.pop(context);
                loadSubjects();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Subject Management', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => _showSubjectDialog())],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final s = subjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text('${s.subjectCode} - ${s.subjectName}'),
              subtitle: Text('Units: ${s.units}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showSubjectDialog(subject: s)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
                    await ApiService.deleteSubject(s.subjectId);
                    loadSubjects();
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}