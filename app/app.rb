#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'aws-sdk'

PAGE_URL = "https://www.zendesk.com/jobs/madison/"

def spam_my_phone(num, last)
    sns = Aws::SNS::Client.new({
        region: 'us-east-1'
    })

    response = sns.publish({
        topic_arn: 'arn:aws:sns:us-east-1:076479453187:NotifyMe',
        message: "ZD-Mad engineering positions changed from #{last} to #{num}."
    })

    puts response.message_id
end

def get_last_count()
    ddb = Aws::DynamoDB::Client.new({
        region: 'us-east-1'
    })

    resp = ddb.get_item({
        table_name: "zdscraper",
        key: {
            "lastNum" => "lastNum",
        }
    })

    return ("%f" % resp.item['qty']).to_i
end

def set_last_count(num)
    ddb = Aws::DynamoDB::Client.new({
        region: 'us-east-1'
    })

    resp = ddb.update_item({
        expression_attribute_names: {
            "#QTY" => "qty",
        }, 
        expression_attribute_values: {
            ":q" => num
        },
        table_name: "zdscraper",
        key: {
            "lastNum" => "lastNum"
        },
        update_expression: "SET #QTY = :q",
    })
end

last_count = get_last_count()

doc = Nokogiri::HTML(open(PAGE_URL))

jobs = doc.css('.engineeringproduct').xpath("..").css('li > h4')
len = jobs.count

if len != last_count
    puts "The count differs. Last count was #{last_count}. This count was #{len}."
    puts "Sending SMS"
    spam_my_phone(len, last_count)
    puts "Updating count"
    set_last_count(len)
end
