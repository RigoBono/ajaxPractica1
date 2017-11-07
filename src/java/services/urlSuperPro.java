/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author RigoBono
 */
@WebServlet(name = "urlSuperPro", urlPatterns = {"/urlSuperPro"})
public class urlSuperPro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
       String nombre=request.getParameter("nombre");
       String paterno=request.getParameter("paterno");
       String materno=request.getParameter("materno");

       System.out.println("Hey el nombre es "+nombre);
       System.out.println("Hey el paterno es "+paterno);
       System.out.println("Hey el materno es "+materno);
       
       JSONObject json=new JSONObject();
       json.put("resultado", true);
       response.setContentType("application/json utf-8");
       PrintWriter out=response.getWriter();
       out.print(json.toString());
       destroy();
    }


}
