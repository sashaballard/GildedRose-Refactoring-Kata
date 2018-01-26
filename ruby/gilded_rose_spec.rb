require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "standard items" do
      it "reduces the sell_in days by one" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
      end

      it "reduces the quality by one" do
        items = [Item.new("foo", 0, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "does not reduce the quality of an item below 0" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "reduces the quality by 2 if sell_in is less than 0" do
        items = [Item.new("foo", -1, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end

    context "Aged Brie" do
      it "reduces the sell_in days by one" do
        items = [Item.new("Aged Brie", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
      end

      it "increases the quality by one before sell_in date" do
        items = [Item.new("Aged Brie", 1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "increases the quality by two after sell_in date" do
        items = [Item.new("Aged Brie", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end


      it "doesn't increase the quality above 50"  do
        items = [Item.new("Aged Brie", 0, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "does not change the sell_in days" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end

      it "does not change the quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      it "reduces sell_in days by one" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
      end

      it "increases quality by one when there are more than 10 days left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "increases quality by two when there are between 6 and 10 days left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "increases quality by three when there are 5 or fewer days left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "decreases quality to zero past sell_in date" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "doesn't increase the quality above 50"  do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end
  end

end