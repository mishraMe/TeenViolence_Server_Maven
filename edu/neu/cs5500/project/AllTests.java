package edu.neu.cs5500.project;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import edu.neu.cs5500.project.authentication.AuthenticatingUserTest;
import edu.neu.cs5500.project.imageData.ImageDataServletTest;
import edu.neu.cs5500.project.parameter.FetchInstructionTest;
import edu.neu.cs5500.project.parameter.InitialParameterTest;
import edu.neu.cs5500.project.questionnaire.QuestionnaireTest;
import edu.neu.cs5500.project.registration.RegisterTest;


@RunWith(Suite.class)
@SuiteClasses({
	AuthenticatingUserTest.class,
	ImageDataServletTest.class,
	FetchInstructionTest.class,
	InitialParameterTest.class,
	QuestionnaireTest.class,
	RegisterTest.class
})
public class AllTests {

}
