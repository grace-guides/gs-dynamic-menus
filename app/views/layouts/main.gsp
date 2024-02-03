<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grace"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <asset:stylesheet src="application.css"/>

    <link id="bootswatch-style" rel="stylesheet" href=""/>

    <g:set var="layoutName" value="main"/>

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" role="navigation">
    <div class="container-fluid">
        <a class="navbar-brand" href="/"><asset:image src="grace.svg" alt="Grace Logo"/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" aria-expanded="false" id="navbarContent">
            <ul class="navbar-nav ms-auto navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                <g:if env="development">
                <g:each var="menu" in="${applicationContext.getBean('webMenuManager').getMenus('topnav')}">
                    <g:set var="items" value="${applicationContext.getBean('webMenuManager').getItems(menu.key)}" />
                    <g:if test="${items}">
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <g:if test="${menu.i18n}"><g:message code="${menu.i18n}" /></g:if><g:else>${menu.title}</g:else> <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <g:each var="item" in="${items}">
                                <li><a class="dropdown-item" href="${item.link}">${item.title}</a></li>
                                </g:each>
                            </ul>
                        </li>
                    </g:if>
                    <g:else>
                        <li class="nav-item">
                            <a class="nav-link" style="padding-top:25px;padding-bottom:25px" href="${menu?.link}"><g:if test="${menu.i18n}"><g:message code="${menu.i18n}" /></g:if><g:else>${menu.title}</g:else></a>
                        </li>
                    </g:else>
                </g:each>
                </g:if>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Management</a>
                    <ul class="dropdown-menu">
                        <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.name } }">
                            <li class="controller">
                                <g:link class="dropdown-item" controller="${c.logicalPropertyName}">
                                    <g:message code="${c.name.uncapitalize()}.label" default="${c.name}"/>
                                </g:link>
                            </li>
                        </g:each>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Languages</a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <g:each var="lang" in="${['en', 'cs', 'da', 'de', 'es', 'fr', 'it', 'ja', 'nb', 'nl', 'pl', 'pt_BR', 'pt_PT', 'ru', 'sk', 'sv', 'th', 'zh_CN', 'zh_TW']}">
                            <g:set var="locale" value="${Locale.forLanguageTag(lang.replace('_', '-'))}"/>
                            <g:set var="paramsWithLang" value="${params + [lang:lang]}"/>
                            <li>
                                <g:link class="dropdown-item" action="${actionName}" params="${paramsWithLang}">
                                    ${locale.getDisplayName(locale)} - (${lang})
                                </g:link>
                            </li>
                        </g:each>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<g:layoutBody/>

<div class="footer" role="contentinfo">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4 col-sm-12">
                <a href="https://github.com/grace-guides" target="_blank">
                    <asset:image src="guides.svg" alt="Grace Guides" class="float-left"/>
                </a>
                <strong class="centered"><a href="https://github.com/grace-guides" target="_blank">Grace Guides</a></strong>
                <p>Building your first Grace app? Looking to add security, or create a Single-Page-App? Check out the <a href="https://github.com/grace-guides" target="_blank">Grace Guides</a> for step-by-step tutorials.</p>

            </div>
            <div class="col-md-4 col-sm-12">
                <a href="http://docs.graceframework.org" target="_blank">
                    <asset:image src="documentation.svg" alt="Grace Documentation" class="float-left"/>
                </a>
                <strong class="centered"><a href="http://docs.graceframework.org" target="_blank">Documentation</a></strong>
                <p>Ready to dig in? You can find in-depth documentation for all the features of Grace in the <a href="http://docs.graceframework.org" target="_blank">User Guide</a>.</p>

            </div>
            <div class="col-md-4 col-sm-12">
                <a href="https://github.com/orgs/grace-community/discussions" target="_blank">
                    <asset:image src="discussion.svg" alt="Grace Community" class="float-left"/>
                </a>
                <strong class="centered"><a href="https://github.com/orgs/grace-community/discussions" target="_blank">Join the Community</a></strong>
                <p>Get feedback and share your experience with other Grace developers in the <a href="https://github.com/orgs/grace-community/discussions" target="_blank">Grace Community</a>.</p>
            </div>
        </div>
    </div>
</div>

<div id="spinner" class="spinner" style="display:none;">
    <div class="d-flex justify-content-center">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
