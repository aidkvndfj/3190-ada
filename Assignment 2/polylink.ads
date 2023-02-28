package polylink is

    procedure readPOLY;
    procedure writePOLY;

    type Node is record
        number : Float;
        power  : Integer;
        next   : Node;
    end record;

end polylink;
