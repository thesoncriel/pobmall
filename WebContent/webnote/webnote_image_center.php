<?php
/******************************************************************************************
* WebNote
* 공식배포처 : http://www.phpwork.kr
* 테스트 : http://www.webnote.kr
* 제작자 이메일 : master@phpwork.kr
* 이프로그램은 개인/기업/영리/비영리 에 관계없이 웹개발에 무료로 자유롭게 사용할 수 있습니다.
* 소스내의 주석문은 어떠한 경우라도 수정/삭제할 수 없습니다.
* 제작자가 배포한상태 그대로인 경우에 한해 재배포를 허용하며 수정된 소스나, 수정된 소스가 포함된 프로그램, 소스중의 일부분을 타인에게 배포하거나 판매할 수 없습니다.
* 제작자와 별도의 상의없이 본프로그램의 버전및 공식사이트 정보를 보여주는 "WebNote"(제일 오른쪽에 "?" 형태의 아이콘으로 출력됨) 버튼을 임의로 안보이도록 할 없습니다.(모든 툴바를 감추는 경우는 자동으로 감추어지므로 관계없습니다.)
* 이프로그램의 사용으로 인해 발생한 어떠한 문제도 제작자는 책임지지 않습니다.
* 사용중 문의나 건의사항은 공식 배포사이트의 게시판을 이용해주시거나 메일로 보내 주시기 바랍니다.
******************************************************************************************/
class WebNote {

	var $ver = '13.8';

	var $upload_web_path;
	var $upload_abs_path;
	var $upload_dir_array;
	var $upload_file_array;

	var $use_auth;
	var $islogin;
	var $se_member_id;

	var $public_add_folder;
	var $public_del_folder;
	var $public_upload_file;
	var $public_delete_file;

	var $use_member_dir;

	var $thumb_max_size;
	var $allow_image_max_width;
	var $allow_image_max_volume;
	var $allow_folder_count;
	var $allow_file_count;
	var $overwrite;
	var $upfile;
	var $upfile_name;
	var $upfile_size = 0;
	var $upfile_path;
	var $upfile_names;
	var $allow_file_ext = array();

	var $get_dir;
	var $action;
	var $up_status = 0;
	var $chk_files;
	var $file_count = 0;
	var $folder_count = 0;

	var $curr_upload_web_path;
	var $curr_upload_abs_path;
	var $curr_upload_thumb_web_path;
	var $curr_upload_thumb_abs_path;

	var $file_sort_name;
	var $file_sort_type;

	var $root_name;
	
	function WebNote() {
		session_start();
		$this->initConfig();
		$this->checkAuth();
		$this->setMemberVars();
		$this->checkAction();
		$this->getTree();
		$this->getCurrFiles();
	}
	function initConfig() {

		//아이콘 디렉토리
		$this->icon_dir						= "icon";

		//파일업로드 경로(쓰기권한필요)
		$this->upload_web_path				= dirname($_SERVER["PHP_SELF"]).'/upload';
		$this->upload_abs_path				= 'upload';
		$this->upload_dir_array				= array();
		$this->upload_file_array			= array();
		
		//auth
		$this->use_auth						= false;			//인증접속? (true면 $_SESSION['SE_LOGIN'] 값이 true 인경우만 접속가능)
		$this->islogin						= false;			//수정하지 마세요
		$this->se_member_id					= null;				//수정하지 마세요

		//방문자 권한 (미인증) : 위 use_auth 가 false 인경우만 적용됨 (관리자는 $_SESSION['SE_LOGIN'] 값이 true 여야 함)
		$this->public_add_folder			= true;			//방문자가 폴더 만들 수 있는 권한
		$this->public_del_folder			= true;			//방문자가 폴더 삭제할 수 있는 권한
		$this->public_upload_file			= true;			//방문자가 파일 업로드 할 수 있는 권한
		$this->public_delete_file			= true;			//방문자가 파일 삭제할 수 있는 권한

		//member dir
		$this->use_member_dir				= false;			//회원전용공간 사용(true면 $_SESSION['SE_MEMBER_ID']값으로 디렉토리 자동 생성후 그 안의 자료만 이용

		// thumb
		$this->thumb_max_size				= 100;				//썸네일 생성시 가로, 세로 중 최대값
		$this->allow_image_max_width		= 960;				//원본 이미지 등록시 가로 사이즈 제한 픽셀제한 (0:무제한) => 제한픽셀을 넘는 이미지를 등록하면 자동으로 제한사이즈로 조절되어 저장됨
		$this->allow_image_max_volume		= 1048576;			// 업로드제한용량(byte) (0: 무제한 => 무제한으로 세팅해도 서버의 설정에따라 제한이 걸릴 수 있습니다.)
		$this->allow_folder_count			= 10;				// 최대 생성 폴더 개수 (0: 무제한)
		$this->allow_file_count				= 100;				// 1개폴더당 최대 업로드 파일 개수 (0: 무제한)
		$this->overwrite					= false; 
		$this->root_name					= "ROOT";
		$this->allow_file_ext				= array("jpg","gif","png");		//허용파일확장자

		$this->file_sort_name				= "time";			//리스트 출력시 정렬 기준(name:파일명, time:등록시각, volume:파일용량, mime:파일타입)
		$this->file_sort_type				= "desc";			//리스트 출력시 정렬 방식(asc:오름차순, desc: 내림차순) : 오름차순 => 숫자, 알파벳대문자,알파벳소문자, 한글 순서 입니다.(내림차순은 역순)

		$this->setLocalSession();
		$this->setMemberDirectory();

	}
	function setLocalSession() {
		if(isset($_SESSION['SE_LOGIN']) && $_SESSION['SE_LOGIN']) {
			$this->islogin = true;
		} else {
			$this->islogin = false;
		}
		if(isset($_SESSION['SE_MEMBER_ID'])) $this->se_member_id = $_SESSION['SE_MEMBER_ID'];
	}
	function setMemberDirectory() {
		if($this->use_member_dir == true) {
			if($this->islogin == false || !$this->se_member_id) {
				$this->accessDeny();
				exit;
			}
			$this->upload_web_path			.= '/__'.$this->se_member_id;
			$this->upload_abs_path			.= '/__'.$this->se_member_id;			
			if(!is_dir($this->upload_abs_path)) {
				if(!mkdir($this->upload_abs_path,0707)) {
					$this->ErrorBackMsg("유저폴더생성에 실패했습니다. 다시한번 시도해주세요");
					exit;
				}
				chmod($this->upload_abs_path,0707);
			}
			$this->root_name				= strtoupper($this->se_member_id);
		}		
	}
	function checkAuth() {
		if($this->use_auth == true) {
			if($this->islogin == false) {
				$this->accessDeny();
				exit;
			}
		}		
	}
	function setMemberVars() {
		if(isset($_GET['action']))		$this->action	= $_GET['action'];
		if(isset($_POST['action']))		$this->action	= $_POST['action'];
		if(isset($_GET['get_dir']))		$this->get_dir	= $_GET['get_dir'];
		if(isset($_POST['get_dir']))	$this->get_dir	= $_POST['get_dir'];
		if(isset($_POST['up_status']))  $this->up_status= $_POST['up_status'];

		//print_r($_POST);


		$this->get_dir			= trim(addslashes($this->get_dir));
		if($this->get_dir) {
			if(!$this->checkFolderNaming($this->get_dir)) {
				$this->ErrorBackMsg("잘못된 폴더명입니다.".$this->get_dir);
				exit;
			}
		}
	}
	function checkAction() {
		if($this->action == 'file_delete')		$this->deleteFile();
		if($this->action == 'file_upload')		$this->uploadFile();
		if($this->action == 'make_folder')		$this->makeFolder();
		if($this->action == 'delete_folder')	$this->deleteFolder();
		if($this->action == 'file_delete_one')	$this->deleteFileOne();
	}
	function getTree() {
		if(!is_dir($this->upload_abs_path)) {
			$this->ErrorBackMsg($this->upload_abs_path." 디렉토리가 존재하지 않습니다.");
			exit;
		}
		$this->folder_count = 0;
		if ($handle = opendir($this->upload_abs_path)) {
			while (false !== ($dir_name = readdir($handle))) {
				if($dir_name != '.' && $dir_name != '..' && is_dir($this->upload_abs_path."/".$dir_name) && !preg_match('/^_/',$dir_name)) {
					$this->upload_dir_array[]	= $dir_name;
					$this->folder_count++;
				}
			}
			closedir($handle); 
			$handle = null;
			asort($this->upload_dir_array);
			$tmp = $this->upload_dir_array;
			$this->last_dir_name		= array_pop($tmp);
			unset($tmp);
		}
	}
	function getCurrFiles() {
		$this->setCurrPath();
		$this->upload_file_array		= array();
		$this->file_count = 0;
		if(is_dir(($this->curr_upload_abs_path))) {
			if ($handle = opendir($this->curr_upload_abs_path)) {
				while (false !== ($file_name = readdir($handle))) {
					if($file_name != '.' && $file_name != '..' && !is_dir($this->curr_upload_abs_path."/".$file_name)) {

						$imgObj															= getimagesize($this->curr_upload_abs_path."/".$file_name);
						if($imgObj[2] > 0 && $imgObj[2] < 4) {
							$file_size													= filesize($this->curr_upload_abs_path."/".$file_name);
							$this->upload_file_array[$this->file_count]['name']			= $file_name;
							$this->upload_file_array[$this->file_count]['width']		= $imgObj[0];
							$this->upload_file_array[$this->file_count]['height']		= $imgObj[1];
							$this->upload_file_array[$this->file_count]['size']			= $this->format_size($file_size);
							$this->upload_file_array[$this->file_count]['mime']			= $imgObj['mime'];
							$this->upload_file_array[$this->file_count]['volume']		= $file_size;
							$this->upload_file_array[$this->file_count]['file_url']		= $this->curr_upload_web_path.'/'.$file_name;
							$this->upload_file_array[$this->file_count]['time']			= filemtime($this->curr_upload_abs_path."/".$file_name);

							$thumb_name													= 't_'.$file_name;
							$thumbObj													= getimagesize($this->curr_upload_thumb_abs_path.'/'.$thumb_name);
							$this->upload_file_array[$this->file_count]['thumb_name']	= $thumb_name;
							$this->upload_file_array[$this->file_count]['thumb_width']	= $thumbObj[0];
							$this->upload_file_array[$this->file_count]['thumb_height']	= $thumbObj[1];
							$this->upload_file_array[$this->file_count]['thumb_url']	= $this->curr_upload_thumb_web_path.'/'.$thumb_name;						
							$this->file_count++;
						}
					}					
				}
				closedir($handle);
			}
			$this->file_sort_name = strtolower($this->file_sort_name);
			if($this->file_sort_name != 'name' && $this->file_sort_name != 'volume' && $this->file_sort_name != 'time' && $this->file_sort_name != 'mime') $this->file_sort_name = 'time';

			$this->file_sort_type	= strtoupper($this->file_sort_type);
			if($this->file_sort_type != 'ASC' && $this->file_sort_type != 'DESC') $this->file_sort_type = 'DESC';
			$this->upload_file_array = $this->array_sort($this->upload_file_array, $this->file_sort_name, $this->file_sort_type);
		}
	}
	function array_sort($array, $on, $order='ASC') {
		
		$new_array = array();
		$sortable_array = array();

		if (count($array) > 0) {
			foreach ($array as $k => $v) {
				if (is_array($v)) {
					foreach ($v as $k2 => $v2) {
						if ($k2 == $on) {
							$sortable_array[$k] = $v2;
						}
					}
				} else {
					$sortable_array[$k] = $v;
				}
			}

			switch ($order) {
				case 'ASC':
					asort($sortable_array);
				break;
				case 'DESC':
					arsort($sortable_array);
				break;
			}

			foreach ($sortable_array as $k => $v) {
				$new_array[$k] = $array[$k];
			}
		}

		return $new_array;
	}
	function format_size($size) {
		$sizes = array(" Bytes", " KB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB");
		if ($size == 0) { return('n/a'); } else {
		return (round($size/pow(1024, ($i = floor(log($size, 1024)))), 2) . $sizes[$i]); }
	}
	function setCurrPath() {
		$this->setMemberVars();
		if($this->get_dir) {
			$this->curr_upload_web_path			= $this->upload_web_path."/".$this->get_dir;
			$this->curr_upload_abs_path			= $this->upload_abs_path."/".$this->get_dir;
		} else {
			$this->curr_upload_web_path			= $this->upload_web_path;
			$this->curr_upload_abs_path			= $this->upload_abs_path;
		}		
		if(!is_dir($this->curr_upload_abs_path)) {
			$this->ErrorBackMsg($this->curr_upload_abs_path." 디렉토리가 존재하지 않습니다.");
			exit;
		}
		$this->curr_upload_thumb_web_path		= $this->curr_upload_web_path."/_thumb";
		$this->curr_upload_thumb_abs_path		= $this->curr_upload_abs_path."/_thumb";
	}
	function resizeString($Str, $size, $addStr="...")  { 
	    //if(mb_strlen($Str, "UTF-8") > $size) return mb_substr($Str, 0, $size, "UTF-8").$addStr; 
	    //else return $Str;
		return $Str;
	}	
	function deleteFile() {	
		$this->checkDeleteFileAuth();
		$this->chk_files	= $_POST['chk_file'];
		$this->setCurrPath();
		foreach($this->chk_files as $files) {
			@unlink($this->curr_upload_abs_path."/".$files);
			@unlink($this->curr_upload_thumb_abs_path."/t_".$files);
		}
		$this->goListPage();
	}
	function deleteFileOne() {	
		$this->checkDeleteFileAuth();
		$this->setCurrPath();
		if(isset($_GET['filename'])) $this->filename	= $_GET['filename'];
		if($this->filename && file_exists($this->curr_upload_abs_path."/".$this->filename)) {
			@unlink($this->curr_upload_abs_path."/".$this->filename);
			@unlink($this->curr_upload_thumb_abs_path."/t_".$this->filename);
		}
	}
	function checkUploadFileVolume() {
		if(!$this->upfile_size) return false;
		if($this->allow_image_max_volume > 0) {
			if($this->upfile_size > $this->allow_image_max_volume) {
				@unlink($this->upfile);
				$this->ErrorBackMsg("파일용량이 ".$this->format_size($this->allow_image_max_volume)." 를 초과하였습니다. ".$this->format_size($this->allow_image_max_volume)." 이하의 파일만 업로드 해주세요!");
				exit;
			}
		}
	}
	function uploadFile() {		
		$this->checkUploadFileAuth();
		$this->setCurrPath();
		$upfile_count = count($_FILES['upfile']['name']);
		$this->upfile_names = '';
		for($i = 0; $i < $upfile_count; $i++) {
			$this->checkFileCount();
			$this->upfile		= $_FILES['upfile']['tmp_name'][$i];
			$this->upfile_name	= $_FILES['upfile']['name'][$i];
			$this->upfile_size	= $_FILES['upfile']['size'][$i];			
			$fileExt	= strtolower(array_pop(explode(".",$this->upfile_name)));
			if(!in_array($fileExt,$this->allow_file_ext)) continue;			
			$this->upfile_path	= $this->curr_upload_abs_path."/".$this->upfile_name;
			$this->checkUploadFileVolume();
			if($this->overwrite == false) {
				if(file_exists($this->upfile_path)) {
					$upfile_name_array	= explode(".",$this->upfile_name);
					$upfile_ext			= array_pop($upfile_name_array);
					$upfile_name_str	= $upfile_name_array[0];
					$loop_count = 5;
					for($i = 0; $i < $loop_count; $i++) {
						$upfile_name_str	= $upfile_name_str."_1";
						$this->upfile_path		= $this->curr_upload_abs_path."/".$upfile_name_str.".".$upfile_ext;
						if(!file_exists($this->upfile_path) || $i  == ($loop_count-1)) {
							$this->upfile_name = $upfile_name_str.".".$upfile_ext;
							break;
						}
					}
				}
			}
			if(is_uploaded_file($this->upfile)) {
				if($this->allow_image_max_width > 0) {
					$imageObj = getimagesize($this->upfile);
					if($imageObj[2] != 1 && $imageObj[2] != 2 && $imageObj[2] != 3) {
						$this->ErrorBackMsg("GIF, JPG, PNG 이미지파일만 업로드 가능합니다.:".$this->upfile_name);	
						exit;
					}
					if($imageObj[2] == 1) {
						$im = imagecreatefromgif($this->upfile); 
					} elseif($imageObj[2] == 2) {
						$im = imagecreatefromjpeg($this->upfile); 
					} elseif($imageObj[2] == 3) {
						$im = imagecreatefrompng($this->upfile); 
					}
					if($imageObj[0] > $this->allow_image_max_width) {
						$width = $this->allow_image_max_width; 
						$height = ($imageObj[1]*$this->allow_image_max_width) / $imageObj[0];
						$sheet = imagecreatetruecolor($width, $height); 
						imagecopyresampled($sheet, $im, 0, 0, 0, 0, $width, $height, $imageObj[0], $imageObj[1]); 
						if($imageObj[2] == 1) {
							imagegif($sheet,$this->upfile_path, 90);
						} elseif($imageObj[2] == 2)	{
							imagejpeg($sheet,$this->upfile_path, 90);
						} elseif($imageObj[2] == 3) {
							imagepng($sheet,$this->upfile_path, 9);
						}
						@chmod($this->upfile_path,0707);
						imagedestroy($sheet); 
					} else {
						if(!move_uploaded_file($this->upfile,$this->upfile_path)) {
							echo "업로드 실패!";
							exit;
						}
						@chmod($this->upfile_path,0707);
					}
				} else {
					if(!move_uploaded_file($this->upfile,$this->upfile_path)) {
						echo "업로드 실패!";
						exit;
					}
					@chmod($this->upfile_path,0707);
				}
				$this->checkThumbPath();
				$this->thumbnail($this->upfile_path, $this->thumb_path.'/t_'.$this->upfile_name);
				$this->upfile_names	.=  $this->upfile_name.'|';
			}
		}
		if($this->up_status == 1) {
			echo "1|".$this->upfile_name;
		} else {
			$this->goListPage();			
		}
		exit;
	}
	function checkThumbPath() {
		$this->thumb_path = $this->curr_upload_abs_path.'/_thumb';
		if(!is_dir($this->thumb_path)) {
			mkdir($this->thumb_path,0707);
			chmod($this->thumb_path,0707);
		}
	}
	function thumbnail($file_path, $save_path,$max_size = 0){ 
		if($max_size > 0) {
			$this->thumb_max_size = $max_size;
		}
		$imageObj = getimagesize($file_path);
		if($imageObj[2] != 1 && $imageObj[2] != 2 && $imageObj[2] != 3) {
			$this->ErrorBackMsg("GIF, JPG, PNG 이미지파일만 업로드 가능합니다.");	
			exit;
		}
		if($imageObj[2] == 1) {
			$im = imagecreatefromgif($file_path); 
		} elseif($imageObj[2] == 2) {
			$im = imagecreatefromjpeg($file_path); 
		} elseif($imageObj[2] == 3) {
			$im = imagecreatefrompng($file_path); 
		}
		if($imageObj[0] <= $this->thumb_max_size && $imageObj[1] <= $this->thumb_max_size){ 
			$width	= $imageObj[0]; 
			$height = $imageObj[1]; 
		}
		if($imageObj[0] > $imageObj[1]){ 
			$width	= $this->thumb_max_size; 
			$height	= ($imageObj[1]*$this->thumb_max_size) / $imageObj[0]; 
		}
		if($imageObj[0] < $imageObj[1]){ 
			$width	= ($imageObj[0]*$this->thumb_max_size) / $imageObj[1]; 
			$height = $this->thumb_max_size; 
		}
		if($imageObj[0] == $imageObj[1]){ 
			$width	= $this->thumb_max_size;
			$height = $this->thumb_max_size;
		}
		$sheet = imagecreatetruecolor($width, $height); 
		imagecopyresampled($sheet, $im, 0, 0, 0, 0, $width, $height, $imageObj[0], $imageObj[1]); 
		if($imageObj[2] == 1) {
			imagegif($sheet,$save_path, 90);
		} elseif($imageObj[2] == 2)	{
			imagejpeg($sheet,$save_path, 90);
		} elseif($imageObj[2] == 3) {
			imagepng($sheet,$save_path, 9);
		}
		@chmod($save_path,0707);
		imagedestroy($sheet); 
		return true;
	}
	function checkFolderCount() {
		if($this->allow_folder_count > 0) {
			$this->folder_count = 0;
			if ($handle = opendir($this->upload_abs_path)) {
				while (false !== ($dir_name = readdir($handle))) {
					if($dir_name != '.' && $dir_name != '..' && is_dir($this->upload_abs_path."/".$dir_name) && !preg_match('/^_/',$dir_name)) {
						$this->upload_dir_array[]	= $dir_name;
						$this->folder_count++;
					}
				}
				closedir($handle); 
			}
			if($this->folder_count >= $this->allow_folder_count) {
				$this->ErrorBackMsg("더이상 폴더를 생성할 수 없습니다. (가능최대폴더개수:".$this->allow_folder_count.")");
				exit;
			}
		}
	}
	function checkFileCount() {
		if($this->allow_file_count > 0) {
			$this->setCurrPath();
			$this->file_count = 0;
			if(is_dir(($this->curr_upload_abs_path))) {
				if ($handle = opendir($this->curr_upload_abs_path)) {
					while (false !== ($file_name = readdir($handle))) {
						if($file_name != '.' && $file_name != '..' && !is_dir($this->curr_upload_abs_path."/".$file_name)) {
							$this->file_count++;
						}					
					}
					closedir($handle); 
				}
			}
			if($this->file_count >= $this->allow_file_count) {
				$this->ErrorBackMsg("더이상 파일을 등록할 수 없습니다. (폴더당최대파일개수:".$this->allow_file_count.")");
				exit;
			}
		}
	}
	function checkMakeFolderAuth() {
		if($this->islogin == false) {
			if($this->use_auth == false) {
				if($this->public_add_folder == false) {
					$this->ErrorBackMsg("폴더생성권한이 없습니다.");
					exit;
				}
			}
		}
	}
	function checkDeleteFolderAuth() {
		if($this->islogin == false) {
			if($this->use_auth == false) {
				if($this->public_del_folder == false) {
					$this->ErrorBackMsg("폴더삭제권한이 없습니다.");
					exit;
				}
			}
		}
	}
	function checkUploadFileAuth() {
		if($this->islogin == false) {
			if($this->use_auth == false) {
				if($this->public_upload_file == false) {
					$this->ErrorBackMsg("파일 업로드권한이 없습니다.");
					exit;
				}
			}
		}
	}
	function checkDeleteFileAuth() {
		if($this->islogin == false) {
			if($this->use_auth == false) {
				if($this->public_delete_file == false) {
					$this->ErrorBackMsg("파일 삭제권한이 없습니다.");
					exit;
				}
			}
		}
	}
	function checkFolderNaming($folder_name) {
		if(!preg_match('/^[a-zA-Z][a-zA-Z0-9_]{1,9}$/', $folder_name)) {
			return false;;
		} else {
			return true;
		}
	}
	function makeFolder() {
		$this->checkMakeFolderAuth();
		$this->checkFolderCount();
		$this->new_dir		= $_POST['new_dir'];
		if(!$this->checkFolderNaming($this->new_dir)) {
			$this->ErrorBackMsg("폴더명은 알파벳으로 시작하는 알파벳,숫자,언더바(_)만으로된 2~10글자를 입력해주세요");
			exit;
		}
		$this->setCurrPath();
		$this->new_path		= $this->upload_abs_path."/".$this->new_dir;
		if(is_dir($this->new_path)) {
			$this->ErrorBackMsg("이미 등록된 폴더명입니다. 다른 이름을 지정해주세요");
			exit;
		}
		if(!mkdir($this->new_path,0707)) {
			$this->ErrorBackMsg("폴더생성에 실패했습니다. 다시한번 시도해주세요");
			exit;
		}
		@chmod($this->new_path,0707);
		$this->get_dir = $this->new_dir;
		$this->goListPage();
		exit;
	}
	function deleteFolder() {
		$this->checkDeleteFolderAuth();
		$this->setCurrPath();
		if(!is_dir($this->curr_upload_abs_path)) {
			$this->ErrorBackMsg("없는 폴더입니다. 다시한번 확인해주세요");
			exit;
		}
		if(is_dir($this->curr_upload_thumb_abs_path)) {
			if ($handle = opendir($this->curr_upload_thumb_abs_path)) {
				while (false !== ($file_name = readdir($handle))) {
					if($file_name != '.' && $file_name != '..') {
						if(is_dir($this->curr_upload_thumb_abs_path.'/'.$file_name)) {
							@rmdir($this->curr_upload_thumb_abs_path.'/'.$file_name);
						} else {
							@unlink($this->curr_upload_thumb_abs_path.'/'.$file_name);	
						}
					}					
				}
				closedir($handle); 
				@rmdir($this->curr_upload_thumb_abs_path);
			}
		}
		if ($handle = opendir($this->curr_upload_abs_path)) {
			while (false !== ($file_name = readdir($handle))) {
				if($file_name != '.' && $file_name != '..') {
					@unlink($this->curr_upload_abs_path.'/'.$file_name);
				}					
			}
			closedir($handle); 
			@rmdir($this->curr_upload_abs_path);
		}
		$this->get_dir = '';
		$this->goListPage();
		exit;		
	}
	function goListPage() {
		//$this->redirect("?get_dir=".$this->get_dir."&uploaded_files=".$this->upfile_names);exit;
		$url = "?get_dir=".$this->get_dir."&uploaded_files=".base64_encode($this->upfile_names);
		$this->redirect($url);exit;
	}
	function redirect($url) {
		header("Location:".$url);
		exit;
	}
	function ErrorBackMsg($msg) {
		echo("
			<html><head><title>$msg</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><script>function Error() {alert('".$msg."');history.back();}</script></head><body onLoad='Error()'><!-- Error Page...--></body></html>");exit;
	}
	function accessDeny() {		
		echo("<html><head><title>$msg</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head><body><div style='width:auto;text-align:center;margin-top:50px;color:red;font-size:15px'>접근권한이 없습니다.</div></body></html>");
		exit;
	}
}
$WebNote = new WebNote;
$uploaded_files = base64_decode($_GET['uploaded_files']);
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<title>WebNote v.<?=$WebNote->ver?> IMAGE CENTER</title>
<script language="Javascript" src="webnote.js"></script>
<script language="Javascript">
<!--
webnote_config = {
//	allow_dndupload:		true					//드래그&드롭을 통한 이미지 파일 업로드 허용 여부
}
function insertImageOpener(name,src,width,height) {
	var html = "<img src='"+src+"' width='"+width+"' height='"+height+"' alt='"+name+"' title='"+name+"'>";
	opener.webNoteExecFunction.insertHTML(html);
	window.close();
}
function viewUploadForm() {
	var form = document.file_upload_form;
	if(eval(form.file_count.value) >= eval(form.allow_file_count.value) && eval(form.allow_file_count.value) > 0) {
		alert("더이상 파일을 등록할 수 없습니다. (폴더당최대파일개수:"+form.allow_file_count.value+")");
		return;
	}	
	var obj = document.getElementById('upload_form_area');
	var btn_obj = document.getElementById('btn_upload');
	if(obj.style.display == 'block') {
		obj.style.display = 'none';
		btn_obj.src = btn_obj.src.replace(/btn_upload_up/,'btn_upload_down');
	} else {
		obj.style.display = 'block';
		btn_obj.src = btn_obj.src.replace(/btn_upload_down/,'btn_upload_up');
	}
}
function checkFile(count) {
	var obj = document.getElementById('chk_'+count);
	var box_obj = document.getElementById('file_unit_box_'+count);
	if(obj.checked == true) {
		obj.checked = false;
		box_obj.className = 'file_unit';
	} else {
		obj.checked = true;
		box_obj.className = 'file_unit_up';
	}
}
function checkFile2(obj,count) {
	var box_obj = document.getElementById('file_unit_box_'+count);
	if(obj.checked == true) {
		box_obj.className = 'file_unit_up';
	} else {
		box_obj.className = 'file_unit';
	}
}
function fileboxOver(obj) {
	obj.className = 'file_unit_up';
}
function fileboxOut(obj,count) {
	var chk_obj = document.getElementById('chk_'+count);
	if(chk_obj.checked == false) {
		obj.className = 'file_unit';
	}
}
function deleteFile(form) {
	var chk_obj = document.getElementsByName('chk_file[]');
	var chk_count = 0;
	for(var i = 0; i < chk_obj.length; i++) {
		if(chk_obj[i].checked == true) chk_count++;
	}
	if(chk_count == 0) {
		alert("삭제할 파일을 선택해 주세요");
		return false;
	}
	if(confirm("선택하신 "+chk_count+"개 파일을 삭제하시겠습니까?")) {
		return true;
	} else {
		return false;
	}
}
function insertMultiImageOpener() {
	var form = document.file_list_form;
	var chk_obj = document.getElementsByName('chk_file[]');
	var upload_web_path = form.upload_web_path.value;
	var get_dir = form.get_dir.value;
	var chk_count = 0;
	var html = "";
	var d = new Date();
	if(get_dir != "") upload_web_path += "/" + get_dir;
	for(var i = 0; i < chk_obj.length; i++) {
		if(chk_obj[i].checked == true) {
			html += "<img src='"+upload_web_path+"/"+chk_obj[i].value+"' alt='"+chk_obj[i].value+"' title='"+chk_obj[i].value+"'>";
			chk_count++;
		}
	}
	if(chk_count == 0) {
		alert("에디터에 삽입할 이미지를 선택해 주세요");
		return;
	}
	opener.webNoteExecFunction.insertHTML(html);
	window.close();
}
function checkUploadForm(form) {
	var fileObj = document.getElementsByName("upfile[]");
	var upfiles = "";
	var ext		= "";
	var fileExp	= /(gif|jpg|jpeg|png)/gi;
	var fileCount = 0;
	for(var i = 0; i < fileObj.length; i++) {		
		if(fileObj[i].value != "") {
			upfiles = fileObj[i].value.split(".");
			ext		= upfiles[upfiles.length-1];
			if ( !fileExp.test( ext ) ) {
				alert("GIF,JPG,PNG 파일만 업로드 가능합니다.");
				return false;
			}
			fileCount++;
		}
	}
	if(fileCount == 0) {
		alert("업로드할 파일을 선택해 주세요");
		return false;
	}	
	return true;
}
function checkMakeFolderForm(form) {
	if(form.new_dir.value == '') {
		alert("폴더명을 입력해주세요");
		form.new_dir.focus();
		return false;
	}
	var regExp	= /^[a-zA-Z0-9_]{2,15}$/;
	if ( !regExp.test( form.new_dir.value ) ) {
		alert("폴더명은 알파벳,숫자,언더바(_)만으로된 2~15글자를 입력해주세요");
		form.new_dir.focus();
		form.new_dir.select();
		return false;
	}
	return true;
}
function deleteDir(dirname) {
	if(confirm("["+dirname+"] 폴더를 삭제하면 폴더내 파일들도 모두 삭제되며 복구할 수 없습니다.\n정말 삭제하시겠습니까?")) {
		document.location.href = "webnote_image_center.php?get_dir="+dirname+"&action=delete_folder";
	}
}
function checkAll(obj) {
	var chk_obj = document.getElementsByName('chk_file[]');
	var box_obj;
	for(var i = 0; i < chk_obj.length; i++) {

		box_obj = document.getElementById('file_unit_box_'+i);
		if(obj.checked == true) {
			chk_obj[i].checked = true;
			box_obj.className = 'file_unit_up';
		} else {
			chk_obj[i].checked = false;
			box_obj.className = 'file_unit';
		}
	}
}
//-->
</script>
<style type="text/css">
body {
	font-size:12px;
	font-family:맑은 고딕,굴림,돋움,arial
	margin:0;
	background-color:#FFFFFF;
}	
td {
	font-size:12px;
}
form {
	display : inline;
}
img {
	border:0;
}
label {
	cursor:pointer;
}
a:link { text-decoration:none; color:gray}
a:visited { text-decoration:none; color:gray}
a:active { text-decoration:none; color:gray}
a:hover { text-decoration:none; color:orange}
.solid_form {
	border-width:1px;
	border-style:solid;
	border-color:#d9d9d9;
}
div.container {	
	width:auto;
	padding:3px;
	border-width:1px;
	border-style:solid;
	border-color:#d9d9d9;
}
div.tree {
	padding:5px;
	width:auto;
	height:400px;
	overflow:auto;
	border-width:1px;
	border-style:solid;
	border-color:#B0E1B8;
	background-color:#DDF2E0;
}
.contents {
	padding:0px;
	border-width:1px;
	border-style:solid;
	border-color:#c9c9c9;
	background-color:#f2f2f2;
}
.contents_fover {
	padding:0px;
	border-width:1px;
	border-style:solid;
	border-color:#c9c9c9;
	background-color:#ffffcc;
}
div.contents_body {
	padding:5px;
}
div.contents_bottom {
	padding:10px;
	background-color:#ffffff;
	clear:both;
	text-align:right;
}
div.file_unit {
	float:left;
	width:110px;
	height:205px;
	padding:0px;
	color:gray;
	border-width:1px;
	border-style:solid;
	border-color:#d9d9d9;
	background-color:#ffffff;
	text-align:center;
	margin:5px;
	margin-bottom:5px;
	word-break:break-all;
	cursor:default;
}
div.file_unit_up {
	float:left;
	width:110px;
	height:205px;
	padding:0px;
	color:gray;
	border-width:1px;
	border-style:solid;
	border-color:#9ACBCB;
	background-color:#D1E7E7;
	text-align:center;
	margin:5px;
	margin-bottom:5px;
	word-break:break-all;
	cursor:default;
}
div.dir_unit {
	margin-left:10px;
	margin-top:3px;
}
.bottom {
	padding:5px;
	border-width:1px;
	border-style:solid;
	border-color:#d9d9d9;
	background-color:#f2f2f2;	
	color:gray;
	font-style:italic;
}
div.contents_top {
	width:auto;
	clear:both;
	padding:5px;
	border-bottom-width:1px;
	border-bottom-style:solid;
	border-bottom-color:#d9d9d9;
	background-color:#FFFFFF;	
	margin-bottom:5px;
	display:none;
}
div.image_info_title {
	width:auto;
	height:18px;
	overflow:hidden;
	margin-bottom:3px;
	color:black;
	font-size:10px;
	text-align:left;
	background-color:#f2f2f2;
	padding:2px;
}

div.image_info_image {
	width:auto;
	margin-bottom:3px;
	color:gray;
	font-size:11px;
	text-align:center;
	padding:3px;
}

div.image_info {
	width:auto;
	margin-bottom:3px;
	color:gray;
	font-size:11px;
	text-align:center;
}
</style>
</head>
<body>
<table align='center' width='100%' height="100%" border='0' cellspacing='0' cellpadding='0'>
	<tr>
		<td width="200" valign="top">
			<div class="tree">
				<div>
					<img src="<?=$WebNote->icon_dir?>/ftv2folderopen.gif" align="absmiddle">
					<?php 
					$Root_Name_View = $WebNote->root_name;
					if(!$WebNote->get_dir) :
						$Root_Name_View = "<span style='font-weight:bold;font-style:italic;color:black'>".$Root_Name_View."</span>";
					endif; 
					?>
					<a href="?get_dir=" title="최상위 디렉토리"><?=$Root_Name_View?></a>
				</div>			
				<?php foreach($WebNote->upload_dir_array as $dir) :  ?>
				<div>					
					<?php if($dir == $WebNote->last_dir_name) : ?>
						<img src="<?=$WebNote->icon_dir?>/ftv2lastnode.gif" align="absmiddle">
					<?php else : ?>	
						<img src="<?=$WebNote->icon_dir?>/ftv2node.gif" align="absmiddle">
					<?php endif; ?>	


					<?php 
					$dirView = $dir;
					if($WebNote->get_dir == $dir) :
						$dirView = "<span style='font-weight:bold;font-style:italic;color:black'>".$dir."</span>";
					endif; 
					?>


					<img src="<?=$WebNote->icon_dir?>/ftv2folderclosed.gif" align="absmiddle"><a href="?get_dir=<?=$dir?>"><?=$dirView?></a> <span ondblclick="deleteDir('<?=$dir?>')" title="폴더삭제(더블클릭)"><img src="<?=$WebNote->icon_dir?>/delete.png" width="12" height="12" valign="middle"></span>
					
					
					


				</div>
				<?php endforeach;  ?>
			</div>
			<?php if(!$WebNote->allow_folder_count || $WebNote->allow_folder_count > $WebNote->folder_count) : ?>
			<div style="margin-top:3px;">
				<form name='make_folder_form' method="POST" action="<?=$_SERVER["PHP_SELF"]?>" onSubmit="return checkMakeFolderForm(this)">
					<input type="hidden" name="get_dir" value="<?=$WebNote->get_dir?>">
					<input type="hidden" name="action" value="make_folder">
					<input type="text" name="new_dir" value="" size="12" class="solid_form" title="새폴더이름을 입력해주세요"><input type="submit" value="폴더생성" class="solid_form">
				</form>
			</div>	
			<?php endif; ?>
		</td>
		<td width="7"></td>
		<td valign="top" class="contents" id="webnote_image_center_body"> 

				<table align='center' width='100%' height="450" border='0' cellspacing='0' cellpadding='0'>
					<tr>
						<td height="35" bgcolor="#d9d9d9">

							<div>
								<div style="float:left;margin-left:10px;padding:5px;">
									<img src="<?=$WebNote->icon_dir?>/ftv2folderclosed.gif" align="absmiddle">
									<b><?= $WebNote->get_dir ? $WebNote->get_dir : $WebNote->root_name ?></b> 디렉토리 (총 <?=$WebNote->file_count?> 개의 파일이 있습니다.)
								</div>
								<div style="float:right;margin-right:0px;padding:2px;"><a href="javascript:viewUploadForm()" title="파일업로드폼 보이기/감추기"><img src="<?=$WebNote->icon_dir?>/btn_upload_down.png" id="btn_upload" alt="upload button"></div>
							</div>


						</td>
					</tr>
					<tr>
						<td valign="top">



						<div class="contents_top" id="upload_form_area">
							<div>
							<form name='file_upload_form' method="POST" enctype="multipart/form-data" action="<?=$_SERVER["PHP_SELF"]?>" onSubmit="return checkUploadForm(this)">
								<input type="hidden" name="allow_image_max_volume" value="<?=$WebNote->allow_image_max_volume?>">
								<input type="hidden" name="file_count" value="<?=$WebNote->file_count?>">
								<input type="hidden" name="allow_file_count" value="<?=$WebNote->allow_file_count?>">
								<input type="hidden" name="get_dir" value="<?=$WebNote->get_dir?>">
								<input type="hidden" name="action" value="file_upload">
								<input type="hidden" name="up_status" value="0">
								<input type="file"  name="upfile[]" multiple="multiple" accept="image/*" title="찾아보기 버튼을 클릭하시어 파일을 선택해주세요"> <input type="submit" value="올리기" class="solid_form">
							</form>
							</div>
							<div style="margin-top:5px">
								※ 업로드 제한 : GIF,JPG,PNG포멧, 가로 <?=$WebNote->allow_image_max_width?>px(초과시조절됨), 용량 <?=$WebNote->format_size($WebNote->allow_image_max_volume)?>, 폴더당 파일수 <?=$WebNote->allow_file_count?>개
							</div>
						</div>		

						<div  class="contents_body">
					
							<form name='file_list_form' method="POST" action="<?=$_SERVER["PHP_SELF"]?>" onSubmit="return deleteFile(this)">
							<input type="hidden" name="get_dir" value="<?=$WebNote->get_dir?>">
							<input type="hidden" name="upload_web_path" value="<?=$WebNote->upload_web_path?>">
							<input type="hidden" name="action" value="file_delete">			
							

							<?php $loop_count = 0; ?>
							<?php foreach($WebNote->upload_file_array as $file) :								 
								$box_class	= 'file_unit';
								$checked	= '';
								if($uploaded_files) {
									$upfile_names_array = explode("|",$uploaded_files);
									if(in_array($file['name'],$upfile_names_array)) {
										$box_class	= 'file_unit_up'; 
										$checked	= 'checked';
									}
								}
							?>
								<div id="file_unit_box_<?=$loop_count?>" class="<?=$box_class?>" onMouseOver="fileboxOver(this)"  onMouseOut="fileboxOut(this,'<?=$loop_count?>')">
									<div class="image_info_title">
										<input type="checkbox" name="chk_file[]" id="chk_<?=$loop_count?>" value="<?=$file['name']?>" title="<?=$file['name']?>" <?=$checked?> onClick="checkFile2(this,'<?=$loop_count?>')"><label for="chk_<?=$loop_count?>"  title="<?=$file['name']?>"><?=$WebNote->resizeString($file['name'],100)?></label>
									</div>
									<div class="image_info_image">
										<img src="<?=$file['thumb_url']?>"  alt="<?=$file['thumb_name']?>" width="<?=$file['thumb_width']?>" height="<?=$file['thumb_height']?>" onClick="checkFile('<?=$loop_count?>')" ondblclick="insertImageOpener('<?=$file['name']?>','<?=$file['file_url']?>','<?=$file['width']?>','<?=$file['height']?>')" title="한번클릭시 선택, 더블클릭시 에디터에 입력됩니다.">
									</div>
									<div class="image_info">
										<?=$file['mime']?>
									</div>
									<div class="image_info">
										<?=$file['width']?> × <?=$file['height']?>
									</div>
									<div class="image_info">
										<?=$file['size']?>
									</div>
									<div class="image_info">
										<?=date("y/m/d H:i",$file['time'])?>
									</div>
								</div>
							<?php $loop_count++; ?>
							<?php endforeach;  ?>
				
							
						</td>
					</tr>
					<tr>
						<td height="35" bgcolor="#d9d9d9">
							<div style="float:left;padding:2px;">
								<input type="checkbox" name="all_check" value="1" id="all_check" onClick="checkAll(this)"><label for="all_check">전체선택</label>
							</div>
												
							<div style="float:right;margin-right:0px;padding:2px;">							
								<img src="<?=$WebNote->icon_dir?>/btn_insertimages.png" title="선택된 이미지를 모두 삽입" alt="Insert Selected Images" onClick="insertMultiImageOpener()" style="cursor:pointer" width="93" height="28">
								<input type="image" src="<?=$WebNote->icon_dir?>/btn_delete.png" width="93" height="28" title="선택된 이미지를 모두 삭제합니다.">
							</div>	
							</form>
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td height="7" colspan="3"></td>
	</tr>
	<tr>
		<td height="20" colspan="3" class="bottom" align="right">WebNote v.<?=$WebNote->ver?> IMAGE CENTER</td>
	</tr>
</table>
</body>
</html>