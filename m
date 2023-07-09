Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23674C15D
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGIG6p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 02:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGIG6o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 02:58:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C9109;
        Sat,  8 Jul 2023 23:58:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIONV-0000AG-1e; Sun, 09 Jul 2023 08:58:41 +0200
Message-ID: <27b669d4-8d8e-458b-d13e-5b635ac46dae@leemhuis.info>
Date:   Sun, 9 Jul 2023 08:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: NFS workload leaves nfsd threads in D state
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688885923;14c6b675;
X-HE-SMSGID: 1qIONV-0000AG-1e
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 08.07.23 20:30, Chuck Lever III wrote:
> 
> I have a "standard" test of running the git regression suite with
> many threads against an NFS mount. I found that with 6.5-rc, the
> test stalled and several nfsd threads on the server were stuck
> in D state.
> 
> I can reproduce this stall 100% with both an xfs and an ext4
> export, so I bisected with both, and both bisects landed on the
> same commit:
> 
> 615939a2ae734e3e68c816d6749d1f5f79c62ab7 is the first bad commit
> commit 615939a2ae734e3e68c816d6749d1f5f79c62ab7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri May 19 06:40:48 2023 +0200
> 
>     blk-mq: defer to the normal submission path for post-flush requests
> 
>     Requests with the FUA bit on hardware without FUA support need a post
>     flush before returning to the caller, but they can still be sent using
>     the normal I/O path after initializing the flush-related fields and
>     end I/O handler.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Link: https://lore.kernel.org/r/20230519044050.107790-6-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/blk-flush.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> On system 1: the exports are on top of /dev/mapper and reside on
> an "INTEL SSDSC2BA400G3" SATA device.
> 
> On system 2: the exports are on top of /dev/mapper and reside on
> an "INTEL SSDSC2KB240G8" SATA device.
> 
> System 1 was where I discovered the stall. System 2 is where I ran
> the bisects.
> 
> The call stacks vary a little. I've seen stalls in both the WRITE
> and SETATTR paths. Here's a sample from system 1:
> 
> INFO: task nfsd:1237 blocked for more than 122 seconds.
>       Tainted: G        W          6.4.0-08699-g9e268189cb14 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:nfsd            state:D stack:0     pid:1237  ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  __schedule+0x78f/0x7db
>  schedule+0x93/0xc8
>  jbd2_log_wait_commit+0xb4/0xf4
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  jbd2_complete_transaction+0x85/0x97
>  ext4_fc_commit+0x118/0x70a
>  ? _raw_spin_unlock+0x18/0x2e
>  ? __mark_inode_dirty+0x282/0x302
>  ext4_write_inode+0x94/0x121
>  ext4_nfs_commit_metadata+0x72/0x7d
>  commit_inode_metadata+0x1f/0x31 [nfsd]
>  commit_metadata+0x26/0x33 [nfsd]
>  nfsd_setattr+0x2f2/0x30e [nfsd]
>  nfsd_create_setattr+0x4e/0x87 [nfsd]
>  nfsd4_open+0x604/0x8fa [nfsd]
>  nfsd4_proc_compound+0x4a8/0x5e3 [nfsd]
>  ? nfs4svc_decode_compoundargs+0x291/0x2de [nfsd]
>  nfsd_dispatch+0xb3/0x164 [nfsd]
>  svc_process_common+0x3c7/0x53a [sunrpc]
>  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>  svc_process+0xc6/0xe3 [sunrpc]
>  nfsd+0xf2/0x18c [nfsd]
>  ? __pfx_nfsd+0x10/0x10 [nfsd]
>  kthread+0x10d/0x115
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  </TASK>

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 615939a2ae734e
#regzbot title blk-mq: NFS workload leaves nfsd threads in D state
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
