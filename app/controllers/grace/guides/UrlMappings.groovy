package grace.guides

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/about"(view:"/about")
        "/product"(view:"/product")
        "/contact"(view:"/contact")
        "/help"(view:"/help")
        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
