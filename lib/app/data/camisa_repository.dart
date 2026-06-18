import 'package:projeto_camiseta_outisder/app/data/camisa_model.dart';
import 'package:projeto_camiseta_outisder/app/data/camisa_service.dart';

class CamisaRepository {
  final CamisaService _camisaService = CamisaService();
  CamisaModel get camisaModel =>
      CamisaModel.fromStringResponse(_camisaService.buscarCamisa() as String);
}
