package artn.common.tag;

import java.util.List;
import java.util.Map;


public class ValueboxMaker extends AbsTagMaker {

	protected int digit;
	protected int index;
	protected String unit = "";
	protected String type;
	protected String zero;
	protected String value;
	
	
	public ValueboxMaker(){}
	public ValueboxMaker(String id, String cssClass, String style, String value) {
		super(id, cssClass, style);
		setValue(value);
	}

	public int splitNumericByDigit(String value, int digit, int index){
		int iPlace;
		
		iPlace = index * digit;
		// split로 일정 수치를 쪼개서 표현 할 땐 그 자릿수가 항상 고정적이며 빈 칸에 대하여 0으로 채워져 있다고 가정함. (그래서 아래는 주석 처리 및 더이상 생각 안함 - 힘듬 OTL)
		// 편하게 쓰려면 그정돈 감수해야지 =_=;; 안그런가 ㅋ
		/*
		if (value.length() < (iPlace + digit - 1)){
			digit = value.length() - iPlace;
		}*/
		
		try{
			return Integer.parseInt(value.substring(iPlace, iPlace + digit));
		}
		catch(Exception ex){
			return 0;
		}
	}
	public int shiftNumericByDigit(String value, int digit, int index){
		int iValue = 0;
		
		try{
			iValue = Integer.parseInt(value);
			return (iValue >> (index * digit) ) & ((1 << digit) - 1);
		}
		catch(Exception ex){
			return 0;
		}
	}
	
	public int extractValueByType(){
		return extractValueByType(value, digit, index, type);
	}
	public int extractValueByType(String value, Integer digit, Integer index, String type){
		try{
			if ((type == null) ||
				(type.equals("numeric") == true)){
				return Integer.parseInt(value);
			}
			else if (type.equals("split") == true){
				return splitNumericByDigit(value, digit, index);
			}
			else if (type.equals("shift") == true){
				return shiftNumericByDigit(value, digit, index);
			}
		}
		catch(Exception ex){}
		return 0;
	}
	
	
	
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		int iValue = 0;
		
		tagStart("span", sb, true);
		
		if (value != null){
			if (zero != null){
				try{
					iValue = Integer.parseInt(value);
				}
				catch(Exception ex){}
				
				if (value.isEmpty() == true || iValue == 0){
					sb.append(zero);
				}
				else{
					sb.append(extractValueByType());
					if (unit != null)	sb.append(unit);
				}
			}
			else{
				sb.append(extractValueByType());
				if (unit != null)	sb.append(unit);
			}
		}
		
		tagEnd("span", sb);
		return sb;
	}

	public ValueboxMaker setDigit(Integer digit) {
		this.digit = (digit != null)? digit : 1;
		return this;
	}
	public ValueboxMaker setIndex(Integer index) {
		this.index = (index != null)? index : 0;
		return this;
	}
	public ValueboxMaker setUnit(String unit) {
		this.unit = (unit != null)? unit : "";
		return this;
	}
	public ValueboxMaker setType(String type) {
		this.type = (type != null)? type : "numeric";
		return this;
	}
	public ValueboxMaker setZero(String zero) {
		this.zero = zero;
		return this;
	}
	public ValueboxMaker setValue(String value) {
		this.value = value;
		return this;
	}
}
