Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A857222E18
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 23:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGPVg5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 17:36:57 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:51097 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgGPVg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 17:36:56 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwBYj-0006k9-Jq
        for linux-nfs@vger.kernel.org; Thu, 16 Jul 2020 16:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tup/9e2MIPG6NXBFiuGjrHmNUvnxX50EE88s5NsIAfA=; b=bJ2mVLx9oW6LfTpCNOyORYOV4T
        n8iRzB8154QA+NAV+FlxgSZACWSPNeUS/tLgims9vHOXvLA6+D+ZFILaIkoIm/ljFTRrXR2Cd+qew
        tLPfysI7qPCvxkPpkksasHsd/mz+2xGrBV3o5Y2Mt2Bes6zk4mqGDtQrRxcOvKMDoSW0EXuuoMzZm
        l/LCG1HEOdo4BGpDzPF2UJNAp+qpPSyeZzTkU2yecq2Le/RN+KRdhrcgjAwWtYqIbdPt3aE078vBI
        Pp2BdZGFLfghC8Bpk4IyPcfNULTgXoLRnLUOtlvV+qE+YG76akKZiUCoJPw3WN8tVLo/WNqLbnShc
        FNLEJ7dg==;
Received: from [174.119.114.224] (port=53115 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwBYj-0007go-DI
        for linux-nfs@vger.kernel.org; Thu, 16 Jul 2020 17:36:53 -0400
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Doug Nazar <nazard@nazar.ca>
Subject: nfs-utils README updates
Message-ID: <34f07da7-250d-f354-bf59-74b9f1a0e16f@nazar.ca>
Date:   Thu, 16 Jul 2020 17:36:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
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
X-SpamExperts-Outgoing-Evidence: Combined (0.19)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhV0Tf1tDRGt++9
 W0l1SN4osETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dKuzJh5z558NRGm8bBH3ZpyqwD+Ufwmnv2XpsoA/vlp5nXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQ9clsf95ERnfa5/3utVu63cGgIqsnjgPIxt+QJb5OikLV0VRXawyICi9P2LaegYD
 7MEavzt+PYIWFngwZuyqjCaZSjmmVb1jzWCjpHhh1WjZqXWvTtyZt5+E2rHRTxiOPQKf33qQtTYr
 DPixEr4D2aetI4g+l6rCWbY0MZcgnbHs5dmPTEEmx4/N3lqiWWXcjbsCnerI87CybAKXp7fccSMK
 2NZSOlQgSOvigk7lcjQ29HDhl4gBqApdFfF/te8FXfRnzQu6jFSVK9YDcVmQAY2napQ1VBeZGBjd
 4wKnJrvdiwQzKw+6v3CaIMG6s7LqJPXlxUTbP0xEZy5p9dvo9LFm4eDGPWQjiHziZaTK5a5hrku1
 56cRrvdYSNwiR1AF7jUTsXpM9hxpG57zCp0I/Nr5d9Mpny2MqlrXcMQyNtV/a69YW9GH6uP7jsWP
 FubLd8OpyKA69LF1Ge2GaGfxmfr6K2lXCppCFhOH1qLPVvOyhENX6cHY1RZ9qv4kihn2llwcIfe9
 qSdMLqKquuUrXWpOB0fQQI8VICRbS6zGNgmkrLchyjwyJsS12kHj54zW1GIRK0UT0GXzK7XVSbOa
 O4t6datJIW5RtosbtmTCpMB/
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I was looking through the README to ensure my systems followed the 
correct setup and noticed a few things.

Looks like the reference to libnfsidmap can be dropped.

It looks like nfsdcld is again the correct setup for client tracking. A 
section should be added to SERVER STARTUP to include nfsdcld on NFS4+ 
servers.

Should it mention which modules are required before starting? I've had 
to locally add 'auth_rpcgss' to my startup scripts or svcgssd will bail 
on startup.

Any other changes or best practices that should be mentioned before I 
send a patch?

Thanks,
Doug

