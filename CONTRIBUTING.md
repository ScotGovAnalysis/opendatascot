
# CONTRIBUTING #

### Fixing typos

Small typos or grammatical errors in documentation may be edited directly using
the GitHub web interface, so long as the changes are made in the _source_ file.

*  YES: edit a roxygen comment in a `.R` file below `R/`.
*  NO: edit an `.Rd` file below `man/`.

### Prerequisites

Before you make a substantial pull request, you should always file an issue and
make sure someone from the team agrees that it’s a problem. If you’ve found a
bug, create an associated issue and illustrate the bug with a minimal
[reprex](https://www.tidyverse.org/help/#reprex).

### Making pull requests

*  We recommend that you create a Git branch for each pull request (PR).
*  Look at the Travis and AppVeyor build status before and after making changes.
The `README` should contain badges for any continuous integration services used
by the package.
*  We recommend the tidyverse [style guide](http://style.tidyverse.org).
You can use the [styler](https://CRAN.R-project.org/package=styler) package to
apply these styles, but please don't restyle code that has nothing to do with
your PR.
*  We use [roxygen2](https://cran.r-project.org/package=roxygen2).
*  We use [testthat](https://cran.r-project.org/package=testthat). Contributions
with test cases included are easier to accept.
*  For user-facing changes, add a bullet to the top of `NEWS.md` below the
current development version header describing the changes made followed by your
GitHub username, and links to relevant issue(s)/PR(s).
* In the title of your PR, reference the GitHub issue number it relates to.
* Keeping your changes focussed on a single issue will help minimise the
time it takes to review your PR.

### Code of Conduct

This project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
project you agree to abide by its terms.

### Thanks for contributing!

This contributing guide is adapted from the [rOpenSci contributing guide template](https://github.com/ropensci/dotgithubfiles/blob/master/dotgithub/CONTRIBUTING.md).
