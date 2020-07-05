within Renewables.Controllers;
model VarController
  "Guide valve signal for hydro turbine based on solar and wind variability"
  Modelica.Blocks.Interfaces.RealInput dP
    "Power difference that should be balanced by hydro. dP = P_l -(P_pv+P_w)"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

  Modelica.Blocks.Interfaces.RealInput H_n "Nominal head of the hydro plant."
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput Vdot_n
    "Nominal discharge of the hydro plant."
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Real G_h "Hydro constant";
  Modelica.Blocks.Sources.RealExpression valveSignal(y=u_v)
    "Turbine valve signal for hydro power plant."
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Modelica.Blocks.Interfaces.RealOutput u_v "Turbine's valve signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  G_h = (0.95/0.95)*999.65*9.8*H_n*Vdot_n;
  u_v = dP/G_h;

  connect(valveSignal.y, u_v)
    annotation (Line(points={{-11,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-104},{104,100}},fileName="modelica://Renewables/Resources/Images/VariabilityController.svg"),
        Text(lineColor={28,108,200},
          extent={{-150,-138},{150,-178}},
          textStyle={TextStyle.Bold},
          textString="%name
")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end VarController;
