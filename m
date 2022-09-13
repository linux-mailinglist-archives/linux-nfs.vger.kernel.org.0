Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B175B6E4D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiIMNYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIMNYG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 09:24:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DCC45982
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 06:24:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q21so17571210edc.9
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=OW+AIwFnzmrttAU2EhE4Y2eBh8gHMX6Jjj/SR01drcs=;
        b=hIXbrVpFES/4lcXhTx9ug7LiAm3EQ6B9DRCPcjponobUTCLfRz8tnSwC3kL4+XY0hQ
         zqIOFyzBODKDwA9dN6ChIXObP4gxVajc73S0yBEofSER61evAJ+ddE2euckejHFcWZtL
         gaU8B28Z/mBVzAf8V1HxXhIxZOsDc8lq3IM7C/DUS10jmGE1hHynmXlkhsFBKmPrPA9R
         EcKIRk0i/S5JqRaeFsygppxvgB7NRf274lfCu0Njjc7DbXnGRH4/wTszdTMENcCcoUnM
         gWPjvnxOD402rqFdnUf/Rjmz8yqJt/zE53L+oJyuwNMjbTxWinN8xql/A3hi/gEYF9dW
         /zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OW+AIwFnzmrttAU2EhE4Y2eBh8gHMX6Jjj/SR01drcs=;
        b=IlGgwZi6RjTN2WahzqvXI6kQjassPIaAxtr9+utShqLbQpMHO4+cEFRMwNRGQ+nJOp
         R8MWKwa+n5yA6ztRXqDup9q+SaySbsJ2E8uiHE/ofpKQjHYIKsYh9p8XnAGIxFmqpEA1
         D89ujK8jef/TXaaulD5AxhLzrzb96RAjvPQayqshokkwZ4085C0cfHhODWOBmQx26O3t
         Ri+rzMzknMkOPGfze68SDiDDwekXh9x+gzr5wOhBhl1HmJiDusXRaC9U5mtgpSimBNk8
         TvuMZ/u10eRKmpd4slIOaEn33ANqplmZbWIkKSDAQ1feDVT7iiiwe6JJigE5No4WhbPW
         9P7Q==
X-Gm-Message-State: ACgBeo0T9dbDI9mn5n0Yj616CBoCxY4w4GJJd0742pAxAEjpAJx8Jg38
        X4STAVsWBeHnHes0BRAosfxVE9tlSSo4BFqwL50=
X-Google-Smtp-Source: AA6agR79S5KkSlzxd+U1+7yveVzmGXlv6nlLFZsmTM2J+iE/NIimCZttNeRf30sc6dy8cbj69vt5uf1yIDQWoL6A+eY=
X-Received: by 2002:a05:6402:520a:b0:450:fcc3:d321 with SMTP id
 s10-20020a056402520a00b00450fcc3d321mr17786528edd.327.1663075443324; Tue, 13
 Sep 2022 06:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
 <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
 <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
 <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
 <CA+9S74iB8kjqcySajgfbcFGt5nrL3YpquWc66oL5mvnPgO3vnA@mail.gmail.com>
 <CH0PR13MB50840DBE3BF030039288DB63B8439@CH0PR13MB5084.namprd13.prod.outlook.com>
 <a3aa0865d7c6e5b0f8f3dfd62e99578fc528eab0.camel@hammerspace.com>
 <CAN-5tyEuWz2wLJOfk5DPLyrQXXc7ScJ7Je8C=YyEpt0pM=-bgA@mail.gmail.com> <CA+9S74ijk6aWL_MEOmWqY5Mn7=9__mqD2k8dfc-8CsC5NYqdrg@mail.gmail.com>
In-Reply-To: <CA+9S74ijk6aWL_MEOmWqY5Mn7=9__mqD2k8dfc-8CsC5NYqdrg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 13 Sep 2022 09:23:51 -0400
Message-ID: <CAN-5tyGDnt1Fo74OvWRCPF9j5W2P8BGvUDzHrjgZ7spX1fZcJQ@mail.gmail.com>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
To:     Igor Raits <igor@gooddata.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 13, 2022 at 5:34 AM Igor Raits <igor@gooddata.com> wrote:
>
> Seems those 2 were backported to 5.18.6 which is around when we
> started to see the issues=E2=80=A6
> I'll try to revert them and see if it helps.

I'm definitely not suggesting to revert them.

> > Is the server constantly returning LAYOUT_UNAVAILABLE?
>
> Not sure, any hint how to check it?

Could you try to keep a set of rotating network traces and/or nfs4
tracepoints and try to hit your condition?

> > And does this happen to be co-located with a volume move operation?
>
> We don't really touch the volumes during that time, although we use
> FlexVolumes so it could expand/shrink on Netapp's side.

Ok thanks. My experience was with an SFO event,

> On Fri, Sep 9, 2022 at 7:00 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Fri, Sep 9, 2022 at 12:52 PM Trond Myklebust <trondmy@hammerspace.co=
m> wrote:
> > >
> > > On Fri, 2022-09-09 at 16:47 +0000, Trond Myklebust wrote:
> > > > This looks like it might be the root cause issue. It looks like
> > > > you're using pNFS:
> > > >
> > > > /proc/3278822/stack:
> > > > [<0>] pnfs_update_layout+0x603/0xed0 [nfsv4]
> > > > [<0>] fl_pnfs_update_layout.constprop.18+0x23/0x1e0
> > > > [nfs_layout_nfsv41_files]
> > > > [<0>] filelayout_pg_init_write+0x3a/0x70 [nfs_layout_nfsv41_files]
> > > > [<0>] __nfs_pageio_add_request+0x294/0x470 [nfs]
> > > > [<0>] nfs_pageio_add_request_mirror+0x2f/0x40 [nfs]
> > > > [<0>] nfs_pageio_add_request+0x200/0x2d0 [nfs]
> > > > [<0>] nfs_page_async_flush+0x120/0x310 [nfs]
> > > > [<0>] nfs_writepages_callback+0x5b/0xc0 [nfs]
> > > > [<0>] write_cache_pages+0x187/0x4d0
> > > > [<0>] nfs_writepages+0xe1/0x200 [nfs]
> > > > [<0>] do_writepages+0xd2/0x1b0
> > > > [<0>] __writeback_single_inode+0x41/0x360
> > > > [<0>] writeback_sb_inodes+0x1f0/0x460
> > > > [<0>] __writeback_inodes_wb+0x5f/0xd0
> > > > [<0>] wb_writeback+0x235/0x2d0
> > > > [<0>] wb_workfn+0x312/0x4a0
> > > > [<0>] process_one_work+0x1c5/0x390
> > > > [<0>] worker_thread+0x30/0x360
> > > > [<0>] kthread+0xd7/0x100
> > > > [<0>] ret_from_fork+0x1f/0x30
> > > >
> > > > What is the pNFS server you are running against? I see you're using
> > > > the files pNFS layout type, so is this a NetApp?
> >
> >
> > This reminds me of the problem that was supposed to be fixed by the
> > patches that went into 5.19-rc3?.
> >       pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNA=
VAILABLE
> >       pNFS: Avoid a live lock condition in pnfs_update_layout()
> >
> > Igor,
> >
> > Is the server constantly returning LAYOUT_UNAVAILABLE? And does this
> > happen to be co-located with a volume move operation?
> >
> >
> > > >
> > >
> > > Sorry for the HTML spam... Resending with all that crap stripped out.
> > >
> > > > From: Igor Raits <igor@gooddata.com>
> > > > Sent: Friday, September 9, 2022 11:09
> > > > To: Trond Myklebust <trondmy@hammerspace.com>
> > > > Cc: anna@kernel.org <anna@kernel.org>; linux-nfs@vger.kernel.org
> > > > <linux-nfs@vger.kernel.org>
> > > > Subject: Re: Regression: deadlock in io_schedule /
> > > > nfs_writepage_locked
> > > >
> > > > Hello Trond,
> > > >
> > > > On Mon, Aug 22, 2022 at 5:01 PM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2022-08-22 at 16:43 +0200, Igor Raits wrote:
> > > > > > [You don't often get email from igor@gooddata.com. Learn why th=
is
> > > > > > is
> > > > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > >
> > > > > > Hello Trond,
> > > > > >
> > > > > > On Mon, Aug 22, 2022 at 4:02 PM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >
> > > > > > > On Mon, 2022-08-22 at 10:16 +0200, Igor Raits wrote:
> > > > > > > > [You don't often get email from igor@gooddata.com. Learn wh=
y
> > > > > > > > this
> > > > > > > > is
> > > > > > > > important at https://aka.ms/LearnAboutSenderIdentification =
]
> > > > > > > >
> > > > > > > > Hello everyone,
> > > > > > > >
> > > > > > > > Hopefully I'm sending this to the right place=E2=80=A6
> > > > > > > > We recently started to see the following stacktrace quite
> > > > > > > > often
> > > > > > > > on
> > > > > > > > our
> > > > > > > > VMs that are using NFS extensively (I think after upgrading
> > > > > > > > to
> > > > > > > > 5.18.11+, but not sure when exactly. For sure it happens on
> > > > > > > > 5.18.15):
> > > > > > > >
> > > > > > > > INFO: task kworker/u36:10:377691 blocked for more than 122
> > > > > > > > seconds.
> > > > > > > >       Tainted: G            E     5.18.15-1.gdc.el8.x86_64 =
#1
> > > > > > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > > > > > > > this
> > > > > > > > message.
> > > > > > > > task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:
> > > > > > > > 2
> > > > > > > > flags:0x00004000
> > > > > > > > Workqueue: writeback wb_workfn (flush-0:308)
> > > > > > > > Call Trace:
> > > > > > > > <TASK>
> > > > > > > > __schedule+0x38c/0x7d0
> > > > > > > > schedule+0x41/0xb0
> > > > > > > > io_schedule+0x12/0x40
> > > > > > > > __folio_lock+0x110/0x260
> > > > > > > > ? filemap_alloc_folio+0x90/0x90
> > > > > > > > write_cache_pages+0x1e3/0x4d0
> > > > > > > > ? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
> > > > > > > > nfs_writepages+0xe1/0x200 [nfs]
> > > > > > > > do_writepages+0xd2/0x1b0
> > > > > > > > ? check_preempt_curr+0x47/0x70
> > > > > > > > ? ttwu_do_wakeup+0x17/0x180
> > > > > > > > __writeback_single_inode+0x41/0x360
> > > > > > > > writeback_sb_inodes+0x1f0/0x460
> > > > > > > > __writeback_inodes_wb+0x5f/0xd0
> > > > > > > > wb_writeback+0x235/0x2d0
> > > > > > > > wb_workfn+0x348/0x4a0
> > > > > > > > ? put_prev_task_fair+0x1b/0x30
> > > > > > > > ? pick_next_task+0x84/0x940
> > > > > > > > ? __update_idle_core+0x1b/0xb0
> > > > > > > > process_one_work+0x1c5/0x390
> > > > > > > > worker_thread+0x30/0x360
> > > > > > > > ? process_one_work+0x390/0x390
> > > > > > > > kthread+0xd7/0x100
> > > > > > > > ? kthread_complete_and_exit+0x20/0x20
> > > > > > > > ret_from_fork+0x1f/0x30
> > > > > > > > </TASK>
> > > > > > > >
> > > > > > > > I see that something very similar was fixed in btrfs
> > > > > > > > (
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/commi
> > > > > > > > t/?h=3Dlinux-
> > > > > > > > 5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
> > > > > > > > but I could not find anything similar for NFS.
> > > > > > > >
> > > > > > > > Do you happen to know if this is already fixed? If so, woul=
d
> > > > > > > > you
> > > > > > > > mind
> > > > > > > > sharing some commits? If not, could you help getting this
> > > > > > > > addressed?
> > > > > > > >
> > > > > > >
> > > > > > > The stack trace you show above isn't particularly helpful for
> > > > > > > diagnosing what the problem is.
> > > > > > >
> > > > > > > All it is saying is that 'thread A' is waiting to take a page
> > > > > > > lock
> > > > > > > that
> > > > > > > is being held by a different 'thread B'. Without information =
on
> > > > > > > what
> > > > > > > 'thread B' is doing, and why it isn't releasing the lock, the=
re
> > > > > > > is
> > > > > > > nothing we can conclude.
> > > > > >
> > > > > > Do you have some hint how to debug this issue further (when it
> > > > > > happens
> > > > > > again)? Would `virsh dump` to get a memory dump and then some
> > > > > > kind of
> > > > > > "bt all" via crash help to get more information?
> > > > > > Or something else?
> > > > > >
> > > > > > Thanks in advance!
> > > > > > --
> > > > > > Igor Raits
> > > > >
> > > > > Please try running the following two lines of 'bash' script as
> > > > > root:
> > > > >
> > > > > (for tt in $(grep -l 'nfs[^d]' /proc/*/stack); do echo "${tt}:";
> > > > > cat ${tt}; echo; done) >/tmp/nfs_threads.txt
> > > > >
> > > > > cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.tx=
t
> > > > >
> > > > > and then send us the output from the two files /tmp/nfs_threads.t=
xt
> > > > > and
> > > > > /tmp/rpc_tasks.txt.
> > > > >
> > > > > The file nfs_threads.txt gives us a full set of stack traces from
> > > > > all
> > > > > processes that are currently in the NFS client code. So it should
> > > > > contain both the stack trace from your 'thread A' above, and the
> > > > > traces
> > > > > from all candidates for the 'thread B' process that is causing th=
e
> > > > > blockage.
> > > > > The file rpc_tasks.txt gives us the status of any RPC calls that
> > > > > might
> > > > > be outstanding and might help diagnose any issues with the TCP
> > > > > connection.
> > > > >
> > > > > That should therefore give us a better starting point for root
> > > > > causing
> > > > > the problem.
> > > >
> > > > The rpc_tasks is empty but I got nfs_threads from the moment it is
> > > > stuck (see attached file).
> > > >
> > > > It still happens with 5.19.3, 5.19.6.
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
>
>
>
> --
> Igor Raits
