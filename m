Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1767375
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfGLQjt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 12:39:49 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:42472 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLQjs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Jul 2019 12:39:48 -0400
Received: by mail-ua1-f47.google.com with SMTP id a97so4219703uaa.9
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2019 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBsFYc4YsS4d44TkvBfE+o/G/b0ODH4qIjde/UCuXN4=;
        b=eqBnxrtJTCMRMDZ9RE5YWNhJmz4ddxa4VxsO4rioWfxishdfVWOrVYXLcKTmggTE4g
         VKQVfJAXTHuRRs02DUPDE91BccSMqJySqIXtnm+LFAsDEEzOMTeO0805v2MMWuZQx8uK
         wbkPipiaLu0ihAt8en9VZl/TgFyJDaGtol1j+HeBTe30oX5539xtoWctQBz/HPpsrd1U
         6tiuqbSK1H92+rAgATaz2RbFqQv8iG369WxtIeX1KKaLX8MzpZNWFMYBBk5LlLcvzW/e
         5o4R2EaJ+Bq0lUKHNQQdLnuZqirnZAzIGA7PSoNjPRp1GAyQ8Y83zHZifYhfq7YW//jf
         owlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBsFYc4YsS4d44TkvBfE+o/G/b0ODH4qIjde/UCuXN4=;
        b=IvkSQ0Pb86FDzuZ4WgYo4ENk2tWei2Y94IqDoGQqsYg9eET//aUkGnZNmPG4kFRoko
         ggvLKr8eeZggHdap08p/lsNhie6CxtOK1iemPUd70xxzZoGsiFCqzjzPPaCnczjipfyt
         UXW/BCmVQsEPBDKjQxAg18kSQN4Jgmb8EFliUIEBf3gFKGgxvxTrMZGur6Wzsis2hu57
         cz+4PoseNa/61e5AHLNPXymgrUVWstEoCLKNOLf+9K8yvgyGQsRPkcj7bZF1fqMneZmN
         OErhw3NdX0l083iwtd+ksPESVuNuplI6inZnk8baoxna0QSMjcK4TAMR3BSZNDzbMno8
         /Q8Q==
X-Gm-Message-State: APjAAAWEtV0GmqjwplwsXkmQQu4mkyPhl2A72tEhnBLvamxo5/R+gd3H
        J6nCAtaC5H9Libh/d3MNTOX70XcMfnm0kY0Ba+/2ud+z
X-Google-Smtp-Source: APXvYqwku7y81yO121NSUjj3Bn/ZCZETTNJwSZEwB6HZWOSKyexPZuynuU2cDo5IdBUsWYKwMZXn4wP261+hDBVnd7U=
X-Received: by 2002:ab0:760e:: with SMTP id o14mr4568747uap.93.1562949587200;
 Fri, 12 Jul 2019 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
 <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
 <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com> <f614be728542c2cb9dd026a5e97b78d4e74a30af.camel@hammerspace.com>
In-Reply-To: <f614be728542c2cb9dd026a5e97b78d4e74a30af.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 12 Jul 2019 12:39:35 -0400
Message-ID: <CAN-5tyHkdmTJZAYwAcfUy4hYOz=KHgdBeTrYMNYiWQaKp7UrJA@mail.gmail.com>
Subject: Re: multipath patches
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 11, 2019 at 5:13 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2019-07-11 at 16:33 -0400, Olga Kornievskaia wrote:
> > On Thu, Jul 11, 2019 at 3:29 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Thu, 2019-07-11 at 15:06 -0400, Olga Kornievskaia wrote:
> > > > Hi Trond,
> > > >
> > > > I see that you have nconnect patches in your testing branch (as
> > > > well
> > > > as your linux-next and I assume they are the same).  There is
> > > > something wrong with that version. A mount hangs the machine.
> > > >
> > > > [  132.143379] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> > > > [mount.nfs:2624]
> > > >
> > > > I don't have such problems with the patch series that Neil has
> > > > posted.
> > > >
> > > > Thank you.
> > >
> > > How are the patchsets different? As far as I know, all I did was
> > > apply
> > > the 3 patches that Neil added to my existing branch.
> >
> > I'm not sure. I had a problem with your "multipath" branch before and
> > I recall what I did is went back and redownloaded your posted
> > patches.
> > That was when I was testing performance. So if you haven't touched
> > that branch and just used it I think it's the same problem.
> >
> > In the current testing branch I don't see several patches that Neil
> > has added (posted) to the mailing list. So I'm not sure what you mean
> > you added 3 of his patches on top of yours. At most I can say maybe
> > you added 2 of his (one that allows for v2 and v3 and another that
> > does state operations on a single connection. There are no patches
> > for
> > sunrpc stats that were posted).
> >
> > What I know is that if I revert your branch to
> > bf11fbdb20b385157b046ea7781f04d0c62554a3 before patches and apply
> > Neils patches. All is fine. I really don't want to debug a non-
> > working
> > version when there is one that works.
>
> Sure, but that is not really an option given the rules for how trees in
> linux-next are supposed to work. They are considered to be more or less
> stable.
>
> Anyhow, I think I've found the bug. Neil had silently fixed it in one
> of my patches, so I've added an incremental patch that does more or
> less what he did.

I just pulled and I still have a problem with the nconnect mount.
Machine still hangs.

Stack trace isn't in NFS but I'm betting it's somehow related

[  235.756747] general protection fault: 0000 [#1] SMP PTI
[  235.765187] CPU: 0 PID: 2780 Comm: pool Tainted: G        W
5.2.0-rc7+ #29
[  235.768555] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  235.774368] RIP: 0010:kmem_cache_alloc_node_trace+0x10b/0x1e0
[  235.777576] Code: 4d 89 e1 41 f6 44 24 0b 04 0f 84 5f ff ff ff 4c
89 e7 e8 08 b6 01 00 49 89 c1 e9 4f ff ff ff 41 8b 41 20 49 8b 39 48
8d 4a 01 <49> 8b 1c 06 4c 89 f0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 36
ff ff
[  235.786811] RSP: 0018:ffffbc7c4200fe58 EFLAGS: 00010246
[  235.789778] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000002b7c
[  235.793204] RDX: 0000000000002b7b RSI: 0000000000000dc0 RDI: 000000000002d96
[  235.796182] RBP: 0000000000000dc0 R08: ffff9c7bfa82d960 R09: ffff9c7bcfc06d00
[  235.799135] R10: ffff9c7bfddf0240 R11: 0000000000000001 R12: ffff9c7bcfc06d00
[  235.802094] R13: 0000000000000000 R14: f000ff53f000ff53 R15: ffffffffbe2d4d71
[  235.805072] FS:  00007fd7f1d48700(0000) GS:ffff9c7bfa800000(0000)
knlGS:0000000000000000
[  235.808430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  235.810762] CR2: 00007fd7f0eb65a4 CR3: 0000000012046005 CR4: 00000000001606f0
[  235.813662] Call Trace:
[  235.814694]  alloc_rt_sched_group+0xf1/0x250
[  235.816439]  sched_create_group+0x59/0x70
[  235.818094]  sched_autogroup_create_attach+0x3a/0x160
[  235.820148]  ksys_setsid+0xeb/0x100
[  235.821645]  __ia32_sys_setsid+0xa/0x10
[  235.823216]  do_syscall_64+0x55/0x1a0
[  235.824710]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
