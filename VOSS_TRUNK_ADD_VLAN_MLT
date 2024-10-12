#@MetaDataStart
#@DetailDescriptionStart
#Script para configurção de portas lógicas MLT/LAG em modo trunk (802.1q/Tagged) - v2.
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida totalmente os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite dados das portas físicas e ID(s) da(s) VLAN(s):")
set ISID_ID_30 11000
set ISID_ID_20 1100
set ISID_ID_10 110
set ISID_ID_00 11
#@VariableFieldLabel (description ="ID(s) do(s) MLT(s) (separados com espaço):", scope = global)
set var MLTS ""
#@VariableFieldLabel (description ="ID(s) da(s) VLAN(s) (separadas com espaço):", scope = global)
set var VLANS ""
set VLAN_LIST ${VLANS}
set MLT_LIST ${MLTS}
#@SectionStart (description = "Switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"
#@SectionEnd
#@MetaDataEnd

CLI enable
CLI config t
CLI terminal more disable
foreach MLT_ID $MLT_LIST {
foreach VLAN_ID $VLAN_LIST {
    if {$VLAN_ID < 10} {
        CLI i-sid $ISID_ID_30$VLAN_ID
        CLI c-vid $VLAN_ID mlt $MLT_ID
} elseif {$VLAN_ID < 100} {
        CLI i-sid $ISID_ID_20$VLAN_ID
        CLI c-vid $VLAN_ID mlt $MLT_ID
} elseif {$VLAN_ID < 1000} {
        CLI i-sid $ISID_ID_10$VLAN_ID
        CLI c-vid $VLAN_ID mlt $MLT_ID 
} else {
        CLI i-sid $ISID_ID_00$VLAN_ID
        CLI c-vid $VLAN_ID mlt $MLT_ID
}  
} 
}
exit
