#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export(rng = false)]]
int which_first_equal_A(IntegerVector x, int a, bool not_equal = false) {
  int n = x.length();
  for (int i = 0; i < n; ++i) {
    if (not_equal) {
      if (x[i] != a) {
        return i + 1;
      }
    } else {
      if (x[i] == a) {
        return i + 1;
      }
    }
  }
  return 0;
}

// [[Rcpp::export(rng = false)]]
int which_first_equal_B(IntegerVector x, int a, bool not_equal = false) {
  int n = x.length();
  if (not_equal) {
    for (int i = 0; i < n; ++i) {
      if (x[i] != a) {
        return i + 1;
      }
    }
  } else {
    for (int i = 0; i < n; ++i) {
      if (x[i] == a) {
        return i + 1;
      }
    }
  }
  return 0;
}


/*

/
x <- integer(1e9)
bench::mark(which_first_equal_A(x, 1L),
            which_first_equal_B(x, 1L))
/

*/
