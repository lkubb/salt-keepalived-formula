# vim: ft=sls

{#-
    Starts the keepalived service and enables it at boot time.
    Has a dependency on `keepalived.config`_.
#}

include:
  - .running
