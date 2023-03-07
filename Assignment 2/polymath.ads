with polylink;
use polylink; -- Using the contents of the polylink package in this package.

package polymath is -- Defining the package named "polymath".

    function addPOLY (a : in Polynomial; b : in Polynomial) return Polynomial;

    function subPOLY (a : in Polynomial; b : in Polynomial) return Polynomial;

    function multPOLY (a : in Polynomial; b : in Polynomial) return Polynomial;

    function evalPOLY (a : in Polynomial; x : in Float) return Float;

end polymath; -- End of the package definition.
