library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.MMIPS_pkg.all;

entity MMIPS_CPU_PC is
  Port (
    clk    : in  STD_LOGIC;
    rst    : in  STD_LOGIC;
    cmd    : out MMIPS_PO_cmd;
    status : in MMIPS_PO_status
    );
end MMIPS_CPU_PC;

architecture RTL of MMIPS_CPU_PC is
  type State_type is (S_Error,
                      S_Init,
                      S_Fetch_wait,
                      S_Fetch,
                      S_Decode,
                      S_Lui,
                      S_Ori,
                      S_Add,
                      S_Addu,
                      S_Addi,
                      S_Addiu,
                      S_And,
                      S_Andi,
                      S_Nor,
                      S_Or,
                      S_Xor,
                      S_Xori,
                      S_Sub,
                      S_Subu,
                      S_Sll,
                      S_Sllv,
                      S_Srl,
                      S_Sra,
                      S_Srav,
                      S_Srlv,
                      S_j,
                      S_jr,
                      S_beq,
                      S_eq,
                      S_bne,
                      S_blez,
                      S_bgez,
                      S_bgtz,
                      S_bltz,
                      S_jal,
                      S_jalr,
                      S_rs,
                      S_bltzal,
                      S_bgezal,
                      S_lw,
                      S_indt,
                      S_addr,
                      S_save,
                      S_sw,
                      S_st,
                      S_slt,
                      S_slti,
                      S_slt1d,
                      S_slt2d,
                      S_slt1t,
                      S_slt2t,
                      S_sltu,
                      S_sltiu,
                      S_it,
                      S_epc1,
                      S_epc2,
                      S_eret
                      );

  signal state_d, state_q : State_type;
begin
  FSM_synchrone : process(clk)
  begin
    if clk'event and clk='1' then
      if rst='1' then
        state_q <= S_Init;
      else
        state_q <= state_d;
      end if;
    end if;
  end process FSM_synchrone;

  FSM_comb : process (state_q, status)
  begin
    state_d <= state_q;
    -- pré-affectation de commandes (cf MMIPS_pkg.vhd)
    cmd <= MMIPS_PO_cmd_zero;
    case state_q is
      when S_Error =>
        state_d <= S_Error;

      when S_Init =>
      -- PC <- 0 + 0
        cmd.ALU_X_sel <= UXS_cst_x00;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP <= AO_plus;
        cmd.PC_we <= true;
        state_d <= S_Fetch_wait;

      when S_Fetch_wait =>
      -- mem[PC]
        cmd.mem_ce <= true;
        state_d <= S_Fetch;

      when S_Fetch =>
      -- IR <- mem_datain
        cmd.IR_we <= true;
        state_d <= S_Decode;

      when S_Decode =>
      -- PC <- PC + 4
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x04;
        cmd.ALU_OP <= AO_plus;
        cmd.PC_we <= true;
        state_d <= S_Init;

       -- case status.IR(31 downto 29) is
         -- when "001" =>
           -- case status.IR(28 downto 26) is
             -- when "111" =>
               -- state_d <= S_Lui;
             -- when "101" =>
              --  state_d <= S_Ori;
              --when others => null;
         -- when others => null;
        --end case;
        if status.it = true then
          state_d <= S_it;

        else
          case status.IR(31 downto 26) is
            when "001111" =>
                state_d <= S_Lui;
            when "001101" =>
                state_d <= S_Ori;
            when "001000" =>
                state_d <= S_Addi;
            when "001001" =>
                state_d <= S_Addiu;
            when "001100" =>
                state_d <= S_Andi;
            when "001110" =>
                state_d <= S_Xori;
            when "000010" =>
                state_d <= S_j;
            when "000100" =>
                state_d <= S_beq;
            when "000101" =>
                state_d <= S_bne;
            when "000110" =>
                state_d <= S_blez;
            when "000111"=>
                state_d <= S_bgtz;
            when "000011"=>
                state_d <= S_jal;
            when "100011"=>
                state_d <= S_lw;
            when "101011"=>
                state_d <= S_sw;
            when "001010"=>
                state_d <= S_slti;
            when "001011" =>
                state_d <= S_sltiu;


            when "000000" =>
                case status.IR(5 downto 0) is
                  when "100000" =>
                      state_d <= S_Add;
                  when "100001" =>
                      state_d <= S_Addu;
                  when "100100" =>
                      state_d <= S_And;
                  when "100111" =>
                      state_d <= S_Nor;
                  when "100101" =>
                      state_d <= S_Or;
                  when "100110" =>
                      state_d <= S_Xor;
                  when "100010" =>
                      state_d <= S_Sub;
                  when "100011" =>
                      state_d <= S_Subu;
                  when "000000" =>
                      state_d <= S_Sll;
                  when "000100" =>
                      state_d <= S_Sllv;
                  when "000010" =>
                      state_d <= S_Srl;
                  when "000011" =>
                      state_d <= S_Sra;
                  when "000111" =>
                      state_d <= S_Srav;
                  when "000110" =>
                      state_d <= S_Srlv;
                  when "001000" =>
                      state_d <= S_jr;
                  when "001001" =>
                      state_d <= S_jalr;
                  when "101010" =>
                      state_d <= S_slt;
                  when "101011" =>
                      state_d <= S_sltu;

                  when others => null;
               end case;
            when "000001" =>
                  case status.IR(20 downto 16) is
                    when "00000" =>
                      state_d <= S_bltz;
                    when "00001" =>
                      state_d <= S_bgez;
                    when "10000" =>
                      state_d <= S_bltzal;
                    when "10001" =>
                      state_d <= S_bgezal;
                    when others => null;
                  end case;
            when others => null;
          end case;
        end if;

      when S_Lui =>
        -- RT <- IR(15..0)||0(16); mem(PC)
        cmd.ALU_X_sel <= UXS_cst_x10;
        cmd.ALU_Y_sel <= UYS_IR_imm16;
        cmd.ALU_OP    <= AO_SLL;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Ori =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16;
        cmd.ALU_OP    <= AO_or;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce   <= true;
        state_d       <= S_fetch;
--------------------------------------------
--------------------------------------------

      when S_Add =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_Addu =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce   <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_Addi =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce    <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_Addiu =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce    <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_And =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_and;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Andi =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16;
        cmd.ALU_OP    <= AO_and;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Nor =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_nor;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Or =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_or;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Xor =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_xor;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Xori =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16;
        cmd.ALU_OP    <= AO_Xor;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Sub =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_moins;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_Subu =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_moins;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        cmd.ALU_extension_signe <= '1';
        state_d       <= S_fetch;

      when S_Sll =>
        cmd.ALU_X_sel <= UXS_IR_SH;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SLL;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Sllv =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SLL;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Srl =>
        cmd.ALU_X_sel <= UXS_IR_SH;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SRL;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Sra =>
        cmd.ALU_X_sel <= UXS_IR_SH;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SRA;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Srav =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SRA;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;

      when S_Srlv =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_SRL;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_fetch;
------------------------------------------------
------------------------------------------------

      when S_j =>
        cmd.ALU_X_sel <= UXS_PC_up;
        cmd.ALU_Y_sel <= UYS_IR_imm26;
        cmd.ALU_OP    <= AO_or;
        cmd.PC_we     <= true;
        state_d       <= S_Fetch_wait;

      when S_jr =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_or;
        cmd.PC_we     <= true;
        state_d       <= S_Fetch_wait;

------------------------------------------------
------------------------------------------------

      when S_beq =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_moins;
        if (status.z = true) then
           state_d    <= S_eq;
        else
           state_d    <= S_Fetch_wait;
        end if;

      when S_eq =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext_up;
        cmd.ALU_OP    <= AO_plus;
        cmd.PC_we     <= true;
        state_d       <= S_Fetch_wait;


      when S_bne =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_moins;

        if (status.z = false) then
           state_d   <= S_eq;
        else
           state_d   <= S_Fetch_wait;
        end if;

      when S_blez =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_cst_x00 ;
        cmd.ALU_OP    <= AO_moins;

        if (status.s = true) or (status.z = true)  then
           state_d   <= S_eq;
        else
          state_d    <= S_Fetch_wait;
        end if;


      when S_bgtz =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_moins;

        if (status.s = false) and (status.z = false) then
           state_d   <= S_eq;
        else
          state_d    <= S_Fetch_wait;
        end if;

      when S_bgez =>
          cmd.ALU_X_sel <= UXS_RF_RS;
          cmd.ALU_Y_sel <= UYS_cst_x00;
          cmd.ALU_OP    <= AO_moins;

          if (status.s = false) or (status.z = true) then
            state_d   <= S_eq;
          else
            state_d   <= S_Fetch_wait;
          end if;

      when S_bltz =>
       cmd.ALU_X_sel <= UXS_RF_RS;
       cmd.ALU_Y_sel <= UYS_cst_x00;
       cmd.ALU_OP    <= AO_moins;

       if (status.s = true)  and (status.z = false) then
         state_d   <= S_eq;
       else
         state_d   <= S_Fetch_wait;
       end if;
------------------------------------------------------------------------
------------------------------------------------------------------------

     when S_jal =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_31;
        cmd.mem_ce    <= true;
        state_d       <= S_j;

      when S_jalr =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        cmd.mem_ce    <= true;
        state_d       <= S_rs;

      when S_rs =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_or;
        cmd.PC_we     <= true;
        state_d       <= S_Fetch_Wait;

     when S_bltzal =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_31;
        cmd.mem_ce    <= true;
        state_d       <= S_bltz;

     when S_bgezal =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_31;
        cmd.mem_ce    <= true;
        state_d       <= S_bgez;

      when S_lw =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_plus;
        cmd.AD_we     <= true;
        state_d       <= S_addr;

      when S_addr =>
        cmd.mem_ce    <= true;
        cmd.mem_we    <= false;
        cmd.ADDR_sel  <= ADDR_from_AD;
        state_d       <= S_indt;

      when S_indt =>
        cmd.DT_we     <= true;
        state_d       <= S_save;

      when S_save =>
        cmd.ALU_X_sel <= UXS_DT;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        state_d       <= S_Fetch_wait;

      when S_sw =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_plus;
        cmd.AD_we     <= true;
        state_d       <= S_st;

      when S_st =>
        cmd.ALU_X_sel <= UXS_cst_x00;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_or;
        cmd.ADDR_sel  <= ADDR_from_AD;
        cmd.mem_ce    <= true;
        cmd.mem_we    <= true;
        state_d       <= S_Fetch_wait;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
      when S_slt =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_moins;

        if (status.s = true) and (status.z = false) then
          state_d     <= S_slt1d;
        else
          state_d     <= S_slt2d;
        end if;

      when S_slt1d =>    --- || 1
        cmd.ALU_X_sel <= UXS_cst_x01;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        state_d       <= S_Fetch_wait;

      when S_slt2d =>    --- || 0
        cmd.ALU_X_sel <= UXS_cst_x00;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RD;
        state_d       <= S_Fetch_wait;

      when S_slt1t =>    --- || 1
        cmd.ALU_X_sel <= UXS_cst_x01;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        state_d       <= S_Fetch_wait;

      when S_slt2t =>    --- || 0
        cmd.ALU_X_sel <= UXS_cst_x00;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_plus;
        cmd.RF_we     <= true;
        cmd.RF_sel    <= RFS_RT;
        state_d       <= S_Fetch_wait;

      when S_slti =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_moins;

        if (status.s = true) and (status.z = false) then
          state_d     <= S_slt1t;
        else
          state_d     <= S_slt2t;
        end if;

     when S_sltu =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_RF_RT;
        cmd.ALU_OP    <= AO_MOINS;

        if (status.c = true) then
          state_d     <= S_slt1d;
        else
          state_d     <= S_slt2d;
        end if;

     when S_sltiu =>
        cmd.ALU_X_sel <= UXS_RF_RS;
        cmd.ALU_Y_sel <= UYS_IR_imm16_ext;
        cmd.ALU_OP    <= AO_MOINS;

        if (status.c = true) then
          state_d     <= S_slt1t;
        else
          state_d     <= S_slt2t;
        end if;

     when S_it =>
        cmd.EPC_we   <= true;
        state_d      <= S_epc1;

     when S_epc1 =>
        cmd.ALU_X_sel <= UXS_PC;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_or;
        cmd.EPC_we    <= true;
        cmd.SR_set    <= true;
        cmd.SR_rst    <= false;
        state_d       <= S_epc2;

      when S_epc2 =>
        cmd.ALU_X_sel <= UXS_IT_vec;
        cmd.ALU_Y_sel <= UYS_cst_x00;
        cmd.ALU_OP    <= AO_or;
        cmd.PC_we     <= true;
        state_d       <= S_eret;

      when S_eret =>
      cmd.ALU_X_sel <= UXS_EPC;
      cmd.ALU_Y_sel <= UYS_cst_x00;
      cmd.ALU_OP    <= AO_or;
      cmd.PC_we     <= true;
      cmd.SR_set    <= false;
      cmd.SR_rst    <= true;
      state_d       <= S_Fetch_wait;


     when others => null;

    end case;
  end process FSM_comb;
end RTL;
