#PBS -N checkload
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

processorusage=`showq -r | tail -5  | grep 'processors in use' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`
nodeusage=`showq -r | tail -5  | grep 'nodes active' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`
nodeusage_percent=`showq -r | tail -5  | grep 'nodes active' | awk -F "(" '{print $NF}' | awk -F ")" '{print $NR}'`
TIME=`date +%T' '%D`

cat <<EOF >>${SYSTEM}_Utilization.dat
-------------------------------------------------------------------------------------
Time: $TIME
The current node utilization on Oakley is $nodeusage_percent
EOF

if [[ -f tmp.txt ]] ; then
rm tmp.txt
fi

/usr/local/sbin/blocked-jobs-summary.py >tmp.txt
total=`cat tmp.txt |grep 'HARD' | awk '{sum+=$1} END {print sum}'`
echo "The total number of blocked jobs due to hard limit: $total" >> ${SYSTEM}_Utilization.dat
echo "Detailed information:"
cat tmp.txt |grep 'HARD' >> ${SYSTEM}_Utilization.dat
rm tmp.txt







