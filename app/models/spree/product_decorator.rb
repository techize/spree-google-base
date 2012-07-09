module Spree
  Product.class_eval do
    scope :google_base_scope, includes(:taxons)
    
    def google_base_description
      description
    end
    
    def google_base_condition
      'new'
    end

    def google_category
      'Hardware &gt; Tools'
    end

    def google_base_brand
      'GLW'
    end

    def google_product_category
      'Hardware &gt; Tools &gt; Wire &amp; Cable Tools &gt; Wire Crimpers'
    end

    def google_base_image_link
      images.first.attachment.url(:product)
    end
    def google_availability
      'in stock'
    end

    def google_base_product_type
      return nil unless Spree::GoogleBase::Config[:enable_taxon_mapping]
      product_type = ''
      priority = -1000
      self.taxons.each do |taxon|
        if taxon.taxon_map && taxon.taxon_map.priority > priority
          priority = taxon.taxon_map.priority
          product_type = taxon.taxon_map.product_type
        end
      end
      product_type
    end
  end
end
