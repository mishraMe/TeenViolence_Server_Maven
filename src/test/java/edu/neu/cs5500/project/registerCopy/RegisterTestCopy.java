package registration.copy;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Test;
import org.mockito.Mock;

public class RegisterTestCopy {
	
	@Mock
	HttpServletRequest request;
	@Mock
	HttpServletResponse response;

	@Test
	public void testDoGetHttpServletRequestHttpServletResponse() {
		int val1 = 4;
	    int val2 = 2;
	    
	    assertEquals(val1,val2);
	}

}
