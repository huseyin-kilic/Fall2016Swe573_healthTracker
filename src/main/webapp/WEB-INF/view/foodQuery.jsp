<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<jsp:include page="htmlHeader.jsp"/>
<body>
<jsp:include page="preloader.jsp"/>

<div id="main-wrapper">

    <jsp:include page="header.jsp"/>

    <div class="row" id="row-main">
        <div class="col-lg-6 col-md-5" id="main-img-container">
            <div id="main-img">
                <img src="img/healthyImage1.jpg" alt=""/>
            </div><!-- End main-img -->
        </div><!-- End main-img-container -->

        <div class="col-lg-6 col-lg-offset-6 col-md-7 col-md-offset-5">
            <div class="row" id="content-row">

                <div class="col-md-12">
                    <h1>Please Enter Name of the Food</h1>
                    <p class="lead">
                        You can search for a food and select the collapsable panel to see it's nutrition details.
                        Start typing name of the foods and the results will be shown if we can find what you are looking
                        for.
                    </p>
                    <p> All calculations and estimations are done based on this project on github. Please refer <a
                            href="https://github.com/Mephala/Fall2016Swe573_healthTracker">my github project</a>. </p>

                    <hr class="add_bottom_30">

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group"><label>Date of your activities:</label></div>
                            <div class="form-group"><input type="date" id="inputDate"
                                                           value="${userSession.activityQueryDate}"></div>
                        </div>
                        <div class="col-md-6 col-sm-6">
                            <form action="${servletRoot}/doQueryFood" method="post" id="foodSearchForm">

                                <div class="form-group"><input type="text" class="form-control" name="foodName"
                                                               id="foodQueryInput"
                                                               placeholder="Food Name"></div>
                                <div class="form-group" id="foodAmountDiv" style="display: none;"><input type="text"
                                                                                                         class="form-control"
                                                                                                         name="foodAmount"
                                                                                                         id="foodQueryAmount"
                                                                                                         placeholder="Amount in (mgs)">
                                </div>
                                <div class="form-group" id="foodUnitDiv" style="display: none;">
                                    <div class="styled-select">
                                        <select class="form-control" name="foodUnit" id="foodUnitSelector">
                                            <%--<option value="kilo">By Kilo (KG)</option>--%>
                                            <%--<option value="pounds">By Pounds</option>--%>
                                        </select>
                                    </div>
                                </div>

                                <%--<input type="submit" class="button_medium add_top" value="Search"--%>
                                <%--onClick="this.form.submit(); this.disabled=true; this.value='SEARCHING…'; ">--%>
                                <input type="submit" class="button_medium add_top" value="Add Food"
                                       onClick="return addFood();" id="addFoodButton">
                            </form>
                        </div><!-- End col-md-6 -->
                        <div class="col-md-6 col-sm-6">
                            <form action="${servletRoot}/doQueryExercise" method="post" id="exerciseSearchForm">
                                <div class="form-group"><input type="text" class="form-control" name="exerciseName"
                                                               id="exerciseSearchInput"
                                                               placeholder="Search for exercise name"></div>
                                <div class="form-group" id="exerciseAmountDiv"><input type="text"
                                                                                      class="form-control"
                                                                                      name="exerciseAmount"
                                                                                      id="exerciseQueryAmount"
                                                                                      placeholder="How many hours ?">
                                </div>

                                <%--<input type="submit" class="button_medium add_top" value="Search"--%>
                                <%--onClick="this.form.submit(); this.disabled=true; this.value='SEARCHING…'; ">--%>
                                <input type="submit" class="button_medium add_top" value="Add Exercise"
                                       onClick="return addExercise();" id="addExerciseButton">
                            </form>
                        </div><!-- End col-md-6 -->

                        <div class="col-md-6 col-sm-6">
                            <c:if test="${searchResultFound}">
                                <div class="panel-group" id="accordion">
                                    <c:forEach items="${foodResults.basicFoodResponseList}" var="item">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a class="accordion-toggle" data-toggle="collapse"
                                                       data-parent="#accordion"
                                                       href="#${item.hrefId}">${item.title}<i
                                                            class="indicator icon-plus pull-right"></i></a>
                                                </h4>
                                            </div>
                                            <div id="${item.hrefId}" class="panel-collapse collapse">
                                                <div class="panel-body">
                                                        ${item.json}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div><!-- End col-md-6-->
                    </div><!-- End row-->
                    <button class="button_medium" data-toggle="modal" data-target="#myModal" style="display: none;"
                            id="nonRegisteredUserButton">
                        Launch demo modal
                    </button>
                    <!-- Modal -->
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="myModalLabel">You are not Registered!</h4>
                                </div>
                                <div class="modal-body">
                                    <h4>You must register to our system in order to use food & activity reports.</h4>
                                    <p>
                                        Please follow <a href="${servletRoot}/loginOrRegister">this link</a> to login or
                                        register.
                                    </p>
                                    <p>
                                        You only need to enter a username and password information to register, no
                                        sensitive data
                                        is asked.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="userActivitiesDiv">

                    </div>


                    <hr>

                    <h3>What are the references of this website ?</h3>
                    <p>This website is prepared as a course-project in Bogazici University / Turkey. All calculations
                        and estimations are done based on the following references. </p>
                    <div class="row">
                        <%--<div class="col-md-6 col-sm-6">--%>
                        <%--<ul class="list_1">--%>
                        <%--<li><a href="#">Ceteros mediocritatem</a></li>--%>
                        <%--<li><a href="#">Labore nostrum</a></li>--%>
                        <%--<li><a href="#">Primis bonorum</a></li>--%>
                        <%--</ul>--%>
                        <%--</div>--%>
                        <div class="col-md-6 col-sm-6">
                            <ul class="list_2">
                                <li><a href="http://www.nutristrategy.com/activitylist4.htm">Activity List
                                    reference </a></li>
                                <li><a href="https://ndb.nal.usda.gov/ndb/doc/">NDB API</a></li>
                                <li><a href="https://en.wikipedia.org/wiki/Body_mass_index">Wikipedia Body/Mass
                                    Index </a></li>
                            </ul>
                        </div>
                    </div><!-- End row -->

                    <%--<footer>--%>
                    <%--<p>Copyright © 2014</p>--%>
                    <%--<ul id="contact_follow">--%>
                    <%--<li><a href="#"><span class="icon-instagram"></span></a></li>--%>
                    <%--<li><a href="#"><span class="icon-facebook"></span></a></li>--%>
                    <%--<li><a href="#"><span class="icon-twitter"></span></a></li>--%>
                    <%--<li><a href="#"><span class=" icon-googleplus"></span></a></li>--%>
                    <%--</ul>--%>
                    <%--</footer><!-- End footer -->--%>

                </div><!-- End col-md-12 -->
            </div><!-- End content-row -->
        </div><!-- End col-lg-6-->
    </div><!-- End main-row -->
</div><!-- End main-wrapper  -->


<input type="hidden" id="protocol" value="http://"/>
<input type="hidden" id="serverRootUrl" value="${serverBase}"/>
<input type="hidden" id="ajaxSearchUrl" value="${serverContext}/ajax/queryFoodName"/>
<input type="hidden" id="ajaxAddFoodUrl" value="${serverContext}/ajax/addFood"/>
<input type="hidden" id="checkLoginUrl" value="${serverContext}/ajax/isLogin"/>
<input type="hidden" id="searchExerciseUrl" value="${serverContext}/ajax/searchExercise"/>
<input type="hidden" id="addExerciseUrl" value="${serverContext}/ajax/addExercise"/>
<input type="hidden" id="retrieveActivitiesUrl" value="${serverContext}/ajax/retrieveActivities"/>
<input type="hidden" id="removeItemUrl" value="${serverContext}/ajax/removeItem"/>
<input type="hidden" id="userLoginCheck" value="${userSession.login}">

<!-- OTHER JS -->
<script src="js/calories_calculators.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/retina-replace.min.js"></script>
<script src="js/jquery.placeholder.js"></script>
<script src="js/functions.js"></script>
<script src="js/jquery-ui.js"></script>

<script>
    $(function () {
        $("#foodQueryInput").on('input', function () {
            var input = $("#foodQueryInput").val();
            if (input.length >= 2) {
                var data = {
                    searchKeyword: input
                };
                var protocol = $("#protocol").val();
                var serverRootUrl = $("#serverRootUrl").val();
                var loginPostUri = $("#ajaxSearchUrl").val();
                $.ajax
                ({
                    type: "POST",
                    url: protocol + serverRootUrl + loginPostUri,
                    dataType: 'JSON',
                    contentType: "application/json; charset=utf8",
                    async: true,
                    data: JSON.stringify(data),
                    beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
                    },
                    success: function (data) {
                        console.log(data.availableKeywords);
                        var availableNames = data.availableKeywords;
                        $("#foodQueryInput").autocomplete({
                            source: availableNames,
                            minLength: 0,
                            select: function (event, ui) {
                                var selectedFoodName = ui.item.value;
                                $('#foodQueryAmount').val('');
//                                $('#foodQueryAmount').attr('placeholder', 'Amount with selected unit above:' + data.unitMap[selectedFoodName]);
                                $('#foodQueryAmount').attr('placeholder', 'Amount with selected units below:');
                                var len = data.unitMap[selectedFoodName].length;
                                var amountOptionsHtml = "";
                                for (var i = 0; i < len; i++) {
                                    amountOptionsHtml += "<option value=\"" + data.unitMap[selectedFoodName][i] + "\">" + data.unitMap[selectedFoodName][i] + "</option>";
                                }
                                $('#foodUnitSelector').html(amountOptionsHtml);
                                $('#foodAmountDiv').show();
                                $('#foodUnitDiv').show();
                                try {
                                    console.log("Available amount units:" + JSON.stringify(data.unitMap[selectedFoodName]));
                                } catch (err) {
                                    console.log("ERROR GETTING AMOUNT UNITS!:" + err.message);
                                }
                            }
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert("ErrorCode: HT001 : " + thrownError);
                        console.log(xhr.responseText);
                    }
                });
            }

        });
    });

    function addFood() {
        var protocol = $("#protocol").val();
        var serverRootUrl = $("#serverRootUrl").val();
        var checkLoginUrl = $("#checkLoginUrl").val();
        $.ajax
        ({
            type: "GET",
            url: protocol + serverRootUrl + checkLoginUrl,
            dataType: 'json',
            contentType: "application/json; charset=utf8",
            async: false,
            data: '',
            beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
            },
            success: function (data) {
                console.log("User Login status:" + data.login);
                var login = data.login;
                if (login) {
                    var input = $("#foodQueryInput").val();
                    var amount = $('#foodQueryAmount').val();
                    var date = $('#inputDate').val();
                    var unit = $('#foodUnitSelector').val();
                    console.log("Selected unit:" + unit);
                    $('#addFoodButton').val("Adding...");
                    var protocol = $("#protocol").val();
                    var serverRootUrl = $("#serverRootUrl").val();
                    var addFoodUrl = $("#ajaxAddFoodUrl").val();
                    if (!(amount && input)) {
                        alert("Please enter valid food name and amount");
                        $('#addFoodButton').val("Add Food");
                        return;
                    }
                    if (isNaN(amount)) {
                        alert("Please enter numerical amount");
                        $('#addFoodButton').val("Add Food");
                        return;
                    }
                    var data = {
                        addedFood: input,
                        amount: amount,
                        date: date,
                        unit: unit
                    };
                    $.ajax
                    ({
                        type: "POST",
                        url: protocol + serverRootUrl + addFoodUrl,
                        dataType: 'html',
                        contentType: "application/json; charset=utf8",
                        async: false,
                        data: JSON.stringify(data),
                        beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
                        },
                        success: function (data) {
                            console.log("Completed adding food.");
                            $('#userActivitiesDiv').html(data);
                            $('.progress .progress-bar').each(function () {
                                var me = $(this);
                                var perc = me.attr("data-percentage");

                                var current_perc = 0;

                                var progress = setInterval(function () {
                                    if (current_perc >= perc) {
                                        clearInterval(progress);
                                    } else {
                                        current_perc += 1;
                                        me.css('width', (current_perc) + '%');
                                    }

                                    me.text((current_perc) + '%');

                                }, 50);

                            });
                            $('#addFoodButton').val("Add Food");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            alert("ErrorCode: HT001 : " + thrownError);
                            console.log(xhr.responseText);
                            $('#addFoodButton').val("Add Food");
                        }
                    });

                } else {
                    $("#nonRegisteredUserButton").click();
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert("ErrorCode: HT002 : " + thrownError);
                console.log(xhr.responseText);
            }
        });


        return false;
    }

    $("#exerciseSearchInput").on('input', function () {
        var q = $("#exerciseSearchInput").val();
        var protocol = $("#protocol").val();
        var serverRootUrl = $("#serverRootUrl").val();
        var searchExerciseUrl = $("#searchExerciseUrl").val();
        var data = {
            searchKeyword: q
        };
        $.ajax
        ({
            type: "POST",
            url: protocol + serverRootUrl + searchExerciseUrl,
            dataType: 'JSON',
            contentType: "application/json; charset=utf8",
            async: true,
            data: JSON.stringify(data),
            beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
            },
            success: function (data) {
                console.log(data.availableKeywords);
                var availableNames = data.availableKeywords;
                $("#exerciseSearchInput").autocomplete({
                    source: availableNames
                });
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert("ErrorCode: HT003 : " + thrownError);
                console.log(xhr.responseText);
            }
        });
    });

    $(document).ready(function () {
        invokeDateChange();
    });

    function invokeDateChange() {
        var dateString = $('#inputDate').val();
        retrieveActivitiesByDate(dateString);
    }

    $("#inputDate").on('input', function () {
        invokeDateChange();
    });


    function retrieveActivitiesByDate(date) {
        var isLogin = $('#userLoginCheck').val();
        if (isLogin == 'true') {
            var protocol = $("#protocol").val();
            var serverRootUrl = $("#serverRootUrl").val();
            var retrieveActivitiesUrl = $("#retrieveActivitiesUrl").val();
            $.ajax
            ({
                type: "POST",
                url: protocol + serverRootUrl + retrieveActivitiesUrl,
                dataType: 'html',
                contentType: "text/plain",
                async: false,
                data: date,
                beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
                },
                success: function (data) {
                    console.log("Completed adding food.");
                    $('#userActivitiesDiv').html(data);
                    $('.progress .progress-bar').each(function () {
                        var me = $(this);
                        var perc = me.attr("data-percentage");

                        var current_perc = 0;

                        var progress = setInterval(function () {
                            if (current_perc >= perc) {
                                clearInterval(progress);
                            } else {
                                current_perc += 1;
                                me.css('width', (current_perc) + '%');
                            }

                            me.text((current_perc) + '%');

                        }, 50);

                    });
                    $('#addExerciseButton').val("Add Exercise");
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert("ErrorCode: HT005 : " + thrownError);
                    console.log(xhr.responseText);
                    $('#addExerciseButton').val("Add Exercise");
                }
            });
        }
    }

    function addExercise() {


        var protocol = $("#protocol").val();
        var serverRootUrl = $("#serverRootUrl").val();
        var checkLoginUrl = $("#checkLoginUrl").val();
        $.ajax
        ({
            type: "GET",
            url: protocol + serverRootUrl + checkLoginUrl,
            dataType: 'json',
            contentType: "application/json; charset=utf8",
            async: false,
            data: '',
            beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
            },
            success: function (data) {
                console.log("User Login status:" + data.login);
                var login = data.login;
                if (login) {
                    var input = $("#exerciseSearchInput").val();
                    var amount = $('#exerciseQueryAmount').val();
                    var date = $('#inputDate').val();
                    $('#addExerciseButton').val("Adding...");
                    var protocol = $("#protocol").val();
                    var serverRootUrl = $("#serverRootUrl").val();
                    var addExerciseUrl = $("#addExerciseUrl").val();
                    if (!(amount && input)) {
                        alert("Please enter valid exercise name and amount");
                        $('#addExerciseButton').val("Add Exercise");
                        return;
                    }
                    if (isNaN(amount)) {
                        alert("Please enter numerical amount");
                        $('#addExerciseButton').val("Add Exercise");
                        return;
                    }
                    var data = {
                        addedFood: input,
                        amount: amount,
                        date: date
                    };
                    $.ajax
                    ({
                        type: "POST",
                        url: protocol + serverRootUrl + addExerciseUrl,
                        dataType: 'html',
                        contentType: "application/json; charset=utf8",
                        async: false,
                        data: JSON.stringify(data),
                        beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
                        },
                        success: function (data) {
                            console.log("Completed adding food.");
                            $('#userActivitiesDiv').html(data);
                            $('.progress .progress-bar').each(function () {
                                var me = $(this);
                                var perc = me.attr("data-percentage");

                                var current_perc = 0;

                                var progress = setInterval(function () {
                                    if (current_perc >= perc) {
                                        clearInterval(progress);
                                    } else {
                                        current_perc += 1;
                                        me.css('width', (current_perc) + '%');
                                    }

                                    me.text((current_perc) + '%');

                                }, 50);

                            });
                            $('#addExerciseButton').val("Add Exercise");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            alert("ErrorCode: HT005 : " + thrownError);
                            console.log(xhr.responseText);
                            $('#addExerciseButton').val("Add Exercise");
                        }
                    });

                } else {
                    $("#nonRegisteredUserButton").click();
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert("ErrorCode: HT006 : " + thrownError);
                console.log(xhr.responseText);
            }
        });

        return false;
    }

    function removeItem(itemId) {
        console.log("Removing item with id:" + itemId);
        var protocol = $("#protocol").val();
        var serverRootUrl = $("#serverRootUrl").val();
        var removeItemUri = $("#removeItemUrl").val();
        var date = $('#inputDate').val();
        var postData = {
            date: date,
            itemId: itemId
        };
        $.ajax
        ({
            type: "POST",
            url: protocol + serverRootUrl + removeItemUri,
            dataType: 'html',
            contentType: "application/json; charset=utf8",
            async: false,
            data: JSON.stringify(postData),
            beforeSend: function (xhr) {
//                    userAuthToken = make_base_auth(username, password);
//                    xhr.setRequestHeader('Authorization', userAuthToken);
            },
            success: function (data) {
                data = JSON.parse(data);
                if (data.completed == true) {
                    console.log("Completed!!!");
                    retrieveActivitiesByDate(date);
                } else {
                    alert(data.promptMsg);
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert("ErrorCode: HT035 : " + thrownError);
                console.log(xhr.responseText);
            }
        });
    }
</script>


</body>
</html>