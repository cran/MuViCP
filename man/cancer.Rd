\name{cancer}
\alias{cancer}

\title{Wisconsin Breast Cancer Data from UCI website}

\description{
This is part of the Breast Cancer Data, publicly available from the UCI
Machine Learning Datasets webpage at https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+\%28Original\%29
}

\usage{
data(cancer)
}

\details{
  Ten real-valued features are computed for each cell nucleus:

  a) radius (mean of distances from center to points on the perimeter)
  b) texture (standard deviation of gray-scale values)
  c) perimeter
  d) area
  e) smoothness (local variation in radius lengths)
  f) compactness (perimeter^2 / area - 1.0)
  g) concavity (severity of concave portions of the contour)
  h) concave points (number of concave portions of the contour)
  i) symmetry 
  j) fractal dimension ("coastline approximation" - 1)

  The mean, standard error, and "worst" or largest (mean of the three
  largest values) of these features were computed for each image,
  resulting in 30 features.  For instance, field 3 is Mean Radius, field
  13 is Radius SE, field 23 is Worst Radius.

  All feature values are recoded with four significant digits.

  Missing attribute values: none

  Class distribution: 357 benign, 212 malignant	
}

\value{A Data Frame with 569 rows and 32 columns. The first column is
  some sort of serial number, and the second column is the class label
  ('M' for Malignant or 'B' for Benign). The rest of the columns are features.
}

\author{Mohit Dayal}

\references{
  1. O. L. Mangasarian and W. H. Wolberg: "Cancer diagnosis via linear 
  programming", SIAM News, Volume 23, Number 5, September 1990, pp 1 & 18.

  2. William H. Wolberg and O.L. Mangasarian: "Multisurface method of 
  pattern separation for medical diagnosis applied to breast cytology", 
  Proceedings of the National Academy of Sciences, U.S.A., Volume 87, 
  December 1990, pp 9193-9196.

  3. O. L. Mangasarian, R. Setiono, and W.H. Wolberg: "Pattern recognition 
  via linear programming: Theory and application to medical diagnosis", 
  in: "Large-scale numerical optimization", Thomas F. Coleman and Yuying
  Li, editors, SIAM Publications, Philadelphia 1990, pp 22-30.

  4. K. P. Bennett & O. L. Mangasarian: "Robust linear programming 
  discrimination of two linearly inseparable sets", Optimization Methods
  and Software 1, 1992, 23-34 (Gordon & Breach Science Publishers).
}
    
