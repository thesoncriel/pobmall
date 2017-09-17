package artn.common.controller;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map.Entry;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import artn.common.FileNameChangeMode;

/**
 * 
 * @author shkang<br/>
 * 파일 업로드 기능을 지원 해주는 액션 클래스
 * @class
 */
public abstract class AbsUploadActionController extends AbsSubDataActionController {
	
	/**
	 * @ignore
	 */
	private static final long serialVersionUID = 950957033370120610L;
	private String[] saExt = new String[]{"jpg","gif","png","bmp"};
	/**
	 * 파일이 저장되는 download의 위치를 확인한다.
	 * @return
	 */
	public String getDownloadPath(){
		return prop.get("artn.common.downloadPath");//realPath;
	}
	/**
	 * 저장되는 파일명을 유지 또는 변경 한다.
	 * @param path
	 * @param mode overwrite: 덮어쓰기. parentheses: 파일명에 (카운트). underbar: 파일명에 _카운트. nowdatetime: 파일명에 _[날짜시간]
	 * @return
	 */
	public String getFilePathFormat(String path, FileNameChangeMode mode){
		String fileExt = path.substring(path.lastIndexOf("."), path.length());
		switch(mode){
			case overwrite: return path;
			case parentheses: return path.replace(fileExt, "(%1$s)" + fileExt);
			case underbar: return path.replace(fileExt, "_%1$s" + fileExt);
			case nowdatetime: return path.replace(fileExt, "_[" + new SimpleDateFormat("yyyy_MM_dd_hh_mm_ss").format(new Date()) + "]" + fileExt );
		}
		
		return null;
	}
	/**
	 * 폴더 생성 및 파일을 저장한다.<br/>
	 * 같은 이름의 파일이 존재 할 경우 파일명을 mode에 따라 변경한다.
	 * @param file
	 * @param savePath 파일이 저장되는 위치
	 * @param mode overwrite: 덮어쓰기. parentheses: 파일명에 (카운트). underbar: 파일명에 _카운트. nowdatetime: 파일명에 _[날짜시간]
	 * @return
	 * @throws IOException
	 */
	public String saveFile(File file, String savePath, FileNameChangeMode mode) throws IOException {
		if ((file == null) ||
				(file.getName().equals("") == true) ||
				(file.length() <= 0)) return null;
		
		File destFile = new File(savePath);
		String sFormattedPath = getFilePathFormat(savePath, mode);
		int iFileNum = 0;
		
		if (destFile.getParentFile().exists() == false){
			destFile.getParentFile().mkdirs();
		}
		
		if (mode == FileNameChangeMode.overwrite){
			if (destFile.exists() == true){
				destFile.delete();
			}
		}
		else{
			while(destFile.exists() == true){
				destFile = new File( String.format(sFormattedPath, iFileNum) );
				++iFileNum;
			}
		}
		
		FileInputStream inStrm = new FileInputStream(file);
		FileOutputStream outStrm = new FileOutputStream(destFile);
		int bytesRead = 0;
		byte[] buffer = new byte[1024];
		
		while((bytesRead = inStrm.read(buffer, 0, 1024)) != -1){
			outStrm.write(buffer, 0, bytesRead);
		}
		
		outStrm.close();
		inStrm.close();
		
		return destFile.getName();
	}
	/**
	 * 폴더 생성 및 파일을 저장한다.<br/>
	 * 이미지인 경우 썸네일을 생성한다.<br/>
	 * 같은 이름의 파일이 존재 할 경우 파일명을 mode에 따라 변경한다.
	 * @param commonSavePath
	 * @param mode
	 * @throws IOException
	 */
	public void saveFileToAuto(String commonSavePath, FileNameChangeMode mode) throws IOException{
		saveFileToAuto(commonSavePath, "", mode);
	}
	/**
	 * 폴더 생성 및 파일을 저장한다.<br/>
	 * 이미지인 경우 썸네일을 생성한다.<br/>
	 * 같은 이름의 파일이 존재 할 경우 파일명을 mode에 따라 변경한다.
	 * @param commonSavePath
	 * @param commonFileNamePrefix
	 * @param mode
	 * @throws IOException
	 */
	public void saveFileToAuto(String commonSavePath, String commonFileNamePrefix, FileNameChangeMode mode) throws IOException{
		Iterator<Entry<String, File[]>> entryIter = getFileParams().entrySet().iterator();
		Entry<String, File[]> entry = null;
		File file = null;
		File[] files = null;
		String sAfterFileName, sBeforeFileName;
		String sFileNameKey, sOriNameKey;
		String sPrefix = (commonFileNamePrefix.equals("") == false)? commonFileNamePrefix + '_' : "";
		String[] saFileName, saOriName;
		int thumbWidth = 0;
		int thumbHeight = 0;
		
		while(entryIter.hasNext() == true){
			entry = entryIter.next();
			sFileNameKey = entry.getKey();
			sOriNameKey = (sFileNameKey.startsWith("file_") == true)? sFileNameKey.replace("file_", "ori_") : "ori_" + sFileNameKey;
			file = entry.getValue()[0];
			files = entry.getValue();
			if( getParams().containsKey("thumbWidth") == true ){
				try{
					thumbWidth = Integer.parseInt(getParams().get("thumbWidth").toString());	
				}catch(Exception e){
					thumbWidth = 0;	
				}
			}
			if( getParams().containsKey("thumbHeight") == true ){
				try{
					thumbHeight = Integer.parseInt(getParams().get("thumbHeight").toString()) ;	
				}catch(Exception e){
					thumbHeight = 0;	
				}
			}
			if (files.length > 1){
				saFileName = getArrayParams().get(sFileNameKey + "FileName");
				saOriName = new String[saFileName.length];
				for(int i = 0; i < files.length; i++){
					sBeforeFileName = saFileName[i].replace(' ', '_');
					sBeforeFileName = saFileName[i].replace('%', '_');
					sAfterFileName = saveFile(files[i], commonSavePath + (sFileNameKey.replace("file_", "") + '/' + sPrefix + sBeforeFileName), mode); // TODO: 파일 확장자 뽑아서 기존 파일명은 가져가지 말 것.
					saOriName[i] = sBeforeFileName;
					saFileName[i] = sAfterFileName;
					// FIXME: 썸네일 루틴 완성 시킬 것
					if( (thumbWidth > 0) || (thumbHeight > 0) ) {
						int iComma = sAfterFileName.lastIndexOf(".");
						String sExt = sAfterFileName.substring(iComma+1).toLowerCase();
						int iMatch = 0;
						for(String s : saExt){
							if( s == sExt){
								iMatch = 1;
							}
						}
						if( iMatch >= 0){
							thumnail_Img(files[i], commonSavePath, sAfterFileName, thumbWidth, thumbHeight, FileNameChangeMode.overwrite);	
						}
					}						
				}
				
				getArrayParams().put(sFileNameKey, saFileName); // 실제 적용된 파일 이름을 DB에 적용하기 위해 그 값을 삽입
				getArrayParams().put(sOriNameKey, saOriName); // 원본 파일이름을 ori_파일타입 필드에 삽입
			}
			else{
				sBeforeFileName = getParams().get(sFileNameKey + "FileName").toString().replace(' ', '_');
				sBeforeFileName = getParams().get(sFileNameKey + "FileName").toString().replace('%', '_');
				sAfterFileName = saveFile(file, commonSavePath + (sFileNameKey.replace("file_", "") + '/' + sPrefix + sBeforeFileName), mode); // TODO: 파일 확장자 뽑아서 기존 파일명은 가져가지 말 것.
				
				// FIXME: 썸네일 루틴 완성 시킬 것
				//thumnail_Img(file, commonSavePath, sBeforeFileName, width, height, mode);// 썸네일
//				if( sAfterFileName.endsWith(".jpg") || sAfterFileName.endsWith(".png") || sAfterFileName.endsWith(".gif") || sAfterFileName.endsWith(".bmp") ){
				int iComma = sAfterFileName.lastIndexOf(".");
				String sExt = sAfterFileName.substring(iComma+1).toLowerCase();
				int iMatch = 0;
				for(String s : saExt){
					if( s == sExt){
						iMatch = 1;
					}
				}
				if( iMatch >= 0){
					thumnail_Img(file, commonSavePath, sAfterFileName, thumbWidth, thumbHeight, FileNameChangeMode.overwrite);	
				}
				
				
				getParams().put(sFileNameKey, sAfterFileName); // 실제 적용된 파일 이름을 DB에 적용하기 위해 그 값을 삽입
				getParams().put(sOriNameKey, sBeforeFileName); // 원본 파일이름을 ori_파일타입 필드에 삽입
			}
		}
	}
	
	/**
	 * 이미지 파일의 썸네일을 만든다.
	 * @param file
	 * @param commonSavePath 저장되는 위치
	 * @param sAfterFileName 썸네일 파일 이름
	 * @param thumbWidth 썸네일 가로길이
	 * @param thumbHeight 썸네일 세로 길이
	 * @param mode overwrite: 덮어쓰기. parentheses: 파일명에 (카운트). underbar: 파일명에 _카운트. nowdatetime: 파일명에 _[날짜시간]
	 * @throws IOException
	 */
	public void thumnail_Img(File file, String commonSavePath, String sAfterFileName, int thumbWidth, int thumbHeight, FileNameChangeMode mode) throws IOException {
		int iFileNum = 0;
		String sFormattedPath = getFilePathFormat(sAfterFileName, mode);
		String mkFolder = commonSavePath + "thumnail/";
//		String mkFolder = getDownloadPath() + "thumnail/";
		File folder = new File(mkFolder);
		File dest = new File(mkFolder + sAfterFileName);
		
		if(folder.exists() == false){
			folder.mkdirs();
		}
		
		if (mode == FileNameChangeMode.overwrite){
			if (dest.exists() == true){
				dest.delete();
			}
		}
		else{
			while(dest.exists() == true){
				dest = new File(mkFolder + String.format(sFormattedPath, iFileNum) );
				++iFileNum;
			}
		}
		
	//String filename= "\\"+getParams().get("fileFileName");
		int RATIO = 0;
		int SAME = -1;
	    Image srcImg = null;
	    // 파일의 확장자 추출
//	    String suffix = file.getName().substring(file.getName().lastIndexOf('.') + 1).toLowerCase();
	    String suffix = sAfterFileName.substring(sAfterFileName.lastIndexOf('.') + 1).toLowerCase();
	    // 이미지의 확장자를 검색하여 이미지 파일인지 검사
	    int iMatch = 0;
	    for(String s : saExt){
			if( s == suffix){
				iMatch = 1;
			}
		}
		if( iMatch >= 0){
			srcImg = ImageIO.read(file); 		 // 메모리에 이미지 생성
	    } else {
	        srcImg = new ImageIcon(file.getAbsolutePath()).getImage();
	    }

	    int srcWidth = srcImg.getWidth(null);   // 원본 이미지 너비 추출
	    int srcHeight = srcImg.getHeight(null); // 원본 이미지 높이 추출

	    int destWidth = -1, destHeight = -1;    // 대상 이미지 크기 초기화

	    if (thumbWidth == SAME) {     // 너비가 같은 경우
	    	destWidth = srcWidth;
	    } else if (thumbWidth > 0) {
	        destWidth = thumbWidth;
	    }

	    if (thumbHeight == SAME) {    // 높이가 같은 경우
	        destHeight = srcHeight;
	    } else if (thumbHeight > 0) {
	        destHeight = thumbHeight;
	    }

	     // 비율에 따른 크기 계산
	    if (thumbWidth == RATIO && thumbHeight == RATIO) {
	        destWidth = srcWidth;
	        destHeight = srcHeight;
	    } else if (thumbWidth == RATIO) {
	        double ratio = ((double) destHeight) / ((double) srcHeight);
	        destWidth = (int) ((double) srcWidth * ratio);
	    } else if (thumbHeight == RATIO) {
	        double ratio = ((double) destWidth) / ((double) srcWidth);
	        destHeight = (int) ((double) srcHeight * ratio);
	    }

	    // 메모리에 대상 이미지 생성
	    Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);
	    int pixels[] = new int[destWidth * destHeight];
	    PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth,
	    		destHeight, pixels, 0, destWidth);
	    try {
	    	pg.grabPixels();
	    } catch (InterruptedException e) {
	        throw new IOException(e.getMessage());
	    }
	    BufferedImage destImg = new BufferedImage(destWidth, destHeight,
	        BufferedImage.TYPE_INT_RGB);
	    destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

	    // 파일에 기록
	    ImageIO.write(destImg, suffix, dest);
	}

}
