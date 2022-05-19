/**
 * @Author - Mohammad Abdullah 
 * 
 *
 * @brief - A class to deal with time management
 *        - functions include checking for new candles
 *        - and checking if a session is open such as London, NY etc
 * 
 */
class CTimeManagement{
   private:
      datetime    previousM15Timestamp;
      datetime    previousM30Timestamp;
      datetime    previousH1Timestamp;
      datetime    previousH4Timestamp;
      datetime    previousD1Timestamp;
      bool        checkCandleTime(datetime &previousTime, ENUM_TIMEFRAMES timeframe);
   public:
      bool        isNew15MCandle();
      bool        isNew30MCandle();
      bool        isNew1HCandle();
      bool        isNew4HCandle();
      bool        isNew1DCandle();
};

/**
 * @brief Generic function to check if a new candle has started
 * 
 * @param previousTime  - reference variable to previous time
 * @param timeframe     - timeframe of candle to check
 * @return true 
 * @return false 
 */
bool CTimeManagement::checkCandleTime(datetime &previousTime, ENUM_TIMEFRAMES timeframe){
   datetime currentCandleTime = iTime(NULL, timeframe, 0);

   if(previousTime != currentCandleTime){
      previousTime = currentCandleTime;
      return true;
   }
   return false;
}

bool CTimeManagement::isNew15MCandle(){
   return checkCandleTime(previousM15Timestamp, PERIOD_M15);
}

bool CTimeManagement::isNew30MCandle(){
   return checkCandleTime(previousM30Timestamp, PERIOD_M30);
}

bool CTimeManagement::isNew1HCandle(){
   return checkCandleTime(previousH1Timestamp, PERIOD_H1);
}

bool CTimeManagement::isNew4HCandle(){
   return checkCandleTime(previousH4Timestamp, PERIOD_H4);
}

bool CTimeManagement::isNew1DCandle(){
   return checkCandleTime(previousD1Timestamp, PERIOD_D1);
}





