@StatusV2 = React.createClass
  displayName: "StatusV2"

  render: ->
    <li className='status_container'>
      <div className='author_image'>
        <img src='https://s3.amazonaws.com/uifaces/faces/twitter/vladarbatov/128.jpg' />
      </div>

      <div className='status'>
        <header>
          <span className='author_name'>
            Donovan Benfouzari
          </span>

          <span className='time_ago'>
            16 minutes ago
          </span>
        </header>

        <div className='content'>
          <img src='https://i.ytimg.com/vi/rTMTYz37-rU/maxresdefault.jpg'/>
          <p>Lorem ipsum In qui ullamco voluptate in aliquip qui id do velit deserunt exercitation velit enim velit nisi ut do elit consectetur labore consectetur officia deserunt Ut velit aute ad dolor adipisicing.</p>
        </div>

        <div className='bottom'>
          <ul className='actions'>
            <li>
              <a href='#'>
                <i className='fa fa-heart'></i>
                Like
              </a>
            </li>
            <li>
              <a href='#'>
                <i className='fa fa-comments-o'></i>
                Comment
              </a>
            </li>
            <li>
              <a href='#'>
                <i className='fa fa-share-alt'></i>
                Like
              </a>
            </li>
          </ul>
        </div>
      </div>
    </li>
