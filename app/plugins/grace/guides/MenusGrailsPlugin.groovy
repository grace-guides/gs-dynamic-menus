package grace.guides

import org.springframework.core.annotation.Order

import grails.plugins.*
import grails.util.Environment

@Order(1001)
class MenuGrailsPlugin extends DynamicPlugin {

    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "2022.1.0 > *"
    def version = "1.0"
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
        "grails-app/views/error.gsp"
    ]

    // TODO Fill in these fields
    def title = "Grace Dynamic Menus" // Headline display name of the plugin
    def author = "Michael Yan"
    def authorEmail = "rain@rainboyan.com"
    def description = '''\
Grace Menu Plugin in the app.
'''
    def profiles = ['web']
    def providedModules = [LanguageModuleDescriptor, MenuModuleDescriptor, MenuItemModuleDescriptor]

    // URL to the plugin's documentation
    def documentation = "http://github.com/grace-guides/gs-dynamic-menus"

    // Extra (optional) plugin metadata

    // License: one of 'APACHE', 'GPL2', 'GPL3'
    def license = "APACHE"

    // Details of company behind the plugin (if there is one)
    def organization = [ name: "Grace guides", url: "http://github.com/grace-guides" ]

    // Any additional developers beyond the author specified above.
    def developers = [ [id: "rainboyan", name: "Michael Yan", email: "rain@rainboyan.com" ]]

    // Location of the plugin's issue tracker.
    def issueManagement = [ system: "JIRA", url: "http://github.com/grace-guides/gs-dynamic-menus/issues" ]

    // Online location of the plugin's browseable source code.
    def scm = [ url: "http://github.com/grails-plugins/grails-foo-plugin" ]

    Closure doWithSpring() { {->
            // TODO Implement runtime spring config (optional)
            webMenuManager(DefaultWebMenuManager)
        }
    }

    void doWithDynamicMethods() {
        // TODO Implement registering dynamic methods to classes (optional)
        String.metaClass.getMenus = { ->
            def webMenuManager = applicationContext.webMenuManager
            webMenuManager.getMenus(delegate)
        }
        String.metaClass.getMenuItems = { ->
            def webMenuManager = applicationContext.webMenuManager
            webMenuManager.getItems(delegate)
        }
    }

    void doWithDynamicModules() {
        // TODO Implement registering dynamic modules to application (optional)
        // Supported Languages
        language(key: 'en_US', title: 'English')
        language(key: 'zh_CN', title: 'Chinese (Simplified Chinese)')
        language(key: 'zh_TW', title: 'Chinese (Traditional Chinese)')
        // Web site Menu
        menu(key: 'about', i18n: 'menu.about', title: 'About US', link: '/about', location: 'topnav') {
            order = 1
            description = 'This is a description'
        }
        menu(key: 'product', i18n: 'menu.product', title: 'Products', link: '/product', location: 'topnav', enabled: "${Environment.isDevelopmentMode()}") {
            params = [id: '100', name: 'product', env: Environment.isDevelopmentMode()]
            description = "This menu enabled: ${Environment.isDevelopmentMode()}"
            order = 2
        }
        menu(key: 'contact', i18n: 'menu.contact', title: 'Contact', link: '/contact', location: 'topnav')
        menu(key: 'help', i18n: 'menu.help', title: 'Help', link: '/help', location: 'footer')
        menu(key: 'application_status', i18n: 'menu.application_status', title: 'Application Status', link: '#', location: 'topnav')
        menuItem(key: 'env', title: "Environment: ${Environment.current.name}", link: '#', menu: 'application_status')
        menuItem(key: 'profile', title: "App profile: ${grailsApplication.config.getProperty('grails.profile')}", link: '#', menu: 'application_status')
        menuItem(key: 'appversion', title: "App version: ${grailsApplication.config.getProperty('info.app.version')}", link: '#', menu: 'application_status')
        menuItem(key: 'grailsversion', title: "Grace version: ${grailsApplication.config.getProperty('info.app.grailsVersion')}", link: '#', menu: 'application_status')
        menuItem(key: 'groovyversion', title: "Groovy version: ${GroovySystem.getVersion()}", link: '#', menu: 'application_status')
        menuItem(key: 'javaversion', title: "JVM version: ${System.getProperty('java.version')}", link: '#', menu: 'application_status')
        menuItem(key: 'reloadingenabled', title: "Reloading active: ${Environment.reloadingAgentEnabled}", link: '#', menu: 'application_status')
        menu(key: 'artefacts', i18n: 'menu.artefacts', title: 'Artefacts', link: '#', location: 'topnav')
        menuItem(key: 'artefact_controllers', title: "Controllers: ${grailsApplication.controllerClasses.size()}", link: '#', menu: 'artefacts')
        menuItem(key: 'domains', title: "Domains: ${grailsApplication.domainClasses.size()}", link: '#', menu: 'artefacts')
        menuItem(key: 'artefact_services', title: "Services: ${grailsApplication.serviceClasses.size()}", link: '#', menu: 'artefacts')
        menuItem(key: 'taglibraries', title: "Tag Libraries: ${grailsApplication.tagLibClasses.size()}", link: '#', menu: 'artefacts')
        menu(key: 'plugins', i18n: 'menu.plugins', title: 'Installed Plugins', link: '#', location: 'topnav')
        applicationContext.getBean('pluginManager').allPlugins.eachWithIndex { plugin, index ->
            menuItem(key: "${plugin.name}", title: "${plugin.name} - ${plugin.version}", link: '#', menu: 'plugins') {
                order = index + 1
            }
        }
    }

}
