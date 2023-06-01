# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

keepalived configuration is managed:
  file.managed:
    - name: {{ keepalived.lookup.config }}
    - source: {{ files_switch(
                    ["keepalived.conf", "keepalived.conf.j2"],
                    config=keepalived,
                    lookup="keepalived configuration is managed",
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ keepalived.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        keepalived: {{ keepalived | json }}
