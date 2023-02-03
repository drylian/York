#!/bin/ash
#################################################################################
#                                                                               #
#                                                                               #
#                     Arquivo base Entrypoint.sh de Drylian                     #
#                                                                               #
#                                                                               #
#################################################################################
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌                                      #
########################################################################################################
# Isto Define o Nome do egg e pasta dele                                                               #
Nome_egg="SA-MP"                                                                                       #
# Isto Define o Stop do egg                                                                            # 
Comando_stop="Sistema Entrypoint.sh Parar"                                                                                        #
# Versão do Entrypoint                                                      /Nome do Egg/              #
entrypoint_vurl="https://raw.githubusercontent.com/drylian/Eggs/main/Connect/$Nome_egg/Versao_Atual"   #
entrypoint_version=$(curl -s "$entrypoint_vurl" | grep "Entrypoint: " | awk '{print $2}')              #
# Aguarde até que o contêiner seja totalmente inicializado                                             #
sleep 1                                                                                                #
#Verifica a Arquitetura do Docker                                                                      #
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "amd64" || echo "arm64")                           #
# URL para a versão mais recente                                               /Nome do Egg/           #
latest_version_url="https://raw.githubusercontent.com/drylian/Eggs/main/Connect/$Nome_egg/Versao_Atual"#
# Extrai a versão atual do arquivo local version.sh                                                    #
current_version=$(grep "Instalação: " ./Status/Versao_Atual | awk '{print $2}')                        #
# Extrai a versão mais recente da URL                                                                  #
latest_version=$(curl -s "$latest_version_url" | grep "Instalação: " | awk '{print $2}')               #
# Cores do Sistema                                                                                     #
bold=$(echo -en "\e[1m")                                                                               #
lightgreen=$(echo -en "\e[92m")                                                                        #
vermelho=$(echo -en "\e[31m")                                                                          #
# ${bold}${vermelho}                                                                                   #
########################################################################################################
# A variante ${SUPORTE_ATIVO} é o Padrão do Script no Entrypoint.                                      #
if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then                                      #
########################################################################################################
  ######################################## VERIFICAÇÃO MAQUINA ##################################################
  echo "${bold}${lightgreen}=============================================================================="
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}==>                     - - - Script  Entrypoint - - -                     <=="
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}=============================================================================="
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}==>                  - - - Informações da Maquina. - - -                   <=="
  echo "${bold}${lightgreen}==>                                                                        <=="
  # Vefirica Arquitetura da Maquina
  if [ "${Arquitetura}" == "arm64" ]; then 
      echo "${bold}${lightgreen}==> 🔵 Arquitetura :Alpine Arm64x                                           <=="
    else
      echo "${bold}${lightgreen}==> 🔵 Arquitetura :Alpine AMD64x                                           <=="
  fi
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}==> ✅ Versão do Entrypoint: $entrypoint_version                                            <=="
  echo "${bold}${lightgreen}==>                                                                        <=="
  # Verifica Versão da Instalação
  if [ -z "$current_version" ]; then
  echo "${bold}${lightgreen}==> ⚫ Versão da instalação: Pre-instalação, não disponivel ou customizada. <=="
  else
  echo "${bold}${lightgreen}==> ✅ Versão da Instalação Atual: $current_version                                      <=="
  fi
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}=============================================================================="
  ##############################################################################################################
  ######################################## VERIFICAÇÃO EGG ##################################################
  echo "${bold}${lightgreen}=============================================================================="
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}==>                           Verificação do Egg                           <=="
  echo "${bold}${lightgreen}==>                                                                        <=="
  # Verifica se o Suporte_Ativo existe no egg
  if [ -z "$SUPORTE_ATIVO" ]; then
  echo "${bold}${lightgreen}==> ❌ Variante do Suporte(ativar/desativar) do egg não está definida.      <=="
  else
  echo "${bold}${lightgreen}==> ✅ Variante do Suporte(ativar/desativar) do egg está definida.          <=="
  fi
  echo "${bold}${lightgreen}==>                                                                        <=="
  echo "${bold}${lightgreen}=============================================================================="
  ###########################################################################################################
  ####################################### SCRIPT DO EGG #####################################################
  # COLOQUE AQUI DENTRO OS CODIGOS DO EGG
  mkdir .Status




  ###########################################################################################################
  # COLOQUE AQUI APENAS OS SCRIPTS DE FINALIZAÇÃO DO EGG
  # Permissões----------------------------------------------------#
    echo "${bold}${lightgreen}==> 🟢 Setando permissões padrões." #
    chmod 777 ./*                                                 #
  # Fim Permissões------------------------------------------------#
  # Mostrar versão-----------------------------------------------------------------------------------------------------------------#
    echo "${bold}${lightgreen}=============================================================================="                      #
    echo "${bold}${lightgreen}==> 🟢 Final do Entrypoint: $entrypoint_version                                             <=="     #
    echo "${bold}${lightgreen}=============================================================================="                      #
    echo " "                                                                                                                       #
    echo " "                                                                                                                       #
    echo " "                                                                                                                       #
    echo " "                                                                                                                       #
    echo " "                                                                                                                       #
  # Fim Versão---------------------------------------------------------------------------------------------------------------------#

  #################################### STARTUP DO SCRIPT ###############################################
  # Comando Start--------------------------------------------
  # nohup ./samp03svr > log_$Nome_egg.txt 2>&1 &
    nohup ./samp03svr > log_$Nome_egg.txt 2>&1 &
  pid=$!

  # Continua a exibir as últimas linhas do arquivo de log a cada segundo
  while true; do
  tail -n 10 -F log_$Nome_egg.txt
  sleep 1
  done &
  tail_pid=$!

  # Aguarda input do usuário
  while read line; do
  if [ "$line" = "$Comando_stop" ]; then
    kill $pid
    echo "${bold}${lightgreen}=============================================================================="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}== 🟢 Comando de Desligamento executado.                                     =="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}=============================================================================="
    cat ./log_$Nome_egg.txt >> ./Status/log_$Nome_egg.txt
    sleep 15
    break
    elif [ "$line" != "$Comando_stop" ]; then
    echo "${bold}${lightgreen}=============================================================================="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}== 🔴 Comando Invalido, oque vocẽ está tentando fazer?                       =="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}=============================================================================="
    else
    echo " "
    echo "${bold}${lightgreen}=============================================================================="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}== 🟢 ${bold}${vermelho}Entrypoint Finalizado com ERRO ou Forçado pelo Kill.${bold}${lightgreen}                  =="
    echo "${bold}${lightgreen}==                                                                          =="
    echo "${bold}${lightgreen}=============================================================================="
    fi
  # Fim Comando Start --------------------------------------------
    #################################### STARTUP DO SCRIPT ###############################################
########################################################################################################
else                                # ELSE DO ${SUPORTE_ATIVO}                                         #
########################################################################################################
  # StartUP Padrão do Pterodactyl---------------------------------------------------------------------#
    cd /home/container                                                                                #
                                                                                                      #
    # Substituir variáveis ​​de inicialização                                                           #
    MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`                #
    echo ":/home/container$ ${MODIFIED_STARTUP}"                                                      #
                                                                                                      #
    # Execute o servidor                                                                              #
    ${MODIFIED_STARTUP}                                                                               #
  # StartUP Padrão do Pterodactyl---------------------------------------------------------------------#
########################################################################################################
fi                                # FI DO ${SUPORTE_ATIVO}                                             #
########################################################################################################