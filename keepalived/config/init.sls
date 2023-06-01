# vim: ft=sls

{#-
    Manages the keepalived service configuration.
    Has a dependency on `keepalived.package`_.

    Note for SELinux:

    Inline scripts lead to denials, they must be placed
    in a special dir. This formula takes care of that
    automatically if SELinux is enabled, so you can
    just keep writing them in the config.
#}

include:
  - .file
