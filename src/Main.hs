import System.IO
import System.Hardware.Serialport
import qualified Data.ByteString.Char8 as B 
--import Data.String.Utils

type Modem = SerialPort

main :: IO ()
main = do
  putStrLn "Hi, haskeller!"
  testResult <- testConnect "/dev/modem"
  print testResult
  

testConnect :: String -> IO Bool
testConnect pathToModem = do
  answ <- withSerial pathToModem defaultSerialSettings pingModem
  return $ 
    case (filter (/= '\r') . B.unpack $ answ) of
      "0" -> True
      "OK" -> True
      _ -> False
  where
    pingModem :: Modem -> IO B.ByteString
    pingModem modem = do
      send modem $ B.pack "AT\r"
      answ <- recv modem 10
      return answ