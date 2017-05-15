#!/usr/bin/env python

import smtplib, sys
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

toaddrs = ''

with open('/home/yt/Documents/Sarin/Ruby/log/'+sys.argv[-2], mode='r') as data:
    informate = str(data.read().split('{')[1])
    print(informate)
    inf = '{' + informate
    info = eval(inf)
    name = info['name']
    toaddrs += info['email']

fromaddr = '........'

msg = MIMEMultipart('alternative')
msg['Subject'] = "varification email"
msg['From'] = '.......'
msg['To'] = toaddrs

text = 'varification email'

html = '<!DOCTYPE html><html><head><style>div {    width: 750px;    background-color: black;    font-size: 24px;   color: white;}div .topnav {  position: absolute;  height: 45px;  top:1px;  left: 7px;  overflow: hidden;  background-color:#808080;}div .topnav a {  float:left;  display: block;  color: #f2f2f2;  text-align: center;  padding: 14px 16px;  text-decoration: none;  font-size: 17px;}div .topnav a:hover {  background-color: black;  color: 	#00FFFF;}</style></head><body><div><div class="topnav">  <a href="https://sarin.io/">Sarin</a></div><p>&nbsp;</p><p style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hi '
html += str(name)
html +=  ' &nbsp;&nbsp;</p><pstyle="color:white">&nbsp;&nbsp;tnx for creating an account at .......&nbsp;&nbsp;</p><p style="color:white">&nbsp;&nbsp;we hope you will find our services usefull.&nbsp;</p><p style="color:white">&nbsp;&nbsp;For further information, please dont hesitate to contact&nbsp;</p><p  style="color:white">&nbsp;&nbsp;relay@sarin.io&nbsp;</p><p  style="color:white">&nbsp;&nbsp;for activating your account you only need to verify your&nbsp;</p><p  style="color:white">&nbsp;&nbsp;phone number.&nbsp;</p><p>&nbsp;&nbsp;an sms was sent to your phone with a 5 digit code&nbsp;</p><p>&nbsp;&nbsp;please refer to the link below to</p><a href="https://sarin.io:'
html += str(sys.argv[-1])
html += "/"
html += str(sys.argv[-2])
html += "/"
html += 'activate" style="color: white;">&nbsp;&nbsp;Activate your account.</a><p>&nbsp;&nbsp;best regards .......&nbsp;&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p style="position: absolute; left:22%; top:125%;">Sarin.io</p><p>&nbsp; <p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p></div></body></html>'

part1 = MIMEText(text, 'plain')
part2 = MIMEText(html, 'html')

msg.attach(part1)
msg.attach(part2)

username = '.........'
password = '.........'
server = smtplib.SMTP('smtp.gmail.com:587')
server.ehlo()
server.starttls()
server.login(username,password)
server.sendmail(fromaddr, toaddrs, msg.as_string())
server.quit()


