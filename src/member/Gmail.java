package member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		

		return new PasswordAuthentication("moonspub0326@gmail.com", "xpujvwlqtjduxfse");
	}

	
}
