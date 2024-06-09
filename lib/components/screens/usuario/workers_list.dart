import 'package:flutter/material.dart';
import 'package:smart_eats/components/app_bars/generic_app_bar.dart';
import 'package:smart_eats/components/screens/usuario/create_worker.dart';
import 'package:smart_eats/enums/type_user.dart';
import 'package:smart_eats/services/user/user_service.dart';
import '../../utils/confirm_button.dart';
import '../../utils/default_colors.dart';

class WorkersList extends StatefulWidget {
  late List<Map<String, dynamic>> colaboradores = [];
  final int companyId;
  late UserService _userService = UserService();

  late bool loading = false;

  WorkersList({super.key, required this.companyId});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  final _formKey = GlobalKey<FormState>();

  // List<Map<String, String>> colaboradores = [
  //   {"nome": "Airfryer de Souza", "perfil": "Rh", "ativo": "true"},
  //   {"nome": "Frigideira Alves de ...", "perfil": "Clb", "ativo": "true"},
  //   {"nome": "Panela Lopes", "perfil": "Czn", "ativo": "true"},
  //   {"nome": "Fogão da Silva", "perfil": "Clb", "ativo": "true"},
  // ];
  Future _fetchData() async {
    setState(() {
      widget.loading = true;
    });
    try {
      await widget._userService.ListWorkers(widget.companyId).then((value) {
        widget.colaboradores = [];
        value.forEach((element) {
          widget.colaboradores.add({
            "id": element["id"],
            "nome": element["name"],
            "perfil": element["typeUser"],
            "ativo": element["ativo"],
          });
        });
        setState(() {
          widget.loading = false;
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

  @override
  void initState() {
    super.initState();
    _fetchData();
    // Chama o método para carregar a lista de categorias quando o widget é iniciado
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: GenericAppBar(
          titleAppBar: 'Colaboradores',
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar Colaborador',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: DefaultColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: DefaultColors.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (!widget.loading)
                  if (widget.colaboradores.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Nome')),
                            DataColumn(label: Text('Perfil')),
                            DataColumn(label: Text('Ativo')),
                            DataColumn(label: Text('Ações')),
                          ],
                          rows: widget.colaboradores.map((colaborador) {
                            return DataRow(cells: [
                              DataCell(
                                SizedBox(
                                  child: Text(
                                    colaborador['nome']!,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                              DataCell(Text(TypeUser
                                  .ProfileValues[colaborador['perfil']]!)),
                              if (colaborador['ativo']! == true)
                                DataCell(Icon(
                                  Icons.check_circle,
                                  color: DefaultColors.primaryColor,
                                ))
                              else
                                DataCell(Icon(
                                  Icons.circle_outlined,
                                  color: DefaultColors.primaryColor,
                                )),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: DefaultColors.primaryColor),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateWorker(
                                            IdUser: colaborador['id'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )),
                            ]);
                          }).toList(),
                        ),
                      ),
                    )
                  else
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: DefaultColors.primaryColor),
                      onPressed: () {},
                    ),
                    for (int i = 1; i <= 3; i++)
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '$i',
                          style: TextStyle(color: DefaultColors.primaryColor),
                        ),
                      ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: DefaultColors.primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Column(
                    children: [
                      ConfirmButton(
                          label: 'Cadastrar',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateWorker(),
                              ),
                            ).then((value) {
                              _fetchData();
                            });
                          })
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
