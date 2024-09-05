import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prolog/model/tire.dart';
import 'package:prolog/custom/app_colors.dart';
import 'package:prolog/services/api_service.dart';

class TireInfoScreen extends StatefulWidget {
  final ApiService apiService;
  final int tireId;

  const TireInfoScreen(
      {super.key, required this.apiService, required this.tireId});

  @override
  _TireInfoScreenState createState() => _TireInfoScreenState();
}

class _TireInfoScreenState extends State<TireInfoScreen> {
  int _currentImageIndex = 0;
  late Future<List<Tire>> _tireFuture;

  @override
  void initState() {
    super.initState();
    _tireFuture = fetchTire();
  }

  Future<List<Tire>> fetchTire() async {
    return await widget.apiService.getRequest<Tire>(
      endpoint: 'tires/${widget.tireId.toString()}',
      fromJson: Tire.fromJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.subdirectory_arrow_left_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors().darkBlue,
        title: const Text(
          'Tire Info',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Tire>>(
        future: _tireFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma informação encontrada.'));
          }

          final tire = snapshot.data![0];
          final formattedDate =
              DateFormat('dd/MM/yyyy').format(tire.createdAt!);
          List<String> imageUrls = tire.disposal?.disposalImagesUrl ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  if (imageUrls.isNotEmpty)
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CarouselSlider.builder(
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                imageUrls[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 250,
                              );
                            },
                            options: CarouselOptions(
                              height: 250,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageUrls.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                _currentImageIndex = entry.key;
                              }),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentImageIndex == entry.key
                                      ? AppColors().normalBlue
                                      : Colors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/no-image.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          _buildInfoText('Número de Série:', tire.serialNumber),
                          _buildInfoText(
                              'Grupo da Empresa:', tire.companyGroupName),
                          _buildInfoText('Filial:', tire.branchOfficeName),
                          _buildInfoText('Vezes Recapado:',
                              tire.timesRetreaded.toString()),
                          _buildInfoText('Máximo Recapagens:',
                              tire.maxRetreadsExpected.toString()),
                          _buildInfoText('Pressão Recomendada:',
                              '${tire.recommendedPressure} psi'),
                          _buildInfoText(
                              'Pressão Atual:', '${tire.currentPressure} psi'),
                          _buildInfoText(
                              'Custo da Compra:', 'R\$${tire.purchaseCost}'),
                          _buildInfoText(
                              'Novo Pneu:', tire.newTire! ? 'Sim' : 'Não'),
                          _buildInfoText('Status:', tire.status),
                          _buildInfoText('Tamanho do Pneu:',
                              '${tire.tireSize?.height} x ${tire.tireSize?.width} x ${tire.tireSize?.rim}'),
                          _buildInfoText('Marca:', tire.make?.name),
                          _buildInfoText('Modelo:', tire.model?.name),
                          _buildInfoText('Data de Criação:', formattedDate),

                          const SizedBox(height: 16),
                          if (tire.middleInnerTreadDepth != null)
                            _buildInfoText(
                                'Profundidade do Sulco Central Interno:',
                                '${tire.middleInnerTreadDepth.toStringAsFixed(2)} mm'),
                          if (tire.outerTreadDepth != null)
                            _buildInfoText('Profundidade do Sulco Externo:',
                                '${tire.outerTreadDepth.toStringAsFixed(2)} mm'),
                          if (tire.middleOuterTreadDepth != null)
                            _buildInfoText(
                                'Profundidade do Sulco Central Externo:',
                                '${tire.middleOuterTreadDepth.toStringAsFixed(2)} mm'),
                          if (tire.innerTreadDepth != null)
                            _buildInfoText('Profundidade do Sulco Interno:',
                                '${tire.innerTreadDepth.toStringAsFixed(2)} mm'),

                          const SizedBox(height: 16),
                          if (tire.installed != null) ...[
                            _buildInfoText('Instalação:', ''),
                            _buildInfoText('Veículo ID:',
                                tire.installed!.vehicleId.toString()),
                            _buildInfoText('Placa do Veículo:',
                                tire.installed!.licensePlate),
                            _buildInfoText(
                                'ID da Frota:', tire.installed!.fleetId),
                            _buildInfoText('Posição de Instalação:',
                                tire.installed!.installedPositionName),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoText(String? label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              '$label ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              softWrap: true,
            ),
          ),
          Flexible(
            child: Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
