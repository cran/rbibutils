\name{rbibutils-package}
\alias{rbibutils-package}

\alias{rbibutils}

\docType{package}


\concept{bibliography formats}
\concept{tex}
\concept{latex}
\concept{bibtex}
\concept{biblatex}
\concept{bibentry}
\concept{copac format}
\concept{ads reference format}
\concept{ebi xml}
\concept{endnote}
\concept{endnote xml}
\concept{endnote refer format}
\concept{isi web of science}
\concept{pubmed xml}
\concept{pubmed nbib}
\concept{ris format}
\concept{MODS XML intermediate}
\concept{Word 2007 bibliography format}


\title{
\packageTitle{rbibutils}
}
\description{
\packageDescription{rbibutils}
}
\details{

  Package \pkg{rbibutils} provides an \R port of the \code{bibutils}
  programs plus additional facilities. The main function,
  \code{bibConvert}, offers all conversions between bibliography formats
  supported by library \code{bibutils}.  In addition, package
  \pkg{rbibutils} converts to and from \R's \code{bibentry} Bibtex-based
  bibliography format.

  The core functionality is provided by the \code{bibutils} programs
  which convert between various bibliography formats using a common MODS
  XML intermediate format, see the source cited below.
  
  Currently we provide the function \code{\link{bibConvert}}
  for conversion between supported bibliography formats. For complete
  list of formats supported by the package, see the documentation of
  the original bibutils library.

  \code{\link{readBib}} and \code{\link{writeBib}} import/export BiBTeX
  files.  \code{\link{readBibentry}} and \code{\link{writeBibentry}}
  import/export \R source files in which the references are represented
  by \code{bibentry()} calls. These functions were originally just
  wrappers around \code{bibConvert}. \code{\link{readBib}} has acquired
  additional features, including a direct import (without going through
  \code{bibConvert}) from BiBTeX files.

  All encodings supported by the bibutils library are available for
  \code{\link{bibConvert}}. 

  Further functionality may be provided in future releases, in
  particular, the underlying C functions could be exposed to package
  authors. Further R wrappers may be added, as well. However, the scope
  of the package will remain conversion between formats based on
  \verb{bibutils} and manipulation of the MODS XML intermediate
  format. \pkg{rbibutils} can be used also as an alternative to package
  \pkg{bibtex} (Francois 2020). For bibliography management see package
  \pkg{RefManager} (McLean 2017). For citations in R documentation (Rd
  or roxygen2) see package \pkg{Rdpack} (Boshnakov 2020).
  %
  % The only external dependency is package \pkg{xml2}.
  % 
  % Up to version 1.4 of \pkg{rbibutils} conversion to \code{"bibentry"}
  % was done in \R using package \pkg{xml2}. From version 1.4.1 this
  % conversion is done in the C code, just as all other conversions, so
  % \pkg{xml2} is no longer needed.

  % The legacy R code is still available and conversion between formats
  % not involving bibentry do not need it.  (import) so it could be made
  % \dQuote{suggested} if there is a strong use case for that.
  %
}
\section{Supported input and output formats}{

  Most formats are supported for both input and output, see the listings
  below. A format supported for input can be converted to any of the
  output formats.

  The input is first converted to \emph{MODS XML intermediate}, the
  latter is then converted to the requested output format.
  In \pkg{rbibutils} there are currently two exceptions to this rule.
  First, the conversion from bibtex to bibentry offers the option to
  bypass the conversion to \emph{MODS XML intermediate} and parse
  directly the bibtex file, see \code{\link{readBib}} for details.
  Second, the conversion from \verb{bibentry} to \verb{BibTeX} just uses
  a \verb{print} method provided by \R.

  In the table below column Abbreviation shows the abbreviation for
  arguments \code{informat} and \code{outformat}, column FileExt gives
  the default file extension for that format, column Input (Output)
  contains TRUE if the format is supported for input (output) and FALSE
  otherwise. Column Description gives basic description of the format.

\Sexpr[stage=build,results=rd]{paste("\\\\tabular{lllll}{", paste0(paste("\\\\strong{", colnames(rbibutils::rbibutils_formats), "}", collapse = " \\\\tab ")), "\\\\cr ", paste(rbibutils::rbibutils_formats[ , 1], rbibutils::rbibutils_formats[ , 2], rbibutils::rbibutils_formats[ , 3], rbibutils::rbibutils_formats[ , 4], rbibutils::rbibutils_formats[ , 5], sep = " \\\\tab ", collapse = "\\\\cr "), "\n}")}
  
  \verb{bibentry} is the native \R variant of BibTeX.  It can be input
  directly from an \R source file or from a binary \verb{rds} file. The
  \verb{"rds"} format is a compressed binary format. The \verb{rds} file
  should contain a \verb{bibentry} R object, saved from R with
  \code{saveRDS}.  An R source file should contain one or more bibentry
  instructions, see \code{\link{readBibentry}} for details of the
  contents.

  A \verb{bibentry} object can be written to a file as a binary
  (\verb{"rds"}) object or as an \R source file, see
  \code{\link{bibConvert}} and \code{\link{writeBib}} for details.

  
  ADS is the reference format of the Smithsonian Astrophysical
  Observatory (SAO) and National Aeronautics and Space Administration
  (NASA) Astrophyics Data System.

  For COPAC, see \verb{https://en.wikipedia.org/wiki/Copac}.
  
}


\author{Georgi N. Boshnakov (R code and R port of bibutils),
  Chris Putnam (author of bibutils library)
}
  
% Maintainer: Georgi N. Boshnakov


\note{

  The \code{bibutils} library is included in a number of software
  packages. These include include pandoc and a library for
  Haskell. Executable programs for conversion are available for Linux
  distributions but seem not easily available for Windows. Executable
  and libraries can also be generated out-of-the-box from the
  \code{bibutils} disribution (on Windows under MSYS).

 \pkg{rbibutils} adds conversions to/from \R's bibentry format and
 direct conversion from bibtex, which preserves non-standard fields from
 the bibtex source. There is also improved support for mathematical
 expressions in bibtex files.

}

\references{

  % bibentry:all 
Georgi
N Boshnakov (2020).
\dQuote{Rdpack: Update and Manipulate Rd Documentation Objects.}
\doi{10.5281/zenodo.3925612}, R package version 2.0.0.

 Damiano Fantini (2019).
\dQuote{easyPubMed: Search and Retrieve Scientific Publication Records from PubMed.}
R package version 2.13, \url{https://CRAN.R-project.org/package=easyPubMed}.

 Romain Francois (2014).
\emph{bibtex: bibtex parser}.
R package version 0.4.0.

 Mathew
William McLean (2017).
\dQuote{RefManageR: Import and Manage BibTeX and BibLaTeX References in R.}
\emph{The Journal of Open Source Software}.
\doi{10.21105/joss.00338}.

 Chris Putnam (2020).
\dQuote{Library bibutils, version 6.10.}
\url{https://sourceforge.net/projects/bibutils/}.
% end:bibentry:all
 
}  
\keyword{ package }
\seealso{
  \code{\link{bibConvert} for further details and examples}
}
%\examples{
%}


% documentation for individual functions at
%     https://sourceforge.net/p/bibutils/home/Bibutils/
%
% bib2xml 	convert BibTeX to MODS XML intermediate
% biblatex2xml 	convert BibLaTeX to MODS XML intermediate
% bibdiff 	compare two bibliographies after reading into the bibutils internal format
% copac2xml 	convert COPAC format references to MODS XML intermediate
% end2xml 	convert EndNote (Refer format) to MODS XML intermediate
% endx2xml 	convert EndNote XML to MODS XML intermediate
% isi2xml 	convert ISI web of science to MODS XML intermediate
% med2xml 	convert Pubmed XML references to MODS XML intermediate
% modsclean 	a MODS to MODS converter for testing puposes mostly
% nbib2xml 	convert Pubmed/National Library of Medicine nbib format
%                       to MODS XML intermedidate 
% ris2xml 	convert RIS format to MODS XML intermediate
% xml2ads 	convert MODS XML intermediate
%                       into Smithsonian Astrophysical Observatory
%                            (SAO)/National Aeronautics and Space Administration (NASA) 
%                            Astrophyics Data System
%                       or ADS reference format (converter submitted by Richard Mathar) 
% xml2bib 	convert MODS XML intermediate into BibTeX
% xml2biblatex 	convert MODS XML intermediate into BibLaTeX
% xml2end 	convert MODS XML intermediate into format for EndNote
% xml2isi 	convert MODS XML intermediate to ISI format
% xml2nbib 	convert MODS XML intermediate
%                       to Pubmed/National Library of Medicine nbib format
% xml2ris 	convert MODS XML intermediate into RIS format
% xml2wordbib 	convert MODS XML intermediate into Word 2007 bibliography format
