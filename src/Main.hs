import System.IO
import System.Hardware.Serialport
import qualified Data.ByteString.Char8 as B 

type Modem = SerialPort

main :: IO ()
main = do
  putStrLn "Hi, haskeller!"
  withSerial "/dev/modem" defaultSerialSettings modemTest

modemTest :: Modem -> IO()
modemTest modem = do
  send modem $ B.pack "AT\r"
  recv modem 10 >>= print