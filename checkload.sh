#PBS -N job_checkload
#PBS -S /bin/bash
#PBS -j oe
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -l walltime=00:20:00
#PBS -A PZS0200

#This script is to check the system utilization and the blocked job information

cd /users/oscgen/xwang/support/batch/load.vs.blocked
# Global Defaults
SYSTEM=$LMOD_SYSTEM_NAME
WEEK=`date +%Y_week%U`

processorusage=`showq -r | tail -5  | grep 'processors in use' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`
nodeusage=`showq -r | tail -5  | grep 'nodes active' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`
nodeusage_percent=`showq -r | tail -5  | grep 'nodes active' | awk -F "(" '{print $NF}' | awk -F ")" '{print $NR}'`
TIME=`date +%T' '%D`

cat <<EOF >>${SYSTEM}_utilization_${WEEK}.dat
-------------------------------------------------------------------------------------
Time: $TIME
The current node utilization on Oakley is $nodeusage_percent
EOF

if [[ -f tmp.txt ]] ; then
rm tmp.txt
fi

/usr/local/sbin/blocked-jobs-summary.py > tmp.txt
total=`cat tmp.txt |grep 'limit' | awk '{sum+=$1} END {print sum}'`

cat <<EOF >>${SYSTEM}_utilization_${WEEK}.dat
The total number of blocked jobs due to batch limit: $total
Detailed information:"
EOF

cat tmp.txt |grep 'limit' >> ${SYSTEM}_utilization_${WEEK}.dat

rm tmp.txt







