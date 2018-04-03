Set up a cron job to check the system load and blocked jobs

Cron job runs every hour

0 * * * * bash -l -c 'qsub /users/oscgen/xwang/support/batch/load.vs.blocked/checkload.sh'

0 * * * * mv job_checkload.* /users/oscgen/xwang/support/batch/load.vs.blocked/

