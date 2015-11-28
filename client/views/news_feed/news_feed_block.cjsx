@NewsFeedBlock = React.createClass
  getDefaultProps: ->
    author: 'Author'
    image: 'http://placehold.it/40x40'
    content: "This is a sticky status update, it's really awesome for quick updates
              and the comments are AJAX-ed so there's no waisting time on
              reloading the page. Cool right?"

  render: ->
    <div className='news_feed_block' aria-label='Actualité'>
      <div className='news_feed_block_header'>
        <a href='#' className='news_feed_author_image'>
          <img src={ @props.image }/>
        </a>

        <div className='news_feed_infos_wrapper'>
          <div className='news_feed_infos'>
            <div className='vam'>
              <h5>
                <a className='news_feed_author_name' href='#'>
                  { @props.author }
                </a>
              </h5>

              <span className='news_feed_time_ago'>
                5 min
              </span>
            </div>
          </div>
        </div>
      </div>

      <div className='news_feed_block_content'>
        { @props.content }
      </div>

      <div className='news_feed_block_links_wrapper'>
        <div className='news_feed_block_links'>
          <span><a href='#' className='like_link'>J'aime</a></span>
          <span><a href='#' className='comment_link'>Commenter</a></span>
          <span><a href='#' className='share_link'>Partager</a></span>
        </div>
      </div>
    </div>
