 import jp.go.aist.rtm.OpenRTMUtil;
 import jp.go.aist.rtm.RTC.port.InPort;
 import jp.go.aist.rtm.RTC.util.DataRef;
 import RTC.TimedShort;
 import RTC.CameraImage;
 import RTC.Time;
 
 //データ、InPortの変数を宣言
 DataRef<TimedShort> indata_id;
 InPort<TimedShort> inport_id;
 
 DataRef<CameraImage> indata_image;
 InPort<CameraImage> inport_image;
 
 public void setup() {
  //ウィンドウサイズを設定
  size(500, 300);
  background(255);
 
  //RTCを"drawGraph"というインスタンス名で生成
  OpenRTMUtil util = new OpenRTMUtil();
  util.createComponent("visualization");
  
  //データの初期化
  TimedShort val1 = new TimedShort();
  indata_id = new DataRef<TimedShort>(val1);
  
  CameraImage val2 = new CameraImage();
  indata_image = new DataRef<CameraImage>(val2);
  
  //InPortを生成
  inport_id = util.addInPort("id", indata_id);
  inport_image = util.addInPort("image", indata_image);
 
 }
 
 int count = 0;
 String id_str = "404";
 boolean detected = false;
 
 public void draw() {
   int id = 404;
   fill(0);         // テキストの色を黒に設定
   textSize(60); 
   
 
  //InPortでデータを受信した時の処理
  if (inport_id.isNew()){
    //受信データの読み込み
    inport_id.read();
    id = indata_id.v.data;
    
    println(id);
    if(detected == true){
      background(255);
      text("Detected!", 100, 125);
      text("ID = " + id_str, 100, 175);
      if(id == 404){
        count += 1;     
      }
      else{
        count = 0;
      }
      if(count > 100){
        detected = false;
      }
    }
    else{
      if(id == 404){
        background(255);
        text("Not Found", 100, 150);
      }
      else{
        detected = true;
        id_str = String.valueOf(id);
        count = 0;
      }
    }
    
  }
 }
