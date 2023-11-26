with Ada.Text_IO; use Ada.Text_IO;
with Mlengine.Operators;
with Orka;
use Orka;

package body Mlengine.Utilities is
    procedure Test is
        LWeights : Tensor;
        LBias : Tensor;
        LInput : Tensor;

        Tensor1 : Tensor;

        --ReLU vars
        R_Activated : Tensor;
        R_Test_Input : Tensor;
        R_dY : Tensor;
    begin  
        LWeights.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));
        LWeights.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));

        LBias.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));
        LBias.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));

        LInput.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));
        LInput.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));

        Tensor1.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));
        Tensor1.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, 2.0, 3.0, 4.0), (2, 2)));

        --relu's activation tensor
        R_Activated.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((0.0, 0.0, 0.0, 0.0), (2, 2)));
        R_Activated.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((0.0, 0.0, 0.0, 0.0), (2, 2)));

        --relu test input data
        R_Test_Input.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, -2.0, 3.0, -4.0), (2, 2)));
        R_Test_Input.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, -2.0, 3.0, -4.0), (2, 2)));

        --relu's dY tensor
        R_dY.Data := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((0.0, 0.0, 0.0, 0.0), (2, 2)));
        R_dY.Grad := new ST_CPU.CPU_Tensor'(ST_CPU.To_Tensor ((1.0, -2.0, 3.0, -4.0), (2, 2)));
        


        declare
            --ReLU object
            R : aliased Mlengine.Operators.ReLU_T := (Activated => R_Activated);
            --relu tensor to print and show output
            R_Tensor : ST_CPU.CPU_Tensor := R.Forward(R_Test_Input);

            --relu tensor to print and show backward output
            R_Tensor_2 : ST_CPU.CPU_Tensor := R.Backward(R_dY);


            L : aliased Mlengine.Operators.Linear_T := (LWeights, LBias, LInput);
            Tensor : ST_CPU.CPU_Tensor := L.Backward(Tensor1);
            Params : Mlengine.Operators.ParamsArray := L.Get_Params; 
        begin
            Put_Line(Params(1).Data.Image);
            Put_Line(Tensor.Image);

            --print returned dY grad (works but at this pt ReLU already changed)
            Put_Line(R_Tensor_2.Image);
            --done in place
            Put_Line(R.Activated.Data.Image);

            
        end;
    end;
end Mlengine.Utilities;
