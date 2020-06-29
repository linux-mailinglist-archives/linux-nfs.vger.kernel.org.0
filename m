Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30620DBBB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgF2UJE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 16:09:04 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:56503 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730719AbgF2UIV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 16:08:21 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jpvDx-0009Rm-Bc
        for linux-nfs@vger.kernel.org; Mon, 29 Jun 2020 09:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DxJCAwBZeh3FYUp8ard82LmO+iEpaSXSx041Gfw1YP8=; b=KPcoo9u/c+DS9EpYGj7EXgtXhP
        GlUTS2BxKmjsgpR0DnbTzWMmdmoL1Z8LfzTj+1XYcVhyn98fBSs8eby8rXhym8wP0o2xgga2+UoAz
        TVOONT/wc7lrqRPJ/b3dqsapusOPelWp3zybFtPIyuqhisWHoti3V8ir0kaG9Rud9vVa94TwB/bNb
        gyi4pFAmBiKvU0/UyrvlFH3PG0rXGcclo+5eI2FNNKvEbkRIRvVnlBRW79GLGD9zsn157codMPhk5
        GpHFfFROHX8VHXLIYJAaE3KQbV5ww2nIXhmYov311aD4FuX5RSYNUQCer+IrmGY3jYw318XL5OP2e
        D01fUmeg==;
Received: from [174.119.114.224] (port=60966 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jpvDw-0005Mv-TN
        for linux-nfs@vger.kernel.org; Mon, 29 Jun 2020 10:57:32 -0400
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Doug Nazar <nazard@nazar.ca>
Subject: gssd keytab resolution
Message-ID: <e61057cc-6c4b-6d88-aab2-c5d5db9bdf50@nazar.ca>
Date:   Mon, 29 Jun 2020 10:57:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AEBAEB98F9D6BA1D8E5E9A39"
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhV0qRtFXphTQ1X
 gcqc5A8IE0TNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJ+TsrBOCPRxoHzZtOBRGsFsl7H6aAPMkVWPpyCe5BmaHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSPd
 dGpuyGYco7KRuXU052lW9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5htTHU
 6zO3rj6Qx1PMXNV0GopK+X8oJE0RD/qmRO7QjEb5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------AEBAEB98F9D6BA1D8E5E9A39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

While playing around I noticed this pattern occasionally.

I was wondering if 'srchost=*' should be treated as NULL (use 
gethostname) or to just skip the loop where we call krb5_kt_get_entry() 
since that won't match with an asterisk.

Thanks,
Doug


--------------AEBAEB98F9D6BA1D8E5E9A39
Content-Type: text/plain; charset=UTF-8;
 name="log.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="log.txt"

aGFuZGxlX2dzc2RfdXBjYWxsOiAnbWVjaD1rcmI1IHVpZD0wIHNlcnZpY2U9KiBlbmN0eXBl
cz0xOCwxNywxNiwyMywzLDEsMicgKG5mcy9jbG50NGEwKQprcmI1X3VzZV9tYWNoaW5lX2Ny
ZWRzOiB1aWQgMCB0Z3RuYW1lIChudWxsKQpnc3NkX3JlZnJlc2hfa3JiNV9tYWNoaW5lX2Ny
ZWRlbnRpYWxfaW50ZXJuYWw6IGhvc3RuYW1lPXBpeGllLmRyYWdvbmluYy5jYSBwbGU9KG5p
bCkgc2VydmljZT0obnVsbCkgc3JjaG9zdD0qCkZ1bGwgaG9zdG5hbWUgZm9yICdwaXhpZS5k
cmFnb25pbmMuY2EnIGlzICdwaXhpZS5kcmFnb25pbmMuY2EnCk5vIGtleSB0YWJsZSBlbnRy
eSBmb3VuZCBmb3IgKiRARFJBR09OSU5DLkNBIHdoaWxlIGdldHRpbmcga2V5dGFiIGVudHJ5
IGZvciAnKiRARFJBR09OSU5DLkNBJwpObyBrZXkgdGFibGUgZW50cnkgZm91bmQgZm9yICok
QERSQUdPTklOQy5DQSB3aGlsZSBnZXR0aW5nIGtleXRhYiBlbnRyeSBmb3IgJyokQERSQUdP
TklOQy5DQScKTm8ga2V5IHRhYmxlIGVudHJ5IGZvdW5kIGZvciByb290LypARFJBR09OSU5D
LkNBIHdoaWxlIGdldHRpbmcga2V5dGFiIGVudHJ5IGZvciAncm9vdC8qQERSQUdPTklOQy5D
QScKTm8ga2V5IHRhYmxlIGVudHJ5IGZvdW5kIGZvciBuZnMvKkBEUkFHT05JTkMuQ0Egd2hp
bGUgZ2V0dGluZyBrZXl0YWIgZW50cnkgZm9yICduZnMvKkBEUkFHT05JTkMuQ0EnCk5vIGtl
eSB0YWJsZSBlbnRyeSBmb3VuZCBmb3IgaG9zdC8qQERSQUdPTklOQy5DQSB3aGlsZSBnZXR0
aW5nIGtleXRhYiBlbnRyeSBmb3IgJ2hvc3QvKkBEUkFHT05JTkMuQ0EnClNjYW5uaW5nIGtl
eXRhYiBmb3Igcm9vdC8qQERSQUdPTklOQy5DQQpQcm9jZXNzaW5nIGtleXRhYiBlbnRyeSBm
b3IgcHJpbmNpcGFsICdob3N0L3dyYWl0aC5kcmFnb25pbmMuY2FARFJBR09OSU5DLkNBJwpX
ZSB3aWxsIE5PVCB1c2UgdGhpcyBlbnRyeSAoaG9zdC93cmFpdGguZHJhZ29uaW5jLmNhQERS
QUdPTklOQy5DQSkKUHJvY2Vzc2luZyBrZXl0YWIgZW50cnkgZm9yIHByaW5jaXBhbCAnaG9z
dC93cmFpdGguZHJhZ29uaW5jLmNhQERSQUdPTklOQy5DQScKV2Ugd2lsbCBOT1QgdXNlIHRo
aXMgZW50cnkgKGhvc3Qvd3JhaXRoLmRyYWdvbmluYy5jYUBEUkFHT05JTkMuQ0EpClByb2Nl
c3Npbmcga2V5dGFiIGVudHJ5IGZvciBwcmluY2lwYWwgJ25mcy93cmFpdGguZHJhZ29uaW5j
LmNhQERSQUdPTklOQy5DQScKV2Ugd2lsbCBOT1QgdXNlIHRoaXMgZW50cnkgKG5mcy93cmFp
dGguZHJhZ29uaW5jLmNhQERSQUdPTklOQy5DQSkKUHJvY2Vzc2luZyBrZXl0YWIgZW50cnkg
Zm9yIHByaW5jaXBhbCAnbmZzL3dyYWl0aC5kcmFnb25pbmMuY2FARFJBR09OSU5DLkNBJwpX
ZSB3aWxsIE5PVCB1c2UgdGhpcyBlbnRyeSAobmZzL3dyYWl0aC5kcmFnb25pbmMuY2FARFJB
R09OSU5DLkNBKQpTY2FubmluZyBrZXl0YWIgZm9yIG5mcy8qQERSQUdPTklOQy5DQQpQcm9j
ZXNzaW5nIGtleXRhYiBlbnRyeSBmb3IgcHJpbmNpcGFsICdob3N0L3dyYWl0aC5kcmFnb25p
bmMuY2FARFJBR09OSU5DLkNBJwpXZSB3aWxsIE5PVCB1c2UgdGhpcyBlbnRyeSAoaG9zdC93
cmFpdGguZHJhZ29uaW5jLmNhQERSQUdPTklOQy5DQSkKUHJvY2Vzc2luZyBrZXl0YWIgZW50
cnkgZm9yIHByaW5jaXBhbCAnaG9zdC93cmFpdGguZHJhZ29uaW5jLmNhQERSQUdPTklOQy5D
QScKV2Ugd2lsbCBOT1QgdXNlIHRoaXMgZW50cnkgKGhvc3Qvd3JhaXRoLmRyYWdvbmluYy5j
YUBEUkFHT05JTkMuQ0EpClByb2Nlc3Npbmcga2V5dGFiIGVudHJ5IGZvciBwcmluY2lwYWwg
J25mcy93cmFpdGguZHJhZ29uaW5jLmNhQERSQUdPTklOQy5DQScKV2UgV0lMTCB1c2UgdGhp
cyBlbnRyeSAobmZzL3dyYWl0aC5kcmFnb25pbmMuY2FARFJBR09OSU5DLkNBKQpTdWNjZXNz
IGdldHRpbmcga2V5dGFiIGVudHJ5IGZvciBuZnMvKkBEUkFHT05JTkMuQ0EK
--------------AEBAEB98F9D6BA1D8E5E9A39--
