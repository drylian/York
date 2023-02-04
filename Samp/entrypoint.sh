#!/bin/bash
# Aguarde até que o contêiner seja totalmente inicializado
sleep 1
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌                                      
########################################################################################################
# Variaveis Facilmente Mudaveis                                                                        #
########################################################################################################
# Isto Define o Nome do egg, logs e a pasta da internet dele dele                                      
Nome_egg="SA-MP"                                                                                       
# Isto Define o Stop do egg                                                                            
Comando_stop="Sistema Entrypoint.sh Parar"                                                             
# Isto Define o novo StartUP do egg                                                                    
Comando_StartUP="./samp03svr"                                                                          
# Isto Define o Link base do egg                                     /deixe o $Nome_egg                
Base_Url="https://raw.githubusercontent.com/drylian/Eggs/main/Connect/${Nome_egg}"                     
# Isto Define a Pasta de Verificação do Egg (Use só o nome, o script ja possue ./)                     
Pasta_Verif="Status"                                                                                   
# Seta permissões Padrões                                                                              
Permissoes_padroes="chmod 777 ./*"                                                                     
# Comandos Permitidos apartir da iniciação $Subcomando                                                 
Subcomando="samp" # no caso qualquer comando é permitido desde que comece com cmd ex:cmd help          
Subcomando_tag="./samp03svr" # isto será oque de fato vai ser executado no terminal ex:./nome help     
# Criação da Pasta de Vefiricação                                                                      
  if [[ -f "./${Pasta_Verif}/Pasta_Verif" ]]; then                                                     
    echo " "                                                                                           
  else                                                                                                 
    mkdir ./${Pasta_Verif}                                                                             
    touch ./${Pasta_Verif}/Pasta_Verif                                                                 
  fi                                                                                                   
# Versão do Entrypoint                                                      /Nome do Egg/              
entrypoint_vurl="$Base_Url/Versao_Atual"                                                            
entrypoint_version=$(curl -s "$entrypoint_vurl" | grep "Entrypoint: " | awk '{print $2}')                                                                                                         #
#Verifica a Arquitetura do Docker                                                                      
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "amd64" || echo "arm64")                           
# URL para a versão mais recente                                               /Nome do Egg/           
latest_version_url="$Base_Url/Versao_Atual"                                                            
# Extrai a versão atual do arquivo local version.sh                                                    
current_version=$(grep "Instalação: " ./${Pasta_Verif}/Versao_Atual | awk '{print $2}')                  
# Extrai a versão mais recente da URL                                                                  
latest_version=$(curl -s "$latest_version_url" | grep "Instalação: " | awk '{print $2}')               
# Cores do Sistema                                                                                     
bold=$(echo -en "\e[1m")                                                                               
lightgreen=$(echo -en "\e[92m")                                                                        
vermelho=$(echo -en "\e[31m")                                                                          
# ${bold}${vermelho}

# A variante ${SUPORTE_ATIVO} é o Padrão do Script no Entrypoint.
  if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then
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

  # Verifica Se Atualização Automatica está ativada
    if [ "${SUPORTE_ATIVO}" == "1" ]; then                                                               #<== Seta sem linha vermelhas          #<== Seta com Linhas
      echo "${bold}${lightgreen}==> ✅ Sistema de Entrypoint Automatico está ativado.                       <=="
    else
      echo "${bold}${lightgreen}==> ❌ Sistema de Entrypoint Automatico está ${bold}${vermelho}desativado${bold}${lightgreen}.                     <=="
    fi

    echo "${bold}${lightgreen}==>                                                                        <=="

  # Verifica Se Atualização Automatica está ativada
    if [ "${AUTO_UPDATE}" == "1" ]; then
      echo "${bold}${lightgreen}==> ✅ Sistema de Atualização Automatica está ativado.                      <=="
    else
      echo "${bold}${lightgreen}==> ❌ Sistema de Atualização Automatica está ${bold}${vermelho}desativado${bold}${lightgreen}.                   <=="
    fi

    echo "${bold}${lightgreen}==>                                                                        <=="
    echo "${bold}${lightgreen}=============================================================================="
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

  # Verifica se o AUTO_UPDATE existe no egg
    if [ -z "$AUTO_UPDATE" ]; then
      echo "${bold}${lightgreen}==> ❌ Variante do Atualização(ativar/desativar) do egg não está definida.  <=="
    else
      echo "${bold}${lightgreen}==> ✅ Variante do Atualização(ativar/desativar) do egg está definida.      <=="
    fi
  #----------------------------------------
  # TXT
    echo "${bold}${lightgreen}==>                                                                        <=="
    echo "${bold}${lightgreen}=============================================================================="
  # TXT

  # Atualizações---------------------------------------------------
    echo "${bold}${lightgreen}==> 🟢 Iniciando Script."

    if [ "${AUTO_UPDATE}" == "1" ]; then
    echo "${bold}${lightgreen}==> 🟠 Iniciando Verificação de Atualizações."
      if [ -z "$current_version" ] || [ "$current_version" != "$latest_version" ]; then
      echo "${bold}${lightgreen}==> 🟠 Buscando Atualizações."
      echo "${bold}${lightgreen}==> 🟠 Nova versão encontrada: $latest_version, preparando para atualização."
      rm -r ./samp03svr && rm -r ./${Pasta_Verif}/Samp_server.instalado
      rm -r ./samp-npc && rm -r ./${Pasta_Verif}/Samp_npc.instalado
      rm -r ./announce && rm -r ./${Pasta_Verif}/announce.instalado
      echo "${bold}${lightgreen}==> 🟠 iniciando script de instalação da nova versão:$latest_version."
      else
      echo "${bold}${lightgreen}==> 🟢 Verificação de Atualizações Detectou que a Sua versão é a mais atual."
      fi
    else
    echo "${bold}${lightgreen}==> 🔴 Verificação de Atualizações Desativado, Pulando etapa."
    fi
  # Fim Atualizações-----------------------------------------------

  # Samp03svr verificador
    if [[ -f "./${Pasta_Verif}/Samp_server.instalado" ]]; then
      echo "${bold}${lightgreen}==> O Samp Linux foi detectado, O Sistema de download não será necessario. <=="
    else
      echo "${bold}${lightgreen}==> O Samp Linux ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.       <=="
      rm -f ./samp03svr
      curl -L -o /home/container/samp03svr "https://github.com/drylian/Eggs/releases/latest/download/samp03svr"
      touch ./${Pasta_Verif}/Samp_server.instalado
    fi
  # Samp-NPC verificador
    if [[ -f "./${Pasta_Verif}/Samp_npc.instalado" ]]; then
      echo "${bold}${lightgreen}==> O Samp Npc foi detectado, O Sistema de download não será necessario.   <=="
    else 
      echo "${bold}${lightgreen}==> O Samp Npc ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      rm -f ./samp-npc
      curl -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
      touch ./${Pasta_Verif}/Samp_npc.instalado
    fi
  # Announce verificador
    if [[ -f "./${Pasta_Verif}/announce.instalado" ]]; then
      echo "${bold}${lightgreen}==> O Announce foi detectado, O Sistema de download não será necessario.   <=="
      else
      echo "${bold}${lightgreen}==> O Announce ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      rm -f ./announce
      curl -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
      touch ./${Pasta_Verif}/announce.instalado
    fi
  # if da Server_log.txt
    if [[ -f "./server_log.txt" ]]; then
      echo "${bold}${lightgreen}==> Copiando Server_log.txt para a Log Completa.                           <=="
      cat ./server_log.txt >> ./${Pasta_Verif}/Server.log.txt
      echo "${bold}${lightgreen}==> Deletando antiga Server_log.txt.                                       <=="
      rm server_log.txt
    else
       echo "${bold}${lightgreen}==> Server_log.txt ${bold}${vermelho}não encontrada${bold}${lightgreen}, pulando etapa.                          <=="
    fi

  # FIM base

  # Permissões----------------------------------------------------#
    echo "${bold}${lightgreen}==> 🟢 Setando permissões padrões." #
    eval "$Permissoes_padroes"                                    #
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

  # StartUP comando
    # nohup Start
      
      nohup ${Comando_StartUP} > ${Nome_egg}.log.txt 2>&1 &
      pid=$!
      # Continua a exibir as últimas linhas do arquivo de log a cada segundo
      while true; do
      tail -n 10 -F ${Nome_egg}.log.txt
      sleep 1
      done &
      tail_pid=$!
    # nohup fim
    # Aguarda input do usuário
      while read line; do
      if [ "$line" = "${Comando_stop}" ]; then
        kill $pid
        echo "${bold}${lightgreen}=============================================================================="
        echo "${bold}${lightgreen}==                                                                          =="
        echo "${bold}${lightgreen}== 🟢 Comando de Desligamento executado, Desligando...                       =="
        echo "${bold}${lightgreen}==                                                                          =="
        echo "${bold}${lightgreen}=============================================================================="
        cat ./${Nome_egg}.log.txt >> ./${Pasta_Verif}/${Nome_egg}.log.txt
        sleep 5
        break
      elif [ "$line" != "${Comando_stop}" ]; then
        echo "${bold}${lightgreen}🔴 Comando Invalido, oque vocẽ está tentando fazer? tente $Subcomando"
      elif [[ "$line" == "${Subcomando}*" ]]; then
        Comando_usuario="${Subcomando_tag} $(echo "$line" | sed 's/^${Subcomando} //')"
        echo "${bold}${lightgreen}🟢 Sub Comando Executado."
        eval "$Comando_usuario"
      else
        echo " "
        echo "${bold}${lightgreen}=============================================================================="
        echo "${bold}${lightgreen}==                                                                          =="
        echo "${bold}${lightgreen}== 🟢 ${bold}${vermelho}Script Falhou ou Forçado pelo Kill.${bold}${lightgreen}                  =="
        echo "${bold}${lightgreen}==                                                                          =="
        echo "${bold}${lightgreen}=============================================================================="
      fi
      done
      kill $tail_pid
    # Fim Comando Start --------------------------------------------
  # StartUP Fim
# Fim if Suporte
else
# Dialogo--------------------------------------------------------
  echo "${bold}${vermelho}================================================================================"
  echo "${bold}${vermelho}= O Script de Iniciação está Desativado, iniciando sem script(Não recomendado) ="
  echo "${bold}${vermelho}================================================================================"
# Fim Dialogo----
  # StartUP Padrão do Pterodactyl---------------------------------------------------------------------#
    cd /home/container                                                                                #
                                                                                                      #
    # Substituir variáveis ​​de inicialização                                                           #
    MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')                         #
    echo -e ":/home/container$ ${MODIFIED_STARTUP}"                                                   #
                                                                                                      #
    # Execute o servidor                                                                              #
    eval ${MODIFIED_STARTUP}                                                                          #
  # StartUP Padrão do Pterodactyl---------------------------------------------------------------------#
fi