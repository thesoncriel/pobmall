package artn.common;

import java.util.Map;

public abstract class Logger implements ILogger {

	public abstract void write(Map<String, Object> data) throws Exception;
	public void write(Object data) throws Exception{
		this.write( (Map<String, Object>)data );
	}
}
