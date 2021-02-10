classdef Person

   properties
      Name
      Stogai = Object(Area1, U1)
      Sienos = Object(Area2, U2)
      Grindys = Object(Area3, U3)
      Langai = Object(Area4, U4)
   end

   methods

       function obj = Person(aName, siena, grindys, langai)
          obj.Name = aName;
          obj.Sienos = siena;
          obj.Grindys = grindys;
          obj.Langai = langai;
       end

       function ret = IsGraeme(obj)
           if STRCMP( obj.Name , 'Graeme')
               ret= 1;
           else
               ret= 0;
           end
       end
   end
   
   
end