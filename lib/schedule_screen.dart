import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Schedule> schedules = [];
  List<Subject> subjects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final schData = await ApiService.getSchedules();
      final subData = await ApiService.getSubjects();
      setState(() {
        schedules = schData;
        subjects = subData;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _showScheduleDialog({Schedule? schedule}) {
    int? selectedSubjectId = schedule?.subjectId ?? (subjects.isNotEmpty ? subjects.first.subjectId : null);
    
    final dayCtrl = TextEditingController(text: schedule?.dayOfWeek ?? '');
    final startCtrl = TextEditingController(text: schedule?.startTime ?? '');
    final endCtrl = TextEditingController(text: schedule?.endTime ?? '');
    final roomCtrl = TextEditingController(text: schedule?.room ?? '');
    final capCtrl = TextEditingController(text: schedule?.slotCapacity.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(schedule == null ? 'Add Schedule' : 'Edit Schedule'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dropdown to prevent Subject FK errors
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Select Subject'),
                      value: selectedSubjectId,
                      items: subjects.map((s) => DropdownMenuItem<int>(
                        value: s.subjectId,
                        child: Text('${s.subjectCode} - ${s.subjectName}'),
                      )).toList(),
                      onChanged: (val) {
                        setDialogState(() {
                          selectedSubjectId = val;
                        });
                      },
                    ),
                    TextField(controller: dayCtrl, decoration: const InputDecoration(labelText: 'Day (e.g. Monday)')),
                    // Time Pickers to ensure correct 24H format
                    TextField(
                      controller: startCtrl, 
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Start Time (HH:MM:SS)'),
                      onTap: () async {
                        final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                        if (time != null) {
                          setDialogState(() {
                            startCtrl.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
                          });
                        }
                      },
                    ),
                    TextField(
                      controller: endCtrl, 
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'End Time (HH:MM:SS)'),
                      onTap: () async {
                        final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                        if (time != null) {
                          setDialogState(() {
                            endCtrl.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
                          });
                        }
                      },
                    ),
                    TextField(controller: roomCtrl, decoration: const InputDecoration(labelText: 'Room')),
                    TextField(controller: capCtrl, decoration: const InputDecoration(labelText: 'Slot Capacity'), keyboardType: TextInputType.number),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedSubjectId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a subject')));
                      return;
                    }
                    try {
                      if (schedule == null) {
                        await ApiService.createSchedule(selectedSubjectId!, dayCtrl.text, startCtrl.text, endCtrl.text, roomCtrl.text, int.parse(capCtrl.text));
                      } else {
                        await ApiService.updateSchedule(schedule.scheduleId, selectedSubjectId!, dayCtrl.text, startCtrl.text, endCtrl.text, roomCtrl.text, int.parse(capCtrl.text));
                      }
                      if (mounted) Navigator.pop(context);
                      loadData();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Schedule Management', style: TextStyle(color: Colors.white)),
        actions: [IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => _showScheduleDialog())],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final s = schedules[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text('Subject ID: ${s.subjectId}'),
              subtitle: Text('${s.dayOfWeek} | ${s.startTime} - ${s.endTime}\nRoom: ${s.room} | Slots: ${s.slotCapacity}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showScheduleDialog(schedule: s)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
                    await ApiService.deleteSchedule(s.scheduleId);
                    loadData();
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