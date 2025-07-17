%consumoDeCafe/2 -> Empleado, Cant

consumoDeCafe(michael, 2).
consumoDeCafe(dwight,5).
consumoDeCafe(angela,1).
consumoDeCafe(jim,2).
consumoDeCafe(kevin,0).
consumoDeCafe(oscar,1).
consumoDeCafe(toby,30).
consumoDeCafe(phyllis,4).
consumoDeCafe(ryan,2).
consumoDeCafe(kelly,3).
consumoDeCafe(andy,3).
consumoDeCafe(stanley,4).
consumoDeCafe(meredith,1).
consumoDeCafe(erin,0).
consumoDeCafe(darryl,0).
consumoDeCafe(pam, 10000000000).

%importancia/2 -> Dundie, Importancia

importancia(mejorJefeDelMundo,100).
importancia(sensei,5).
importancia(jimothy,10).
importancia(mejorPapa,15).
importancia(mejorMama,15).
importancia(masPequenia,10).
importancia(zapatosBlancos,30).
importancia(masAtractivoDeLaOficina,20).
importancia(mejorCoqueteo,10).
importancia(crucigrama,15).
importancia(peorVendedor,5).
importancia(abejaMasOcupada,10).
importancia(compromisoMasLargo,15).

%tomaMuchoCafe/1 -> Persona
tomaMuchoCafe(Persona):-
    consumoDeCafe(Persona, Tazas),
    Tazas > 10.

ganoDundie(michael, mejorJefeDelMundo).
ganoDundie(dwight, sensei).
ganoDundie(jim, jimothy).
ganoDundie(jim, mejorPapa).
ganoDundie(meredith, mejorMama).
ganoDundie(angela, masPequenia).
ganoDundie(pam, zapatosBlancos).
ganoDundie(ryan, masAtractivoDeLaOficina).
ganoDundie(kelly, mejorCoqueteo).
ganoDundie(stanley, crucigrama).
ganoDundie(oscar, peorVendedor).
ganoDundie(phyllis, abejaMasOcupada).
ganoDundie(meredith, compromisoMasLargo).

%nuncaGano/1 -> Persona
nuncaGano(Persona):-
    empleado(Persona),
    not(ganoDundie(Persona, _)).

empleado(Persona):-
    consumoDeCafe(Persona, _).

%puntaje/3 -> Persona, Dundie, Puntaje
puntaje(Persona, Dundie, Puntaje):-
    consumoDeCafe(Persona, Tazas),
    ganoDundie(Persona, Dundie),
    importancia(Dundie, Importancia),
    Puntaje is Tazas * Importancia.

%ganadorElite/1 -> Persona
ganadorElite(Persona):-
    empleado(Persona),
    forall(ganoDundie(Persona, Premio), esElite(Premio)).

esElite(Premio):-
    importancia(Premio, Importancia),
    Importancia > 14.

ganadorSupremo(Empleado):-
    empleado(Empleado),
    forall(empleado(OtroEmpleado), tienePuntajeMayor(Empleado,OtroEmpleado)).

tienePuntajeMayor(EmpleadoMayor, EmpleadoMenor):-
    puntaje(EmpleadoMayor, _, PuntajeMayor),
    puntaje(EmpleadoMenor, _, PuntajeMenor),
    PuntajeMayor >= PuntajeMenor.

ganoMasDeUnaVez(Empleado):-
    ganoDundie(Empleado, Dundie1),
    ganoDundie(Empleado, Dundie2),
    Dundie1 \= Dundie2.

ganoUnaSolaVez(Empleado):-
    ganoDundie(Empleado, _),
    not(ganoMasDeUnaVez(Empleado)).

%VERSION 1
puesto(pam, ventas, minorista, 20).
puesto(jim, ventas, corporativo, 30).
puesto(michael, gerente, 20, 5).
puesto(pam, recepcionista,_,_).

%VERSION 2.
%ventas/3 -> Nombre, Tipo, Cantidad
ventas(jim, corporativo, 30).
%recepcionista/1 -> NOmbre
recepcionista(pam).
%gerente/3 -> Nombre, Despidos, Contrataciones
gerente(michael, 20, 5).

ganoDundie2(Persona, productividad):-
    ventas(Persona, corporativo, Cantidad),
    Cantidad > 100,
    tomaMuchoCafe(Persona). %Repite lógica

ganoDundie2(Persona, productividad):-
    contabilidad(Persona, Sueldos),
    Sueldos > 200,
    tomaMuchoCafe(Persona). %Repite lógica

%bono/2 -> Persona, Bono
bono(Persona, 100):-
    recepcionista(Persona).

%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCTORES

nacimiento(pam, 10, 5, 1986).
%nacimiento2/2 -> Nombre, Fecha
nacimiento2(pam, fecha(10, 5, 1986)).

%performance/2 -> Nombre, Performance/Rol
performance(pam, ventas(20, minorista)).
performance(jim, ventas(30, corporativo)).
performance(dwight, ventas(200, corporativo)).
performance(michael, gerente(5, 20)).
performance(kevin, contabilidad(200)).
performance(pam, recepcionista).

ganoDundie(Persona, productividad):-
    tomaMuchoCafe(Persona),
    performance(Persona, Performance),
    esBuenPerformance(Performance).

esBuenPerformance(ventas(Cantidad, corporativo)):-
    Cantidad > 100.

esBuenPerformance(ventas(_, minoristas)).
esBuenPerformance(contabilidad(Sueldos)):-
    Sueldos > 200.
esBuenPerformance(recepcionista).
esBuenPerformance(gerente(Contratados, Despedidos)):-
    Contratados > Despedidos.

bono(Persona, Bono):-
    performance(Persona, Performance),
    bonoSegun(Performance, Bono).

bonoSegun(recepcionista, 100).
bonoSegun(contabilidad(Sueldos), Sueldos).
bonoSegun(gerente(Contrataciones, _), Bono):-
    Bono is Contrataciones * 20.
bonoSegun(ventas(_, minorista), 50).
bonoSegun(ventas(Cantidad, corporativo), 1):-
    Cantidad < 100.
bonoSegun(ventas(Cantidad, corporativo), 100):-
    Cantidad >= 100.
