#/bin/sh

#
#BOP
#--------------------------------------------------------------------#
# Sistema de Avaliação de Modelos (SAM)                              #
#--------------------------------------------------------------------#
#
# !DESCRIPTION:
# Script para executar o SCAMTEC
#
# !CALLING SEQUENCE:
# ./run_scamtec.sh N
#                  
#  N=1 TestCase utilizando dados do modelo BRAMS 05km para janeiro de 2016
#  N=2 TestCase utilizando dados do G3DVAR para agosto 2014
#  N=3 Configuração do usuário 
#
#
# !Histórico de revisões: 
#      20-05-2016 - Lucas Amarante     - Versão inicial
#      24-05-2016 - Claudio Pavani     - TestCase BRAMS, execução do plot.gpl
#      15-06-2016 - Carlos Bastarz     - Ajustes, padronização e generalizações
#      16-06-2016 - Claudio Pavani     - Acrescentando mais um testeCase
#      04-07-2016 - Lucas Amarante     - Atualizando testcase e outors parametros
#
#
#EOP  
#--------------------------------------------------------------------#
#BOC

# Descomente a linha abaixo para debugar
# set -o xtrace


#--------------------------------------------------------------------#
# Script para rodar os experimentos do SCAMTEC                       #
#--------------------------------------------------------------------#

export gnuplot=/scratchin/grupos/assim_dados/home/gdad/public/gnuplot5/bin/gnuplot

echo ""
echo " <<< INICIANDO TESTCASE SCAMTEC >>> " 
echo ""

#--------------------------------------------------------------------#
# Configuracao inicial das variaveis                                 #
#--------------------------------------------------------------------#

# Define o diretorio atual
dir_act=`pwd`

RUNTM=`date "+%Y%m%d.%H.%M"`
ARQlog=${dir_act}/exec_scamtec_${RUNTM}.log

# Verifica parametros de entrada
if [ -z "${1}" ] 
then
  echo 
  echo " A opcao TestCase nao foi corretamente informada!"
  echo " Uso:"
  echo " ./run_scamtec.sh 1 - para fazer um TestCase do BRAMS (Jan/2016)"
  echo " ./run_scamtec.sh 2 - para fazer um TestCase do G3DVAR (Ago/2014)"
  echo " ./run_scamtec.sh 3 - para usar os dados definidos pelo usuario"
  echo  
  exit 1
else
  export TESTCASE=${1} 
  if [ $TESTCASE -gt 3 ]
  then
    echo 
    echo " A opcao TestCase nao foi corretamente informada!"
    echo " Uso:"
    echo " ./run_scamtec.sh 1 - para fazer um TestCase do BRAMS (Jan/2016)"
    echo " ./run_scamtec.sh 2 - para fazer um TestCase do G3DVAR (Ago/2014)"
    echo " ./run_scamtec.sh 3 - para usar os dados definidos pelo usuario"
    echo 
    echo 
    exit 1
  fi
fi

case $TESTCASE in
[1]) 

#--------------------------------------------------------------------#
# Configuracoes do TestCase BRAMS (NAO ALTERAR!)                     #
#--------------------------------------------------------------------#

# Datas
datai=2016010100
dataf=2016010300
passo_analise=06
passo_previsao=06
total_previsao=36

# Recortes
lat_low=-49.875 
lon_low=-82.625 
lat_up=11.375 
lon_up=-35.375 
dx=0.25  
dy=0.25 

# Quantidade de experimentos
quant_exp=1

# Referencias
# Plugin modelo
pl_model_refer=11

# Arquivo (analise)
arq_refer=/stornext/online8/exp-dmd/OPER.2016/05km/exp5kmM/%y4%m2%d200/grads/BRAMS5.exp5kmM_%y4%m2%d200-A-%y4-%m2-%d2-000000-g1.gra

# Experimento
# Plugin experimento
pl_model_exper=11

# Arquivo (previsao)
arq_prev=/stornext/online8/exp-dmd/OPER.2016/05km/exp5kmM/%y4%m2%d200/grads/BRAMS5.exp5kmM_%iy4%im2%id200-A-%fy4-%fm2-%fd2-%fh20000-g1.gra

# Climatologia
use_climatologia=1

# Precipitacao
use_precipitacao=0

# EOF
use_eof=0
;;

[2])

#--------------------------------------------------------------------#
# Configuracoes do TestCase G3DVAR (NAO ALTERAR!)                    #
#--------------------------------------------------------------------#

# Datas
datai=2014080500
dataf=2014081500
passo_analise=06
passo_previsao=06
total_previsao=72

# Recortes
lat_low=-49.875 
lon_low=-82.625 
lat_up=11.375 
lon_up=-35.375 
dx=0.4  
dy=0.4 

# Quantidade de experimentos
quant_exp=1

# Referencias 
# Plugin modelo
pl_model_refer=1

# Arquivo (analise)
arq_refer=/stornext/online6/assim_dados/luiz.sapucci/testcase_scamtec/exp_global_cptec/TQ0299L064/%y4%m2%d2%h2/GPOSNMC%y4%m2%d2%h2%y4%m2%d2%h2P.icn.TQ0299L064.grb

# Experimento
# Plugin experimento
pl_model_exper=1

# Arquivo (previsao)
arq_prev=/stornext/online6/assim_dados/luiz.sapucci/testcase_scamtec/exp_global_cptec/TQ0299L064/%y4%m2%d2%h2/GPOSNMC%iy4%im2%id2%ih2%fy4%fm2%fd2%fh2P.fct.TQ0299L064.grb


#climatologia
use_climatologia=1

#precipitacao
use_precipitacao=0

#calculo EOF
use_eof=0
;;

 
[3])

#--------------------------------------------------------------------#
# Configuracoes do Usuario (ALTERAR O QUE FOR NECESSARIO)            #
#--------------------------------------------------------------------#

# Datas
datai=2016010100
dataf=2016010500
passo_analise=12
passo_previsao=12
total_previsao=120

# Recortes
lat_low=-49.875 
lon_low=-82.625 
lat_up=11.375 
lon_up=-35.375 
dx=0.4  
dy=0.4 

# Referencias
# Plugin modelo
pl_model_refer=1

# Arquivo (analise)
arq_refer=diretorio_dados

# Experimento
#Plugin experimento
pl_model_exper=1

# Arquivo (previsao)
arq_prev=diretorio_dados

# Climatologia
use_climatologia=1

# Precipitacao
use_precipitacao=0

# EOF
use_eof=0
;;

esac

# Diretorio de saida do resultados
saida_results=${WORK_HOME}/saida_scamtec

if [ ! -e ${saida_results} ]; then mkdir -p ${saida_results}; fi

echo
echo " =====================================     " 
echo " Configuracoes iniciais do Testcase:       " 
echo " =====================================     "  
echo " Data inicial:   ${datai}                  "
echo " Data final:     ${dataf}                  "
echo " Passo analise:  ${passo_analise}          "
echo " Passo previsao: ${passo_previsao}         "
echo " Total previsao: ${total_previsao}         "
echo
echo
echo " Recorte utilizado:                        "
echo " Lat low: ${lat_low}                       "
echo " Lon low: ${lon_low}                       "
echo " Lat up:  ${lat_up}                        "
echo " Lon up:  ${lon_up}                        "
echo
echo " Quantidade de experimentos: ${quant_exp}  "
echo
echo
echo " Num. plugin referencia: ${pl_model_refer} "
echo " Dados referencia (analise):               "
echo " ${arq_refer}                              "
echo
echo " Num. plugin experimento: ${pl_model_exper}"
echo " Dados experimento (previsao):             "
echo " ${arq_prev}                               "
echo
echo "Uso climatologia: ${use_climatologia}      "
echo "Uso precipitacao: ${use_precipitacao}      "
echo "Uso eof:          ${use_eof}               "
echo
echo "Saida resultados:                          "
echo "${saida_results}                           "
echo
echo
echo "  ======================================   " 
echo

#--------------------------------------------------------------------#

data=`date`
 
# Iniciando o processamento
echo "Inicio do processamento: ${data}" >> ${ARQlog}
echo "Inicio do processamento: ${data}"

# Entrando no diretorio do programa principal
cd ${dir_act}/bin

echo ""
echo "Criando o arquivo de configuracao (bin/scamtec.conf)"
echo ""

INPUTDATA='$INPUTDATA'
cat <<EOT1 > scamtec.conf
$INPUTDATA
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!
#                  SCAMTeC - GDAD/CPTEC/INPE - 2010                   !
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!

#======================================================================
#                          Runtime options
#
Starting Time: ${datai}                #Format  :: YYYYMMDDHH
Ending Time:   ${dataf}                #Format  :: YYYYMMDDHH
Analisys Time Step:  ${passo_analise}  #Format  :: HH
Forecast Time Step:  ${passo_previsao} #Format  :: HH
Forecast Total Time: ${total_previsao} #Format  :: HH
History Time:   48                     #Format  :: HH

#======================================================================
#                       DOMAIN SPECIFICATION
# Definition of Running Domain
# Specify the domain extremes in latitude and longitude
#
#              +----------------------------------+
#              |**********************************|
#              |**********************************|
#            L |*************** +--------------+ *|
#            A |*************** |              | *|
#            T |*************** |     Area     | *|
#            I | * +--------+ * |      02      | *|
#            T | * |        | * |              | *|
#            U | * |  area  | * |              | *|
#            D | * |   01   | * |              | *|
#            E | * |        | * +--------------+ *|
#              | * |        | ********************|
#              | * +--------+ ********************|
#              | *********************************|
#              +----------------------------------+
#                        L O N G I T U D E
#

run domain number: 1 # Number of areas to analise 

# domain of each area
#                    AREAS     1               2            3        4          5
#                 	1                 America Sul             Brasil   hemisferio sul  equatorial  norte
run domain lower left lat:     ${lat_low}      # -49.875    # -60.95   #  -35	   # -80    -20	        20
run domain lower left lon:     ${lon_low}      # -82.625    # -82.95   #  -80	   #   0      0	         0	
run domain upper right lat:    ${lat_up}       #  11.375    #  20.95   #   10	   # -20     20	        80
run domain upper right lon:    ${lon_up}       # -35.375    # -33.95   #  -30	   # 360     360       360   
run domain resolution dx:    	${dx}          #   0.25     #    0.1   #  0.4	   # 0.4 
run domain resolution dy:    	${dy}          #   0.25     #    0.1   #  0.4	   # 0.4 

#======================================================================
#                              Files to Analyse
#
#======================================
# Reference File
#
#         Name diretory File_Name_with_mask
#

Reference model: ${pl_model_refer}
Reference file:  ${arq_refer}
Reference label: REFER

#======================================
# Experiment Files
#

Number of Experiments: ${quant_exp}

Experiments:
#ModelId Name Diretory File_Name_with_mask
${pl_model_exper} EXP01 ${arq_prev}
::

#======================================
# Climatology File
#

Use Climatology: ${use_climatologia}	  # 0-do not use, 1-use
# Diretory prefix mask sulfix
Climatology Model Id: 3
Climatology file: /stornext/online6/assim_dados/luiz.sapucci/testcase_scamtec/climatologiaJGM/climatologia50yr.%mc.bin

#======================================
# Precipitation File
#

Use Precipitation: ${use_precipitacao}	# 0-do not use, 1-use
# Diretory prefix mask sulfix
Precipitation Model Id: 5
Precipitation file: /stornext/online6/assim_dados/luiz.sapucci/testcase_scamtec/precipitacao/3B42RT/%y4/3B42RT.%y4.%m2.%d2.%h2z.bin
Define o Range do Histograma: 2                                         # exemplo: 2
Define valor do limite inferior da ultima classe do histograma: 70      # exemplo: 100
Define valor do minimo inferior da primeira classe do histograma: 0     # exemplo: 0
Define qual Precipitacao deseja avaliar: 21                             # exemplo: 16 para TOTAL ou 17 para CONVECTIVE
Define o periodo de acumulo de precpitacao da observacao: 3             # exemplo: 3 
Define o periodo de acumulo de precpitacao do experimento: 24           # exemplo: 24

#======================================
# Calculate EOFs
#
Use EOFs: ${use_eof}	           # 0-do not use, 1-use
Define a quantidade de EOFs: 4     # exemplo: 4

#======================================================================
# OUTPUT
#

Output directory: ${saida_results}
EOT1

echo "Arquivo de configuracao criado com sucesso."
echo 

echo "Copiando scamtec.conf final para a area selecionada e experimento..."  >> ${ARQlog}
echo  >> ${ARQlog}
cat scamtec.conf >> ${ARQlog}                           
echo  >> ${ARQlog}
echo  >> ${ARQlog}

#--------------------------------------------------------------------#

# Executando o SCAMTEC
cd ${dir_act}/bin 

if [ -e scamtec.x ]; then
 echo
 echo "Executando o scamtec.x"
 echo 
 echo "AGUARDE... "
 echo 
#  ./scamtec.x >> ${ARQlog}
  
else
 echo
 echo " ------ WARNING ------ "
 echo
 echo "Programa scamtec.x nao existe! Favor realizar a compilacao.."
 echo
 echo " ------ WARNING ------ "
 echo
 exit 1

fi


if [ $(echo $?) -ne 0 ]; then
  echo "Falha ao executar o SCAMTEC, abortando!"
  exit 2
fi

data=`date`
echo "Final do processo!! ${data}"

echo "============================" >> ${ARQlog}
echo  >> ${ARQlog}
echo "Final do processo: ${data}" >> ${ARQlog}
echo >> ${ARQlog} 

echo 
echo "Log da rodada se encontra no arquivo: ${ARQlog}"
echo "===================================================================================="
echo 
echo "Fim do processo!" 
echo 


echo "Fim do processo.. " >> ${ARQlog}
echo >> ${ARQlog}

#--------------------------------------------------------------------#

# Verificando saida para executar script gpl
ver_scam=`\ls ${saida_results}/*.scam`

div_scam=(${ver_scam// / }); #separa resultados pelo espaço

scam_fn=${div_scam[0]}

if [ ! -z ${scam_fn} ]; then

 # Executando script para plotar os resultados
 echo "Executando o script para plotar os gráficos"
 echo

 cp ${dir_act}/core/plot_scamtec_results.gpl ${saida_results}
 cd ${saida_results}
 ${gnuplot} -c ./plot_scamtec_results.gpl ${datai} ${dataf}
 
 echo "Fim da geração dos gráficos!"
 echo 

 echo "Resultados encontram-se em: ${saida_results}/plot_scamtec_results.eps" 
 echo "Para vizualizar a figura digite evince plot_scamtec_results.eps "
 echo 

else
 
 echo
 echo "Resultados (.scam) nao foram gerados!!"
 echo

fi




exit 0
