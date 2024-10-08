# B-Spline
Implementation of B-splines in MATLAB, including the execution of knot insertion and removal processes.
A B-spline mathematical function was implemented in MATLAB to generate curves using seven control points of degree four. Initially, the function produced a smooth curve defined by these control points. To enhance the curve's flexibility, knot insertion was performed, increasing the number of control points to eight. This process allows for finer adjustments to the curve shape without altering its overall structure significantly.

Subsequently, knot removal was conducted to revert the number of control points back to seven. This operation is essential for simplifying the curve representation while maintaining its essential characteristics. However, it's crucial to recognize the differences between degree elevation and degree reduction in B-splines.

In degree elevation, the curve remains similar despite the increase in the degree of the spline function, allowing for smoother transitions and enhanced detail without losing the original shape. This property is particularly advantageous when refining the curve for improved accuracy or aesthetics.

Conversely, achieving a similar curve through degree reduction poses challenges due to the rational nature of the B-spline function. When reducing the degree, some geometric properties of the curve may be lost, leading to potential alterations in shape and continuity. This inherent complexity necessitates careful consideration when working with degree reduction in B-spline functions.
