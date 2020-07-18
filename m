Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE5224D72
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgGRSHm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 14:07:42 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:44447 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgGRSHl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 14:07:41 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwrFK-0002Ec-P1; Sat, 18 Jul 2020 13:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0lMxVG9DhlpdlStM0yVK9+ShTlLsgRFGPNvlAVjByc8=; b=Z5T445iOmvluYGckZ3FSQeu2gQ
        gv9CNATkn7Igc2qS7xHJaJybmf+ATdAuLMPjBPpQygacX1c9zzqLiUSeX2U0/t/TK+7xDwEX+JUH5
        6BTbkLmm9y0Wd/8lilzjqihqk+LV/X4dchszEDSAuSZibRCHlSr2XKsdg/futLy7rFkezbQXORKrR
        nFTIfG6BSkJMVSj9oDRi8NE1ajwTFEpJIq1jFk+3YAOQX1JAuRXxv59m7dvphpO8IOSy/5ddRC8oM
        wwPFDPHk8TQuT0apAFKJvmkbRTEnarI1IEXq/nhEqv21g5ZzWzgkFUhBz+mhaP3gMOeb3syK+4q+q
        VCdwqNVw==;
Received: from [174.119.114.224] (port=61475 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwrFK-0005gh-Ak; Sat, 18 Jul 2020 14:07:38 -0400
Subject: Re: [PATCH 11/11] svcgssd: Wait for nullrpc channel if not available
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-12-nazard@nazar.ca>
 <20200718155501.GB27817@fieldses.org>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <3b9a70ce-f1b4-da68-cfc1-8e93af197461@nazar.ca>
Date:   Sat, 18 Jul 2020 14:07:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200718155501.GB27817@fieldses.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVDncSqfHBIqen
 moyOfPgwyUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTpHR
 3t4R4vw0+gs6rQMezuDQdD3ECQyPVYuo/ujzNsc8viEqxXu9nsjup+bYfVGN6j3c2bTBkiueaPJT
 gX20BBPX8GBK2+FCvMRX/exKBeIMDxZyF+/quwlXr13DBHJ7kWp/mCTKAj9EQotc65cQxEIUOled
 bu+r9+W9cDXvzL3SjEekZ1w6js9KEGCkjNjGdcOV2awaruQPIfR7DggPD4IAKQlQdTfwbSciar+2
 JCMst0dEunmtVTQWqR0MJGYnYGBIZS4rRgm1GD0QN7Psq7kMoOLjGsRz/MUE6aIZoCcUNXR4aVG4
 tVHU1Zldyy+zfTHgoRSIkNGyZDkdPdUqQyeAwOSH7Hm+6hU/jLtdYTiGHQrtppYmxMktfUX7kfB+
 UdezYqxGMqsKjARq8PBC4qgVedic00I3CA/YxDWByJcFD6rr00FXqj5BQiRpjh6VtRR9Ovbqz/k9
 Jlx8RTZkJCspOMQJvQ/Ck3iiU+4DQAj366V+bW1tsfg2xPA2CLYwN9BKAwe6u/Z3EPCB2KCyO1D7
 ry+P9mvkP6Vs460VPtaTVT6bE0ihpqUKOhPoey51kVRouUaKew42cME526cBHCITG4aOo9aTjoWh
 BEYykJb/5H/Lzjsr3foqzoW7y6GskI89mIoZPNvZfQKw2NX8SuW4vJz2+4kbZsr/7Bkn+2moEPa+
 9NZ1qwLC8KIVpu8GCwIOT2izZex7n9jkqzOt1NMEV6gwbG4z0RlfxqM+my40HHASJNUmoOHSoqgq
 xfHmWVt/SL7ectM6Ephk0yyOsO2hm/Umr3EBwhPfF53vAaarHHVcTyqIv4H/pWtDI5cIrmbzroJX
 jH7wQNY/kO3yis8rKC1V3fY3WzdMefBRTJj7sqHXVea/5OzO4moKJZPGcIFh8wkpjrBcUVLrf2ME
 wcB49DjiWowOnKvI8aF4jzAuaOZSGeNj6SDHeu/o/TAv4qgzSk6C9sUJqq9ebzUDvEk=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-18 11:55, J. Bruce Fields wrote:

> So, is there a race here that could result in a hang, and has anyone
> seen it in practice?
>
> Just curious.  Thanks for doing this.--b.

Not a hang, with the existing code, svcgssd will just exit. I'd have to 
go and restart it after boot. I'm assuming a systemd setup would just 
restart it automatically.
On my original systems I'd configured it to force load the modules, but 
I'd forgotten about that (it was about 10 years ago) when I built this 
new box last month.

As mentioned in the other email, sunrpc is loaded from an initramfs that 
doesn't have any of the gss modules. When nfsd is started (after 
svcgssd) it'll then load the gss modules but by then it's too late.

It seems to be a standard Gentoo setup. I just checked the default 
kernel config for genkernel (their kernel & initramfs builder) and it 
has all the rpc & nfs as modules, with the initramfs not supporting 
Kerberos.

Looks like Debian modprobes rpcsec_gss_krb5 before starting rpc.svcgssd.

So with this waiting for the file to appear, and I'm planning on adding 
a conditional module load to the Gentoo rpc.svcgssd init script, things 
should be as bulletproof as I can make it.

Doug

