default['hello-world']['user'] = 'helloworld'
default['hello-world']['nginx']['backends'] = ['127.0.0.1']
default['hello-world']['nginx']['backend_port'] = '8484'

# override attributes for the nginx cookbook at compile time.
#
# disable the default nginx site
override['nginx']['default_site_enabled'] = false
