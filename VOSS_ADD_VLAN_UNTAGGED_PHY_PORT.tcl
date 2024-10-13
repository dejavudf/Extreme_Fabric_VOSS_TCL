#@MetaDataStart
#@DetailDescriptionStart
#Script para configurção de portas físicas em modo acesso (untagged).
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida totalmente os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite dados das portas físicas e ID da VLAN:")
set ISID_ID_30 11000
set ISID_ID_20 1100
set ISID_ID_10 110
set ISID_ID_00 11
set var PORT_ID ""
set var VLAN_ID ""
#@SectionStart (description = "Switch(es) selecionado(s):")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"
#@SectionEnd
#@MetaDataEnd

CLI enable
CLI config t
if {$VLAN_ID < 10} {
    CLI i-sid $ISID_ID_30$VLAN_ID
    CLI untagged-traffic port $PORT_ID
    CLI show i-sid $ISID_ID_30$VLAN_ID
} elseif {$VLAN_ID < 100} {
    CLI i-sid $ISID_ID_20$VLAN_ID
    CLI untagged-traffic port $PORT_ID
    CLI show i-sid $ISID_ID20$VLAN_ID
} elseif {$VLAN_ID < 1000} {
    CLI i-sid $ISID_ID_10$VLAN_ID
    CLI untagged-traffic port $PORT_ID
    CLI show i-sid $ISID_ID_10$VLAN_ID
} else {
    CLI i-sid $ISID_ID_00$VLAN_ID
    CLI untagged-traffic port $PORT_ID
    CLI show i-sid $ISID_ID_00$VLAN_ID
}    
CLI save config
exit
