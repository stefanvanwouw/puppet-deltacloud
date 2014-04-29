class deltacloud {
    require deltacloud::requirements

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
