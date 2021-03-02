classdef EnergyClass

   properties
      Name
      Roof_U
      Wall_U
      Floor_U
      Windows_U
   end

   methods
      function obj = EnergyClass(aName, roof, wall, floor, windows)
        obj.Name = aName;
        obj.Roof_U = roof;
        obj.Wall_U = wall;
        obj.Floor_U = floor;
        obj.Windows_U = windows;
      end
   end
   
   
end