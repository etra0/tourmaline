module Tourmaline
  class MessageEntity
    include JSON::Serializable
    include Tourmaline::Model

    MENTION_TYPES = %w[
      mention text_mention hashtag cashtag bot_command url email phone_number
      bold italic code pre text_link underline strikethrough spoiler
    ]

    property type : String

    property offset : Int32

    property length : Int32

    property url : String?

    property user : User?

    property language : String?

    def initialize(@type, @offset = 0, @length = 0, @url = nil, @user = nil, @language = nil)
    end

    {% for mention_type in MENTION_TYPES %}
      def {{mention_type.id}}?
        @type == {{mention_type}}
      end
    {% end %}

    def ==(other)
      other.is_a?(MessageEntity) &&
      other.type == type &&
      other.offset == offset &&
      other.length == length &&
      other.url == url &&
      other.user == user &&
      other.language == language
    end
  end
end
