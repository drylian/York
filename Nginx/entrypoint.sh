#!/bin/ash

# icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌

# Aguarde até que o contêiner seja totalmente inicializado
sleep 1

#Verifica a Arquitetura do Docker
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "amd64" || echo "arm64")

# Cores do Sistema
bold=$(echo -en "\e[1m")
lightgreen=$(echo -en "\e[92m")
vermelho=$(echo -en "\e[31m")
# ${bold}${vermelho}

if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then
  echo "${bold}${lightgreen}=============================================================================="
  echo "${bold}${lightgreen}==>                           Script  Entrypoint                           <=="
  echo "${bold}${lightgreen}==>                                                                        <=="
  if [ "${Arquitetura}" == "arm64" ]; then 
      echo "${bold}${lightgreen}==> 🔵 Arquitetura :Alpine Arm64x                                           <=="
    else
      echo "${bold}${lightgreen}==> 🔵 Arquitetura :Alpine AMD64x                                           <=="
  fi
  echo "${bold}${lightgreen}=============================================================================="
  echo "${bold}${lightgreen}==> ✅ Versão Oficial do Entrypoint.sh 1.5                                 <=="
  echo "${bold}${lightgreen}=============================================================================="

  # Dialogo--------------------------------------------------------
    echo "${bold}${lightgreen}==> 🟢 Iniciando Script Entrypoint."
    echo "${bold}${lightgreen}==> 🟠 Iniciando Verificação de Arquivos."
  # Fim Dialogo----------------------------------------------------
   
  # Sistema do Nginx-----------------------------------------------
   if [[ -f "./Status/Nginx_instalador" ]]; then
      echo "${bold}${lightgreen}==> 🟢 Nginx foi detectado, pulando Download."
   else
      echo "${bold}${lightgreen}==> 🔴 Verificador do Nginx ${bold}${vermelho}não foi detectado ${bold}${lightgreen}, Iniciando download."
      mkdir ./Cache
      git clone https://github.com/finnie2006/ptero-nginx ./Cache
      mv ./Cache/nginx ./Nginx
      rm -rf ./Cache
      mkdir ./Status
      curl https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/Leiame.txt  -o ./Status/Leia-me.txt
      touch ./Status/Nginx_instalador
    fi
  # Fim do Nginx---------------------------------------------------

  # Sistema do Nginx Explorador------------------------------------
   if [[ -f "./Status/Explorer_instalador" ]]; then
      echo "${bold}${lightgreen}==> 🟢 Nginx Explorer foi detectado, pulando Download."
   else
      echo "${bold}${lightgreen}==> 🔴 Verificador do Nginx Explorer ${bold}${vermelho}não foi detectado ${bold}${lightgreen}, Iniciando download."
      mkdir ./Explorer
      git clone https://github.com/drylian/nginx-explorer ./Explorer
      touch ./Status/Explorer_instalador
    fi
  # Fim do Nginx Explorador----------------------------------------

  # Sistema das Logs-----------------------------------------------
   if [[ -f "./Status/Pasta_instalador" ]]; then
      echo "${bold}${lightgreen}==> 🟢 Verificador da Logs foi detectado, Executando procedimento padrão da pasta Logs."
      mkdir ./Cache
      mv ./logs/* ./Cache
      rm -r ./logs
      mkdir ./logs >/dev/null
      mv ./Cache/* ./logs
      rm -r ./Cache
   else
      echo "${bold}${lightgreen}==> 🔴 Verificador da Pasta Logs ${bold}${vermelho}não foi detectado ${bold}${lightgreen}, Iniciando download."
      mkdir ./logs >/dev/null
      touch ./Status/Pasta_instalador
    fi
  # Fim das Logs---------------------------------------------------

  # Sistema do default.conf----------------------------------------
    if [[ -f "./Status/Default.conf_instalado" ]]; then
      echo "${bold}${lightgreen}==> 🟢 Default.conf ja carregado, pulando etapa."
    else
      echo "${bold}${lightgreen}==> 🔴 Verificador do Default.conf ${bold}${vermelho}não foi detectado ${bold}${lightgreen}, Iniciando download."
      mkdir ./Arquivos
      rm ./Nginx/conf.d/default.conf
      curl https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/default.conf -o ./Nginx/conf.d/default.conf
      echo "${bold}${lightgreen}==> 🟠 Criando Introdução."
      curl https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/introducao.md -o ./Arquivos/introducao.md
      touch ./Status/Default.conf_instalado
    fi
  # Fim do default.conf--------------------------------------------

  # Permissões-----------------------------------------------------
    echo "${bold}${lightgreen}==> 🟢 Verificação Completa."
    echo "${bold}${lightgreen}==> 🟢 Setando permissões padrões."
    chmod 777 ./*
  # Fim Permissões-------------------------------------------------

  # Limpar Tmp-----------------------------------------------------
    echo "${bold}${lightgreen}==> 🟢 Removendo Arquivos Temporarios "
    rm -rf /home/container/tmp/*
  # Fim Limpar Tmp-------------------------------------------------

  # Dialogo--------------------------------------------------------
    echo "${bold}${lightgreen}==> 🟢 Iniciado Nginx "
    echo "${bold}${lightgreen}==> 🟢 Inicializado com sucesso"
    echo "${bold}${lightgreen}==> 🟢 Finalizando iniciador online"
    echo "${bold}${lightgreen}=============================================================================="
    echo "${bold}${lightgreen}==> 🟢 Final do Entrypoint.sh 1.5                                          <=="
    echo "${bold}${lightgreen}=============================================================================="
  # Fim Dialogo----------------------------------------------------

  # Comando Nginx start--------------------------------------------
    /usr/sbin/nginx -c /home/container/Nginx/nginx.conf -p /home/container/
  # Fim Nginx start------------------------------------------------
  # Dialogo de Erro------------------------------------------------
    echo "${bold}${vermelho}=============================================================================="
    echo "${bold}${vermelho}==    O Entrypoint Foi Finalizao Com Erro, Delete Todas As Pastas Menos     =="
    echo "${bold}${vermelho}==         A Pasta Arquivos e Tente Novamante, Normalmente Resolve.         =="
    echo "${bold}${vermelho}=============================================================================="
  # Fim Dialogo de Erro--------------------------------------------
else
  # Dialogo--------------------------------------------------------
    echo "${bold}${vermelho}=============================================================================="
    echo "${bold}${vermelho}=O Script de Iniciação está Desativado, iniciando sem script(Não recomendado)="
    echo "${bold}${vermelho}=============================================================================="
  # Fim Dialogo----------------------------------------------------
fi

cd /home/container

# Substituir variáveis ​​de inicialização
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Execute o servidor
${MODIFIED_STARTUP}