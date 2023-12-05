Return-Path: <linux-nfs+bounces-329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87980512C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2388F280E1C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962C241F1;
	Tue,  5 Dec 2023 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG/+X53j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA637D51D
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 10:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF5C433C8;
	Tue,  5 Dec 2023 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701773468;
	bh=i6Z/lUSE+XloQ1jXap8woWLQieqH7dxa87kXDVTL2vQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sG/+X53jSkJ+edW9yuWmxc8GQNkviZIMut7YMvY+2bQGBvpDtCRPc4z59ez9b1bSW
	 nkF8tzxkchkqQ9d24QlwfNKvbrfo1mI6bWZDG0hscayTcpOLDPWeHNDIhm+rYI9tl3
	 4WwXOJU/6EgWUjha2M0LYv1+a+hL8Gknvy1eAwYsZtPvppFfhxb1LAny1Lm+PgNCrA
	 FTENIj+/9lxUytBfjJWWBnFXgiaI/YGXuOI20v0L0Rvuaj53f/Dr7htO29qFgX1Q/C
	 Wny1a8P3h65jzHOYd/ptv5100ELsA/ZP02UkvDijstRmBKTCU2q6A4nsvVewhr7Oud
	 NQNOcor61zqYA==
Message-ID: <18dc97cae8ead7137edfab8ffec1b5fdd0dc914e.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] SUNRPC: Fix a suspicious RCU usage warning
From: Jeff Layton <jlayton@kernel.org>
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	trond.myklebust@hammerspace.com
Date: Tue, 05 Dec 2023 05:51:06 -0500
In-Reply-To: <20231204202512.108047-5-anna@kernel.org>
References: <20231204202512.108047-1-anna@kernel.org>
	 <20231204202512.108047-5-anna@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 15:25 -0500, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> I received the following warning while running cthon against an ontap
> server running pNFS:
>=20
> [   57.202521] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   57.202522] WARNING: suspicious RCU usage
> [   57.202523] 6.7.0-rc3-g2cc14f52aeb7 #41492 Not tainted
> [   57.202525] -----------------------------
> [   57.202525] net/sunrpc/xprtmultipath.c:349 RCU-list traversed in non-r=
eader section!!
> [   57.202527]
>                other info that might help us debug this:
>=20
> [   57.202528]
>                rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   57.202529] no locks held by test5/3567.
> [   57.202530]
>                stack backtrace:
> [   57.202532] CPU: 0 PID: 3567 Comm: test5 Not tainted 6.7.0-rc3-g2cc14f=
52aeb7 #41492 5b09971b4965c0aceba19f3eea324a4a806e227e
> [   57.202534] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS u=
nknown 2/2/2022
> [   57.202536] Call Trace:
> [   57.202537]  <TASK>
> [   57.202540]  dump_stack_lvl+0x77/0xb0
> [   57.202551]  lockdep_rcu_suspicious+0x154/0x1a0
> [   57.202556]  rpc_xprt_switch_has_addr+0x17c/0x190 [sunrpc ebe02571b9a8=
ceebf7d98e71675af20c19bdb1f6]
> [   57.202596]  rpc_clnt_setup_test_and_add_xprt+0x50/0x180 [sunrpc ebe02=
571b9a8ceebf7d98e71675af20c19bdb1f6]
> [   57.202621]  ? rpc_clnt_add_xprt+0x254/0x300 [sunrpc ebe02571b9a8ceebf=
7d98e71675af20c19bdb1f6]
> [   57.202646]  rpc_clnt_add_xprt+0x27a/0x300 [sunrpc ebe02571b9a8ceebf7d=
98e71675af20c19bdb1f6]
> [   57.202671]  ? __pfx_rpc_clnt_setup_test_and_add_xprt+0x10/0x10 [sunrp=
c ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
> [   57.202696]  nfs4_pnfs_ds_connect+0x345/0x760 [nfsv4 c716d88496ded0ea6=
d289bbea684fa996f9b57a9]
> [   57.202728]  ? __pfx_nfs4_test_session_trunk+0x10/0x10 [nfsv4 c716d884=
96ded0ea6d289bbea684fa996f9b57a9]
> [   57.202754]  nfs4_fl_prepare_ds+0x75/0xc0 [nfs_layout_nfsv41_files e3a=
4187f18ae8a27b630f9feae6831b584a9360a]
> [   57.202760]  filelayout_write_pagelist+0x4a/0x200 [nfs_layout_nfsv41_f=
iles e3a4187f18ae8a27b630f9feae6831b584a9360a]
> [   57.202765]  pnfs_generic_pg_writepages+0xbe/0x230 [nfsv4 c716d88496de=
d0ea6d289bbea684fa996f9b57a9]
> [   57.202788]  __nfs_pageio_add_request+0x3fd/0x520 [nfs 6c976fa593a7c29=
76f5a0aeb4965514a828e6902]
> [   57.202813]  nfs_pageio_add_request+0x18b/0x390 [nfs 6c976fa593a7c2976=
f5a0aeb4965514a828e6902]
> [   57.202831]  nfs_do_writepage+0x116/0x1e0 [nfs 6c976fa593a7c2976f5a0ae=
b4965514a828e6902]
> [   57.202849]  nfs_writepages_callback+0x13/0x30 [nfs 6c976fa593a7c2976f=
5a0aeb4965514a828e6902]
> [   57.202866]  write_cache_pages+0x265/0x450
> [   57.202870]  ? __pfx_nfs_writepages_callback+0x10/0x10 [nfs 6c976fa593=
a7c2976f5a0aeb4965514a828e6902]
> [   57.202891]  nfs_writepages+0x141/0x230 [nfs 6c976fa593a7c2976f5a0aeb4=
965514a828e6902]
> [   57.202913]  do_writepages+0xd2/0x230
> [   57.202917]  ? filemap_fdatawrite_wbc+0x5c/0x80
> [   57.202921]  filemap_fdatawrite_wbc+0x67/0x80
> [   57.202924]  filemap_write_and_wait_range+0xd9/0x170
> [   57.202930]  nfs_wb_all+0x49/0x180 [nfs 6c976fa593a7c2976f5a0aeb496551=
4a828e6902]
> [   57.202947]  nfs4_file_flush+0x72/0xb0 [nfsv4 c716d88496ded0ea6d289bbe=
a684fa996f9b57a9]
> [   57.202969]  __se_sys_close+0x46/0xd0
> [   57.202972]  do_syscall_64+0x68/0x100
> [   57.202975]  ? do_syscall_64+0x77/0x100
> [   57.202976]  ? do_syscall_64+0x77/0x100
> [   57.202979]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   57.202982] RIP: 0033:0x7fe2b12e4a94
> [   57.202985] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 74 13 b8 03 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 ec 18 89 7c 24 0c e8 c3
> [   57.202987] RSP: 002b:00007ffe857ddb38 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000003
> [   57.202989] RAX: ffffffffffffffda RBX: 00007ffe857dfd68 RCX: 00007fe2b=
12e4a94
> [   57.202991] RDX: 0000000000002000 RSI: 00007ffe857ddc40 RDI: 000000000=
0000003
> [   57.202992] RBP: 00007ffe857dfc50 R08: 7fffffffffffffff R09: 000000006=
5650f49
> [   57.202993] R10: 00007fe2b11f8300 R11: 0000000000000202 R12: 000000000=
0000000
> [   57.202994] R13: 00007ffe857dfd80 R14: 00007fe2b1445000 R15: 000000000=
0000000
> [   57.202999]  </TASK>
>=20
> The problem seems to be that two out of three callers aren't taking the
> rcu_read_lock() before calling the list_for_each_entry_rcu() function in
> rpc_xprt_switch_has_addr(). I fix this by having
> rpc_xprt_switch_has_addr() unconditionaly take the rcu_read_lock(),
> which is okay to do recursively in the case that the lock has already
> been taken by a caller.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> v2: Don't provide a function bypass to skip taking the rcu_read_lock()
> ---
>  net/sunrpc/xprtmultipath.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> index 701250b305db..0706575d9392 100644
> --- a/net/sunrpc/xprtmultipath.c
> +++ b/net/sunrpc/xprtmultipath.c
> @@ -336,8 +336,9 @@ struct rpc_xprt *xprt_iter_current_entry_offline(stru=
ct rpc_xprt_iter *xpi)
>  			xprt_switch_find_current_entry_offline);
>  }
> =20
> -bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> -			      const struct sockaddr *sap)
> +static
> +bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> +				const struct sockaddr *sap)
>  {
>  	struct list_head *head;
>  	struct rpc_xprt *pos;
> @@ -356,6 +357,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch=
 *xps,
>  	return false;
>  }
> =20
> +bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
> +			      const struct sockaddr *sap)
> +{
> +	bool res;
> +
> +	rcu_read_lock();
> +	res =3D __rpc_xprt_switch_has_addr(xps, sap);
> +	rcu_read_unlock();
> +
> +	return res;
> +}
> +
>  static
>  struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
>  		const struct rpc_xprt *cur, bool check_active)

Reviewed-by: Jeff Layton <jlayton@kernel.org>

