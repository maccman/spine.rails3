class Page extends Spine.Model
  @configure "Page", "name", "slug", "body"
  @extend Spine.Ajax

module.exports = Page