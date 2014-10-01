module Qiita
  module Markdown
    class Processor
      DEFAULT_CONTEXT = {
        asset_root: "/images",
      }

      DEFAULT_FILTERS = [
        Filters::Redcarpet,
        HTML::Pipeline::EmojiFilter,
        Filters::Code,
        HTML::Pipeline::SyntaxHighlightFilter,
        Filters::Mention,
      ]

      # @param [Hash] context Optional context for HTML::Pipeline.
      def initialize(context = {})
        @context = DEFAULT_CONTEXT.merge(context)
      end

      # Converts Markdown text into HTML string with extracted metadata.
      #
      # @param [String] input Markdown text.
      # @return [Hash] Process result.
      # @example
      #   Qiita::Markdown::Processor.new.call(markdown) #=> {
      #     codes: [...],
      #     mentioned_usernames: [...],
      #     output: "...",
      #   }
      def call(input)
        HTML::Pipeline.new(filters, @context).call(input)
      end

      # @note Modify filters if you want.
      # @return [Array<HTML::Pipeline::Filter>]
      def filters
        @filters ||= DEFAULT_FILTERS
      end
    end
  end
end
