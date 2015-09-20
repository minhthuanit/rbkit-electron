React = require('react')
OverlayTrigger = require 'react-bootstrap/lib/OverlayTrigger'
Popover = require 'react-bootstrap/lib/Popover'

module.exports = React.createClass
  propTypes:
    children: React.PropTypes.element.isRequired

  render: ->
    popover = <Popover id={@props.content}>{@props.content}</Popover>
    <OverlayTrigger trigger={['hover', 'focus']} placement={@props.placement} overlay={popover}>
      {@props.children}
    </OverlayTrigger>
