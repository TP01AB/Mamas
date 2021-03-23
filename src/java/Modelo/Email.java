package Modelo;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import Auxiliar.constantes;

public class Email {

    public void enviarCorreo(String para, String mensaje, String asunto) {
        try {
            Properties prop = System.getProperties();

            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.host", constantes.host);
            prop.put("mail.smtp.user", constantes.correo);
            prop.put("mail.smtp.password", constantes.clave);
            prop.put("mail.smtp.port", 587);
            //prop.put("mail.smtp.port",465);
            prop.put("mail.smtp.auth", "true");

            Session sesion = Session.getDefaultInstance(prop, null);

            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress(constantes.correo));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress(para));

            message.setSubject(asunto);
            message.setText(mensaje);

            Transport transport = sesion.getTransport("smtp");

            transport.connect(constantes.host, constantes.correo, constantes.clave);

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
