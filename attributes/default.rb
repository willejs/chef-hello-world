default['hello-world']['user'] = 'helloworld'
default['hello-world']['root_dir'] = '/opt/hello-world'
default['hello-world']['package_location'] = 'github.com/willejs/go-hello-world'
default['hello-world']['exec_command'] = '/opt/go/bin/go-hello-world'
default['hello-world']['nginx']['backends'] = []

# override attributes for the nginx cookbook at compile time.
#
# disable the default nginx site
override['nginx']['default_site_enabled']   = false
