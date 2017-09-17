package artn.common;

import artn.common.model.User;

public interface ILogger {
	public void write(User user, String msg, int actionCode) throws Exception;
}
