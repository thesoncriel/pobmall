package artn.common.controller;

import java.io.File;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import artn.common.FileNameChangeMode;
import artn.common.Property;

public class EmailAction extends DefaultAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7655681120677420365L;	
	
	@Override
	public String write() throws Exception {
		String path = "/upload/";
		
		if (getFileParams().isEmpty() == false) {
			try {
				File file = new File(path);
				if(!file.isDirectory()){
					file.mkdir();
				}
				saveFileToAuto(getDownloadPath() + path, "", FileNameChangeMode.parentheses);
			}catch(Exception e){e.printStackTrace();}	
			
		}
    	email(getParams(), getArrayParams(), getFileParams());
		return SUCCESS;
	}
	
	public String email(Map<String, Object> mParams, Map<String, String[]> maParams,
						Map<String, File[]> mFileParam) throws Exception {
		try {		 
   		 // 프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
           Properties properties = new Properties();
           boolean isSelfMail = "true".equals( prop.get("artn.mail.smtp.self") );
           String sEncoding = prop.get("artn.mail.encoding");
           
           // struts.properties 값을 이용하여 불러올 수 있도록 수정 - 2013.10.12 by jhson
           if ( isSelfMail == false){
           	//구글이나 네이버로 셋팅 
           	properties.put("mail.smtp.socketFactory.port", prop.getInteger("artn.mail.smtp.socketFactory.port") );//네이버 587 구글 465
               properties.put("mail.smtp.starttls.enable", prop.get("artn.mail.smtp.starttls.enable") );  
           }
            properties.put("mail.smtp.port", prop.get("artn.mail.smtp.port") );
			properties.put("mail.smtp.host", prop.get("artn.mail.smtp.host") );
			properties.put("mail.smtp.auth", prop.get("artn.mail.smtp.auth") );
			
           //구글이나 네이버로 셋팅        
           //   props.put("mail.smtp.socketFactory.port", 587);//네이버 587 구글 465
     /*      props.put("mail.smtp.starttls.enable","true");  
           props.put("mail.smtp.port", "587");
           props.put("mail.smtp.host", "smtp.naver.com");
           props.put("mail.smtp.auth", "true");
     */
           //자체메일셋팅
//           props.put("mail.smtp.port", "25");
//           props.put("mail.smtp.host", "mail.artn.kr");
//           props.put("mail.smtp.auth", "true");

           
           Authenticator auth = new Authenticator(){
           	@Override
           	protected PasswordAuthentication getPasswordAuthentication() {
           		Property prop = Property.getInstance();
           		return new PasswordAuthentication(
           				prop.get("artn.mail.userId"),
           				prop.get("artn.mail.userPw")
           		);
           	}
           };

           Session mailSession = Session.getDefaultInstance(properties, auth);
           
           Message msg = new MimeMessage(mailSession);
           String emailFrom = valid.toEmail(maParams, "email");//보내는사람
           System.out.println(emailFrom);
           String emailTo = (mParams.containsKey("email_to") == true)? mParams.get("email_to").toString() : prop.get("artn.mail.sendTo");
           /*Address address = new InternetAddress(emailFrom,emailVO.getFm_name());
           msg.setFrom(address);*/
           //msg.setFrom(new InternetAddress("policejam@naver.com",emailVO.getFm_name()));
           msg.setFrom(new InternetAddress(emailFrom,mParams.get("name").toString()));
           msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo, false));
           
           msg.setSubject("("+mParams.get("category").toString()+") "+mParams.get("contentName").toString());// 제목 설정
           msg.setSentDate(new Date());
      //     msg.setText(emailVO.getFm_contents());
           MimeMultipart multipart = new MimeMultipart();
           
           MimeBodyPart bodypart = new MimeBodyPart();
      
           if ( isSelfMail == false ){
           	//gmail, naver로 했을때!!
           	// FIXME: emailVO가 뭐고 어디에 있나요 ㅠ_ㅠ - 2013.10.12 by jhson
           	/*
           	bodypart.setContent("보낸사람 이메일 : "+emailVO.getFm_email()+"@"+emailVO.getFm_email2()+"\n\n"
	  				+"이름 : "+emailVO.getFm_name()+"\n\n"
	  				+emailVO.getFm_contents(),"text/plain; charset=" + sEncoding);
	  			*/
           }
           else{
           	//자체 메일로 했을때
        	   if(mParams.containsKey("contectus")){
        		   bodypart.setContent("회 사 명 : " + mParams.get("company").toString()+"\n"
          					+"연 락 처 : " + valid.toPhone(maParams, "phone") +"\n"
          					+"사이트 주소 : " + mParams.get("site").toString()+"\n\n"
          					+mParams.get("content").toString(),"text/plain; charset=" + sEncoding);
        	   } else{
        		   bodypart.setContent(mParams.get("content").toString(),"text/html; charset=" + sEncoding);
        	   }               
           }
           multipart.addBodyPart(bodypart);
      //파일첨부    
           if(mFileParam.isEmpty() == true && mFileParam.size() != 0){
	            //FileDataSource fds = new FileDataSource(getDownloadPath() + path+"email" + getParams().get("ori_name"));
           	FileDataSource fds = new FileDataSource(mFileParam.get("file_email")[0]);
	            MimeBodyPart part = new MimeBodyPart();
	            part.setDataHandler(new DataHandler(fds));
	            //part.setFileName(new String(getParams().get("ori_email").toString().getBytes("8859_1"),"euc-kr"));
	            part.setFileName(MimeUtility.encodeText(mParams.get("ori_email").toString()));
	            multipart.addBodyPart(part);
           }
           
           msg.setContent(multipart);
           Transport.send(msg); // 메일 보내기
           
           System.out.println("메일 발송을 완료하였습니다.");
       } catch ( Exception ex ) {ex.printStackTrace();}
		
		return "";
	}
}
