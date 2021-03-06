<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<hr>

<h3>Your added dishes and activities will be listed in this section</h3>
<p>As you add food and activities, total nutrition intake and output will be calculated. Calculation methods and
    references can also be found below. </p>
<div class="row">
    <%--<div class="col-md-6 col-sm-6">--%>
    <%--<ul class="list_1">--%>
    <%--<li><a href="#">Ceteros mediocritatem</a></li>--%>
    <%--<li><a href="#">Labore nostrum</a></li>--%>
    <%--<li><a href="#">Primis bonorum</a></li>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <div class="col-md-6 col-sm-6">
        <div class="progress">
            <div class="progress-bar progress-bar-danger" role="progressbar"
                 data-percentage="${userSession.calorieIntakePercentage}">
            </div>
        </div>
        <p>Your daily calorie need is ${userSession.dailyCalorieNeed}. Your current intake
            is ${userSession.currentCalorieIntake}</p>
        <div class="progress">
            <div class="progress-bar progress-bar-success" role="progressbar"
                 data-percentage="${userSession.calorieOutputPercentage}">
            </div>
        </div>
        <p>Your suggested daily exercise need is ${userSession.suggestedDailyCalorieSpent}. Your current exercise amount
            is ${userSession.currentCalorieOutput}</p>
    </div>
    <div class="col-md-6 col-sm-6">
        <div class="panel-group" id="accordion">
            <c:forEach items="${userSession.consumedFoods}" var="consumedFood">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle" data-toggle="collapse"
                               data-parent="#accordion"
                               href="#${consumedFood.ndbno}">${consumedFood.foodName}<i
                                    class="indicator icon-plus pull-right"></i></a>
                        </h4>
                    </div>
                    <div id="${consumedFood.ndbno}" class="panel-collapse collapse">
                        <div class="panel-body">
                            <input type="button" class="button_medium add_top" value="Remove Item"
                                   onClick="removeItem(${consumedFood.ndbno});">
                            <c:forEach items="${consumedFood.persistedNutritionList}" var="nutrition">
                                <p>${nutrition.nutritionName}
                                    - ${nutrition.nutritionUnitValue} ${nutrition.nutritionUnit}</p>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:forEach items="${userSession.completedExercises}" var="completedExercise">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle" data-toggle="collapse"
                               data-parent="#accordion"
                               href="#${completedExercise.guid}">${completedExercise.exercise.type}<i
                                    class="indicator icon-plus pull-right"
                            ></i></a>
                        </h4>
                    </div>
                    <div id="${completedExercise.guid}" class="panel-collapse collapse">
                        <div class="panel-body">
                            <input type="button" class="button_medium add_top" value="Remove Item"
                                   onClick="removeItem(${completedExercise.hash});">
                            <p>${completedExercise.exercise.type} for ${completedExercise.duration} hours.</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- End row -->
