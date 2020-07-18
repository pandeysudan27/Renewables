within Renewables.Controllers;
model VarController "This is a model of a variability controller."
  outer OpenHPL.Data data "Instance of Data class";
  Real u_v_n = 1 "Nominal guide vane opening of hydro turbine.";
  Real eta_h = 0.95 "Hydraulic efficiency of the turbine.";
  Real G_h "Hydro constant";
  Modelica.Blocks.Interfaces.RealOutput u_v "Turbine valve signal."
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput H_n "Nominal head of the plant."
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput dP "P_l-P_pv-P_w"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput Vdot_n "Nominal discharge."
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{16,38},{36,58}})));
  Modelica.Blocks.Sources.RealExpression G(y=G_h) "Hydro constant."
    annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
equation
  G_h = (eta_h/u_v_n)*data.rho*data.g*H_n*Vdot_n;
  connect(dP, division.u1) annotation (Line(points={{-120,80},{-54,80},{-54,54},
          {14,54}}, color={0,0,127}));
  connect(G.y, division.u2) annotation (Line(points={{-31,32},{-10,32},{-10,42},
          {14,42}}, color={0,0,127}));
  connect(division.y, u_v) annotation (Line(points={{37,48},{68,48},{68,0},{110,
          0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-102},{100,100}}, fileName="modelica://Renewables/Resources/Images/VariabilityController.svg")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
              Icon(graphics={Bitmap(extent={{-100,-104},{102,102}}, fileName="modelica://Renewables/Resources/Images/VariabilityController.svg")}));
end VarController;
