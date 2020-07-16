Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3638A221CE2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgGPG4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 02:56:54 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:40649 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgGPG4x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 02:56:53 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jvxp4-00016l-Fc; Thu, 16 Jul 2020 01:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3vEJOJeC3OECtPOoboSB2ff9UvbqfTBBFm5VA3r7HUM=; b=QU7lnPBhSqHPTJxWzUr7DKnv/b
        du2nc358atLxTVYCy5bLziNpGib40P/EDvs0768QV9kcxPo3cfPcj0bHV5xwsOSPvj6O3c3c3QpuL
        PJanm+W4aKbh/C5OtW2GLBjIL8R9HXmOFMbvr/rorm/mq6JXYdJgUn8lrnmr6MvznD88OPFB2/X9s
        8n50KzfpgGnaQNpSiYipW3esGzgnUdgPYVXs8FjwkPPgiTLbwcvDT55/FuMwaqWO61gDiuBNYJbMv
        GpF8CifNRDy+r0xuk0NLQfiACxDyzAIkq2bhYaO9cXb/I7ItXaT9ko6shdibWZ51eV0QljEJQ67CE
        Wt+VC+QQ==;
Received: from cpeec086b225c87-cm9050ca1f1120.cpe.net.cable.rogers.com ([174.119.114.224]:51124 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jvxp3-0000ZJ-Ti; Thu, 16 Jul 2020 02:56:49 -0400
Subject: Re: [PATCH 00/10] Misc fixes & cleanups for nfs-utils
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200701182803.14947-1-nazard@nazar.ca>
 <c1b8566f-064e-c063-2a6d-94d4bd92709f@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <0256f366-6541-9ae3-3d1b-62f63e6d62c6@nazar.ca>
Date:   Thu, 16 Jul 2020 02:56:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <c1b8566f-064e-c063-2a6d-94d4bd92709f@RedHat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVJhpdp2CTiRQe
 u7IJCNhY6kTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5FtXX3Os1fmXpEMn
 iUskKykBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHofN2rfek/RlvmPWvnqLlM9QeYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvdZoI5EudELJiACu9h+oDYzMKjS34vqacdzFcsWaw3HKctgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-14 14:38, Steve Dickson wrote:
>
>>    gssd: Refcount struct clnt_info to protect multithread usage
>>    Update to libevent 2.x apis.
>>    gssd: Cleanup on exit to support valgrind.
>>    gssd: gssd_k5_err_msg() returns a strdup'd msg. Use free() to release.
>>    gssd: Fix locking for machine principal list
>>    gssd: Add a few debug statements to help track client_info lifetimes.
>>    gssd: Lookup local hostname when srchost is '*'
>>    gssd: We never use the nocache param of gssd_check_if_cc_exists()
>>    Fix various clang warnings.
> I did commit all of the above... (tag: nfs-utils-2-5-2-rc1)

Oops, I'd been working on an updated patch set. There's nothing really 
actively wrong in the above patches. I'd just gone back and added proper 
NULL checks and error messages for the libevent conversion. I'll rebase 
and send that as an update. Also "gssd: Lookup local hostname when 
srchost is '*'" I think is wrong. After the first day I couldn't get it 
to repeat, and think it was a mis-compile issue. However, the new code 
arrangement is better in that it shows the correct dns name 
transformation. Previously it would use the same buffer for input & 
output which made the log message very confusing. I'll just drop the '*' 
check.

> I did not commit the following
>     Cleanup printf format attribute handling and fix format strings
>
> because 3 different version were posted
>
> Cleanup printf format attribute handling and fix various format strings
> Cleanup printf format attribute handling and fix format strings
> Consolidate printf format attribute handling and fix various format strings
>
> I was not sure which one you wanted and I was wondering what exactly is
> being cleaned up? What problems is this solving?

They're all the same patch. The summary line was wrapping in the cover 
letter so I edited it a few times, not realizing that format-patch was 
creating another file even if I aborted.

So, it actually does a few things, all based around fixing printf style 
formats.

There were 2 different macros defined to add printf format attribute to 
functions, and several open codings. So it first consolidates them into 
one set of macros (although there is a second copy in nfsidmap.h since 
that's an installed file and can't depend on config.h.

Then, there were several functions that were not marked with the printf 
format attribute (nfsidmap plugins and gssd printerr()).

Finally, a cleanup of all the resulting gcc & clang warnings on both 32 
& 64 bit. In several cases some real errors, not enough parameters, 
passing in various types for the dynamic length which requires an int, 
passing in a char** instead of char*, etc. Of course these are mainly 
debugging messages so rarely caused an issue but were in need of 
cleaning up.

> Finally, being this is a whole tree commit and I have a number
> of patches in the queue.. I would like to hold off on this one.
>
> A patch like this will cause all those patches in the queue
> not to apply... So once I drain the queue, hopefully you
> would not mind rebasing... after we talk about what you
> are trying to do.

Not a problem. I have it rebased here and can send it at any time, or 
split it up if you prefer.

> I do appreciate the hard work... esp with gssd... I did test
> it every step of the way... and it seems to be fairly
> solid... nice work!

I've been chasing that threading bug for over a year. Trying to stress 
the number of simultaneous mounts, types, etc. never thinking the issue 
was external. I bet if I went back and correlated the crashes I saw, 
probably happened when I was upgrading or rebooting the kdc.

Doug

