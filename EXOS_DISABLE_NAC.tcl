 #@MetaDataStart
#@DetailDescriptionStart
#Script para desativação de NAC nas portas dos switches EXOS.
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida totalmente os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite os dados para a Desativação do NAC na(s) porta(s) do(s) switch(es) selecionado(s):")
#@SectionStart (description = "Selecione o Range de Módulo/Slots(s) e Porta(s):")
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
#@VariableFieldLabel (description ="Selecione a Role default a ser configurada na(s) porta(s):", scope = global,
#   required    = yes,
#   validValues = [POLICY_XPTO,POLICY_XPTO1,POLICY_XPTON])
set var ID_ROLE_DEFAULT
#@SectionEnd
#@SectionStart (description = "Switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"

#lista de roles (LISTA POLICY (ROLES) AND set ID to VAR)
set POLICY_XPTO 1
set POLICY_XPTO2 2
set POLICY_XPTO3 n

#@SectionEnd
#@MetaDataEnd

#desativação do NAC na(s) porta(s)
incr ID_SLOT_LAST 1
incr ID_PORT_LAST 1
    for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
        for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
        CLI disable netlogin ports $i:$j mac
        }
    }
    for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
        for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
        CLI disable netlogin ports $i:$j dot1x
        }
    }
for {set i $ID_SLOT_FIRST} {$i < $ID_SLOT_LAST } { incr i +1 } {
    for {set j $ID_PORT_FIRST} {$j < $ID_PORT_LAST } { incr j +1 } {
    CLI configure policy rule admin-profile port $i:$j mask 16 port-string $i:$j admin-pid [subst $$ID_ROLE_DEFAULT]
    }
}
