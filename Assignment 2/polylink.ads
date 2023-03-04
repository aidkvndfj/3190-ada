with Ada.Unchecked_Deallocation;

package polylink is

    type Term;
    type TermPtr is access Term;

    type Term is record
        Coefficient : Float;
        Exponent    : Integer;
        Next        : TermPtr := null;
    end record;

    type Polynomial is record
        Head : TermPtr := null;
    end record;

    type polynomialArray is array (1 .. 5) of Polynomial;
    polyArray : polynomialArray;

    procedure readPOLY;

    procedure writePOLY (num : in Integer);
    -- Print the contents of the polynomial
    procedure writePOLY (poly : in Polynomial);
    -- Print the contents of the polynomial

    procedure Append
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer);
    -- Add a new term with the given coefficient and exponent to the end of the polynomial

    procedure Remove
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer);
    -- Remove the first term with the given coefficient and exponent from the polynomial

    procedure Clear (P : in out Polynomial);

    function GetPoly (num : in Integer) return Polynomial;

    function SortPoly (L : Polynomial) return Polynomial;

    function DisplayAll return Boolean;

    procedure DeleteTerm is new Ada.Unchecked_Deallocation (Term, TermPtr);

end polylink;
