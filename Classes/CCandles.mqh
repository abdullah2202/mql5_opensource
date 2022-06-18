class CCandles{
   private:
      ENUM_TIMEFRAMES   mTimeframe;
      string            mSymbol;
   public:
                        CCandles();
      void              setTimeframe(ENUM_TIMEFRAMES timeframe);
      ENUM_TIMEFRAMES   getTimeframe();
      void              setSymbol(string symbol);
      string            getSymbol();
      double            getOpen(int shift);
      double            getHigh(int shift);
      double            getLow(int shift);
      double            getClose(int shift);
      double            getBid();
      double            getAsk();

};

// Constructor
CCandles::CCandles(){
   mTimeframe = PERIOD_M30;
   mSymbol = _Symbol;
}

void CCandles::setTimeframe(ENUM_TIMEFRAMES timeframe){
   mTimeframe = timeframe;
}

ENUM_TIMEFRAMES CCandles::getTimeframe(){
   return mTimeframe;
}

void CCandles::setSymbol(string symbol){
   mSymbol = symbol;
}

string CCandles::getSymbol(){
   return mSymbol;
}

double CCandles::getOpen(int shift = 0){
   return iOpen(mSymbol, mTimeframe, shift);
}

double CCandles::getHigh(int shift = 0){
   return iHigh(mSymbol, mTimeframe, shift);
}

double CCandles::getLow(int shift = 0){
   return iLow(mSymbol, mTimeframe, shift);
}

double CCandles::getClose(int shift = 0){
   return iClose(mSymbol, mTimeframe, shift);
}

double CCandles::getBid(){
   return SymbolInfoDouble(_Symbol, SYMBOL_BID);
}

double CCandles::getAsk(){
   return SymbolInfoDouble(_Symbol, SYMBOL_ASK);
}