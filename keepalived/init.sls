# vim: ft=sls

{#-
    *Meta-state*.

    This installs the keepalived package,
    manages the keepalived configuration file
    and then starts the associated keepalived service.
#}

include:
  - .package
  - .config
  - .service
