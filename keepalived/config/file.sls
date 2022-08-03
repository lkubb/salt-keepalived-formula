# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

keepalived-config-file-file-managed:
  file.managed:
    - name: {{ keepalived.lookup.config }}
    - source: {{ files_switch(['keepalived.conf', 'keepalived.conf.j2'],
                              lookup='keepalived-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ keepalived.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        keepalived: {{ keepalived | json }}
