Pod::Spec.new do |spec|
    spec.name           = 'NovaMenu'
    spec.version        = '0.0.1'
    spec.license        = { :type => 'MIT' }
    spec.homepage       = 'https://github.com/netizen01/NovaMenu'
    spec.authors        = { 'Netizen01' => 'n01@invco.de' }
    spec.summary        = 'Sweet Menu Thing'
    spec.source         = { :git => 'https://github.com/netizen01/NovaMenu.git',
                            :tag => spec.version.to_s }
    spec.source_files   = 'Source/**/*.swift'
    spec.dependency     'Cartography', '~> 0.6'

    spec.ios.deployment_target  = '8.4'
end
