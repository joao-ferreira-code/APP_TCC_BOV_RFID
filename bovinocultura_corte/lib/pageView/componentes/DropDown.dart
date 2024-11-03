
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dataModel/admSistema/Cidade.dart';
import '../../dataModel/admSistema/Estado.dart';
import '../../dataModel/admSistema/NivelAcesso.dart';
import '../../dataModel/admSistema/Raca.dart';
import '../../dataModel/inventario/LoteVacina.dart';
import 'PaletaCores.dart';

class DropDown{

//============================================================================//

  static bordaDropDown( {required Widget child} ){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color(0xbfffffff),
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
            style: BorderStyle.solid, width: 2, color: Colors.grey
        ),
      ),

      child: Padding(padding: EdgeInsets.only(left: 5, right: 5), child: child)
    );
  }

//============================================================================//

  static ByText( {required ValueChanged<String?> onChanged, String? value,
                    required List<String> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<String>(
        isExpanded: true,
        icon: icon,
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }
        ).toList()
      )
    );
  }

//============================================================================//

  static ByInt( {required ValueChanged<int?> onChanged, int? value,
                    required List<int> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<int>(
        isExpanded: true,
        icon: icon,
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text("  ${value}"),
          );
        }
        ).toList()
      )
    );
  }

//============================================================================//

  static ByEstado( {required ValueChanged<Estado?> onChanged, Estado? value,
                      required List<Estado> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<Estado>(
        isExpanded: true,
        icon: icon,
        hint: Text("Selecione..."),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<Estado>>((Estado value) {
          return DropdownMenuItem<Estado>(
              value: value,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text("${value.txNome}-${value.txSigla}")
                  ],
                ),
              )

          );
        }).toList()
      )
    );
  }

//============================================================================//

  static ByCidade( {required ValueChanged<Cidade?> onChanged, Cidade? value,
                      required List<Cidade> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<Cidade>(
        isExpanded: true,
        icon: icon,
        hint: Text("Selecione..."),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<Cidade>>((Cidade value) {
          return DropdownMenuItem<Cidade>(
              value: value,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text("${value.txNome}")
                  ],
                ),
              )

          );
        }).toList()
      )
    );
  }

//============================================================================//

  static ByRaca( {required ValueChanged<Raca?> onChanged, Raca? value,
                    required List<Raca> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<Raca>(
        isExpanded: true,
        icon: icon,
        hint: Text("Selecione..."),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<Raca>>((Raca value) {
          return DropdownMenuItem<Raca>(
              value: value,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text("${value.txNome}")
                  ],
                ),
              )

          );
        }).toList()
      )
    );
  }

//============================================================================//

  static ByVacina( {required ValueChanged<LoteVacina?> onChanged, LoteVacina? value,
                      required List<LoteVacina> items, Icon? icon} ) {

    return bordaDropDown(
      child: DropdownButton<LoteVacina>(
        isExpanded: true,
        icon: icon,
        hint: Text("Selecione..."),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<LoteVacina>>((LoteVacina value) {
          return DropdownMenuItem<LoteVacina>(
              value: value,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Icon(Icons.vaccines, color: Palette.main.shade300,),
                    SizedBox(width: 5,),
                    Text("${value.txNomeVacina}")
                  ],
                ),
              )

          );
        }).toList()
      )
    );
  }

//============================================================================//

  static ByNivelAcesso( {required ValueChanged<NivelAcesso?>? onChanged, NivelAcesso? value,
                          required List<NivelAcesso> items, Icon? icon}) {

    return bordaDropDown(
      child: DropdownButton<NivelAcesso>(
        isExpanded: true,
        icon: icon,
        hint: Text("Selecione..."),
        value: value,
        elevation: 16,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<NivelAcesso>>((NivelAcesso value) {
          return DropdownMenuItem<NivelAcesso>(
              value: value,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text("${value.txNome}")
                  ],
                ),
              )

          );
        }).toList()
      )
    );
  }

//============================================================================//


}