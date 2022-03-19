package datos;
import java.io.Serializable;
import java.security.spec.KeySpec;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

@SuppressWarnings("serial")
public class Encrypt implements Serializable {

	//Atributos
	private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0abcdefghijklmnopqrstuvwxyz0123456789.$@#/*-+?_&"; //CARACTERES PARA GENERAR LA LLAVE
	private static String secretKeyAES = ""; //1// (1,2) DEBEN SER GENERADAS ALEATORIAMENTE.
	private static String saltAES = ""; //2// DEBEN SER UNICAS PARA C/USUARIO.
	
	//METODOS
    
    //METODO PARA GENERAR ALEATORIAMENTE UNA LLAVE PRIVADA//
  	private static String randomAlphaNumeric(int count) {
  		StringBuilder builder = new StringBuilder();
  		while (count-- != 0) 
  		{
  			int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
  			builder.append(ALPHA_NUMERIC_STRING.charAt(character));
  		}
  		return builder.toString();
  	}
  	
  //METODO PARA GENERAR LA LLAVE PRIVADA
  	public String generarLLave(){
  		//GENERAMOS LA LLAVE
    	String llave = "";
    	llave = Encrypt.randomAlphaNumeric(32);
    	///////////////////////////////////////   
    	return llave;
  	}
  	
  //METODO PARA ENCRIPTAR
    public String getAES(String data, String key) {
        try {
        	//ASIGNAMOS LA LLAVE PRIVADA 
        	Encrypt.secretKeyAES = key;
        	Encrypt.saltAES = key;
        	///////////////////////////
            byte[] iv = new byte[16];
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec keySpec = new PBEKeySpec(secretKeyAES.toCharArray(), saltAES.getBytes(), 65536, 256);
            SecretKey secretKeyTemp = secretKeyFactory.generateSecret(keySpec);
            SecretKeySpec secretKey = new SecretKeySpec(secretKeyTemp.getEncoded(), "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec);
            return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes("UTF-8")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	
  //METODO PARA DESENCRIPTAR
    public String getAESDecrypt(String data, String key) {
        byte[] iv = new byte[16];
        try {
        	//ASIGNAMOS LA LLAVE PRIVADA 
        	Encrypt.secretKeyAES = key;
        	Encrypt.saltAES = key;
        	///////////////////////////
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);
            SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec keySpec = new PBEKeySpec(secretKeyAES.toCharArray(), saltAES.getBytes(), 65536, 256);
            SecretKey secretKeyTemp = secretKeyFactory.generateSecret(keySpec);
            SecretKeySpec secretKey = new SecretKeySpec(secretKeyTemp.getEncoded(), "AES");
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivParameterSpec);
            return new String(cipher.doFinal(Base64.getDecoder().decode(data)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Encrypt enc = new Encrypt();
		String key = "";
		String pwd = "Egonzalez#87.";
		//String pwdEncrypt = "";
		String pwdDecrypt = "";

		//key=enc.generarLLave();
		//System.out.println("Llave generada: "+key);
		//pwdEncrypt = enc.getAES(pwd,key);
		//System.out.println("resultado encrypt: "+pwdEncrypt);
		pwdDecrypt = enc.getAESDecrypt("+kl2U4zJEqOUBrNZ6JcixQ==", "@TaH-Quhs+l1XKcPRI&oU..-3K4mHaI0");
		System.out.println("resultado decrypt: "+pwdDecrypt);
		
		

	}

}
