Global = {
  changePhoto: function(){
    $(this).find('img.hide').removeClass("hide");
    $(this).find('img.first').addClass("hide");
  },
  showFirstPhoto: function(){
    $(this).find('img').addClass("hide");
    $(this).find('img.first').removeClass("hide");
  },
	init: function(){
    $('.carousel').carousel({
    	interval: 2000
    });

    // $(".image_group").hover(Global.changePhoto, Global.showFirstPhoto)
	}
};
$(Global.init);