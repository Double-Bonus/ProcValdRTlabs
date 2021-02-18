classdef Person

   properties
      Name
      Stogai = Object_heat(0, 0);
      Sienos = Object_heat(0, 0)
      Grindys = Object_heat(0, 0)
      Langai = Object_heat(0, 0)
   end

   methods

      function obj = Person(aName, a1, u1, a2, u2, a3, u3, a4, u4)

          obj.Name = aName;
          obj.Stogai = Object_heat(a1, u1);
          obj.Sienos = Object_heat(a2, u2);
obj.Grindys = Object_heat(a3, u3);
obj.Langai = Object_heat(a4, u4);

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