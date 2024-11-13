.. _readme:

keepalived Formula
==================

|img_sr| |img_pc|

.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :alt: pre-commit
   :scale: 100%
   :target: https://github.com/pre-commit/pre-commit

Manage keepalived with Salt.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please refer to:

- `how to configure the formula with map.jinja <map.jinja.rst>`_
- the ``pillar.example`` file
- the `Special notes`_ section

Special notes
-------------


Configuration
-------------
An example pillar is provided, please see `pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in `map.jinja`.


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

Note for SELinux:

Inline scripts lead to denials, they must be placed
in a special dir. This formula takes care of that
automatically if SELinux is enabled, so you can
just keep writing them in the config.


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
Removes the configuration of the keepalived service
including configured scripts (if SELinux is enabled) and has a
dependency on `keepalived.service.clean`_.


``keepalived.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the keepalived service and disables it at boot time.



Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``. ::

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.
