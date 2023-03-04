package LinkedList is

    type Node;
    type NodePtr is access Node;

    type Node is record
        Number : Integer;
        Power  : Integer;
        Next   : NodePtr := null;
    end record;

    type List is record
        Head : NodePtr := null;
    end record;

    procedure Append
       (L : in out List; Number : in Integer; Power : in Integer);
    -- Add a new node with the given number and power to the end of the list

    procedure Remove
       (L : in out List; Number : in Integer; Power : in Integer);
    -- Remove the first node with the given number and power from the list

    procedure Print (L : in List);
    -- Print the contents of the list

end LinkedList;
