@NewsFeedBlock = React.createClass
  getDefaultProps: ->
    header:
      author: 'Author'

    content: "Lorem ipsum Dolore ut ut laboris nostrud reprehenderit in ex ullamco culpa dolore consectetur aliquip eiusmod elit quis et laboris non Excepteur et veniam in irure sed eu quis laboris sint nostrud aute fugiat mollit aliquip et anim cupidatat sunt ea et aliquip voluptate consectetur Excepteur cillum do proident tempor minim id eiusmod sunt dolore nisi ut id ut."

  render: ->
    <div className='news_feed_block' aria-label='Actualité'>
      <div className='news_feed_block_header'>
        <a href='#' className='news_feed_author_image'>
          <img src='http://placehold.it/40x40'/>
        </a>

        <div className='news_feed_infos_wrapper'>
          <div className='news_feed_infos'>
            <div className='vam'>
              <h5>
                <a className='news_feed_author_name' href='#'>
                  { @props.header.author }
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
