% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmd_to_html.R
\name{rmd_to_html}
\alias{rmd_to_html}
\title{Config some options for Knitr tranlate Rmd file to HTML file}
\source{
\itemize{
    \item \href{https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html}{https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html}
  }
}
\usage{
rmd_to_html(df_print)
rmd_to_html(df_print, keep_md)
}
\arguments{
\item{code_folding}{Enable document readers to toggle the display of R code
chunks. Specify \code{"none"} to display all code chunks (assuming
they were knit with \code{echo = TRUE}). Specify \code{"hide"} to hide all R
code chunks by default (users can show hidden code chunks either
individually or document-wide). Specify \code{"show"} to show all R code
chunks by default.}

\item{fig_width}{Default width (in inches) for figures}

\item{fig_height}{Default height (in inches) for figures}

\item{fig_retina}{Scaling to perform for retina displays (defaults to 2, which
currently works for all widely used retina displays). Set to \code{NULL} to
prevent retina scaling. Note that this will always be \code{NULL} when
\code{keep_md} is specified (this is because \code{fig_retina} relies on
outputting HTML directly into the markdown document).}

\item{keep_md}{Keep the markdown file generated by knitting.}

\item{dev}{Graphics device to use for figure output (defaults to png)}

\item{fig_caption}{\code{TRUE} to render figures with captions}

\item{md_extensions}{Markdown extensions to be added or removed from the
default definition or R Markdown. See the \code{\link[rmarkdown]{rmarkdown_format}} for
additional details.}

\item{self_contained}{Produce a standalone HTML file with no external
dependencies, using data: URIs to incorporate the contents of linked
scripts, stylesheets, images, and videos. Note that even for self contained
documents MathJax is still loaded externally (this is necessary because of
its size).}

\item{df_print}{Method to be used for printing data frames. Valid values
include "default", "kable", "tibble", and "paged". The "default" method
uses a corresponding S3 method of \code{print}, typically
\code{print.data.frame}. The "kable" method uses the
\code{\link[knitr:kable]{knitr::kable}} function. The "tibble" method uses
the \pkg{tibble} package to print a summary of the data frame. The "paged"
method creates a paginated HTML table (note that this method is only valid
for formats that produce HTML). In addition to the named methods you can
also pass an arbitrary function to be used for printing data frames. You
can disable the \code{df_print} behavior entirely by setting the option
\code{rmarkdown.df_print} to \code{FALSE}.}

\item{smart}{Produce typographically correct output, converting straight
quotes to curly quotes, \code{---} to em-dashes, \code{--} to en-dashes, and
\code{...} to ellipses.}

\item{...}{Additional function arguments to pass to the
base R Markdown HTML output formatter \code{\link[rmarkdown]{html_document_base}}}

\item{toc}{Not config option.}

\item{toc_depth}{Not config option.}
}
\value{
Return HTML file in same folder of Rmd file.
}
\description{
This function inherit from \code{rmarkdown::html_document} function to config some options for Knitr tranlate Rmd file to HTML file.
}
\details{
Details for some things.
}
\note{
\itemize{
  \item{Don't run directly.}
  \item{Passing value throught header of Rmd file.
    \describe{
      \item{Example}{}
      \item{}{\preformatted{
---
output: Rb3m::rmd_to_html
  keep_md: yes
---}
      }
    }
  }
}
}
\section{A Custom Section}{


Text accompanying the custom section.
}

\examples{
add_numbers(1, 2) ## returns 3

## don't run this in calls to 'example(add_numbers)'
\dontrun{
add_numbers(2, 3)
}

## don't test this during 'R CMD check'
\donttest{
add_numbers(4, 5)
}

}
\references{
\describe{
    \item{label-1}{text-1}
    \item{label-2}{text-2}
  }
}
\seealso{
\itemize{
  \item \href{https://github.com/BabyMouse/Rb3m}{GitHub: https://github.com/BabyMouse/Rb3m}
  \item \href{http://r-pkgs.had.co.nz/man.html}{http://r-pkgs.had.co.nz/man.html}
}
}
\author{
\describe{
    \item{}{Trát Quang Th<U+1EE5>y}
  }
}
