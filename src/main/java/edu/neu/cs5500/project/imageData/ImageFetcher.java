package edu.neu.cs5500.project.imageData;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class ImageFetcher
 */
@WebServlet("/ImageFetcher")
public class ImageFetcher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageFetcher() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("image/jpeg");
		
		//String pathToWeb = getServletContext().getRealPath(File.separator);
		//System.out.println(pathToWeb);
		String imageType=request.getParameter("param1");
		File f = new File("/Users/surindersokhal/Desktop/photos/"+imageType);
		File[] files=f.listFiles();
		Random random=new Random();
		int num=random.nextInt(files.length);
		while(!files[num].getName().endsWith("jpg")){
			num=random.nextInt(files.length);
		}
		BufferedImage bi = ImageIO.read(files[num]);
		OutputStream out = response.getOutputStream();
		ImageIO.write(bi, "jpg", out);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
