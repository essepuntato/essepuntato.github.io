
//	
//	$('ol.maincitolist').bind('click', function() {
//		myChanger.change($('p.otheramo'));
//	})
//
//}


//
//
// $(this).find('.otheramo').toggle()
//
//
//


$(document).ready(function(){
		
	function change(element) {
		console.info("Receiving request to 'change' on element: " + (element.prop("nodeName")) + " with id: " + (element.prop("id")) + 
				"and class: " + (element.prop("class")));
		element.toggle('slow');
		console.log("Toggle successful");
	}
	
	$('#amoIndexTitle').bind('click', function() {
		change($('ol.mainamolist'));
		console.log("Bound the change on click over #amoIndexTitle to the element 'ol.mainamolist'");
	})

	$('#citoIndexTitle').bind('click', function() {
		change($('ul.maincitolist'));
		console.log("Bound the change on click over #citoIndexTitle to the element 'ul.maincitolist'");
	})
	
	// Problema: non va in Chrome (MA PORCO CANE FINO A 10 MINUTI FA ANDAVA!)
	// BELLO, aggiungere righe di console rovina il funzionamento (WTF)
	// RISOLTO, JAVASCRIPT MERDA.
	var last_tooltip = null;
	console.log("last_tooltip is: " + last_tooltip + " (should be null) ")
	
	$('.claimtext').mouseenter(function() {
		
		var local_tooltip = $(this).find('span.tooltip');
		
		console.log("local_tooltip found is: " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
			+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
		if (last_tooltip != null) {
		console.log("last_tooltip is: " + + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
			+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
		}
		
		if (local_tooltip != last_tooltip) {
			console.log("Toggling tooltip");
			
			if (last_tooltip != null) {
				last_tooltip.toggle();
			}
			
			local_tooltip.toggle();
			
			console.log("After TOGGLE LOCAL is : " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
				+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
			if (last_tooltip != null) {
			console.log("After TOGGLE LAST is: " + + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
			+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
			}
				
			last_tooltip = local_tooltip;
			
			console.log("After REASSIGN local : " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
				+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
			console.log("After REASSIGN last (should be =) : " + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
				+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
		}
	})
	
	$('a.intra_ref').mouseenter(function() {
		
		var local_tooltip = $(this).parent().find('span.tooltip');
		
		console.log("local_tooltip found is: " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
			+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
		if (last_tooltip != null) {
		console.log("last_tooltip is: " + + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
			+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
		}
		
		if (local_tooltip != last_tooltip) {
			console.log("Toggling tooltip");
			
			if (last_tooltip != null) {
				last_tooltip.toggle();
			}
			
			local_tooltip.toggle();
			
			console.log("After TOGGLE LOCAL is : " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
				+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
			if (last_tooltip != null) {
			console.log("After TOGGLE LAST is: " + + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
			+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
			}
				
			last_tooltip = local_tooltip;
			
			console.log("After REASSIGN local : " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") 
				+ " href: " + local_tooltip.attr("href") + " class: " + local_tooltip.prop("class"));
			console.log("After REASSIGN last (should be =) : " + last_tooltip.prop("nodeName") + " id: " + last_tooltip.prop("id") 
				+ " href: " + last_tooltip.attr("href") + " class: " + last_tooltip.prop("class"));
		}
	})
	
	// MUAHAHAHAHAHAHAHAH VA TUTTOOOOOOOHHH!!!!
	// MAUAHAHAHAHAHA!!
	
	
	// In realtà va QUASI - ME LA DEVO STUDIARE MEGLIO - PRIMA FINIAMO LA CSS - ANCHE NO, RISOLVIAMO QUESTA CHE CON LA CSS NON SI VEDE IL PROBLEMA!
	// CAPITO IL PERCHE', è perchè NON HO UN CAZZO CON CUI CONFRONTARE.
	
	// DEVO RIGENERARE L'HTML
	
	// FONDAMENTALE QUESTO:
	
	// onclick="$(this).find('.otheramo').toggle()" nell'argument
	// ed anche
	// onclick="$(this).find('.internalReference').toggle()" nei property --- DONE
	// E pure
	// HO TROPPI UL sotto i property! --- DONE
	// E INFINE DEVO APPUNTO PROCURARMI ID NEI TOOLTIPS --- DONE
	// MI ERO DIMENTICATO CHE LA INTERNALREFERENCE DEVE PARTIRE HIDDATA
	// RIGENERO HTML E SPERIMMO ABBUONO
	// 
	
	// .....................
	
	
	
	// Manco questo
	// var last_tooltip = null;
	// console.log("last_tooltip is: " + last_tooltip + " (should be null) ")
// 	
	// $('.claims').mouseenter(function() {
// 		
		// var local_tooltip = $(this).find('span.infotip');
		// console.log("local_tooltip found is: " + local_tooltip.prop("nodeName") + " id: " + local_tooltip.prop("id") + " class: " + local_tooltip.prop("class"));
// 		
		// if (local_tooltip != last_tooltip) {
			// // local_tooltip.toggle();
			// // last_tooltip.hide();
			// // local_tooltip.show();
// 			
			// last_tooltip = local_tooltip;
		// }
	// })
// 	


	// $(document).mouseover(function() {
		// last_tooltip.show();
	// })
	
	
	
	
//	var amolistclaims = $('ol.mainamolist').find('div.claims');
//	var amolistlength = amolistclaims.length;
//	
//	for (var i=0; i < amolistlength; i++) {
//		$(amolistclaims[i]).parent().find('.otheramo').toggle();
//	}
// QUESTO VA (giusto per prova)!!

// QUESTO NON VA---- RAGIONI: SCONOSCIUTE! (Viene chiamato correttamente, ma non fa niente il toggle!!)
//
//	var amolistargs = $('ol.mainamolist').find('div.argument') 
//	console.log("General variable amolistargs is long: " + amolistargs.length);
//	
//	for (var i=0; i < amolistargs.length; i++) {
//		
//		var currentarg = $(amolistargs[i]);
//		var currentothers = currentarg.find('.otheramo');
//		
//		console.group("Iteration on amolist #"+i);
//		console.log("currentarg is: " + currentarg.prop("nodename") + " with id: " + currentarg.prop("id") + " and class: " + currentarg.prop("class"));
//		console.log("currentothers is long:" + currentothers.length);
//		console.groupEnd();
//		
//		for (var j=0; j < currentothers.length; j++)
//			{
//			var sonqui = $(currentothers[j]);
//			
//			console.log("At the iteration i:"+i+",j:"+j+" The current other being examined is: " + sonqui.prop("nodename") + 
//					" id: " + sonqui.prop("id") + " class: " + sonqui.prop("class"));
//			currentarg.bind('click', function() {
//				change(sonqui);
//			})
//			}
//		}
//	
//
//	var amoclaims = $('ol.mainamolist').find('div.claims'); 
//	console.log("General variable amolistargs is long: " + amoclaims.length);
//	
//	for (var i=0; i < amoclaims.length; i++) {
//		
//		var currentclaim = $(amoclaims[i]);
//		var currentothers = currentclaim.parent().find('.otheramo');
//		
//		console.group("Iteration on amoclaims #"+i);
//		console.log("currentclaim is: " + currentclaim.prop("nodename") + " with id: " + currentclaim.prop("id") + " and class: " + currentclaim.prop("class"));
//		console.log("currentothers is long:" + currentothers.length);
//		console.groupEnd();
//		
//		for (var j=0; j < currentothers.length; j++)
//			{
//			var sonqui = $(currentothers[j]);
//			
//			console.log("At the iteration i:"+i+",j:"+j+" The current other being examined is: " + sonqui.prop("nodename") + 
//					" id: " + sonqui.prop("id") + " class: " + sonqui.prop("class"));
//			currentclaim.bind('click', function() {
//				change(sonqui);
//			})
//			}
//		}
//
//	
	
	
	
// OLD USELESS	
//	var amolistclaims = $('ol.mainamolist').find('div.claims') 
//	var amolistlength = amolistclaims.length;
//	
//	for (var i=0; i < amolistlength; i++) {
//		$(amolistclaims[i]).parent().bind('click', function() {
//			
//			var otherfound = $(amolistclaims[i]).parent().find('.otheramo');
//			
//			for (var j=0; j < otherfound.length; j++) {
//				change($(otherfound[j]));
//			}
//			
////			$(amolistclaims[i]).parent().find('.otheramo').toggle();
//		})
//	}

	
//	for (var i=0; i < $('ol.mainamolist').find('div.claims').length; i++) {
//		
//	  $($('ol.mainamolist').find('div.claims').get(i)).bind('click', function() {
//	  	$($('ol.mainamolist').find('div.claims').get(i)).parent().find('.otheramo');
//	  })
//	}
	
	
//	for (var i=0; i < $('ol.mainamolist').find('div.argument').length; i++) {
//		
//	  $($('ol.mainamolist').find('div.argument')[i]).bind('click', function() {
//	  	$($('ol.mainamolist').find('div.argument')[i]).find('.otheramo');
//	  })
//	}
	
	
//	$('ol.mainamolist').find('div.claims').bind('click', function() {
//		change($((this).parent().find('.otheramo')));
//	})

	}
);





//
//$(document).ready(
//		
//		function()  {
//			
//			 $.variable = "this is a variable"; 
//			
//			 $fn.ThisIsAfunction = function() {
//				 // Nothing;
//			 }
//			 
//			 
//			 
//			
//		}
//)