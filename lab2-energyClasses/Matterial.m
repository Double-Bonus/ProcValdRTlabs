classdef Matterial

   properties (Access = public)
      Name
      Conductivity_q
      Price
   end

   methods
      function obj = Matterial(aName, cond, price)
          obj.Name = aName;
          obj.Conductivity_q = cond;
          obj.Price = price;
      end
      
        function cond = getCond(obj)      
          cond = obj.Conductivity_q;
      end
      
   end
   
   
end