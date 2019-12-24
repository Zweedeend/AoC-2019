(* ::Package:: *)

(* ::Text:: *)
(*Written December 23rd, 2019.*)


(* ::Subsubsection:: *)
(*Import*)


(* ::Input:: *)
(*input=ToExpression/@(StringSplit[#,","]&@Flatten[Import[FileNameJoin[{NotebookDirectory[],"Day23Input.txt"}],"Table"]][[1]]);*)
(*input=Thread[Range[0,Length[#]-1]->#&@input];*)


(* ::Input:: *)
(*ClearAll@runIntcode;*)
(*runIntcode[inputList_List,inputValues_List,initialPosition_Integer,initialBase_Integer,OptionsPattern[{"OutputSteps"->False}]]:=*)
(*Module[{*)
(*intcodeProgram,*)
(*stepList={},*)
(*outputValue={},*)
(**)
(*padLengths={1->5,2->5,3->3,4->3,5->4,6->4,7->5,8->5,9->3},*)
(**)
(*i,jump,counter,*)
(**)
(*j,inputValue,*)
(*outputFlag=0,*)
(*inputFlag=0,*)
(*fullOpCode,opCode,parameterModes,parameters,*)
(**)
(*relativeBase=initialBase,memory*)
(*},*)
(*intcodeProgram[n_Integer]:=0;*)
(*Do[intcodeProgram[inputList[[i,1]]]=inputList[[i,2]],{i,Length[inputList]}];*)
(**)
(*i=initialPosition;jump=1;counter=1;*)
(*j=1;*)
(**)
(*While[intcodeProgram[i]!=99,*)
(*fullOpCode=*)
(*PadLeft[IntegerDigits[intcodeProgram[i]],*)
(*IntegerDigits[intcodeProgram[i]][[-1]]/.padLengths];*)
(*opCode=FromDigits[fullOpCode[[-2;;]]];*)
(*parameterModes=Reverse[fullOpCode[[;;-3]]];*)
(*parameters=Table[*)
(*Which[*)
(*parameterModes[[j]]==0,*)
(*intcodeProgram[i+j],*)
(**)
(*parameterModes[[j]]==1,*)
(*i+j,*)
(**)
(*parameterModes[[j]]==2,*)
(*intcodeProgram[i+j]+relativeBase],*)
(*{j,Length[parameterModes]}];*)
(*jump=Length[parameterModes]+1;*)
(**)
(*If[OptionValue["OutputSteps"],*)
(*AppendTo[stepList,*)
(*Table[intcodeProgram[i+j],{j,0,Length[parameterModes]}]]];*)
(**)
(*Which[*)
(*opCode==1,*)
(*intcodeProgram[parameters[[3]]]=intcodeProgram[parameters[[2]]]+intcodeProgram[parameters[[1]]],*)
(**)
(*opCode==2,*)
(*intcodeProgram[parameters[[3]]]=intcodeProgram[parameters[[2]]]*intcodeProgram[parameters[[1]]],*)
(**)
(*opCode==3,*)
(*If[inputFlag==1,*)
(*Return[{#[[1,1,1]]->#[[1,1]]&/@DownValues[intcodeProgram][[;;-2]],i,relativeBase,outputValue,counter}],*)
(**)
(*inputValue=inputValues[[j]];*)
(*intcodeProgram[parameters[[1]]]=inputValue;*)
(*j+=1;*)
(*If[j>Length[inputValues],*)
(*inputFlag=1;]];,*)
(**)
(*opCode==4,*)
(*AppendTo[outputValue,intcodeProgram[parameters[[1]]]];*)
(*outputFlag+=1;*)
(*(*Print[outputValue]*),*)
(**)
(*opCode==5,*)
(*If[intcodeProgram[parameters[[1]]]!=0,*)
(*i=intcodeProgram[parameters[[2]]];*)
(*jump=0],*)
(**)
(*opCode==6,*)
(*If[intcodeProgram[parameters[[1]]]==0,*)
(*i=intcodeProgram[parameters[[2]]];*)
(*jump=0],*)
(**)
(*opCode==7,*)
(*If[intcodeProgram[parameters[[1]]]<intcodeProgram[parameters[[2]]],*)
(*intcodeProgram[parameters[[3]]]=1,*)
(*intcodeProgram[parameters[[3]]]=0],*)
(**)
(*opCode==8,*)
(*If[intcodeProgram[parameters[[1]]]==intcodeProgram[parameters[[2]]],*)
(*intcodeProgram[parameters[[3]]]=1,*)
(*intcodeProgram[parameters[[3]]]=0],*)
(**)
(*opCode==9,*)
(*relativeBase+=intcodeProgram[parameters[[1]]],*)
(**)
(*opCode==99\[Or]i>Length[intcodeProgram],*)
(*Break[]*)
(*];*)
(*counter++;*)
(*If[counter>10000000,*)
(*Print["Infinite Loop"];*)
(*Break[]];*)
(*i+=jump;*)
(*];*)
(*If[intcodeProgram[i]==99,*)
(*Return[{#[[1,1,1]]->#[[1,1]]&/@DownValues[intcodeProgram][[;;-2]],i,relativeBase,outputValue,counter,"Halt"}]];*)
(*If[*)
(*OptionValue["OutputSteps"],*)
(*{outputValue,stepList},*)
(*outputValue]*)
(*]*)


(* ::Subsubsection:: *)
(*Part 1*)


(* ::Input:: *)
(*states=Table[runIntcode[input,{i},0,0],{i,0,49}];*)
(*packetQueue={};*)
(**)
(*Do[*)
(*globalWatch=j;*)
(*states=Table[*)
(*runIntcode[*)
(*states[[i,1]],*)
(*If[Length[#]==0,{-1},#]&@Flatten[Select[packetQueue,#[[1]]==i-1&][[;;,2;;]]],*)
(*states[[i,2]],*)
(*states[[i,3]]],*)
(*{i,Length[states]}];*)
(*packetQueue=Partition[Flatten[states[[;;,4]]],3];*)
(*If[MemberQ[packetQueue[[;;,1]],255],Break[]];*)
(*,{j,10}]*)


(* ::Input:: *)
(*packetQueue*)


(* ::Subsubsection:: *)
(*Part 2*)


(* ::Input:: *)
(*states=Table[runIntcode[input,{i},0,0],{i,0,49}];*)
(*packetQueue={};*)
(*natMemory={};*)
(*zeroPackets={};*)
(**)
(*Do[*)
(*globalWatch=j;*)
(*states=Table[*)
(*runIntcode[*)
(*states[[i,1]],*)
(*If[Length[#]==0,{-1},#]&@Flatten[Select[packetQueue,#[[1]]==i-1&][[;;,2;;]]],*)
(*states[[i,2]],*)
(*states[[i,3]]],*)
(*{i,Length[states]}];*)
(*packetQueue=Partition[Flatten[states[[;;,4]]],3];*)
(*If[*)
(*MemberQ[packetQueue[[;;,1]],255],*)
(*natMemory=packetQueue[[Position[packetQueue,255][[-1,1]],2;;]];*)
(*];*)
(*If[*)
(*Length[packetQueue]==0,*)
(*packetQueue={Join[{0},natMemory]};*)
(*AppendTo[zeroPackets,natMemory[[2]]];*)
(*];*)
(*If[!DuplicateFreeQ[zeroPackets],Print[zeroPackets[[-1]]];Break[]];*)
(*,{j,1000}]*)