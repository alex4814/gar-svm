# RBF-AR(p)
RBF-AR(p) is a learning model that is a combination of *[Radial Basis Function(RBF)][1]* and *AutoRegressive(AR)* with order *p*, as noted *[AR(p)][2]*.

[1]: https://en.wikipedia.org/wiki/Radial_basis_function
[2]: https://en.wikipedia.org/wiki/Autoregressive_model

Latest version can be found here: www.bruceluo.net

## Introduction
RBF-AR(p) is devised for learning a data model when individual feature and time series analysis are both taken into consideration.

Let's take weather prediction as a simple example. To predict whether it is going to rain tomorrow, we could collect and calculate some related feature data like temperature, humidity, saturated humidity, etc. Also, it is helpful if we consider the facts that whether it rained yesterday, the day before yesterday, and so forth. We need thus benefits from both features to train the regression model.

RBF-AR(p) does that training and prediction for you if only both individual features and time series values are provided.


## Package Structure
The whole package consists of several files each is a function.

The core functionality is supported by following functions:

- **gartrain**
- **gartune**
- **garpredict**

Others are just helper functions for internal use and you can simply ignore them.


## Demo
We have written a complete demo to illustrate how to use RBF-AR(p) step by step. It's a tutorial that you may have a first look at. See *demo.html* under folder *demo* for details.


## Licence
RBF-AR(p), as a whole package, is licensed under GNU GPL v2.0. Read LICENSE for more details.

## Contact
If you have any question in applying RBF-AR(p), please don't hesitate to contact us.
Homepage: www.bruceluo.net
Email: luozhiling@zju.edu.cn, alex4814.fu@gmail.com




