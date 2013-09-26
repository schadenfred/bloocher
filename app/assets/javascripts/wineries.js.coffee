# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	$("#myCanvasContainer").hide() unless $("#myCanvas").tagcanvas(
    textColour: "grey"
    , outlineColour: "grey"
    , reverse: true
    , depth: 0.8
    , maxSpeed: 0.05
    , wheelZoom: false
    , freezeActive: true
  	, "tags")

	$('#frati').popover( { 
		trigger: 'hover'
		, placement: 'right' } )

	$('.blooch').popover( { trigger: 'hover', placement: 'left'
		, title: "definition: blooch"
		, content: "To prattle on, to talk aimlessly."} )

    
  $("#review_user_email").validate
    expression: "if(VAL != '') return true; else return false;"
    message: "Bloocher will never spam you."
    
  $(".accordion-toggle").on "shown", ->
    $(this).addClass "active"

  $(".accordion-toggle").on "hidden", ->
    $(this).removeClass "active"
