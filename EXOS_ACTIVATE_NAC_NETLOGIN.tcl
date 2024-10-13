#@MetaDataStart
#@DetailDescriptionStart
#Script para ativação de NAC nas portas dos switches EXOS.
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida totalmente os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite os dados para a ativação do NAC no(s) switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Ativar Autenticação via MAC?", scope = global,
#   required    = yes,
#   validValues = [Sim,Nao])
set var NAC_MAC Sim
#@VariableFieldLabel (description ="Ativar Autenticação via 802.1x?", scope = global,
#   required    = yes,
#   validValues = [Sim,Nao])
set var NAC_DOT1X Nao
#@SectionEnd
#@SectionStart (description = "Selecione o Range de Módulo(s) e Porta(s):")
#@VariableFieldLabel (description ="Módulo/Slot inicial:", scope = global,
#   required    = yes,
#   validValues = [1,2,3,4,5,6,7,8])
set var ID_SLOT_FIRST 
#@VariableFieldLabel (description ="Módulo/Slot final:", scope = global,
#   required    = yes,
#   validValues = [1,2,3,4,5,6,7,8])
set var ID_SLOT_LAST 
#@VariableFieldLabel (description ="Porta inicial:", scope = global,
#   required    = yes,
#   validValues = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48])
set var ID_PORT_FIRST 
#@VariableFieldLabel (description ="Porta final:", scope = global,
#   required    = yes,
#   validValues = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48])
set var ID_PORT_LAST 
#@VariableFieldLabel (description ="Configurar porta(s) com vlan de Salvaguarda?", scope = global,
#   required    = yes,
#   validValues = [Sim,Nao])
set var SALVAGUARDA Sim
#@SectionEnd
#@SectionStart (description = "Switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"
#@SectionEnd
#@MetaDataEnd

#ativação do NAC no(s) dispositivo(s)
if {$NAC_MAC eq "Sim" } {
CLI enable netlogin mac
CLI configure policy vlanauthorization disable
}
if {$NAC_DOT1X eq "Sim" } {
CLI enable netlogin dot1x
CLI configure policy vlanauthorization disable
}

#ativação do NAC na(s) porta(s)
incr ID_SLOT_LAST 1
incr ID_PORT_LAST 1
if {$NAC_MAC eq "Sim" } {
    for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
        for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
        CLI configure netlogin port $i:$j authentication mode optional
        CLI enable netlogin ports $i:$j mac
        CLI configure policy vlanauthorization port $i:$j disable untagged
        }
    }
}
if {$NAC_DOT1X eq "Sim" } {
    for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
        for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
        CLI configure netlogin port $i:$j authentication mode optional
        CLI enable netlogin ports $i:$j dot1x
        CLI configure policy vlanauthorization port $i:$j disable untagged
        }
    }
}
if {$SALVAGUARDA eq "Sim" } {
    for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
        for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
        CLI configure policy rule admin-profile port $i:$j mask 16 port-string $i:$j admin-pid 1
        }
    }
}

