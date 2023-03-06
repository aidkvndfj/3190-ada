with Ada.Unchecked_Deallocation;

package polylink is

    type Term;
    type TermPtr is access Term;

    type Term is record -- a 'node' in the polynomial linked list
        Coefficient : Float;
        Exponent    : Integer;
        Next        : TermPtr := null;
    end record;

    type Polynomial is record -- stores the start of the linked list
        Head : TermPtr := null;
    end record;

    type polynomialArray is array (1 .. 5) of Polynomial;
    polyArray : polynomialArray;

    procedure readPOLY;
    -- Read in the coefficent and exponential for the polynomial and add to list

    procedure writePOLY (num : in Integer);
    -- Print the contents of the polynomial at num

    procedure writePOLY (poly : in Polynomial);
    -- Print the contents of the polynomial

    procedure Append
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer);
    -- Add a new term with the given coefficient and exponent to the end of the polynomial

    procedure Add
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer);
    -- Try to add the coefficient to an already existing exponent to the polynomial

    procedure Remove
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer);
    -- Remove the first term with the given coefficient and exponent from the polynomial

    procedure Clear (P : in out Polynomial);
    -- Free the polynomial and set head to null

    function GetPoly (num : in Integer) return Polynomial;
    -- return the polynomial at the num index in the list

    function SortPoly (L : Polynomial) return Polynomial;
    -- Sort a polynomial from biggest to smallest exponent

    function DisplayAll return Boolean;
    -- Print the conents of all the polynomials in the list

    procedure DeleteTerm is new Ada.Unchecked_Deallocation (Term, TermPtr);
    -- used to free a termptr

end polylink;
