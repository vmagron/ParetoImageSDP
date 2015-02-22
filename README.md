ParetoImageSDP
==============

*ParetoImageSDP* is a set of libraries using the Yalmip and Gloptipoly toolboxes for MATLAB.
It provides functions to compute semidefinite approximations of 

1) Pareto curves (see paretosdp/) implementing the three methods described in:
Victor Magron, Didier Henrion and Jean-Bernard Lasserre “Approximating Pareto curves using semidefinite relaxations”
(on the [arxiv](http://arxiv.org/abs/1403.5899))

2) Images of semialgebraic sets under polynomial applications (see imagesdp/) implementing the two methods described in 
Victor Magron, Didier Henrion and Jean-Bernard Lasserre “Semidefinite approximations of projections and polynomial images of semialgebraic sets”
(on [Optimization Online](http://www.optimization-online.org/DB_HTML/2014/10/4606.html))


Requirements
------------

Matlab

Yalmip [Download](http://users.isy.liu.se/johanl/yalmip/pmwiki.php?n=Main.Download)

Mosek  [Download](https://mosek.com/resources/downloads)


Documentation
-------------

See 

1) `paretosdp/examples/ex11_4.m` and `paretosdp/examples/test4.m`

2) `imagesdp/exists/ex11_4_exists.m`

for some example-based documentation.


Warning
-------

*This is a preliminary implementation and the probability of finding bugs is high.*

Do not hesitate to submit bug report of pull requests.


License
-------

*ParetoImageSDP* is released under the terms of CeCILL license.
This license is compatible with the GNU GPL license.

See the files LICENSE.en or LICENCE.fr for more information.




