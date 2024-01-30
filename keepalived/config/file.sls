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

{%- if keepalived._scripts %}
{%-   for name, contents in keepalived._scripts.items() %}

Configured script {{ name }} is present in libexec dir:
  file.managed:
    - name: {{ keepalived.lookup.libexec | path_join(name ~ ".sh") }}
    - source: {{ files_switch(
                    [name ~ ".sh", "libexec.sh.j2"],
                    config=keepalived,
                    lookup="Configured script " ~  name ~ " is present in libexec dir",
                 )
              }}
    - mode: '0755'
    - user: root
    - group: {{ keepalived.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        keepalived: {{ keepalived | json }}
        contents: {{ contents | json }}
{%-   endfor %}
{%- endif %}

{%- for proto in ["ipv4", "ipv6"] %}
{%-   if keepalived.sysctl[proto ~ "_nonlocal_bind"] is not none %}

net.{{ proto }}.ip_nonlocal_bind:
  sysctl.present:
    - value: {{ keepalived.sysctl[proto ~ "_nonlocal_bind"] is true | int }}
{%-   endif %}
{%- endfor %}
