Return-Path: <linux-nfs+bounces-303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FE803B09
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 18:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B31F20F6C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410A28DD2;
	Mon,  4 Dec 2023 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkDee85l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3E171D9
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE13C433C8
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701709223;
	bh=WJkTW8AuJgLgd0uAQFkbSXpS5mDW+chuieyjRpBszmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nkDee85lyE/NfSr+AFG+dsjVLs7BScnHWqJQFw7NRLRdhab4ypkWy1oDj5N0K7mLB
	 +yrYH555whhf+Nkl+Zmkd2Pi0dWZzEbsxk4qE+SQ9Vboa91FybkWEAMZOeI+9NMdFX
	 PXCulpeL9beK7LsldDtLvDAIXsrfjiIR5TFfmu6etZ+bZcT7poj94RpRr+uP/kTRs9
	 3iWTDhQNoIP6bHvPwbEhNb+T6RaI5Xd2H54adDBnjx4hSZrBoMOWwMOopDp1CVpj/S
	 nuJ+N7/fmH0ct95dmvfqbSWvyU2hP3z0g6FSQjhVZSaHdKn9WrZeYnXM68fbrIBgHX
	 isSxpe6Q/bE1A==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-423a459d616so33123331cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Dec 2023 09:00:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxKXFb1giyh/rHp38+bLSU5WgXolnGkI79fl4koXtNbIn1nfnzg
	K84J9t56QSZeGS/hLnn2GhVJT+cj0G+7sxqbpco=
X-Google-Smtp-Source: AGHT+IHyIj5+p1E/ZXvAGvyYnjKjqGrQxyaiUy/gcme1BnW2aGnzNz3t1vP/CE01x4msoSS/zN2hDIJ0WF/swKbfVDM=
X-Received: by 2002:ac8:5941:0:b0:425:4043:2a08 with SMTP id
 1-20020ac85941000000b0042540432a08mr5821576qtz.131.1701709222717; Mon, 04 Dec
 2023 09:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201211549.126941-1-anna@kernel.org> <20231201211549.126941-5-anna@kernel.org>
 <89064b882a9e67fadc03520b99e9e52fa94094c9.camel@kernel.org>
In-Reply-To: <89064b882a9e67fadc03520b99e9e52fa94094c9.camel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Mon, 4 Dec 2023 12:00:06 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfk74u+G04Q+KR+Z6DgNTu4iqeN4491MSk-L1rqTwPdFqQ@mail.gmail.com>
Message-ID: <CAFX2Jfk74u+G04Q+KR+Z6DgNTu4iqeN4491MSk-L1rqTwPdFqQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] SUNRPC: Fix a suspicious RCU usage warning
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Sun, Dec 3, 2023 at 7:30=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2023-12-01 at 16:15 -0500, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > I received the following warning while running cthon against an ontap
> > server running pNFS:
> >
> > [   57.202521] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   57.202522] WARNING: suspicious RCU usage
> > [   57.202523] 6.7.0-rc3-g2cc14f52aeb7 #41492 Not tainted
> > [   57.202525] -----------------------------
> > [   57.202525] net/sunrpc/xprtmultipath.c:349 RCU-list traversed in non=
-reader section!!
> > [   57.202527]
> >                other info that might help us debug this:
> >
> > [   57.202528]
> >                rcu_scheduler_active =3D 2, debug_locks =3D 1
> > [   57.202529] no locks held by test5/3567.
> > [   57.202530]
> >                stack backtrace:
> > [   57.202532] CPU: 0 PID: 3567 Comm: test5 Not tainted 6.7.0-rc3-g2cc1=
4f52aeb7 #41492 5b09971b4965c0aceba19f3eea324a4a806e227e
> > [   57.202534] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 unknown 2/2/2022
> > [   57.202536] Call Trace:
> > [   57.202537]  <TASK>
> > [   57.202540]  dump_stack_lvl+0x77/0xb0
> > [   57.202551]  lockdep_rcu_suspicious+0x154/0x1a0
> > [   57.202556]  rpc_xprt_switch_has_addr+0x17c/0x190 [sunrpc ebe02571b9=
a8ceebf7d98e71675af20c19bdb1f6]
> > [   57.202596]  rpc_clnt_setup_test_and_add_xprt+0x50/0x180 [sunrpc ebe=
02571b9a8ceebf7d98e71675af20c19bdb1f6]
> > [   57.202621]  ? rpc_clnt_add_xprt+0x254/0x300 [sunrpc ebe02571b9a8cee=
bf7d98e71675af20c19bdb1f6]
> > [   57.202646]  rpc_clnt_add_xprt+0x27a/0x300 [sunrpc ebe02571b9a8ceebf=
7d98e71675af20c19bdb1f6]
> > [   57.202671]  ? __pfx_rpc_clnt_setup_test_and_add_xprt+0x10/0x10 [sun=
rpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
> > [   57.202696]  nfs4_pnfs_ds_connect+0x345/0x760 [nfsv4 c716d88496ded0e=
a6d289bbea684fa996f9b57a9]
> > [   57.202728]  ? __pfx_nfs4_test_session_trunk+0x10/0x10 [nfsv4 c716d8=
8496ded0ea6d289bbea684fa996f9b57a9]
> > [   57.202754]  nfs4_fl_prepare_ds+0x75/0xc0 [nfs_layout_nfsv41_files e=
3a4187f18ae8a27b630f9feae6831b584a9360a]
> > [   57.202760]  filelayout_write_pagelist+0x4a/0x200 [nfs_layout_nfsv41=
_files e3a4187f18ae8a27b630f9feae6831b584a9360a]
> > [   57.202765]  pnfs_generic_pg_writepages+0xbe/0x230 [nfsv4 c716d88496=
ded0ea6d289bbea684fa996f9b57a9]
> > [   57.202788]  __nfs_pageio_add_request+0x3fd/0x520 [nfs 6c976fa593a7c=
2976f5a0aeb4965514a828e6902]
> > [   57.202813]  nfs_pageio_add_request+0x18b/0x390 [nfs 6c976fa593a7c29=
76f5a0aeb4965514a828e6902]
> > [   57.202831]  nfs_do_writepage+0x116/0x1e0 [nfs 6c976fa593a7c2976f5a0=
aeb4965514a828e6902]
> > [   57.202849]  nfs_writepages_callback+0x13/0x30 [nfs 6c976fa593a7c297=
6f5a0aeb4965514a828e6902]
> > [   57.202866]  write_cache_pages+0x265/0x450
> > [   57.202870]  ? __pfx_nfs_writepages_callback+0x10/0x10 [nfs 6c976fa5=
93a7c2976f5a0aeb4965514a828e6902]
> > [   57.202891]  nfs_writepages+0x141/0x230 [nfs 6c976fa593a7c2976f5a0ae=
b4965514a828e6902]
> > [   57.202913]  do_writepages+0xd2/0x230
> > [   57.202917]  ? filemap_fdatawrite_wbc+0x5c/0x80
> > [   57.202921]  filemap_fdatawrite_wbc+0x67/0x80
> > [   57.202924]  filemap_write_and_wait_range+0xd9/0x170
> > [   57.202930]  nfs_wb_all+0x49/0x180 [nfs 6c976fa593a7c2976f5a0aeb4965=
514a828e6902]
> > [   57.202947]  nfs4_file_flush+0x72/0xb0 [nfsv4 c716d88496ded0ea6d289b=
bea684fa996f9b57a9]
> > [   57.202969]  __se_sys_close+0x46/0xd0
> > [   57.202972]  do_syscall_64+0x68/0x100
> > [   57.202975]  ? do_syscall_64+0x77/0x100
> > [   57.202976]  ? do_syscall_64+0x77/0x100
> > [   57.202979]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [   57.202982] RIP: 0033:0x7fe2b12e4a94
> > [   57.202985] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00=
 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 74 13 b8 03 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 ec 18 89 7c 24 0c e8 c3
> > [   57.202987] RSP: 002b:00007ffe857ddb38 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000003
> > [   57.202989] RAX: ffffffffffffffda RBX: 00007ffe857dfd68 RCX: 00007fe=
2b12e4a94
> > [   57.202991] RDX: 0000000000002000 RSI: 00007ffe857ddc40 RDI: 0000000=
000000003
> > [   57.202992] RBP: 00007ffe857dfc50 R08: 7fffffffffffffff R09: 0000000=
065650f49
> > [   57.202993] R10: 00007fe2b11f8300 R11: 0000000000000202 R12: 0000000=
000000000
> > [   57.202994] R13: 00007ffe857dfd80 R14: 00007fe2b1445000 R15: 0000000=
000000000
> > [   57.202999]  </TASK>
> >
> > The problem seems to be that two out of three callers aren't taking the
> > rcu_read_lock() before calling the list_for_each_entry_rcu() function i=
n
> > rpc_xprt_switch_has_addr(). I fix this by making a new variant of the
> > function that takes the lock when necessary, and provide a bypass path
> > for the one function that was doing this already.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  include/linux/sunrpc/xprtmultipath.h |  2 ++
> >  net/sunrpc/clnt.c                    |  2 +-
> >  net/sunrpc/xprtmultipath.c           | 14 +++++++++++++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrp=
c/xprtmultipath.h
> > index c0514c684b2c..0598552e7ccc 100644
> > --- a/include/linux/sunrpc/xprtmultipath.h
> > +++ b/include/linux/sunrpc/xprtmultipath.h
> > @@ -78,6 +78,8 @@ extern struct rpc_xprt *xprt_iter_xprt(struct rpc_xpr=
t_iter *xpi);
> >  extern struct rpc_xprt *xprt_iter_get_xprt(struct rpc_xprt_iter *xpi);
> >  extern struct rpc_xprt *xprt_iter_get_next(struct rpc_xprt_iter *xpi);
> >
> > +extern bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> > +             const struct sockaddr *sap);
> >  extern bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> >               const struct sockaddr *sap);
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 0b2c4b5484f5..b2a81c26da32 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -3299,7 +3299,7 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_cln=
t *clnt,
> >
> >       rcu_read_lock();
> >       xps =3D rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
> > -     ret =3D rpc_xprt_switch_has_addr(xps, sap);
> > +     ret =3D __rpc_xprt_switch_has_addr(xps, sap);
> >       rcu_read_unlock();
> >       return ret;
> >  }
> > diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> > index 701250b305db..20f9dc220383 100644
> > --- a/net/sunrpc/xprtmultipath.c
> > +++ b/net/sunrpc/xprtmultipath.c
> > @@ -336,7 +336,7 @@ struct rpc_xprt *xprt_iter_current_entry_offline(st=
ruct rpc_xprt_iter *xpi)
> >                       xprt_switch_find_current_entry_offline);
> >  }
> >
> > -bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> > +bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> >                             const struct sockaddr *sap)
> >  {
> >       struct list_head *head;
> > @@ -356,6 +356,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_swit=
ch *xps,
> >       return false;
> >  }
> >
> > +bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> > +                           const struct sockaddr *sap)
> > +{
> > +     bool res;
> > +
> > +     rcu_read_lock();
> > +     res =3D __rpc_xprt_switch_has_addr(xps, sap);
> > +     rcu_read_unlock();
> > +
> > +     return res;
> > +}
> > +
> >  static
> >  struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
> >               const struct rpc_xprt *cur, bool check_active)
>
> Adding an new wrapper here is probably more trouble than it's worth.
>
> Why not have rpc_xprt_switch_has_addr take and drop the rcu_read_lock
> itself? It is safe (and reasonably cheap) to take it recursively, so
> that should be fine from existing callers that already hold it.

Good suggestion! I'm too used to thinking in terms of avoiding
recursive locks. I'll fix up the patch and resend.

Thanks for the review!
Anna

>
> Either way, this patch fixes a real bug, so if you choose go to with it:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

