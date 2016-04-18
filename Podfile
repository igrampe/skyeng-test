platform :ios, '8.0'
xcodeproj 'SkyEngTest'

inhibit_all_warnings!

def data_pods
    pod 'EasyMapping', '~> 0.15.3'
    pod 'Realm', '~> 0.98.8'
end

def network_pods
    pod 'AFNetworking', '~> 2.6.1'
    pod 'AFNetworkActivityLogger', '~> 2.0.4'
end

def analytics_pods
end

def ui_pods
    pod 'PureLayout', '~> 3.0.1'
    pod 'SVProgressHUD'
    pod 'UIAlertView+Blocks'
    pod 'SDWebImage'
    pod 'PureLayout'
end

def sdk_pods

end

def fabric_pods
    # pod 'Fabric'
    # pod 'Crashlytics'
end

target 'SkyEngTest' do
    data_pods
    network_pods
    analytics_pods
    ui_pods
    sdk_pods
    fabric_pods
end
