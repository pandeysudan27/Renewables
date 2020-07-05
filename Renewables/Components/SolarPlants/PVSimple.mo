within Renewables.Components.SolarPlants;
model PVSimple "This is a simple PV unit."

  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin={-32,-38},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation (
    Placement(visible = true, transformation(origin={70,74},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleCell cell(
      useConstantIrradiance=false, constantIrradiance=1000) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,8})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.0137114772)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,36})));
  Modelica.Blocks.Interfaces.RealInput k "Solar irradiance"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.RealExpression P_cell(y=cell.powerGenerating)
    "A single cell will generated a 1 W power."
    annotation (Placement(transformation(extent={{-26,-76},{-6,-56}})));

  Modelica.Blocks.Interfaces.RealOutput P_pv "Solar power output in [Watts]."
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  connect(ground.p, cell.p)
    annotation (Line(points={{-32,-28},{-32,-2}}, color={0,0,255}));
  connect(cell.n, resistor.n) annotation (Line(points={{-32,18},{-24,18},{-24,36},
          {-14,36}}, color={0,0,255}));
  connect(resistor.p, ground.p) annotation (Line(points={{6,36},{10,36},{10,-28},
          {-32,-28}}, color={0,0,255}));
  connect(cell.variableIrradiance, k) annotation (Line(points={{-44,8},{-72,8},{
          -72,0},{-120,0}}, color={0,0,127}));
  connect(P_cell.y, P_pv) annotation (Line(points={{-5,-66},{48,-66},{48,0},{110,
          0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-74,-66},{84,84}}, fileName="modelica://Renewables/Resources/Images/SolarPlants.svg"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Text(lineColor={28,108,200},
          extent={{-148,-68},{152,-108}},
          textStyle={TextStyle.Bold},
          textString="%name
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is a simple PV cell of 1W power for a solar irradiance of 1000W/m^2. </p>
</html>"));
end PVSimple;
