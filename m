Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D659C1CB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiHVOnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiHVOnS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 10:43:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE61B2F1
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 07:43:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so14224377edi.8
        for <linux-nfs@vger.kernel.org>; Mon, 22 Aug 2022 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=gjL2xuux9MB2kKaVk+nFyaPuo5IftCcvkOgAThY0CZA=;
        b=YX6dJzhZZQakwpHkXC3kBo7F0kVmdoYOmNP3zYejdY26z8hZEfKUO+CHMdVfFDUySY
         iNyXsAnbJo4AU+2kHM7cfj/SLMVIVJnNlObHcsUk6Uvjsfq5mXfz98svONwSeBhQehSJ
         2pBLWg2W25Ss2TTegl14at7uimG/u3Vg3Is5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=gjL2xuux9MB2kKaVk+nFyaPuo5IftCcvkOgAThY0CZA=;
        b=JcSK3Q/qtX6Y/pwcp4B1Ow7w8ByCfc0Bg/yAeY1pbwKbwjmPET3UqkjhuVlHzOQOAC
         sxyMkxKc/f6eO/dnKSGOr8JMDnS4TuG2Lop6FEiNK1+Xkna8rRWWcx/chQWLwnkyrvm/
         HxNa3+rMqfhGJvj00W/iYp4ukVXzCtDjjt2HHT9HyFxTbAeb9YrN1hSzSvxgVbDBjqNn
         B7SnbKdf7bWcg18YtPbB4n+Fj+PvsAubi+jaBajdlgI+nxzQTlA/RDdBsYmCRL+6oAgo
         D+Sdioon5wT8FG6vyShaWNHM3x9+XSfxvqZdxE4CO8K5zos57zXln1/P1Ls15Wmm+MG0
         Jz9w==
X-Gm-Message-State: ACgBeo0IEmUzH+40ly0O+DDf0cnFZPX8wkAKoIY64RxfXeo+90MHniT6
        GQVpPNOHhcjQkAJ5muHYSnPNu02ZDH+LtB+UOqzpe5Qg55knFA==
X-Google-Smtp-Source: AA6agR46o34Q6nbrIgGRpYHkcW7Cm5nlUo5ylsvNXwsoc99itYuT7oEnmlMEtOl2sZ96yfdTANo4xrJBKfjaD9iL6SY=
X-Received: by 2002:a05:6402:541b:b0:446:783e:2bbf with SMTP id
 ev27-20020a056402541b00b00446783e2bbfmr9303030edb.252.1661179393478; Mon, 22
 Aug 2022 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9S74iBrObUnaSpSdqXu0_GosDdE1dmSbmgxfmxEK2mhDaNjg@mail.gmail.com>
 <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
In-Reply-To: <28bbec15d3a631e0a9047f4a5895bd42db364dba.camel@hammerspace.com>
From:   Igor Raits <igor@gooddata.com>
Date:   Mon, 22 Aug 2022 16:43:03 +0200
Message-ID: <CA+9S74jaMmn69WLsOZG8QYT2kZQDn9SGszNr-ozxRPubPuV5wQ@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 4:02 PM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
> On Mon, 2022-08-22 at 10:16 +0200, Igor Raits wrote:
> > [You don't often get email from igor@gooddata.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hello everyone,
> >
> > Hopefully I'm sending this to the right place=E2=80=A6
> > We recently started to see the following stacktrace quite often on
> > our
> > VMs that are using NFS extensively (I think after upgrading to
> > 5.18.11+, but not sure when exactly. For sure it happens on 5.18.15):
> >
> > INFO: task kworker/u36:10:377691 blocked for more than 122 seconds.
> >      Tainted: G            E     5.18.15-1.gdc.el8.x86_64 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > message.
> > task:kworker/u36:10  state:D stack:    0 pid:377691 ppid:     2
> > flags:0x00004000
> > Workqueue: writeback wb_workfn (flush-0:308)
> > Call Trace:
> > <TASK>
> > __schedule+0x38c/0x7d0
> > schedule+0x41/0xb0
> > io_schedule+0x12/0x40
> > __folio_lock+0x110/0x260
> > ? filemap_alloc_folio+0x90/0x90
> > write_cache_pages+0x1e3/0x4d0
> > ? nfs_writepage_locked+0x1d0/0x1d0 [nfs]
> > nfs_writepages+0xe1/0x200 [nfs]
> > do_writepages+0xd2/0x1b0
> > ? check_preempt_curr+0x47/0x70
> > ? ttwu_do_wakeup+0x17/0x180
> > __writeback_single_inode+0x41/0x360
> > writeback_sb_inodes+0x1f0/0x460
> > __writeback_inodes_wb+0x5f/0xd0
> > wb_writeback+0x235/0x2d0
> > wb_workfn+0x348/0x4a0
> > ? put_prev_task_fair+0x1b/0x30
> > ? pick_next_task+0x84/0x940
> > ? __update_idle_core+0x1b/0xb0
> > process_one_work+0x1c5/0x390
> > worker_thread+0x30/0x360
> > ? process_one_work+0x390/0x390
> > kthread+0xd7/0x100
> > ? kthread_complete_and_exit+0x20/0x20
> > ret_from_fork+0x1f/0x30
> > </TASK>
> >
> > I see that something very similar was fixed in btrfs
> > (
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> > t/?h=3Dlinux-5.18.y&id=3D9535ec371d741fa037e37eddc0a5b25ba82d0027)
> > but I could not find anything similar for NFS.
> >
> > Do you happen to know if this is already fixed? If so, would you mind
> > sharing some commits? If not, could you help getting this addressed?
> >
>
> The stack trace you show above isn't particularly helpful for
> diagnosing what the problem is.
>
> All it is saying is that 'thread A' is waiting to take a page lock that
> is being held by a different 'thread B'. Without information on what
> 'thread B' is doing, and why it isn't releasing the lock, there is
> nothing we can conclude.

Do you have some hint how to debug this issue further (when it happens
again)? Would `virsh dump` to get a memory dump and then some kind of
"bt all" via crash help to get more information?
Or something else?

Thanks in advance!
--=20
Igor Raits
