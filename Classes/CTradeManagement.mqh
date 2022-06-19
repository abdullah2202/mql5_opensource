#include <Trade/Trade.mqh>

class CTradeManagement{
   private:
      CTrade      trade;
   public:
                  CTradeManagement();
      void        makeTrade(  
                              string setupType, 
                     ENUM_ORDER_TYPE orderType,
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                        );
      void        makeSellTrade(
                              string setupType, 
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                        );
      void        makeBuyTrade(
                              string setupType, 
                              double lot, 
                              double entry, 
                              double tp, 
                              double sl
                         );
};

CTradeManagement::CTradeManagement(){}

CTradeManagement::makeTrade(
      string setupType,
      ENUM_ORDER_TYPE orderType,
      double lot,
      double entry,
      double tp,
      double sl,
){
      trade.PositionOpen(
            _Symbol,
            orderType,
            lot,
            entry,
            sl,
            0,
            setupType + " trade. Magic Number: " + (string) trade.RequestMagic()
      );

      if(trade.ResultRetcode() == 10008 ||
         trade.ResultRetcode() == 10009){
            // Successfully placed trade
      }else{
            // Error placing trade.
            Print((string) GetLastError());
            ResetLastError();
            return;
      }
}

CTradeManagement::makeBuyTrade(
      string setupType,
      double lot,
      double entry,
      double tp,
      double sl,
){
      double tradeEntry = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      makeTrade(setupType,ORDER_TYPE_BUY,lot,tradeEntry,tp,sl);
}

CTradeManagement::makeSellTrade(
      string setupType,
      double lot,
      double entry,
      double tp,
      double sl,
){
      double tradeEntry = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      makeTrade(setupType,ORDER_TYPE_SELL,lot,tradeEntry,tp,sl);
}


