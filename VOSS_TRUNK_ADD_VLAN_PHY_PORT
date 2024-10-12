
#@MetaDataStart
#@DetailDescriptionStart
#Script para configurção de portas físicas em modo trunk (802.1q/Tagged).
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida totalmente os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite dados das portas físicas e ID(s) da(s) VLAN(s):")
set ISID_ID_30 11000
set ISID_ID_20 1100
set ISID_ID_10 110
set ISID_ID_00 11
#@VariableFieldLabel (description ="ID(s) da(s) Porta(s):", scope = global)
set var PORT_ID ""
#@VariableFieldLabel (description ="ID(s) da(s) VLAN(s) (separadas com espaço):", scope = global)
set var VLANS ""
set VLAN_LIST ${VLANS}
#@SectionStart (description = "Switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"
#@SectionEnd
#@MetaDataEnd

CLI enable
CLI config t
CLI terminal more disable
foreach VLAN_ID $VLAN_LIST {
    if {$VLAN_ID < 10} {
        CLI i-sid $ISID_ID_30$VLAN_ID
        CLI c-vid $VLAN_ID port $PORT_ID
} elseif {$VLAN_ID < 100} {
        CLI i-sid $ISID_ID_20$VLAN_ID
        CLI c-vid $VLAN_ID port $PORT_ID
} elseif {$VLAN_ID < 1000} {
        CLI i-sid $ISID_ID_10$VLAN_ID
        CLI c-vid $VLAN_ID port $PORT_ID 
} else {
        CLI i-sid $ISID_ID_00$VLAN_ID
        CLI c-vid $VLAN_ID port $PORT_ID
}  
} 
CLI show i-si
CLI save config
exit
