Return-Path: <linux-nfs+bounces-12585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D5AE1A57
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 13:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5DF1BC0AE3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227027FD56;
	Fri, 20 Jun 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kPTvl70M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tKxIOt0V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cl9mrrk6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JFLqehut"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02091CAA6D
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420537; cv=none; b=gAKIbbekJvES7OA1XmKLgBNTDpDlDpHMmuwfbzo+jetq9byK66Z3Xr7SQOZCuDLviUz0x4yhmVby0PMZmynF5Bh5VT/aJkHTJ5fnz9tHrngfgtcnGC/blR9g73RJ8RDvfBZ1SkKcniiN/5Yge0MmzaIG8bscUlYq0WbYWWFf5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420537; c=relaxed/simple;
	bh=leUZfC3phG/G71xqxE7hs61HDNGRm6jBy7y2+hiUxzA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JU+b3W0ZKTV3WAsIoHtLjxR6horSbIx6EsOf3wpurLCX9rPmPgV4dssMjqozChpfZVvJHOHmrz+ezwOQftmh6+LmeF3zkF6DOMq0XDq1UjV51EjvbtIYuSkXG0eumF0Tkb6AR0oe+Vc1Z3ORzeQ1ReRKNmvjT5ZmbzQXIcYCpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kPTvl70M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tKxIOt0V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cl9mrrk6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JFLqehut; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65FFD1F38D;
	Fri, 20 Jun 2025 11:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750420526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2u7GadND6JlOOwvzYu1NWbjBdk1zkrqp9DT8Mri/5Y=;
	b=kPTvl70MGqaW6Yi3jiuH/4heyMKV67vgaYQZmE1YMoivhf7IXZ2HZTRjlHGXMrvGByHhEn
	C998DFe6N+kgSGHpH+ymJlcHonnGXJOoZKDFHCvqKCxjfLhGgCX+6lNyhC5XZMyNPUxAVH
	zS2u4aTAXDOYpsYJVg/SinrqUg2S5xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750420526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2u7GadND6JlOOwvzYu1NWbjBdk1zkrqp9DT8Mri/5Y=;
	b=tKxIOt0Vg2hCqS741ET7fQhnvw9PZ/XCyskWVtDltNkj0OnRQosjQzh7mXzH6Adpo4Tok7
	A1ahGkf5+WlASjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750420525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2u7GadND6JlOOwvzYu1NWbjBdk1zkrqp9DT8Mri/5Y=;
	b=Cl9mrrk68VbbkvsTLF4uxihOieWJfQ4eGVbT16tbdqQSKoNAp9m/rQrHpjQNv9FiEpuWfG
	/5LVKv+GkTCXcdRFoiFKaLvUSR05BOHsPPWrJMdUovD1619yRkFinGCIiMl4CPLI7ywHkY
	Df/H/ryaGZVsAnpU+2nP/wrqqwUzsYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750420525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2u7GadND6JlOOwvzYu1NWbjBdk1zkrqp9DT8Mri/5Y=;
	b=JFLqehutfZfY4J9hA3ujziMmXJO01FJcSrxAropdwdI7fY71xN11mVETenkZ8FnAFEOIoY
	EpHjjAFC/7JmLBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8EE813736;
	Fri, 20 Jun 2025 11:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eDI6JilMVWgUHwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Jun 2025 11:55:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: chenxiaosong@chenxiaosong.com
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, huhai@kylinos.cn,
 "ChenXiaoSong" <chenxiaosong@kylinos.cn>
Subject: Re: [RFC PATCH] nfsd: convert the nfsd_users to atomic_t
In-reply-to: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
References: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
Date: Fri, 20 Jun 2025 21:55:11 +1000
Message-id: <175042051171.608730.8613669948428192921@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo,chenxiaosong.com:email,chenxiaosong.com:url]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, 18 Jun 2025, chenxiaosong@chenxiaosong.com wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>=20
> Before commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_client=
"),
> we had a null-ptr-deref in nfsd4_probe_callback() (Link[1]):
>=20
>  nfsd: last server has exited, flushing export cache
>  NFSD: starting 90-second grace period (net f0000030)
>  Unable to handle kernel NULL pointer dereference at virtual address 000000=
0000000000

The only possible cause that I can find for this crash is that the nfsd
thread must have still been running when nfsd_shutdown_net() and then
nfsd_shutdown_generic() were called resulting in the workqueue being
destroyed.

The threads will all have been signalled with SIGKILL, but there was no
mechanism to wait for the threads to complete.

This was changed in

Commit: 3409e4f1e8f2 ("NFSD: Make it possible to use svc_set_num_threads_sync=
")

Sync then threads were stopped synchronously so they were certainly all
stopped before the workqueue was removed.

NeilBrown


>  ...
>  Call trace:
>   __queue_work+0xb4/0x558
>   queue_work_on+0x88/0x90
>   nfsd4_probe_callback+0x4c/0x58 [nfsd]
>  NFSD: starting 90-second grace period (net f0000030)
>   nfsd4_probe_callback_sync+0x20/0x38 [nfsd]
>   nfsd4_init_conn.isra.57+0x8c/0xa8 [nfsd]
>   nfsd4_create_session+0x5b8/0x718 [nfsd]
>   nfsd4_proc_compound+0x4c0/0x710 [nfsd]
>   nfsd_dispatch+0x104/0x248 [nfsd]
>   svc_process_common+0x348/0x808 [sunrpc]
>   svc_process+0xb0/0xc8 [sunrpc]
>   nfsd+0xf0/0x160 [nfsd]
>   kthread+0x134/0x138
>   ret_from_fork+0x10/0x18
>  Code: aa1c03e0 97ffffba aa0003e2 b5000780 (f9400262)
>  SMP: stopping secondary CPUs
>  Starting crashdump kernel...
>  Bye!
>=20
> One of the cases is:
>=20
>     task A (cpu 1)    |   task B (cpu 2)     |   task C (cpu 3)
>  ---------------------|----------------------|-----------------------------=
----
>  nfsd_startup_generic | nfsd_startup_generic |
>    nfsd_users =3D=3D 0    |  nfsd_users =3D=3D 0     |
>    nfsd_users++       |  nfsd_users++        |
>    nfsd_users =3D=3D 1    |                      |
>    ...                |                      |
>    callback_wq =3D=3D xxx |                      |
>  ---------------------|----------------------|-----------------------------=
----
>                       |                      | nfsd_shutdown_generic
>                       |                      |   nfsd_users =3D=3D 1
>                       |                      |   --nfsd_users
>                       |                      |   nfsd_users =3D=3D 0
>                       |                      |   ...
>                       |                      |   callback_wq =3D=3D xxx
>                       |                      |   destroy_workqueue(callback=
_wq)
>  ---------------------|----------------------|-----------------------------=
----
>                       |  nfsd_users =3D=3D 1     |
>                       |  ...                 |
>                       |  callback_wq =3D=3D yyy  |
>=20
> After commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_client"=
),
> this issue no longer occurs, but we should still convert the nfsd_users
> to atomic_t to prevent other similar issues.
>=20
> Link[1]: https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe_c=
allback.html
> Co-developed-by: huhai <huhai@kylinos.cn>
> Signed-off-by: huhai <huhai@kylinos.cn>
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/nfsd/nfssvc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 9b3d6cff0e1e..08b1f9ebdc2a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -270,13 +270,13 @@ static int nfsd_init_socks(struct net *net, const str=
uct cred *cred)
>  	return 0;
>  }
> =20
> -static int nfsd_users =3D 0;
> +static atomic_t nfsd_users =3D ATOMIC_INIT(0);
> =20
>  static int nfsd_startup_generic(void)
>  {
>  	int ret;
> =20
> -	if (nfsd_users++)
> +	if (atomic_fetch_inc(&nfsd_users))
>  		return 0;
> =20
>  	ret =3D nfsd_file_cache_init();
> @@ -291,13 +291,13 @@ static int nfsd_startup_generic(void)
>  out_file_cache:
>  	nfsd_file_cache_shutdown();
>  dec_users:
> -	nfsd_users--;
> +	atomic_dec(&nfsd_users);
>  	return ret;
>  }
> =20
>  static void nfsd_shutdown_generic(void)
>  {
> -	if (--nfsd_users)
> +	if (atomic_dec_return(&nfsd_users))
>  		return;
> =20
>  	nfs4_state_shutdown();
> --=20
> 2.34.1
>=20
>=20


