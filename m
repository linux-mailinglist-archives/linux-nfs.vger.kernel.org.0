Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA5519C32
	for <lists+linux-nfs@lfdr.de>; Wed,  4 May 2022 11:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347710AbiEDJtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347825AbiEDJtN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 05:49:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7EB88
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 02:45:37 -0700 (PDT)
Received: from [2a02:8108:963f:de38:1b3c:6996:5378:f253]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nmBZf-0005Go-GG; Wed, 04 May 2022 11:45:35 +0200
Message-ID: <4262c3f2-7b24-49a9-1cf2-2e9b7b68d4bb@leemhuis.info>
Date:   Wed, 4 May 2022 11:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: NFS regression between 5.17 and 5.18
Content-Language: en-US
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-nfs@vger.kernel.org
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1651657537;c7a168fd;
X-HE-SMSGID: 1nmBZf-0005Go-GG
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.17..v5.18
#regzbot title nfs: copy from NFS to the local disk suddently takes 3
min instead of half a second
#regzbot ignore-activity

If it turns out this isn't a regression, free free to remove it from the
tracking by sending a reply to this thread containing a paragraph like
"#regzbot invalid: reason why this is invalid" (without the quotes).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

On 28.04.22 15:05, Dennis Dalessandro wrote:
> Hi NFS folks,
> 
> I've noticed a pretty nasty regression in our NFS capability between 5.17 and
> 5.18-rc1. I've tried to bisect but not having any luck. The problem I'm seeing
> is it takes 3 minutes to copy a file from NFS to the local disk. When it should
> take less than half a second, which it did up through 5.17.
> 
> It doesn't seem to be network related, but can't rule that out completely.
> 
> I tried to bisect but the problem can be intermittent. Some runs I'll see a
> problem in 3 out of 100 cycles, sometimes 0 out of 100. Sometimes I'll see it
> 100 out of 100.
> 
> The latest attempt I have is at 5.18-rc4 and here's what I see when I 1) create
> file with dd, 2) copy local disk to NFS mount, 3) copy NFS to local disk.
> 
> Test 2
> Creating /dev/shm/run_nfs_test.junk...
> 262144+0 records in
> 262144+0 records out
> 268435456 bytes (268 MB, 256 MiB) copied, 1.29037 s, 208 MB/s
> Done
> copy /dev/shm/run_nfs_test.junk to /mnt/nfs_test/run_nfs_test.junk...
> 
> real    0m0.502s
> user    0m0.001s
> sys     0m0.250s
> Done
> copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...
> 
> real    4m11.835s
> user    0m0.001s
> sys     0m0.277s
> Done
> Comparing files...
> Done
> Remove /dev/shm/run_nfs_test.tmp...
> 
> real    0m0.031s
> user    0m0.000s
> sys     0m0.031s
> Done
> Remove /dev/shm/run_nfs_test.junk...
> 
> real    0m0.031s
> user    0m0.001s
> sys     0m0.030s
> Done
> Remove /mnt/nfs_test/run_nfs_test.junk...
> 
> real    0m0.024s
> user    0m0.001s
> sys     0m0.022s
> Done
> 
> Create the server with a 4G RAM disk:
> mount -t tmpfs -o size=4096M tmpfs /mnt/nfs_test
> 
> exportfs -o fsid=0,rw,async,insecure,no_root_squash
> 192.168.254.0/255.255.255.0:/mnt/nfs_test
> 
> Mount on the client side with:
> mount -o rdma,port=20049 192.168.254.1:/mnt/nfs_test /mnt/nfs_test
> 
> Any advice on tracking this down further would be greatly appreciated.
> 
> Thanks
> 
> -Denny
> 

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
