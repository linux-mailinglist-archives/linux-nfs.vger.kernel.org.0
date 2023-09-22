Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD727AB721
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIVRXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVRXF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 13:23:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36AAF1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 10:22:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00b877379so9477071fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695403377; x=1696008177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzBeempfnorpRCWhb2c2UDdkMLUj52zZihmUev7/bak=;
        b=Qb1mITAhvzr0cNO8zO8hkJ6rHWaSzM8+Gtqj+a24Q7zijxXYKcGqTLIGxqw4R3qWV2
         3cXcS8fY7V+MvkjfLVT0b6r/6G3SGr5IPpXRe5YkgIjvGl1cp9bAGrlqGscws5JDcCaO
         KiHSQhIZ5TrrzkqXt93ZfdevtyXlRc8uNcPxL9FlM8aNrzTw6Lm7aKtLFsbJc7HNQ54S
         g34QFDI9cKhSMCH/R1SJLy5TeyHKxE7BQ6IbxaU6wiog4MxVuUUj5px8Wpdk03I8kRoL
         1idrApMNIeuN4xn7+y6Q5FBqZaPtDPdCFMVp/DI6XYGVkGw1WI0p7uj39YKK7Xap3129
         uGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403377; x=1696008177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzBeempfnorpRCWhb2c2UDdkMLUj52zZihmUev7/bak=;
        b=Z7PnyZj9flYM21I3OxMoeuwaemuju9YEI15KYGH3COpL4e/e83kNcb/cBUN4z3CPLm
         pWo48wMtUUOhwjZxOhaAN8RrYKA6C33SpyBFLN7YYUTgpYEAIDxWDhOvX0bfyQeJoBzt
         +NGAWYxDlNV8G1KdfOu11HPN+MgXDYErnfEfSNtsfLEjtWdB2sLtAhS0d284a5t0WVIw
         7IO+Q0I/dlOIRJumzrXslmdw8KLZovLtEMWWAJOIb84PZYTeWx/xiwcWwOnrzIk94sF6
         u7tTiBQGRS3LtVo5VnpghI03PxhVNvVeA4RRD+FsegxSXlzxiPGsDLBABtJY0CsaJEDB
         v3kw==
X-Gm-Message-State: AOJu0YxffUYv6Q5z2naj1frwyJx9qMo0Jc6rn+qyCIJITA4p3WN5Cf09
        luKA7RsyH4Izz/h1i0f8V4lD9G5hI4x0x06++pQ=
X-Google-Smtp-Source: AGHT+IGIYc60mjV5sAV7MEUZB7CjLA75sTAZefGWUavPfFlohgIhXBEjbTG2s5SfBaAx2bxkgSsLQ2uOhaS65w0OFYE=
X-Received: by 2002:a2e:a7c8:0:b0:2bf:7908:ae7c with SMTP id
 x8-20020a2ea7c8000000b002bf7908ae7cmr10338689ljp.2.1695403376653; Fri, 22 Sep
 2023 10:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230551.30483-1-trondmy@kernel.org> <20230917230551.30483-2-trondmy@kernel.org>
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com> <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
In-Reply-To: <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 22 Sep 2023 13:22:45 -0400
Message-ID: <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 20, 2023 at 8:27=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Wed, 2023-09-20 at 15:38 -0400, Anna Schumaker wrote:
> > Hi Trond,
> >
> > On Sun, Sep 17, 2023 at 7:12=E2=80=AFPM <trondmy@kernel.org> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > Commit 4dc73c679114 reintroduces the deadlock that was fixed by
> > > commit
> > > aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because
> > > it
> > > prevents the setup of new threads to handle reboot recovery, while
> > > the
> > > older recovery thread is stuck returning delegations.
> >
> > I'm seeing a possible deadlock with xfstests generic/472 on NFS v4.x
> > after applying this patch. The test itself checks for various
> > swapfile
> > edge cases, so it seems likely something is going on there.
> >
> > Let me know if you need more info
> > Anna
> >
>
> Did you turn off delegations on your server? If you don't, then swap
> will deadlock itself under various scenarios.

Is there documentation somewhere that says that delegations must be
turned off on the server if NFS over swap is enabled?

If the client can't handle delegations + swap, then shouldn't this be
solved by (1) checking if we are in NFS over swap and then proactively
setting 'dont want delegation' on open and/or (2) proactively return
the delegation if received so that we don't get into the deadlock?

I think this is similar to Anna's. With this patch, I'm running into a
problem running against an ONTAP server using xfstests (no problems
without the patch). During the run two stuck threads are:
[root@unknown000c291be8aa aglo]# cat /proc/3724/stack
[<0>] nfs4_run_state_manager+0x1c0/0x1f8 [nfsv4]
[<0>] kthread+0x100/0x110
[<0>] ret_from_fork+0x10/0x20
[root@unknown000c291be8aa aglo]# cat /proc/3725/stack
[<0>] nfs_wait_bit_killable+0x1c/0x88 [nfs]
[<0>] nfs4_wait_clnt_recover+0xb4/0xf0 [nfsv4]
[<0>] nfs4_client_recover_expired_lease+0x34/0x88 [nfsv4]
[<0>] _nfs4_do_open.isra.0+0x94/0x408 [nfsv4]
[<0>] nfs4_do_open+0x9c/0x238 [nfsv4]
[<0>] nfs4_atomic_open+0x100/0x118 [nfsv4]
[<0>] nfs4_file_open+0x11c/0x240 [nfsv4]
[<0>] do_dentry_open+0x140/0x528
[<0>] vfs_open+0x30/0x38
[<0>] do_open+0x14c/0x360
[<0>] path_openat+0x104/0x250
[<0>] do_filp_open+0x84/0x138
[<0>] file_open_name+0x134/0x190
[<0>] __do_sys_swapoff+0x58/0x6e8
[<0>] __arm64_sys_swapoff+0x18/0x28
[<0>] invoke_syscall.constprop.0+0x7c/0xd0
[<0>] do_el0_svc+0xb4/0xd0
[<0>] el0_svc+0x50/0x228
[<0>] el0t_64_sync_handler+0x134/0x150
[<0>] el0t_64_sync+0x17c/0x180

>
> > >
> > > Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if
> > > swap is enabled")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/nfs4proc.c  |  4 +++-
> > >  fs/nfs/nfs4state.c | 38 ++++++++++++++++++++++++++------------
> > >  2 files changed, 29 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index 5deeaea8026e..a19e809cad16 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -10652,7 +10652,9 @@ static void nfs4_disable_swap(struct inode
> > > *inode)
> > >          */
> > >         struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> > >
> > > -       nfs4_schedule_state_manager(clp);
> > > +       set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> > > +       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> > > +       wake_up_var(&clp->cl_state);
> > >  }
> > >
> > >  static const struct inode_operations nfs4_dir_inode_operations =3D {
> > > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > > index 0bc160fbabec..5751a6886da4 100644
> > > --- a/fs/nfs/nfs4state.c
> > > +++ b/fs/nfs/nfs4state.c
> > > @@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct
> > > nfs_client *clp)
> > >  {
> > >         struct task_struct *task;
> > >         char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
> > > +       struct rpc_clnt *clnt =3D clp->cl_rpcclient;
> > > +       bool swapon =3D false;
> > >
> > > -       if (clp->cl_rpcclient->cl_shutdown)
> > > +       if (clnt->cl_shutdown)
> > >                 return;
> > >
> > >         set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
> > > -       if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state) !=3D 0) {
> > > -               wake_up_var(&clp->cl_state);
> > > -               return;
> > > +
> > > +       if (atomic_read(&clnt->cl_swapper)) {
> > > +               swapon =3D
> > > !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
> > > +                                          &clp->cl_state);
> > > +               if (!swapon) {
> > > +                       wake_up_var(&clp->cl_state);
> > > +                       return;
> > > +               }
> > >         }
> > > -       set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
> > > +
> > > +       if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp-
> > > >cl_state) !=3D 0)
> > > +               return;
> > > +
> > >         __module_get(THIS_MODULE);
> > >         refcount_inc(&clp->cl_count);
> > >
> > > @@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct
> > > nfs_client *clp)
> > >                         __func__, PTR_ERR(task));
> > >                 if (!nfs_client_init_is_complete(clp))
> > >                         nfs_mark_client_ready(clp, PTR_ERR(task));
> > > +               if (swapon)
> > > +                       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state);
> > >                 nfs4_clear_state_manager_bit(clp);
> > > -               clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state);
> > >                 nfs_put_client(clp);
> > >                 module_put(THIS_MODULE);
> > >         }
> > > @@ -2748,22 +2759,25 @@ static int nfs4_run_state_manager(void
> > > *ptr)
> > >
> > >         allow_signal(SIGKILL);
> > >  again:
> > > -       set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
> > >         nfs4_state_manager(clp);
> > > -       if (atomic_read(&cl->cl_swapper)) {
> > > +
> > > +       if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
> > > +           !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp-
> > > >cl_state)) {
> > >                 wait_var_event_interruptible(&clp->cl_state,
> > >
> > > test_bit(NFS4CLNT_RUN_MANAGER,
> > >                                                       &clp-
> > > >cl_state));
> > > -               if (atomic_read(&cl->cl_swapper) &&
> > > -                   test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
> > > +               if (!atomic_read(&cl->cl_swapper))
> > > +                       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state);
> > > +               if (refcount_read(&clp->cl_count) > 1 &&
> > > !signalled())
> > >                         goto again;
> > >                 /* Either no longer a swapper, or were signalled */
> > > +               clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state);
> > > +               nfs4_clear_state_manager_bit(clp);
> > >         }
> > > -       clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
> > >
> > >         if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
> > >             test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
> > > -           !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp-
> > > >cl_state))
> > > +           !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp-
> > > >cl_state))
> > >                 goto again;
> > >
> > >         nfs_put_client(clp);
> > > --
> > > 2.41.0
> > >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
