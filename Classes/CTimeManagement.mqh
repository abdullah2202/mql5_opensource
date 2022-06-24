class CTimeManagement{
   private:
      datetime    previousM5Timestamp;
      datetime    previousM15Timestamp;
      datetime    previousM30Timestamp;
      datetime    previousH1Timestamp;
      datetime    previousH4Timestamp;
      datetime    previousD1Timestamp;
      bool        checkCandleTime(datetime &previousTime, ENUM_TIMEFRAMES timeframe);
      bool        checkSessionTime(string startTimeStr, string endTimeStr);
   public:
      bool        isNew5MCandle();
      bool        isNew15MCandle();
      bool        isNew30MCandle();
      bool        isNew1HCandle();
      bool        isNew4HCandle();
      bool        isNew1DCandle();
      bool        isLondonSession();
      bool        isNewYorkSession();
      bool        isAsianSession();
      bool        isTokyoSession();
      bool        isSydneySession();
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

bool CTimeManagement::isNew5MCandle(){
   return checkCandleTime(previousM5Timestamp, PERIOD_M5);
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

bool CTimeManagement::checkSessionTime(string startTimeStr, string endTimeStr){
   string currentDateStr = TimeToString(TimeGMT(),TIME_DATE);
   datetime startTime = StringToTime(currentDateStr + " " + startTimeStr);
   datetime endTime = StringToTime(currentDateStr + " " + endTimeStr);
   datetime currentTime = TimeGMT();
   
   if(startTime < endTime){
      if(currentTime >= startTime && currentTime < endTime){
         return true;
      }
   }

   if(startTime >= endTime){
      if(currentTime >= startTime || currentTime < endTime){
         return true;
      }
   }

   return false;
}

bool CTimeManagement::isLondonSession(){
   return checkSessionTime("07:00:00", "16:00:00");
}

bool CTimeManagement::isNewYorkSession(){
   return checkSessionTime("12:00:00", "20:00:00");
}

bool CTimeManagement::isAsianSession(){
   return checkSessionTime("23:00:00", "08:00:00");
}

bool CTimeManagement::isTokyoSession(){
   return checkSessionTime("23:00:00", "08:00:00");
}

bool CTimeManagement::isSydneySession(){
   return checkSessionTime("22:00:00", "05:00:00");
}

