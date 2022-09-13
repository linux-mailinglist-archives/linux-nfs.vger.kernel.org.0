Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC65B6AC1
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIMJeW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiIMJeT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 05:34:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1186C5E332
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 02:34:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x11so296032edi.11
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=fBjP2mTs123py9ewOWuJmwPCtJ1hJKlXLRIBijOwxqU=;
        b=J/UqhrW73Qay3db9syLjWAAluhLQrIjgZ1df7k2jnG0BPe0m+/LlvqKi1sPjGgA6sD
         aInY1edBl+zZZhRh40Hd5XfCFz7dmjiozBDndy3gP2ZW4edWRE/Qo/0LmgU2NPrpJyLB
         C8KH+oJ93gDlPPuvMZrN9pqqEBXzOu4k2Uc7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fBjP2mTs123py9ewOWuJmwPCtJ1hJKlXLRIBijOwxqU=;
        b=iWBfQ1F82mUXn/CZ8g/vr2rK2hAiWA8GAzS//ZhQ6GGECisG7A195DkiExmLmjC6z6
         PE+Uq0spk3w/QSQhj/U86Ige+RUOTSFdnCDGfJFoJIKujBFkoqI/ZYjvE1fuz+ojeul/
         Z0b3yacT/Je0YF1lfGb9a409wW3AJ17QXuH+LoCg+3SGuNfzk8rSOGyw97fa88HO9TMj
         /wYSXsKInxOqfW9Gwls/4yP/16PBHsLb8JfeQKzmcmFjX8jweRTPeUksaEVOSpXfcUKL
         jjXjjd1BNzYIfS/JEW+kztC60zwvs9lWyf7RQkkVvkg7FgcC5bTK+ZorfWex/TdHvBPK
         F+Zw==
X-Gm-Message-State: ACgBeo2C66pQpCGZMvk0IPgTjIxfqTUPXgqXFUjdjWTjboL94OaDXooZ
        TtD46Aw0VofTYHe/CYzHwwZ0VJgEM/xx/DnrneFCGMoMErGkVgTH
X-Google-Smtp-Source: AA6agR7w4o0MP3AFVzFCq8OuRpC0v0fOloPD1XCtjleqNImbLrc64P1YuMctXp8HkdtQUTMe/dUEB+CpItMWoHpbeLU=
X-Received: by 2002:aa7:da86:0:b0:44e:91c8:eb4f with SMTP id
 q6-20020aa7da86000000b0044e91c8eb4fmr26549032eds.252.1663061655444; Tue, 13
 Sep 2022 02:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
 <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
 <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
 <6beb46a169e675c560871ca54748481522ecbaec.camel@hammerspace.com>
 <CA+9S74iB8kjqcySajgfbcFGt5nrL3YpquWc66oL5mvnPgO3vnA@mail.gmail.com>
 <CH0PR13MB50840DBE3BF030039288DB63B8439@CH0PR13MB5084.namprd13.prod.outlook.com>
 <a3aa0865d7c6e5b0f8f3dfd62e99578fc528eab0.camel@hammerspace.com> <CAN-5tyEuWz2wLJOfk5DPLyrQXXc7ScJ7Je8C=YyEpt0pM=-bgA@mail.gmail.com>
In-Reply-To: <CAN-5tyEuWz2wLJOfk5DPLyrQXXc7ScJ7Je8C=YyEpt0pM=-bgA@mail.gmail.com>
From:   Igor Raits <igor@gooddata.com>
Date:   Tue, 13 Sep 2022 10:34:04 +0100
Message-ID: <CA+9S74ijk6aWL_MEOmWqY5Mn7=9__mqD2k8dfc-8CsC5NYqdrg@mail.gmail.com>
Subject: Re: Regression: deadlock in io_schedule / nfs_writepage_locked
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
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

Seems those 2 were backported to 5.18.6 which is around when we
started to see the issues=E2=80=A6
I'll try to revert them and see if it helps.

> Is the server constantly returning LAYOUT_UNAVAILABLE?

Not sure, any hint how to check it?

> And does this happen to be co-located with a volume move operation?

We don't really touch the volumes during that time, although we use
FlexVolumes so it could expand/shrink on Netapp's side.


On Fri, Sep 9, 2022 at 7:00 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Fri, Sep 9, 2022 at 12:52 PM Trond Myklebust <trondmy@hammerspace.com>=
 wrote:
> >
> > On Fri, 2022-09-09 at 16:47 +0000, Trond Myklebust wrote:
> > > This looks like it might be the root cause issue. It looks like
> > > you're using pNFS:
> > >
> > > /proc/3278822/stack:
> > > [<0>] pnfs_update_layout+0x603/0xed0 [nfsv4]
> > > [<0>] fl_pnfs_update_layout.constprop.18+0x23/0x1e0
> > > [nfs_layout_nfsv41_files]
> > > [<0>] filelayout_pg_init_write+0x3a/0x70 [nfs_layout_nfsv41_files]
> > > [<0>] __nfs_pageio_add_request+0x294/0x470 [nfs]
> > > [<0>] nfs_pageio_add_request_mirror+0x2f/0x40 [nfs]
> > > [<0>] nfs_pageio_add_request+0x200/0x2d0 [nfs]
> > > [<0>] nfs_page_async_flush+0x120/0x310 [nfs]
> > > [<0>] nfs_writepages_callback+0x5b/0xc0 [nfs]
> > > [<0>] write_cache_pages+0x187/0x4d0
> > > [<0>] nfs_writepages+0xe1/0x200 [nfs]
> > > [<0>] do_writepages+0xd2/0x1b0
> > > [<0>] __writeback_single_inode+0x41/0x360
> > > [<0>] writeback_sb_inodes+0x1f0/0x460
> > > [<0>] __writeback_inodes_wb+0x5f/0xd0
> > > [<0>] wb_writeback+0x235/0x2d0
> > > [<0>] wb_workfn+0x312/0x4a0
> > > [<0>] process_one_work+0x1c5/0x390
> > > [<0>] worker_thread+0x30/0x360
> > > [<0>] kthread+0xd7/0x100
> > > [<0>] ret_from_fork+0x1f/0x30
> > >
> > > What is the pNFS server you are running against? I see you're using
> > > the files pNFS layout type, so is this a NetApp?
>
>
> This reminds me of the problem that was supposed to be fixed by the
> patches that went into 5.19-rc3?.
>       pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVA=
ILABLE
>       pNFS: Avoid a live lock condition in pnfs_update_layout()
>
> Igor,
>
> Is the server constantly returning LAYOUT_UNAVAILABLE? And does this
> happen to be co-located with a volume move operation?
>
>
> > >
> >
> > Sorry for the HTML spam... Resending with all that crap stripped out.
> >
> > > From: Igor Raits <igor@gooddata.com>
> > > Sent: Friday, September 9, 2022 11:09
> > > To: Trond Myklebust <trondmy@hammerspace.com>
> > > Cc: anna@kernel.org <anna@kernel.org>; linux-nfs@vger.kernel.org
> > > <linux-nfs@vger.kernel.org>
> > > Subject: Re: Regression: deadlock in io_schedule /
> > > nfs_writepage_locked
> > >
> > > Hello Trond,
> > >
> > > On Mon, Aug 22, 2022 at 5:01 PM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Mon, 2022-08-22 at 16:43 +0200, Igor Raits wrote:
> > > > > [You don't often get email from igor@gooddata.com. Learn why this
> > > > > is
> > > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > Hello Trond,
> > > > >
> > > > > On Mon, Aug 22, 2022 at 4:02 PM Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > >
> > > > > > On Mon, 2022-08-22 at 10:16 +0200, Igor Raits wrote:
> > > > > > > [You don't often get email from igor@gooddata.com. Learn why
> > > > > > > this
> > > > > > > is
> > > > > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > > > >
> > > > > > > Hello everyone,
> > > > > > >
> > > > > > > Hopefully I'm sending this to the right place=E2=80=A6
> > > > > > > We recently started to see the following stacktrace quite
> > > > > > > often
> > > > > > > on
> > > > > > > our
> > > > > > > VMs that are using NFS extensively (I think after upgrading
> > > > > > > to
> > > > > > > 5.18.11+, but not sure when exactly. For sure it happens on
> > > > > > > 5.18.15):
> > > > > > >
> > > > > > > INFO: task kworker/u36:10:377691 blocked for more than 122
> > > > > > > seconds.
> > > > > > >       Tainted: G            E     5.18.15-1.gdc.el8.x86_64 #1
> > > > > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > > > > > > this
> > > > > > > message.
> > > > > > > task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:
> > > > > > > 2
> > > > > > > flags:0x00004000
> > > > > > > Workqueue: writeback wb_workfn (flush-0:308)
> > > > > > > Call Trace:
> > > > > > > <TASK>
> > > > > > > __schedule+0x38c/0x7d0
> > > > > > > schedule+0x41/0xb0
> > > > > > > io_schedule+0x12/0x40
> > > > > > > __folio_lock+0x110/0x260
> > > > > > > ? filemap_alloc_folio+0x90/0x90
> > > > > > > write_cache_pages+0x1e3/0x4d0
> > > > > > > ? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
> > > > > > > nfs_writepages+0xe1/0x200 [nfs]
> > > > > > > do_writepages+0xd2/0x1b0
> > > > > > > ? check_preempt_curr+0x47/0x70
> > > > > > > ? ttwu_do_wakeup+0x17/0x180
> > > > > > > __writeback_single_inode+0x41/0x360
> > > > > > > writeback_sb_inodes+0x1f0/0x460
> > > > > > > __writeback_inodes_wb+0x5f/0xd0
> > > > > > > wb_writeback+0x235/0x2d0
> > > > > > > wb_workfn+0x348/0x4a0
> > > > > > > ? put_prev_task_fair+0x1b/0x30
> > > > > > > ? pick_next_task+0x84/0x940
> > > > > > > ? __update_idle_core+0x1b/0xb0
> > > > > > > process_one_work+0x1c5/0x390
> > > > > > > worker_thread+0x30/0x360
> > > > > > > ? process_one_work+0x390/0x390
> > > > > > > kthread+0xd7/0x100
> > > > > > > ? kthread_complete_and_exit+0x20/0x20
> > > > > > > ret_from_fork+0x1f/0x30
> > > > > > > </TASK>
> > > > > > >
> > > > > > > I see that something very similar was fixed in btrfs
> > > > > > > (
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/commi
> > > > > > > t/?h=3Dlinux-
> > > > > > > 5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
> > > > > > > but I could not find anything similar for NFS.
> > > > > > >
> > > > > > > Do you happen to know if this is already fixed? If so, would
> > > > > > > you
> > > > > > > mind
> > > > > > > sharing some commits? If not, could you help getting this
> > > > > > > addressed?
> > > > > > >
> > > > > >
> > > > > > The stack trace you show above isn't particularly helpful for
> > > > > > diagnosing what the problem is.
> > > > > >
> > > > > > All it is saying is that 'thread A' is waiting to take a page
> > > > > > lock
> > > > > > that
> > > > > > is being held by a different 'thread B'. Without information on
> > > > > > what
> > > > > > 'thread B' is doing, and why it isn't releasing the lock, there
> > > > > > is
> > > > > > nothing we can conclude.
> > > > >
> > > > > Do you have some hint how to debug this issue further (when it
> > > > > happens
> > > > > again)? Would `virsh dump` to get a memory dump and then some
> > > > > kind of
> > > > > "bt all" via crash help to get more information?
> > > > > Or something else?
> > > > >
> > > > > Thanks in advance!
> > > > > --
> > > > > Igor Raits
> > > >
> > > > Please try running the following two lines of 'bash' script as
> > > > root:
> > > >
> > > > (for tt in $(grep -l 'nfs[^d]' /proc/*/stack); do echo "${tt}:";
> > > > cat ${tt}; echo; done) >/tmp/nfs_threads.txt
> > > >
> > > > cat /sys/kernel/debug/sunrpc/rpc_clnt/*/tasks > /tmp/rpc_tasks.txt
> > > >
> > > > and then send us the output from the two files /tmp/nfs_threads.txt
> > > > and
> > > > /tmp/rpc_tasks.txt.
> > > >
> > > > The file nfs_threads.txt gives us a full set of stack traces from
> > > > all
> > > > processes that are currently in the NFS client code. So it should
> > > > contain both the stack trace from your 'thread A' above, and the
> > > > traces
> > > > from all candidates for the 'thread B' process that is causing the
> > > > blockage.
> > > > The file rpc_tasks.txt gives us the status of any RPC calls that
> > > > might
> > > > be outstanding and might help diagnose any issues with the TCP
> > > > connection.
> > > >
> > > > That should therefore give us a better starting point for root
> > > > causing
> > > > the problem.
> > >
> > > The rpc_tasks is empty but I got nfs_threads from the moment it is
> > > stuck (see attached file).
> > >
> > > It still happens with 5.19.3, 5.19.6.
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >



--=20
Igor Raits
