import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/utils/custom_radio_button.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../models/user/create_user_model.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class CreateWorker extends StatefulWidget {
  late CreateUserModel? usuarioModel;

  CreateWorker({this.usuarioModel = null, super.key});

  @override
  State<CreateWorker> createState() => _CreateWorkerState();
}

class _CreateWorkerState extends State<CreateWorker> {
  final _formKey = GlobalKey<FormState>();

  final Map<int, String> _profileValues = {
    1: 'RH',
    2: 'Colaborador',
    3: 'Empresa',
    4: 'Cozinha',
  };
  int _selectedProfile = 1; // Valor padrão do Dropdown
  int _ativo = 1;
  @override
  void initState() {
    super.initState();
    if (widget.usuarioModel != null) {
      dsNomeController.text = widget.usuarioModel!.Nome;
      dsCpfController.text = widget.usuarioModel!.Cpf;
      dsEmailController.text = widget.usuarioModel!.Email;
      dsSenhaController.text = widget.usuarioModel!.Senha;
      dsPerfilController.text = widget.usuarioModel!.Perfil.toString();
      _ativo = widget.usuarioModel!.Ativo ? 1: 0;
      _selectedProfile = widget.usuarioModel == null ? 1: widget.usuarioModel!.Perfil;
    }
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  TextEditingController dsNomeController = TextEditingController();
  TextEditingController dsCpfController = TextEditingController();
  TextEditingController dsEmailController = TextEditingController();
  TextEditingController dsSenhaController = TextEditingController();
  TextEditingController dsPerfilController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Cadastro Colaborador',
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um Nome';
                  }
                  return null;
                },
                controller: dsNomeController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                ),
              ),
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um CPF';
                  }
                  return null;
                },
                controller: dsCpfController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',

                  labelText: 'CPF',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                ),
              ),
              TextFormField(
                validator: (String? value) {
                  if (DefaultValidators.textValidator(value)) {
                    return 'Insira um email';
                  }
                  return null;
                },
                controller: dsEmailController,
                decoration: const InputDecoration(
                  // hintText: 'Qual é o seu nome?',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(223, 223, 223, 0.5),
                      width: 1,
                    ),
                  ),
                  labelText: 'E-Mail',
                  labelStyle: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Perfil',
                            style: TextStyle(
                              color: DefaultColors.primaryColor,
                              fontFamily: 'Roboto-Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        DropdownButton<int>(
                          value: _selectedProfile,
                          items: _profileValues.keys.map((int key) {
                            return DropdownMenuItem<int>(
                              value: key,
                              child: Text(_profileValues[key]!),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedProfile = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Situação',
                            style: TextStyle(
                              color: DefaultColors.primaryColor,
                              fontFamily: 'Roboto-Regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        CustomRadioButton(value: _ativo, groupValue: 1, onChanged: (value){
                          setState(() {
                            _ativo = _ativo == 1? 0: 1;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Column(
                  children: [
                    ConfirmButton(
                        label: 'Salvar',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int selectedProfileValue = _selectedProfile;
                            print(selectedProfileValue);
                            widget.usuarioModel = CreateUserModel(
                              Nome: dsNomeController.text,
                              Cpf: dsCpfController.text,
                              Email: dsEmailController.text,
                              Senha: dsSenhaController.text,
                              Perfil: selectedProfileValue,
                              Ativo: _ativo == 1,
                            );
                            print(
                                '${widget.usuarioModel!.Nome},${widget.usuarioModel!.Cpf},${widget.usuarioModel!.Email},${widget.usuarioModel!.Ativo}');
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }
}
