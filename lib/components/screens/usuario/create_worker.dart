import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/utils/custom_radio_button.dart';
import 'package:smart_eats/validators/utils_validators.dart';

import '../../../contexts/user_context.dart';
import '../../../enums/type_user.dart';
import '../../../models/user/create_user_model.dart';
import '../../../services/user/user_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class CreateWorker extends StatefulWidget {
  late CreateUserModel? usuarioModel;
  late String? IdUser;
  late UserService _userService = UserService();
  late bool loading = false;

  CreateWorker({this.IdUser, super.key});

  @override
  State<CreateWorker> createState() => _CreateWorkerState();
}

class _CreateWorkerState extends State<CreateWorker> {
  final _formKey = GlobalKey<FormState>();

  final Map<int, String> _profileValues = TypeUser.ProfileValues;

  int _selectedProfile = 2; // Valor padrão do Dropdown
  int _ativo = 1;

  Future<void> _fetchData() async {
    setState(() {
      widget.loading = true;
    });
    widget.usuarioModel = await widget._userService.GetUser(widget.IdUser!);

    dsNomeController.text = widget.usuarioModel!.Nome;
    dsCpfController.text = widget.usuarioModel!.Cpf;
    dsEmailController.text = widget.usuarioModel!.Email;
    dsPerfilController.text = widget.usuarioModel!.Perfil.toString();
    _ativo = widget.usuarioModel!.Ativo ? 1 : 0;
    _selectedProfile =
        widget.usuarioModel == null ? 1 : widget.usuarioModel!.Perfil;
    setState(() {
      widget.loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _profileValues.remove(0);
    _profileValues.remove(1);
    if (widget.IdUser != null) {
      _fetchData();
    }
  }

  TextEditingController dsNomeController = TextEditingController();
  TextEditingController dsCpfController = TextEditingController();
  TextEditingController dsEmailController = TextEditingController();
  TextEditingController dsSenhaController = TextEditingController();
  TextEditingController dsPerfilController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: widget.IdUser == null
              ? 'Editar Colaborador'
              : 'Cadastro Colaborador',
        ),
        body: SafeArea(
          child: Container(
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
                          CustomRadioButton(
                              value: _ativo,
                              groupValue: 1,
                              onChanged: (value) {
                                setState(() {
                                  _ativo = _ativo == 1 ? 0 : 1;
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
                      if(!widget.loading)
                      ConfirmButton(
                          label: 'Salvar',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try{
                                setState(() {
                                  widget.loading = true;
                                });
                                int selectedProfileValue = _selectedProfile;
                                if (widget.IdUser == null) {
                                  widget.usuarioModel = CreateUserModel(
                                      Nome: dsNomeController.text,
                                      Cpf: dsCpfController.text,
                                      Email: dsEmailController.text,
                                      Senha: dsSenhaController.text,
                                      Perfil: selectedProfileValue,
                                      Ativo: _ativo == 1,
                                      CompanyId: int.parse(userContext.CompanyId!));
          
                                  await widget._userService
                                      .RegisterUser(widget.usuarioModel!)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResponseModal(
                                          texto: value,
                                        ),
                                      ),
                                    ).then((value){
                                      Navigator.pop(context);
                                    });
                                    setState(() {
                                      widget.loading = false;
                                    });
                                  });
                                }
                                if (widget.IdUser != null) {
                                  widget.usuarioModel = CreateUserModel(
                                      Id: widget.IdUser,
                                      Nome: dsNomeController.text,
                                      Cpf: dsCpfController.text,
                                      Email: dsEmailController.text,
                                      Perfil: selectedProfileValue,
                                      Ativo: _ativo == 1,
                                      CompanyId: widget.usuarioModel!.CompanyId);
          
                                  await widget._userService
                                      .RegisterUser(widget.usuarioModel!)
                                      .then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResponseModal(
                                          texto: value,
                                        ),
                                      ),
                                    );
                                    _fetchData();
                                    setState(() {
                                      widget.loading = false;
                                    });
                                  });
                                }
                              }catch(e){
                                var erro = e.toString();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(erro),
                                  ),
                                );
                                setState(() {
                                  widget.loading = false;
                                });
                              }
          
                            }
                          })
                      else
                        Center(child: CircularProgressIndicator(),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: DefaultColors.backgroudColor,
      ),
    );
  }
}
