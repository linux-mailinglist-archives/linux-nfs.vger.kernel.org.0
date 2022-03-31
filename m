Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297974ED604
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiCaIpN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 04:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiCaIpL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 04:45:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105CE3D486
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 01:43:21 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nZqOk-0000r9-F8; Thu, 31 Mar 2022 10:43:18 +0200
Message-ID: <a7a91106-1443-b38a-ece6-7c3f335908b1@leemhuis.info>
Date:   Thu, 31 Mar 2022 10:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Performance regression with random IO pattern from the client
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, nfbrown@suse.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220330103457.r4xrhy2d6nhtouzk@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648716202;1b5f1b0a;
X-HE-SMSGID: 1nZqOk-0000r9-F8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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

Hi, this is your Linux kernel regression tracker.  CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 30.03.22 12:34, Jan Kara wrote:
> Hello,
> 
> during our performance testing we have noticed that commit b6669305d35a
> ("nfsd: Reduce the number of calls to nfsd_file_gc()") has introduced a
> performance regression when a client does random buffered writes. The
> workload on NFS client is fio running 4 processed doing random buffered writes to 4
> different files and the files are large enough to hit dirty limits and
> force writeback from the client. In particular the invocation is like:
> 
> fio --direct=0 --ioengine=sync --thread --directory=/mnt/mnt1 --invalidate=1 --group_reporting=1 --runtime=300 --fallocate=posix --ramp_time=10 --name=RandomReads-128000-4k-4 --new_group --rw=randwrite --size=4000m --numjobs=4 --bs=4k --filename_format=FioWorkloads.\$jobnum --end_fsync=1
> 
> The reason why commit b6669305d35a regresses performance is the
> filemap_flush() call it adds into nfsd_file_put(). Before this commit
> writeback on the server happened from nfsd_commit() code resulting in
> rather long semisequential streams of 4k writes. After commit b6669305d35a
> all the writeback happens from filemap_flush() calls resulting in much
> longer average seek distance (IO from different files is more interleaved)
> and about 16-20% regression in the achieved writeback throughput when the
> backing store is rotational storage.
> 
> I think the filemap_flush() from nfsd_file_put() is indeed rather
> aggressive and I think we'd be better off to just leave writeback to either
> nfsd_commit() or standard dirty page cleaning happening on the system. I
> assume the rationale for the filemap_flush() call was to make it more
> likely the file can be evicted during the garbage collection run? Was there
> any particular problem leading to addition of this call or was it just "it
> seemed like a good idea" thing?
> 
> Thanks in advance for ideas.
> 

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced b6669305d35a
#regzbot title nfs: Performance regression with random IO pattern from
the client
#regzbot backburner: introduced more than two years ago, first report,
hence developers want to give it some thought
#regzbot ignore-activity

If it turns out this isn't a regression, free free to remove it from the
tracking by sending a reply to this thread containing a paragraph like
"#regzbot invalid: reason why this is invalid" (without the quotes).

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. Regzbot needs them to
automatically connect reports with fixes, but they are useful in
general, too.

I'm sending this to everyone that got the initial report, to make
everyone aware of the tracking. I also hope that messages like this
motivate people to directly get at least the regression mailing list and
ideally even regzbot involved when dealing with regressions, as messages
like this wouldn't be needed then. And don't worry, if I need to send
other mails regarding this regression only relevant for regzbot I'll
send them to the regressions lists only (with a tag in the subject so
people can filter them away). With a bit of luck no such messages will
be needed anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

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
