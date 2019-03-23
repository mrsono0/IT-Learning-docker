#!/bin/bash
/usr/bin/supervisord -n &
# if [[ ! -z "${JUPYTER_ENABLE_LAB}" ]]; then
if [[ "${JUPYTER_ENABLE_LAB}" = "yes" ]]; then
        jupyter lab --allow-root $*
elif [[ "${JUPYTER_ENABLE_LAB}" = "pyspark" ]]; then
        echo 'pyspark --allow-root $*'
        pyspark
else
    jupyter notebook --allow-root $*
fi
