

#@MetaDataStart
#@DetailDescriptionStart
#Script para criação de LAG LACP (MLT) em Clusters SMLT (duplas de switches com cluster vIST).
#@DetailDescriptionEnd
#@SectionStart (description = "Atenção: Este script não valida os dados digitados.")
#@SectionEnd
#@SectionStart (description = "Digite os dados do LAG LACP (MLT) a ser criado no cluster SMLT (cluster v-IST):")
#@VariableFieldLabel (description ="ID do LAG LACP (MLT ID):", scope = global)
set var LAG_ID ""
#@VariableFieldLabel (description ="Nome do LAG LACP (MLT Name):", scope = global)
set var LAG_NAME ""
#@VariableFieldLabel (description ="ID da(s) porta(s) onde será ativado o LAG LACP (exemplo: 1/30 ou 1/30-1/31):", scope = global)
set var PORT_ID ""
#@SectionEnd
#@SectionStart (description = "Dupla de Switches selecionados:")
#@VariableFieldLabel (description ="Selecionados:", scope = local,
set var SELECIONADOS "Sim"
#@SectionStart (description = "Atenção: Verifique se a dupla de switches correta foi selecionada.")
#@SectionEnd
#@MetaDataEnd

#CONFIGURA INTERFACE LÓGICA MLT
CLI enable
CLI config t
CLI terminal more disable
CLI mlt $LAG_ID
CLI mlt $LAG_ID name $LAG_NAME
CLI mlt $LAG_ID encapsulation dot1q
CLI interface mlt $LAG_ID
CLI lacp key $LAG_ID
CLI lacp enable
CLI smlt
CLI flex-uni enable
CLI fa
CLI no fa message-authentication

#CONFIGURA INTERFACES FÍSICAS
CLI vlan members remove 1 $PORT_ID
CLI interface giga $PORT_ID
CLI no lock enable
CLI shutdown
CLI no flex-uni enable
CLI no spanning-tree mstp force-port-state enable
CLI y
CLI name $LAG_NAME
CLI no fa
CLI encapsulation dot1q
CLI lacp key $LAG_ID agg enable mode active
CLI lacp enable
CLI no shutdown
CLI lock enable
CLI save config
exit
