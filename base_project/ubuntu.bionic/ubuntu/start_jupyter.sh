#!/bin/bash
/usr/bin/supervisord -n &
if [[ "${JUPYTER_ENABLE_LAB}" = "yes" ]]; then
        jupyter lab --allow-root $*
elif [[ "${JUPYTER_ENABLE_LAB}" = "pyspark" ]]; then
        pyspark
else
    jupyter notebook --allow-root $*
fi