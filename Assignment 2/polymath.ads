with polylink;
use polylink; -- Using the contents of the polylink package in this package.

package polymath is -- Defining the package named "polymath".

    function addPOLY
       (a : in Polynomial; b : in Polynomial)
        return Polynomial; -- Defining a function named "addPOLY" that takes two input parameters of type Polynomial and returns a Polynomial.
    function subPOLY
       (a : in Polynomial; b : in Polynomial)
        return Polynomial; -- Defining a function named "subPOLY" that takes two input parameters of type Polynomial and returns a Polynomial.
    function multPOLY (a : in Polynomial; b : in Polynomial) return Polynomial;

end polymath; -- End of the package definition.
