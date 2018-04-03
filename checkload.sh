#!/bin/bash
##############################################################################
# Chekck the load vs. blocked jobs
# Author:       Summer Wang <xwang@osc.edu>
# Date:         April 2017

# Global Defaults
SYSTEM=$LMOD_SYSTEM_NAME

processorusage=`showq -r | tail -5  | grep 'processors in use' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`
nodeusage=`showq -r | tail -5  | grep 'nodes active' | awk -F "(" '{print $NF}' | awk -F "%)" '{print $NR}'`

if [[ $nodeusage < 80 ]]
then

cat <<EOF >>${SYSTEM}_Utilization.dat
    -- -- -- -- Usage Summary for $SYSTEM -- -- -- --

-- Settings
TIMEOUT_LIMIT = $TIMEOUT_LIMIT
RELEVANT DATE RANGE = $RANGE

-- Statistics for Classes of Jobs
EOF


echo "$nodeusage"
else
echo "this is not right"
fi



