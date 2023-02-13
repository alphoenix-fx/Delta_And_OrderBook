//+------------------------------------------------------------------+
//|                                                    OrderBook.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict



class OrderBook{


   private:
      
      
      double m_Data[];
      int    m_Size;   
      double m_Unique[];
      int    m_UniqueSize;
      double m_NumUnique[];
      int    m_NumUniqueSize;
      long   m_Volume[];
      bool IsUnique(double Val);
      void UpdateNumUnique();
   public: 
         OrderBook();
         ~OrderBook();
         void Insert(double Data,ulong Volume_);
         void ClearBook();
         void dump();
         int SetArraysWithValues(double &UniqueValues[],double &UniqueNumValues[]);
         
         



};

OrderBook::OrderBook(void){
   ArrayResize(m_Data,1);
   m_Data[0]=0;
   
   ArrayResize(m_Unique,1);
   m_Unique[0]=0;
   
   ArrayResize(m_NumUnique,1);
   m_NumUnique[0]=0;
   
   
   
   ArrayResize(m_Volume,1);
   m_Volume[0]=0;
   
   m_Size = 1;
   m_UniqueSize=1;
   m_NumUniqueSize=1;
}

OrderBook::~OrderBook(void){


}
void OrderBook::Insert(double Data, ulong Volume_){

   
   
    
   
   if( IsUnique(Data)){
      
      m_Unique[m_UniqueSize-1] = Data;
      m_UniqueSize= m_UniqueSize+1;
      ArrayResize(m_Unique,m_UniqueSize);
      
      ArrayResize(m_NumUnique,m_UniqueSize);   
   
   }
   
   m_Data[m_Size-1] = Data;
   m_Volume[m_Size-1] = Volume_;
   m_Size = m_Size+1;
   ArrayResize(m_Volume,m_Size);
   ArrayResize(m_Data,m_Size);
   UpdateNumUnique();
   
  
   
   
   
   
   

}
bool OrderBook::IsUnique(double Val){

      bool Truth= true;

      for( int i = 0 ; i<m_Size;i++ ){
      
         if( Val == m_Data[i]){
               Truth = false;
         }
      
      
      }

      return Truth;

}

void OrderBook::dump(void){

     Print( "m_Data:");
     for( int i =0 ; i<m_Size-1 ;i++ ){
     
         Print(m_Data[i]);
     
     }

      
      
     Print("m_UniqueData:");
     for( int i =0 ; i<m_UniqueSize-1 ;i++ ){
     
         Print(m_Unique[i],"---->",m_NumUnique[i]);
     
     }


}


void OrderBook::UpdateNumUnique(void){

   
   
   
 

   
   

                                  
   for( int i = 0 ; i< m_UniqueSize-1 ; i++ ){
  
         
         long count = 0;
         for(int j = 0 ; j<m_Size -1 ; j++){
         
            if( m_Unique[i] == m_Data[j]){
               count += m_Volume[j];
            }
         
         }
         
         //Print(count);
         m_NumUnique[i]= count;
         
         
   }
   


}

int OrderBook::SetArraysWithValues(double &UniqueNumValues[],double &UniqueValues[]){

      
      
      
      
            ArrayResize(UniqueValues,m_UniqueSize);
            for( int i =0 ; i < m_UniqueSize; i++){
                  
               UniqueValues[i] = m_Unique[i];
            
            
            
            }
      
      
      
      
            ArrayResize(UniqueNumValues, m_UniqueSize);
            
            
            for( int i =0 ; i < m_UniqueSize; i++){
                  
               UniqueNumValues[i] = m_NumUnique[i];
            
            
            
            }
      
      
      
      
      
      
      
      
      
      
      
      return m_UniqueSize;

}



void OrderBook::ClearBook(void){

   ArrayResize(m_Data,1);
   m_Data[0]=0;
   
   ArrayResize(m_Unique,1);
   m_Unique[0]=0;
   
   ArrayResize(m_NumUnique,1);
   m_NumUnique[0]=0;
   
   m_Size = 1;
   m_UniqueSize=1;
   m_NumUniqueSize=1;




}