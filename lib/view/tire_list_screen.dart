import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prolog/custom/app_colors.dart';
import 'package:prolog/model/tire.dart';
import 'package:prolog/services/api_service.dart';
import 'package:prolog/view/tire_info.dart';

class TireListScreen extends StatefulWidget {
  const TireListScreen({super.key});

  @override
  _TireListScreenState createState() => _TireListScreenState();
}

class _TireListScreenState extends State<TireListScreen> {
  final ApiService apiService = ApiService();
  List<Tire> tires = [];
  int pageNumber = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchTires();
  }

  Future<void> fetchTires() async {
    if (isLoading || !hasMoreData) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newTires = await apiService.getRequest<Tire>(
          endpoint:
              'tires?branchOfficesId=215&pageSize=20&pageNumber=$pageNumber',
          fromJson: Tire.fromJson,
          rootKey: 'content');

      setState(() {
        pageNumber++;
        isLoading = false;
        if (newTires.isEmpty) {
          hasMoreData = false;
        }
        tires.addAll(newTires);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().darkBlue,
        title: const Text(
          'Tires List',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              hasMoreData) {
            fetchTires();
          }
          return false;
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: tires.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == tires.length) {
              return Center(
                  child:
                      CircularProgressIndicator(color: AppColors().darkBlue));
            }

            final tire = tires[index];
            final formattedDate =
                DateFormat('dd/MM/yyyy').format(tire.createdAt!);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TireInfoScreen(
                          apiService: apiService, tireId: tire.id),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 12,
                        offset: Offset(-3, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Hero(
                      tag: 'serialNumber_${tire.serialNumber}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(tire.serialNumber ?? '',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'make_${tire.serialNumber}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Marca: ${tire.make?.name}, Modelo: ${tire.model?.name}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'pressure_${tire.serialNumber}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Pressão Atual: ${tire.currentPressure} psi, Recomendada: ${tire.recommendedPressure} psi',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        if (tire.middleInnerTreadDepth != null)
                          Hero(
                            tag: 'treadDepth_${tire.serialNumber}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                'Profundidade do Sulco: ${tire.middleInnerTreadDepth.toStringAsFixed(2)} mm',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        Hero(
                          tag: 'status_${tire.serialNumber}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Status: ${tire.status}',
                              style: TextStyle(
                                color: tire.status == 'INSTALLED'
                                    ? AppColors().normalBlue
                                    : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Hero(
                      tag: 'date_${tire.serialNumber}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
