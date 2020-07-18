within Renewables.Examples;
model HydroSimpleVarCon "This a hydro model with only a turbine unit."
  extends Modelica.Icons.Example;
  Components.HydroPlants.HydroDetailed hydroDetailed(
    H_r=2075,
    H_t=5,
    H_i=20,
    L_i=4500,
    Di_i=6,
    Do_i=6,
    H=80,
    L=80,
    D=4,
    h_0=70,
    H_p=300,
    L_p=500,
    Di_p=4,
    Do_p=4,
    H_n=2370,
    Vdot_n=40)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Components.WindPlants.WindSimple windSimple
    "A simple wind turbine unit of rated capacity of "
    annotation (Placement(transformation(extent={{-20,-24},{0,-4}})));
  Components.SolarPlants.PVSimple pVSimple
    annotation (Placement(transformation(extent={{-20,-64},{0,-44}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=1000,
    y_min=4,
    y_max=8) annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise1(
    samplePeriod=1000,
    y_min=700,
    y_max=1100)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  Modelica.Blocks.Math.Gain P_w(k=1000)
    annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
  Modelica.Blocks.Math.Gain P_pv(k=0.5E9)
    annotation (Placement(transformation(extent={{20,-64},{40,-44}})));
  Modelica.Blocks.Continuous.Filter filter1(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-48,-64},{-28,-44}})));
  Modelica.Blocks.Math.Add3 P_l(k2=-1, k3=-1)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Controllers.VarController varController
    annotation (Placement(transformation(extent={{36,56},{56,76}})));
  Modelica.Blocks.Noise.UniformNoise P_ref(
    samplePeriod=1800,
    y_min=0.5e9,
    y_max=2e9)
    annotation (Placement(transformation(extent={{-98,36},{-78,56}})));
  Modelica.Blocks.Sources.RealExpression H_n(y=hydroDetailed.H_n)
    "Hydro constant."
    annotation (Placement(transformation(extent={{0,56},{20,76}})));
  Modelica.Blocks.Sources.RealExpression Vdot_n(y=hydroDetailed.Vdot_n)
    "Nominal discharge."
    annotation (Placement(transformation(extent={{2,42},{22,62}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0.001)
    annotation (Placement(transformation(extent={{-78,60},{-58,80}})));
  Modelica.Blocks.Continuous.Filter filter2(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,-24},{-30,-4}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{4,-88},{16,-76}})));
  Modelica.Blocks.Sources.RealExpression H_n1(y=P_w.y) "Hydro constant."
    annotation (Placement(transformation(extent={{-80,-88},{-60,-68}})));
  Modelica.Blocks.Sources.RealExpression Vdot_n1(y=P_pv.y) "Nominal discharge."
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Sources.RealExpression Vdot_n2(y=hydroDetailed.P_out)
    "Nominal discharge."
    annotation (Placement(transformation(extent={{-76,-106},{-56,-86}})));
  Modelica.Blocks.Sources.Step step(
    height=0.5e9,
    offset=1e9,
    startTime=1000)
    annotation (Placement(transformation(extent={{-94,8},{-74,28}})));
equation
  connect(windSimple.P_w, P_w.u)
    annotation (Line(points={{1,-14},{10,-14},{10,-12},{18,-12}},
                                                color={0,0,127}));
  connect(pVSimple.P_pv, P_pv.u)
    annotation (Line(points={{1,-54},{18,-54}}, color={0,0,127}));
  connect(P_w.y,P_l. u2) annotation (Line(points={{41,-12},{46,-12},{46,-30},{
          58,-30}}, color={0,0,127}));
  connect(P_pv.y,P_l. u3)
    annotation (Line(points={{41,-54},{41,-38},{58,-38}}, color={0,0,127}));
  connect(P_l.y, varController.dP) annotation (Line(points={{81,-30},{86,-30},{
          86,84},{24,84},{24,74},{34,74}}, color={0,0,127}));
  connect(varController.H_n, H_n.y)
    annotation (Line(points={{34,66},{21,66}}, color={0,0,127}));
  connect(varController.Vdot_n, Vdot_n.y) annotation (Line(points={{34,58},{28,
          58},{28,52},{23,52}}, color={0,0,127}));
  connect(limiter.u, varController.u_v) annotation (Line(points={{-80,70},{-80,
          100},{66,100},{66,66},{57,66}}, color={0,0,127}));
  connect(hydroDetailed.u_v, limiter.y)
    annotation (Line(points={{-42,70},{-57,70}}, color={0,0,127}));
  connect(uniformNoise1.y, filter1.u)
    annotation (Line(points={{-59,-54},{-50,-54}}, color={0,0,127}));
  connect(pVSimple.k, filter1.y)
    annotation (Line(points={{-22,-54},{-27,-54}}, color={0,0,127}));
  connect(uniformNoise.y, filter2.u)
    annotation (Line(points={{-59,-14},{-52,-14}}, color={0,0,127}));
  connect(windSimple.v, filter2.y)
    annotation (Line(points={{-22,-14},{-29,-14}}, color={0,0,127}));
  connect(multiSum.u[1], H_n1.y) annotation (Line(points={{4,-79.2},{-38,-79.2},
          {-38,-78},{-59,-78}}, color={0,0,127}));
  connect(multiSum.u[2], Vdot_n1.y) annotation (Line(points={{4,-82},{-42,-82},
          {-42,-90},{-59,-90}}, color={0,0,127}));
  connect(Vdot_n2.y, multiSum.u[3]) annotation (Line(points={{-55,-96},{-26,-96},
          {-26,-84.8},{4,-84.8}}, color={0,0,127}));
  connect(P_ref.y, P_l.u1) annotation (Line(points={{-77,46},{48,46},{48,-22},{
          58,-22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=21600,
      __Dymola_NumberOfIntervals=50000,
      __Dymola_Algorithm="Dassl"));
end HydroSimpleVarCon;
