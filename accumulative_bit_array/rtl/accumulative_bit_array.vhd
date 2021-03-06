--------------------------------------------------------------------------------
-- vhdl_simple library
-- https://github.com/m-kru/vhdl_simple
--------------------------------------------------------------------------------
--
-- Entity: Accumulative bit array.
--
-- Description:
--  This entity works like an accumulative array of 1 bit accumulative
--  registers.
--
--------------------------------------------------------------------------------
-- Copyright (c) 2019 Michal Kruszewski
--------------------------------------------------------------------------------
-- MIT License
--------------------------------------------------------------------------------
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

entity accumulative_bit_array is
  generic (
    G_WIDTH : positive := 32
  );
  port (
    clk_i   : in    std_logic;
    rst_i   : in    std_logic;
    wr_en_i : in    std_logic := '1';
    d_i     : in    std_logic_vector(G_WIDTH - 1 downto 0);
    q_o     : out   std_logic_vector(G_WIDTH - 1 downto 0)
  );
end entity accumulative_bit_array;

architecture rtl of accumulative_bit_array is
    
  signal q_r : std_logic_vector(G_WIDTH - 1 downto 0);

begin

  q_o <= q_r;
  
  accumulate : process (clk_i) is
  begin

    if rising_edge(clk_i) then
      if rst_i = '1' then
        q_r   <= (others => '0');
      elsif wr_en_i = '1' then
        for_each_bit : for i in 0 to G_WIDTH - 1 loop
          if q_r(i) = '0' then
            q_r(i) <= d_i(i);
          end if;
        end loop;
      end if;
    end if;

  end process accumulate;

end architecture rtl;
