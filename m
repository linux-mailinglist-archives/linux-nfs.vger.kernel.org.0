Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2421157F
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGAV5P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 17:57:15 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:36259 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgGAV5O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 17:57:14 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqkjA-0001LD-5F
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 16:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i17icfh+NgGBKnHLoQto187xFWR5auMVJUKzwWjFKrE=; b=JNwsRCqGICcY3M7peKi19uvkdW
        k70tUzvQ159GvbLd1hZG+OW85hqKemH8oevAUjPAy2N6y/ASgF/YVcRNB0hQTMDgn6w++R1sNaQtw
        ar5ywWcA6vGa5x+2hLn9/uto7u/cK509AAp7NY+5UD5p5L8Oz4u2WUaUWr9VNkR6gDgn3Woklwbxu
        ztKnA7hklwxKwWn9yWaEycUAHD0GDftQVgufEjurErRDcW6Djrq95h5jYC5j3blijAoiEs4GaQvSw
        sNTK5kf9mmzs1IK12rnwsDvvGbNwJW7WEWzWJiQhL+r95FjjBh8lWwW5kq8Fhx2J4IrAQzBdqOm0A
        tJsstzhg==;
Received: from [174.119.114.224] (port=62301 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqkj9-0004f5-Py
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 17:57:11 -0400
Subject: Re: gssd keytab resolution
From:   Doug Nazar <nazard@nazar.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <e61057cc-6c4b-6d88-aab2-c5d5db9bdf50@nazar.ca>
Message-ID: <487c34e4-1ba3-a77f-3257-c47cdc6c6a1c@nazar.ca>
Date:   Wed, 1 Jul 2020 17:57:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <e61057cc-6c4b-6d88-aab2-c5d5db9bdf50@nazar.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVQZ6Zcq9hGJDb
 tXBIej2IUUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dL3UGel2+kHLzkrcOfjhoacqwD+Ufwmnv2XpsoA/vlp5nXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSOf
 sBWD4ORwI9sxSnztzWd/9HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hyLlN
 M8NiMQzxyIfU2tsmD1Z4mbA7QbgZqM76s09fTaH5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-06-29 10:57, Doug Nazar wrote:
> While playing around I noticed this pattern occasionally.
>
> I was wondering if 'srchost=*' should be treated as NULL (use 
> gethostname) or to just skip the loop where we call 
> krb5_kt_get_entry() since that won't match with an asterisk.

Nope, looks like this was me. During a rebase I managed to get 
gssd_proc.c compiled with the old version of krb5_util.h and gentoo 
disables dependency tracking by default.

Seems to have gone away now after a make clean, was able to reproduce it 
for hours... sigh.

So, that patch can be dropped.

Doug

