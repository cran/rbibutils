bibtexImport <- function(infile, ..., tex = NULL, encoding = NULL, options, extra = FALSE){
    ## informat is always "bibtex"
    stopifnot(length(list(...)) == 0) # no ... arguments allowed

    outfile <- tempfile(fileext = ".R")
    on.exit(unlink(outfile))

    argv_2be <- c("dummy")

    if(!is.null(encoding)){
        if(length(encoding) == 1)
            encoding <- rep(encoding, 2)

        if(encoding[1] == "UTF-8" || encoding[1] == "default")
            encoding[1] <- "utf8"
        if(encoding[2] == "UTF-8" || encoding[2] == "default")
            encoding[2] <- "utf8"
                                             
        argv_2be <- c(argv_2be, "-i", encoding[1])
        argv_2be <- c(argv_2be, "-o", encoding[2])
    }

    if(!is.null(tex)){
        for(tex_op in tex){
            switch(tex_op,
                   keep_tex_chars = {  #  Georgi
                       argv_2be <- c(argv_2be, "--keep-tex-chars") 
                   },
                   no_latex = { # accents to letters    # TODO: this needs further work
                       argv_2be <- c(argv_2be, "-nl") 
                   },
                   ## uppercase = {
                   ##     argv_2be <- c(argv_2be, "-U")
                   ## },
                   brackets = {
                       argv_2be <- c(argv_2be, "-b")
                   },
                   dash = {
                       argv_2be <- c(argv_2be, "-sd")
                   },
                   comma = {
                       argv_2be <- c(argv_2be, "-fc")
                   },
                   ## default
                   stop("unsupported 'tex' option")
                   )
        }
    }
    
    if(!missing(options)){
        nams <- names(options)
        ## options <- as.vector(options)
        for(j in seq_along(options)){
            switch(nams[j],
                   i = { argv_2be <- c(argv_2be, "-i", options[j]) },
                   o = { argv_2be <- c(argv_2be, "-o", options[j]) },
                   ## oxml = {argv_2xml <- c(argv_2xml, "-o", options[j])},
                   h = {argv_2be <- c(argv_2be, "-h")},
                   v = {argv_2be <- c(argv_2be, "-v")},
                   a = {argv_2be <- c(argv_2be, "-a")},
                   s = {argv_2be <- c(argv_2be, "-s")},
                   u = {argv_2be <- c(argv_2be, "-u")},
                   U = {argv_2be <- c(argv_2be, "-U")},
                   un = {argv_2be <- c(argv_2be, "-un")},
                   x = {argv_2be <- c(argv_2be, "-x")},
                   nl = { argv_2be <- c(argv_2be, "-nl") },
                   d = { argv_2be <- c(argv_2be, "-d") },
                   c = {argv_2be <- c(argv_2be, "-c", options[j])},
                   ## as = {argv_2be <- c(argv_2be, "-as", options[j])},
                   nt = {argv_2be <- c(argv_2be, "-nt")},
                   verbose = {argv_2be <- c(argv_2be, "--verbose")},
                   debug = {
                       argv_2be <- c(argv_2be, "--debug")
                   },
                   
                   ##default
                   stop("unsupported option '", nams[j])
                   )
        }
    }

    argv_2be <- c(argv_2be, infile)
    argc_2be <- as.integer(length(argv_2be))

    n_2be <- as.double(0)  # for the number of references (double)

    prg <- paste0("bib", "2be")
    argv_2be[1] <- prg
    wrk_out <- .C(C_bib2be_main, as.integer(argc_2be), argv_2be, outfile, nref_in = n_2be)

    bibe <- readBibentry(outfile, extra = extra)

    bibe
}
