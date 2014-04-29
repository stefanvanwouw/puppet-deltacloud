class deltacloud (
    $environment,
    $bind,
    $providers,
) {
    require deltacloud::requirements
    $provider_key_str = inline_template('<% providers.keys.sort.each do |key| -%><%= key %> <% end -%>')
    $provider_val_str = inline_template('<% providers.keys.sort.each do |key| -%><%= providers[key] %> <% end -%>')
    #$provider_key_str = join(keys($providers), ' ')
    #$provider_val_str = join(values($providers), ' ')

    file {'/etc/default/deltacloud-server':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        content => template('deltacloud/deltacloud-defaults.erb'),
        notify  => Service['deltacloud-server'],
    }

    file {'/etc/init.d/deltacloud-server':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template('deltacloud/deltacloud-server.erb'),
        notify  => Service['deltacloud-server'],
    }

    service {'deltacloud-server':
        ensure  => running,
        require => [File['/etc/default/deltacloud-server'], File['/etc/init.d/deltacloud-server']],
    }
    
}
