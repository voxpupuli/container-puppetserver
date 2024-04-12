#!/bin/sh

if [ -n "$PUPPET_NODE_TERMINUS" ]; then
  puppet config set node_terminus $PUPPET_NODE_TERMINUS --section master
fi

if [ -n "$PUPPET_EXTERNAL_NODES" ]; then
  puppet config set external_nodes $PUPPET_EXTERNAL_NODES --section master
fi
