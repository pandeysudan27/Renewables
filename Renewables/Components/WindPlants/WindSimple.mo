within Renewables.Components.WindPlants;
model WindSimple "This is a simple wind turbine unit."

  Modelica.Blocks.Interfaces.RealInput v "Wind velocity"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput P_w "Value of Real output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  WindPowerPlants.Plants.GenericVariableSpeed plant
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
equation
  connect(v, plant.v)
    annotation (Line(points={{-120,0},{-14,0}}, color={0,0,127}));
  connect(P_w, plant.power)
    annotation (Line(points={{110,0},{58,0},{58,11},{4,11}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-74,-66},{84,84}}, fileName=
              "modelica://Renewables/Resources/Images/WindPowerPlants.svg"),
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
end WindSimple;
