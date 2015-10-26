name 'hello-world'
maintainer 'Will Salt'
maintainer_email 'williamejsalt@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures hello-world'
long_description 'Installs/Configures hello-world'
version '0.1.0'

# I dont trust community cookbooks obeying the semver standard.
depends 'docker', '= 2.1.20'
depends 'nginx', '= 2.7.6'
