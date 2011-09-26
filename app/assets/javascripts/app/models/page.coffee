class Page extends Spine.Model
  @configure "Page", "name", "slug", "body"
  @extend Spine.Model.Ajax

window.Page = Page