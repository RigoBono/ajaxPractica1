/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function sendData2Back(){
    var nombre=document.getElementById("nombre").value;
    var paterno=document.getElementById("paterno").value;
    var materno=document.getElementById("materno").value;
    
    $.post("urlSuperPro",
    {
        nombre:nombre,
        paterno:paterno,
        materno:materno
    }
    ,
    function(data){
        console.log("Hey tu data");
        console.log(data);
        if(data.resultado===true){
            window.alert("Hey funciono")
        }       
    }
    );
}