require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage(page_url)
    page = Nokogiri::HTML(open(page_url))

    reg = /.+@.+\.\w+/

    adresse = page.css('td.style27 p.Style22').select do |elt|
        elt.text.match?(reg)
    end

    adresse.join("")[1..-1]
end

def get_all_the_emails_of_val_doise_townhalls
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    annuaire = Hash.new(0)

    page.css("a.lientxt").each do |l|
        ville = l.text
        lien = "http://annuaire-des-mairies.com" + l['href'][1..-1]
        email = get_the_email_of_a_townhal_from_its_webpage("#{lien}")
        annuaire[ville] = email
    end

    puts annuaire
end

get_all_the_emails_of_val_doise_townhalls
