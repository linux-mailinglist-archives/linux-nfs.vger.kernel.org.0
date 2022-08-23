Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686259E58F
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Aug 2022 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiHWPDV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Aug 2022 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242963AbiHWPBp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Aug 2022 11:01:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176F316D70
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 05:27:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e21so12959615edc.7
        for <linux-nfs@vger.kernel.org>; Tue, 23 Aug 2022 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=h12X43FHmRMmOz7kLdcPk2A2ysZuGXjo4LapiMVHrOo=;
        b=ZQgDN3k04WvEMM0eS0df4ZpEXDSXBdp3KFejIbNSP05C5XSosQU/gubs9StE4bB1B0
         Nfw3RyQipf0si8RNN3TtIq6gayiDdHUnrbjJe8/+SC5Louv0HgWsJiQwPgeCcV3kTJfi
         uNNShzxfFgOGjvLgYZ24Cd2GaXaN2sC5hBC+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=h12X43FHmRMmOz7kLdcPk2A2ysZuGXjo4LapiMVHrOo=;
        b=LJ2d1ZMj8RVs4ucgWx8OG/ceLEcpMYohXyfUHz9afEvJBhM0Hjk7oYFC1odoBTtOt0
         sEk1bRt0q6xD9JkEoG3zheGuRrAUVrp34/9NwBxrGPz9DrqolgivytQC6PLu3ayR1dWQ
         dFDlEOH8MduynOqRI56aE3DaFh2YOAz88SAOP+guwW6i0rBct2deUMpJ6mVz6SYUsW9R
         h3nDnxsbilZOtb45ByVACfX6v0+xADnVEsLtk5/CsnG/ti88UZV8iRrEeopI405mVMlE
         GRsV6/dwhPxtwUR6IaPWG4X2wULQBPdazamFkBlBgUWbXXs/Qp8Kuu58pYWYPM1HpV2i
         zT/A==
X-Gm-Message-State: ACgBeo2DbnNCyZhtDjDEzwARlShXa4yVgi+8LZlwXl0A2C+Yuu/wyLNW
        R5P4eowsvWhbg1o5iyzTVAQW1G0d5LH1727HY6FrtT7Y8M8wemFA
X-Google-Smtp-Source: AA6agR6PFNfT8ROyU5QwQxNYHF+NbVykrQNyNxPzi3sadGt6jLk+O/vjXkyEQaU2HFs1vEbAQi3x5RMDT/OzLlxcvHE=
X-Received: by 2002:a05:6402:f29:b0:446:6629:bbb6 with SMTP id
 i41-20020a0564020f2900b004466629bbb6mr3487998eda.384.1661257593948; Tue, 23
 Aug 2022 05:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
 <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
 <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com> <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
In-Reply-To: <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
From:   Igor Raits <igor@gooddata.com>
Date:   Tue, 23 Aug 2022 14:26:22 +0200
Message-ID: <CA+9S74je9Ack6c-H_a6raYFJSMvdSkjP76_05xzeT4wkut9DCA@mail.gmail.com>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond,

On Mon, Aug 22, 2022 at 5:01 PM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
> On Mon, 2022-08-22 at 16:43 +0200, Igor Raits wrote:
> > [You don't often get email from igor@gooddata.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hello Trond,
> >
> > On Mon, Aug 22, 2022 at 4:02 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2022-08-22 at 10:16 +0200, Igor Raits wrote:
> > > > [You don't often get email from igor@gooddata.com. Learn why this
> > > > is
> > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > Hello everyone,
> > > >
> > > > Hopefully I'm sending this to the right place=E2=80=A6
> > > > We recently started to see the following stacktrace quite often
> > > > on
> > > > our
> > > > VMs that are using NFS extensively (I think after upgrading to
> > > > 5.18.11+, but not sure when exactly. For sure it happens on
> > > > 5.18.15):
> > > >
> > > > INFO: task kworker/u36:10:377691 blocked for more than 122
> > > > seconds.
> > > >      Tainted: G            E     5.18.15-1.gdc.el8.x86_64 #1
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > > > message.
> > > > task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:     2
> > > > flags:0x00004000
> > > > Workqueue: writeback wb_workfn (flush-0:308)
> > > > Call Trace:
> > > > <TASK>
> > > > __schedule+0x38c/0x7d0
> > > > schedule+0x41/0xb0
> > > > io_schedule+0x12/0x40
> > > > __folio_lock+0x110/0x260
> > > > ? filemap_alloc_folio+0x90/0x90
> > > > write_cache_pages+0x1e3/0x4d0
> > > > ? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
> > > > nfs_writepages+0xe1/0x200 [nfs]
> > > > do_writepages+0xd2/0x1b0
> > > > ? check_preempt_curr+0x47/0x70
> > > > ? ttwu_do_wakeup+0x17/0x180
> > > > __writeback_single_inode+0x41/0x360
> > > > writeback_sb_inodes+0x1f0/0x460
> > > > __writeback_inodes_wb+0x5f/0xd0
> > > > wb_writeback+0x235/0x2d0
> > > > wb_workfn+0x348/0x4a0
> > > > ? put_prev_task_fair+0x1b/0x30
> > > > ? pick_next_task+0x84/0x940
> > > > ? __update_idle_core+0x1b/0xb0
> > > > process_one_work+0x1c5/0x390
> > > > worker_thread+0x30/0x360
> > > > ? process_one_work+0x390/0x390
> > > > kthread+0xd7/0x100
> > > > ? kthread_complete_and_exit+0x20/0x20
> > > > ret_from_fork+0x1f/0x30
> > > > </TASK>
> > > >
> > > > I see that something very similar was fixed in btrfs
> > > > (
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmi
> > > > t/?h=3Dlinux-5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
> > > > but I could not find anything similar for NFS.
> > > >
> > > > Do you happen to know if this is already fixed? If so, would you
> > > > mind
> > > > sharing some commits? If not, could you help getting this
> > > > addressed?
> > > >
> > >
> > > The stack trace you show above isn't particularly helpful for
> > > diagnosing what the problem is.
> > >
> > > All it is saying is that 'thread A' is waiting to take a page lock
> > > that
> > > is being held by a different 'thread B'. Without information on
> > > what
> > > 'thread B' is doing, and why it isn't releasing the lock, there is
> > > nothing we can conclude.
> >
> > Do you have some hint how to debug this issue further (when it
> > happens
> > again)? Would `virsh dump` to get a memory dump and then some kind of
> > "bt all" via crash help to get more information?
> > Or something else?
> >
> > Thanks in advance!
> > --
> > Igor Raits
>
> Please try running the following two lines of 'bash' script as root:
>
> (for tt in $(grep -l 'nfs[^d]' /proc/*/stack); do echo "${tt}:"; cat ${tt=
}; echo; done) >/tmp/nfs_threads.txt
>
> cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.txt
>
> and then send us the output from the two files /tmp/nfs_threads.txt and
> /tmp/rpc_tasks.txt.
>
> The file nfs_threads.txt gives us a full set of stack traces from all
> processes that are currently in the NFS client code. So it should
> contain both the stack trace from your 'thread A' above, and the traces
> from all candidates for the 'thread B' process that is causing the
> blockage.
> The file rpc_tasks.txt gives us the status of any RPC calls that might
> be outstanding and might help diagnose any issues with the TCP
> connection.
>
> That should therefore give us a better starting point for root causing
> the problem.

We just hit the problem again and here are the files (copying in-line
as the output is not very large):

22/08/23 13:11:37 PD277054 rack-na3/k8s_worker, Cluster 53 @ rack-na3 (id 5=
3)
[root@na3-k8s-worker03:~] cat /tmp/rpc_tasks.txt

22/08/23 13:11:43 PD277054 rack-na3/k8s_worker, Cluster 53 @ rack-na3 (id 5=
3)
[root@na3-k8s-worker03:~] cat /tmp/nfs_threads.txt
/proc/3093002/stack:
[<0>] __folio_lock+0x110/0x260
[<0>] write_cache_pages+0x1e3/0x4d0
[<0>] nfs_writepages+0xe1/0x200 [nfs]
[<0>] do_writepages+0xd2/0x1b0
[<0>] __writeback_single_inode+0x41/0x360
[<0>] writeback_sb_inodes+0x1f0/0x460
[<0>] __writeback_inodes_wb+0x5f/0xd0
[<0>] wb_writeback+0x235/0x2d0
[<0>] wb_workfn+0x312/0x4a0
[<0>] process_one_work+0x1c5/0x390
[<0>] worker_thread+0x30/0x360
[<0>] kthread+0xd7/0x100
[<0>] ret_from_fork+0x1f/0x30

/proc/89011/stack:
[<0>] nfs41_callback_svc+0x1af/0x1c0 [nfsv4]
[<0>] kthread+0xd7/0x100
[<0>] ret_from_fork+0x1f/0x30

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


--=20
Igor Raits
