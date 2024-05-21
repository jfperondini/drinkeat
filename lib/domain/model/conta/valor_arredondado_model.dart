import 'package:drinkeat/cors/shared/extension/num_extension.dart';

class ValorArredondadoModel {
  num valorDiversoPessoa;
  num valorComidaPessoa;
  num valorBebidaPessoa;
  num valorDiversoComidaPessoa;

  ValorArredondadoModel({
    required this.valorDiversoPessoa,
    required this.valorComidaPessoa,
    required this.valorBebidaPessoa,
    required this.valorDiversoComidaPessoa,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'valorDiversoPessoa': valorDiversoPessoa,
      'valorComidaPessoa': valorComidaPessoa,
      'valorBebidaPessoa': valorBebidaPessoa,
      'valorDiversoComidaPessoa': valorDiversoComidaPessoa,
    };
  }

  factory ValorArredondadoModel.fromJson(Map<String, dynamic> map) {
    return ValorArredondadoModel(
      valorDiversoPessoa: map['valorDiversoPessoa'] ?? 0.00,
      valorComidaPessoa: map['valorComidaPessoa'] ?? 0.00,
      valorBebidaPessoa: map['valorBebidaPessoa'] ?? 0.00,
      valorDiversoComidaPessoa: map['valorDiversoComidaPessoa'] ?? 0.00,
    );
  }

  factory ValorArredondadoModel.empty() {
    return ValorArredondadoModel.fromJson({});
  }

  num get valorBebidaToFloor {
    return valorBebidaPessoa.toPrecisionFloor(valorBebidaPessoa);
  }

  num get valorBebidaToCeil {
    return valorBebidaPessoa.toPrecisionCeil(valorBebidaPessoa);
  }

  num get valorDiversoComida => valorDiversoPessoa + valorComidaPessoa;

  num get valorDiversoComidaToFloor {
    return valorDiversoComidaPessoa.toPrecisionFloor(valorDiversoComidaPessoa);
  }

  num get valorDiversoComidaToCeil {
    return valorDiversoComidaPessoa.toPrecisionCeil(valorDiversoComidaPessoa);
  }
}
