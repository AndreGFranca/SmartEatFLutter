import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/models/justify/justify_create.dart';
import 'package:smart_eats/models/justify/justify_read.dart';
import 'package:smart_eats/services/justify/justify_service.dart';
import '../../../contexts/user_context.dart';
import '../../../enums/type_user.dart';
import '../../../models/confirm/confirm_model.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';
import '../response_modal.dart';

class JustifyConfirm extends StatefulWidget {
  JustifyConfirm({super.key, required this.justificativa});

  late JustifyRead justificativa;
  bool loading = false;
  JustifyService _justifyService = JustifyService();
  List<ConfirmModel> listaDiasNaoComparecidos = [];

  @override
  State<JustifyConfirm> createState() => _JustifyConfirmState();
}

class _JustifyConfirmState extends State<JustifyConfirm> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedId;
  final _motivoController = TextEditingController();
  TextEditingController dsJustifyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _motivoController.text = widget.justificativa.MotivoRecusa ?? "";
    setState(() {

    });
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  @override
  Widget build(BuildContext context) {
    final userContext = Provider.of<UserContext>(context);
    return LayoutBuilder(
      builder:(context, constraints)=>Form(
        key: _formKey,
        child: Scaffold(
          appBar: GenericAppBar(
            titleAppBar: 'Justificativa',
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Colaborador:\t',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular',
                                color: DefaultColors.primaryColor,
                              ),
                            ),
                            Text(
                              widget.justificativa.Funcionario.Nome,
                              style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Perfil:\t',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular',
                                color: DefaultColors.primaryColor,
                              ),
                            ),
                            Text(
                              TypeUser.ProfileValues[
                                  widget.justificativa.Funcionario.Perfil]!,
                              style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Data de ausência:\t',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular',
                                color: DefaultColors.primaryColor,
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM').format(
                                  widget.justificativa.Confirmacao.DataDeConfirmacao),
                              style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          height: 0,
                          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                          margin: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey)),

                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Justificativa:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular',
                                color: DefaultColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: DefaultColors.primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                              color: DefaultColors.primaryColor.withOpacity(0.1),
                            ),
                            child: Row(
                              children: [
                                Text(widget.justificativa.Justificativa),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 0,
                          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                          margin: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey)),

                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Motivo:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Regular',
                                color: DefaultColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: DefaultColors.primaryColor),
                            borderRadius: BorderRadius.circular(8.0),
                            color: DefaultColors.primaryColor.withOpacity(0.1),
                          ),
                          child: TextFormField(
                            controller: _motivoController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '(Opcional) escreva o motivo por ter aceitado ou rejeitado)',
                              hintStyle: TextStyle(color: DefaultColors.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: ConfirmButton(
                                      label: 'Aceitar',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              widget.loading = true;
                                            });

                                            widget.justificativa.MotivoRecusa = _motivoController.text;
                                            widget.justificativa.Aprovado = true;
                                            widget.justificativa.IdAprovador = userContext.Id;


                                            await widget._justifyService
                                                .ConfirmJustify(widget.justificativa)
                                                .then((value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ResponseModal(
                                                    texto: value,
                                                  ),
                                                ),
                                              ).then((value) {
                                                Navigator.pop(context);
                                              });
                                            });
                                          } catch (e) {
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
                                      }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: ConfirmButton(
                                      label: 'Rejeitar',
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              widget.loading = true;
                                            });

                                            widget.justificativa.MotivoRecusa = _motivoController.text;
                                            widget.justificativa.Aprovado = false;
                                            widget.justificativa.IdAprovador = userContext.Id;

                                            await widget._justifyService
                                                .ConfirmJustify(widget.justificativa)
                                                .then((value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ResponseModal(
                                                    texto: value,
                                                  ),
                                                ),
                                              ).then((value) {
                                                Navigator.pop(context);
                                              });
                                            });
                                          } catch (e) {
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
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: DefaultColors.backgroudColor,
        ),
      ),
    );
  }
}
