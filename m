Return-Path: <linux-nfs+bounces-12552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7901DADEAF0
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6993AB731
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CA2DE1EC;
	Wed, 18 Jun 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSh2KrQI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3FC2C3258;
	Wed, 18 Jun 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247437; cv=none; b=bNp+kIbbXUMky3z9dGmJU9CbGJfqeHP33vyIv5dQXiz8Ur0Z9RcYDTSJEUUac32l5gjDUwgmmIRqVEuuTAmdQAY6IngBFFpIAcZElAa1CUTxiWw2nadzd88jBqzzahPbNmNQIZiTdtCHpEfxBi3iB4TtYxVK+Qnatzk5vmXXb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247437; c=relaxed/simple;
	bh=08NkLB6cEniKmLmxnOXjf/XpsQuGpQY+0IAnMiMy0rw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lh1X7udAIdTUdykcJEs41RCnQMxG6n9o+XZPJh1iVgCJXJgqcZbU7M5Tuo0JDbft84Pj85EYuoTYeB+bVziqL9Rdye0HLmk3djFZ+cCp9J/dotElpCpc7kwaG7xc9GZZdWtiCccYt/orj1ZDj/CpxIZbxfP1UYGLk4NUrPeSh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSh2KrQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0180FC4CEE7;
	Wed, 18 Jun 2025 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247435;
	bh=08NkLB6cEniKmLmxnOXjf/XpsQuGpQY+0IAnMiMy0rw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OSh2KrQIhSH2gbB3rmIMHQrJ+FgOfJaHOSxTT3OwMksTFLH/rzlWT75MipZAV4rSb
	 1ORNj2OpTau5syxKjLQh2iH4SeDQaxBldPa5tyoOXMl9XLWLCRjaiT7qEKHJaqGhEF
	 y0/hRLucRMNsaWvr4qykNedtjqfod9ZrxcphgJHNSE1oSi0uTBw5/Z6IAw7PNcGKIB
	 kDvzAZa8QdUQHiqR8ka6jWyFFlUwdbOhFjATFog0hnrI23WSHuyOoJYweFC96ggU+z
	 s+DO33IVGODE+vWKkoBVaZ1ogKRJtkHmkCoXjEqyrHg4ViL1E8stQ8BaYOCZwW/7lg
	 +VMb31hrc9OAg==
Message-ID: <197b15028aa942d2812b1746aff453c4e791aa00.camel@kernel.org>
Subject: Re: [RFC PATCH] nfsd: convert the nfsd_users to atomic_t
From: Jeff Layton <jlayton@kernel.org>
To: chenxiaosong@chenxiaosong.com, chuck.lever@oracle.com, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 huhai@kylinos.cn,  ChenXiaoSong <chenxiaosong@kylinos.cn>
Date: Wed, 18 Jun 2025 07:50:33 -0400
In-Reply-To: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
References: <20250618104123.398603-1-chenxiaosong@chenxiaosong.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 18:41 +0800, chenxiaosong@chenxiaosong.com wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>=20
> Before commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_clie=
nt"),
> we had a null-ptr-deref in nfsd4_probe_callback() (Link[1]):
>=20
>  nfsd: last server has exited, flushing export cache
>  NFSD: starting 90-second grace period (net f0000030)
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000000
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
>  ---------------------|----------------------|---------------------------=
------
>  nfsd_startup_generic | nfsd_startup_generic |
>    nfsd_users =3D=3D 0    |  nfsd_users =3D=3D 0     |
>    nfsd_users++       |  nfsd_users++        |
>    nfsd_users =3D=3D 1    |                      |
>    ...                |                      |
>    callback_wq =3D=3D xxx |                      |
>  ---------------------|----------------------|---------------------------=
------
>                       |                      | nfsd_shutdown_generic
>                       |                      |   nfsd_users =3D=3D 1
>                       |                      |   --nfsd_users
>                       |                      |   nfsd_users =3D=3D 0
>                       |                      |   ...
>                       |                      |   callback_wq =3D=3D xxx
>                       |                      |   destroy_workqueue(callba=
ck_wq)
>  ---------------------|----------------------|---------------------------=
------
>                       |  nfsd_users =3D=3D 1     |
>                       |  ...                 |
>                       |  callback_wq =3D=3D yyy  |
>=20
> After commit 38f080f3cd19 ("NFSD: Move callback_wq into struct nfs4_clien=
t"),
> this issue no longer occurs, but we should still convert the nfsd_users
> to atomic_t to prevent other similar issues.
>=20
> Link[1]: https://chenxiaosong.com/en/nfs/en-null-ptr-deref-in-nfsd4_probe=
_callback.html
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
> @@ -270,13 +270,13 @@ static int nfsd_init_socks(struct net *net, const s=
truct cred *cred)
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

Isn't nfsd_users protected by the nfsd_mutex? It looks like it's held
in all of the places this counter is accessed.

--=20
Jeff Layton <jlayton@kernel.org>

