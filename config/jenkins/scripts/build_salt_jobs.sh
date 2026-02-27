#!/bin/bash
#===============================================================================
#         FILE: build_salt_jobs.sh
#       AUTHOR: Celine H.
#      COMMENT: The scripts will loop in your salt repository and collect all saltenv
#               Once the list is fetched it will submit them to Jenkins
#               One job per Grain with the list of saltenv available for the grain in param
#               Create a .env file with the following variables
#               [JENKINS_URL=http://host.plop.local:8080 JENKINS_USER=xxx JENKINS_TOKEN=xxx SALTUSERID=XXXXX]
#===============================================================================

# /srv/saltstack
declare -A SALTBYHOSTS
source .env
function sort_format() {
  myxml=""
  mystring=$1

  # Sort array and remove all duplicates
  uniqs_arr=($(echo "${mystring}" | tr ' ' '\n' | sort -u ))
  # Replace newline by ,
  uniqs_arr=${uniqs_arr//[$'\t\r\n']/,}

  IFS="," read -ra uarr <<<"$uniqs_arr"
  for s in "${uarr[@]}"
  do
    if [[ ! -z $s ]]; then
      myxml+="<string>$s</string>"
    fi
  done
}

function add () {
  gotit=0
  for el in "${!SALTBYHOSTS[@]}"
  do
    if [[ ${el} == $1 ]]; then
      SALTBYHOSTS[$el]+="$2 "
      gotit=1
    fi
  done
  if [[ $gotit == 0 ]]; then
      SALTBYHOSTS[$1]+="$2 "
    fi
}

function clean () {
  i=$1
  i=${i//\'/}
  i=${i//:/}
  i=${i#[[:space:]]}
  i=${i%[[:space:]]}
  i=${i//[[:blank:]]/}
  i=${i//$'\n'/ }
  #return $i
}
RES=`find ~/git/saltstack/ -name top.sls -exec grep -hE -A1 ^[a-z] {} +`

array=()
saltenv=()
tmp_salt=()

# Replacing -- by ,
RES="${RES//--/,}"

IFS=','
cpt=0

for i in $RES
do
  # Removing extra characters from i
  clean ${i}

  IFS=" " read -ra iarray <<<"$i"

  HOST=${iarray[1]/\*/all}
  SE=${iarray[0]}

  add ${HOST} ${SE}

  ((cpt++))
done
echo "## Im Done looping, building the xml job files and submitting them to Jenkins"

for i in "${!SALTBYHOSTS[@]}"
do
  sort_format ${SALTBYHOSTS[$i]}
  echo "Building template for > key: [${i}] value: >> [$myxml]"

  host=${i}
  if [[ ${i} == "all" ]]; then
    host="*"
  fi

  buildJob=$(sed "s/MYHOSTTOREPLACE/${host}/;s|MYSALTENVTOREPLACE|${myxml}|;s/SALTUSERID/${SALTUSERID}/" ./Refresh.xml)

  job_name="Refresh_${i%.*.*}"
  echo ${buildJob} > "${job_name}.xml"

  # Fetching crumbs
  CRUMB=$(curl -s "${JENKINS_USER}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)" -u ${JENKINS_USER}:${JENKINS_TOKEN})

  # Checking if the job already exists
  CHECK=$(curl -X GET -s -o /dev/null -w "%{http_code}" ${JENKINS_URL}/view/all/job/${job_name}/config.xml -u ${JENKINS_USER}:${JENKINS_TOKEN})


  if [[ $CHECK == "200" ]];then
    # This api call will update an existing job
    echo "$CHECK should be okay, we will try to update ${job_name}"
    curl -s -X POST ${JENKINS_URL}/job/${job_name}/config.xml --data-binary @./${job_name}.xml -u ${JENKINS_USER}:${JENKINS_TOKEN} -H "Content-Type:text/xml" -H "$CRUMB" -H "Content-Type:text/xml"
  else
    echo "$CHECK does not seem to be okay, we will try to create ${job_name}"
    # This api call will create the job
    curl -s -X POST "${JENKINS_URL}/createItem?name=${job_name}" -u ${JENKINS_USER}:${JENKINS_TOKEN} --data-binary @./${job_name}.xml -H "Content-Type:text/xml" -H "$CRUMB" -H "Content-Type:text/xml"
  fi
done
