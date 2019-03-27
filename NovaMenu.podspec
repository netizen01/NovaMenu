Pod::Spec.new do |spec|

    spec.name                   = 'NovaMenu'
    spec.version                = '0.8'
    spec.summary                = 'Sweet Menu Thing'

    spec.homepage               = 'https://github.com/netizen01/NovaMenu'
    spec.license                = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                 = { 'Netizen01' => 'n01@invco.de' }

    spec.ios.deployment_target  = '9.3'

    spec.source                 = { :git => 'https://github.com/netizen01/NovaMenu.git',
                                    :tag => spec.version.to_s }
    spec.source_files           = 'Source/**/*.swift'
    spec.swift_versions         = ['5.0']

    spec.dependency             'NovaCore'
    spec.dependency             'NovaLines'
    spec.dependency             'Cartography'

end
