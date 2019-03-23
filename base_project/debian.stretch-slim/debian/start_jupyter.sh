#!/bin/bash
/usr/bin/supervisord -n &
if [[ ! -z "${JUPYTER_ENABLE_LAB}" ]]; then
    jupyter lab --allow-root $*
else
    jupyter notebook --allow-root $*
fi
