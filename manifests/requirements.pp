class deltacloud::requirements {

    $system_packages = ['ruby1.9.1-full','g++', 'libxslt1-dev', 'libxml2-dev', 'libxml++2.6-dev', 'sqlite', 'libsqlite3-dev']
    package {$system_packages:
        ensure => installed,
    }

    $ruby_packages = ['thin', 'sinatra', 'rack-accept', 'rest-client', 'sinatra-content-for', 'nokogiri']
    package {$ruby_packages:
        ensure   => installed,
        provider => 'gem',
        require  => Package[$system_packages],
    }

    $deltacloud_version = '1.1.3'
    package {'deltacloud-core':
        ensure   => $deltacloud_version,
        provider => 'gem',
        require  => Package[$ruby_packages],
    }
    
    file {'/usr/bin/deltacloudd':
        ensure  => 'link',
        target  => "/var/lib/gems/1.9.1/gems/deltacloud-core-${deltacloud_version}/bin/deltacloudd",
        require => Package['deltacloud-core'],
    }

}
