Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``keepalived``
^^^^^^^^^^^^^^
*Meta-state*.

This installs the keepalived package,
manages the keepalived configuration file
and then starts the associated keepalived service.


``keepalived.package``
^^^^^^^^^^^^^^^^^^^^^^
Installs the keepalived package only.


``keepalived.config``
^^^^^^^^^^^^^^^^^^^^^
Manages the keepalived service configuration.
Has a dependency on `keepalived.package`_.


``keepalived.service``
^^^^^^^^^^^^^^^^^^^^^^
Starts the keepalived service and enables it at boot time.
Has a dependency on `keepalived.config`_.


``keepalived.clean``
^^^^^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``keepalived`` meta-state
in reverse order, i.e.
stops the service,
removes the configuration file and then
uninstalls the package.


``keepalived.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the keepalived package.
Has a dependency on `keepalived.config.clean`_.


``keepalived.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the keepalived service and has a
dependency on `keepalived.service.clean`_.


``keepalived.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the keepalived service and disables it at boot time.


