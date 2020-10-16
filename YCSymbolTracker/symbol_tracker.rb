#!/usr/bin/env ruby

#   symbol_tracker
#
#   Created by ycpeng on 2020/6/11.
#   Copyright © 2020 ycpeng. All rights reserved.

def symbol_tracker(installer)
    pods_project = installer.pods_project
    name = 'YCSymbolTracker'
    symbol_tracker_target = pods_project.targets.find { |t| t.name == name }
    if !symbol_tracker_target.nil?
        pods_target_config(pods_project, name, symbol_tracker_target)
    end
end

def pods_target_config(pods_project, name, symbol_tracker_target)
    symbol_tracker_target
    
    build_settings = Hash[
    'OTHER_CFLAGS' => '-fsanitize-coverage=func,trace-pc-guard',
    'OTHER_SWIFT_FLAGS' => '-sanitize=undefined -sanitize-coverage=func',
    'ENABLE_BITCODE' => 'NO']
    
    isDynamic = symbol_tracker_target.product_type.include?('framework')
    
    if isDynamic
        build_settings['FRAMEWORK_SEARCH_PATHS'] = '${PODS_CONFIGURATION_BUILD_DIR}/' + name
    end
    
    symbol_tracker = symbol_tracker_target.product_reference
    pods_project.targets.each do |target|
        if target.name != name and !target.name.include?('Pods-')
            if isDynamic and !target.instance_of? Xcodeproj::Project::Object::PBXAggregateTarget
                # 添加依赖
                dependency = target.dependency_for_target(symbol_tracker_target)
                if dependency
                    puts "[WARN] Already depended on #{target.name}"
                    else
                    target.add_dependency(symbol_tracker_target)
                end
                # 添加framework
                build_phase = target.frameworks_build_phase
                if build_phase
                    build_phase.add_file_reference(symbol_tracker)
                end
            end
            
            # 修改build_settings
            target.build_configurations.each do |config|
                build_settings.each do |pair|
                    key = pair[0]
                    value = pair[1]
                    if config.build_settings[key].nil?
                        config.build_settings[key] = ['$(inherited)']
                    end
                    if !config.build_settings[key].include?(value)
                        config.build_settings[key] << value
                    end
                end
            end
            
            puts '[Interpose]: ' + target.name + ' success.'
        end
    end
end
