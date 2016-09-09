Pod::Spec.new do |spec|

    spec.name           = 'NovaMenu'
    spec.version        = '0.1'
    spec.summary        = 'Sweet Menu Thing'

    spec.homepage       = 'https://github.com/netizen01/NovaMenu'
    spec.license        = { :type => 'MIT', :file => 'LICENSE' }
    spec.author         = { 'Netizen01' => 'n01@invco.de' }

    spec.ios.deployment_target  = '8.4'

    spec.source         = { :git => 'https://github.com/netizen01/NovaMenu.git',
                            :tag => spec.version.to_s }
    spec.source_files   = 'Source/**/*.swift'

    spec.dependency     'NovaCore', '~> 0.2'
    spec.dependency     'Cartography'
    spec.dependency     'NovaLines', '~> 0.1'

end
