package manager;

import dao.HealthTrackerUserDao;
import exception.LoginException;
import exception.RegistrationException;
import model.RegisterForm;
import org.apache.log4j.Logger;
import persistance.HealthTrackerUser;
import util.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

/**
 * Created by Mephalay on 10/4/2016.
 */
public class HealthTrackerUserManager {

    private static HealthTrackerUserManager instance;
    private HealthTrackerUserDao dao = HealthTrackerUserDao.getInstance();
    private Logger logger = Logger.getLogger(this.getClass());

    private HealthTrackerUserManager() {
        logger.info("HealthTracker user manager constructed.");
    }

    public static synchronized HealthTrackerUserManager getInstance() {
        if (instance == null)
            instance = new HealthTrackerUserManager();
        return instance;
    }

    public HealthTrackerUser registerUser(RegisterForm registerForm) throws RegistrationException {
        try {
            String username = registerForm.getUsername();
            String password = registerForm.getPassword();
            String gender = registerForm.getFemale();
            String height = registerForm.getHeight();
            String weight = registerForm.getWeight();
            Unit weightUnit = Unit.forName(registerForm.getWeightSelect());
            Unit heightUnit = Unit.forName(registerForm.getHeightSelect());
            String age = registerForm.getAge();
            if (!CommonUtils.isNumeric(age)) {
                throw new RegistrationException("Please enter a numeric age", "REG009", "Please enter a numeric age", null);
            }
            if (heightUnit != weightUnit) {
                throw new RegistrationException("Please enter your height and weight units ALL Metric, or ALL Imperial. Don't confuse us!", "REG008", "Please enter your height and weight units ALL Metric, or ALL Imperial. Don't confuse us!", null);
            }
            ActivityLevel activityLevel = ActivityLevel.forName(registerForm.getExerciseLevel());
            Gender userGender = Gender.forName(gender);
            if (CommonUtils.isEmpty(gender)) {
                gender = registerForm.getMale();
                userGender = Gender.forName(gender);
                if (CommonUtils.isEmpty(gender)) {
                    throw new RegistrationException("Gender can not be empty", "REG005", "Username can not be empty", null);
                }
            }
            if (!CommonUtils.isNumeric(height)) {
                throw new RegistrationException("Height must be numeric", "REG006", "Username can not be empty", null);
            }
            if (!CommonUtils.isNumeric(weight)) {
                throw new RegistrationException("Weight must be numeric", "REG007", "Username can not be empty", null);
            }
            if (username == null || username.isEmpty()) {
                throw new RegistrationException("Username can't be empty", "REG002", "Username can not be empty", null);
            }
            if (password == null || password.isEmpty()) {
                throw new RegistrationException("Password can't be empty", "REG003", "Password can not be empty", null);
            }
            BigDecimal weightVal = new BigDecimal(weight);
            BigDecimal heightVal = new BigDecimal(height);
            List<HealthTrackerUser> users = dao.fetchUsersByUsername(username);
            if (users != null && users.size() > 0) {
                throw new RegistrationException("Username in use", "REG004", "Username is in use, please pick different username", null);
            }
            HealthTrackerUser userToRegister = new HealthTrackerUser();
            Integer userAge = Integer.parseInt(age);
            userToRegister.setAge(userAge);
            userToRegister.setUserId(UUID.randomUUID().toString());
            userToRegister.setUsername(username);
            userToRegister.setPassword(SecurityUtils.generateHashWithHMACSHA256(password));
            userToRegister.setGender(userGender);
            userToRegister.setActivityLevel(activityLevel);
            userToRegister.setHeight(heightVal);
            userToRegister.setWeight(weightVal);
            userToRegister.setHeightUnit(heightUnit);
            userToRegister.setWeightUnit(weightUnit);
            dao.saveUser(userToRegister);
            logger.info("Completed registering user.");
            return userToRegister;
        } catch (Throwable t) {
            if (t instanceof RegistrationException) {
                throw (RegistrationException) t;
            }
            logger.error("Failed to register user.", t);
            throw new RegistrationException("Encountered an error during registration", "REG001", "Failed to process your registration,please try again", t);
        }
    }

    public HealthTrackerUser loginUser(String username, String password) throws LoginException {
        try {
            if (username == null || username.isEmpty()) {
                throw new LoginException("Username can't be empty", "LOG002", "Username can not be empty", null);
            }
            if (password == null || password.isEmpty()) {
                throw new LoginException("Password can't be empty", "LOG003", "Password can not be empty", null);
            }
            List<HealthTrackerUser> users = dao.fetchUsersByUsername(username);
            if (users == null || users.size() == 0) {
                throw new LoginException("No user with such user", "LOG004", "Invalid credentials", null);
            }
            for (HealthTrackerUser user : users) {
                String hashedPw = SecurityUtils.generateHashWithHMACSHA256(password);
                if (user.getPassword().equals(hashedPw)) {
                    return user;
                }
            }
            throw new LoginException("No user matches that password", "LOG005", "Invalid credentials", null);
        } catch (Throwable t) {
            logger.error("Failed to login user with username:" + username, t);
            throw new LoginException("Error during login process", "LOG001", "Failed to process your login request, please try again later", t);
        }
    }


}
