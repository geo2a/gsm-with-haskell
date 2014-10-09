module Utils.Helpers (
  testConnect,
  sendSMS
) where

import System.IO
import System.Hardware.Serialport
import qualified Data.ByteString.Char8 as B 

-- | This type represents GSM modem connected to serial port
type Modem = SerialPort

---------------Testing Connection---------------
-- | Test the connection with modem by sending it "AT"
-- | The argument is string containing path to modem`` (like /dev/ttyUSB0)
-- | In case of success modem may answer with either "0\r" or "OK\r"
-- | depending on it's internal state 
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

---------------Sending SMS---------------
type PhoneNumber = String
sendSMS :: PhoneNumber -> String -> String -> IO()
sendSMS pn msg pathToModem = do
  withSerial pathToModem defaultSerialSettings f
  where
    f :: Modem -> IO () 
    f modem = do
      send modem $ B.pack $ "AT+CMGS=\"" ++ pn ++ "\""
      send modem $ B.pack $ "\r" ++ msg ++ "\r"
      return ()