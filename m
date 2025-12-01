Return-Path: <linux-nfs+bounces-16825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F0C9882B
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D63924E14E5
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D0311C09;
	Mon,  1 Dec 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqS+MW7K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57B30E0D4;
	Mon,  1 Dec 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609993; cv=none; b=uMhZnkCyIZaozTb+WB/LT/2F9YsPaxfXCiCv6i5S1c+iQtYJyzmzrtxh1F5dZUHHa9Pog98/DXpfmV93HhZoeNPfkpocq6sfgMIKWysN4efwkrGTPzz7M+v6c0Z87dLJS2iUauxiwyApJN+I5K8VWq56miPL5x5l42JaV58Ae1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609993; c=relaxed/simple;
	bh=7AasdRgLRi4qaixMvXfG1exskygBRvqyj7df5offskU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZl00C39Led4YoAaie0fh0ToaMs/Q/nGsKn8j1OWGQdTbAgcipmlo3/mh/i/IQjiNOgDZrKRBYNMGScaqH6k1hzD4iYSzHjbsxx6terfiZxMqa+TCzl79qr+ZKJWg2FMNdP41cPV3GXfBp51rWa5HAn49Fe3SusoUIwWM8ITIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqS+MW7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB018C4CEF1;
	Mon,  1 Dec 2025 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764609993;
	bh=7AasdRgLRi4qaixMvXfG1exskygBRvqyj7df5offskU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cqS+MW7KeoIxUV1QC4D+Y4jzx2Duaf+HEX77FyZiWgaH5FE5C3DTEjC6KIzcbUNC/
	 MmwXOV4LpLr0uTQ7LHZkKxV7oIkIld11IByIbLPhgfFrX3yFwSA+h9oPieTQdQ7E/8
	 yyrNrLaYhSkm41c/Xe8Zmeroo7TouHda7eAy4PW37OYtwAwmga9CDbT6C/pwrOEKCM
	 yPbY9xte5DjfHGBG1y+WpHSEMzZ1GSzs+HzRuCiaCy++XCZV6YiuKU2pobTWnZuavB
	 86vBwJxyxzkcLtDjgRU2NZeOwlAtEZ+iGUxAlu1efbyNwiOAr/e/PGESnyKqe4km6M
	 j8yMZ/Ly2e7bw==
Message-ID: <a09d7b34f02b67be947b82eb1f677fa5e09280d8.camel@kernel.org>
Subject: Re: [PATCH] When following NFS referrals, the client always
 attempts RDMA first (if compiled in), even when the parent mount uses TCP.
 This causes unnecessary timeouts when the referral server doesn't support
 RDMA.
From: Trond Myklebust <trondmy@kernel.org>
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>, anna@kernel.org, 
	tom@talpey.com, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 01 Dec 2025 12:26:12 -0500
In-Reply-To: <20251201090732.4608-1-gaurav.gangalwar@gmail.com>
References: <20251201090732.4608-1-gaurav.gangalwar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 04:07 -0500, Gaurav Gangalwar wrote:
> Modify nfs4_create_referral_server() to check the parent client's
> transport protocol. Only attempt RDMA if the parent is using RDMA,
> otherwise use the parent's protocol (TCP/TCP-TLS) directly.
>=20
> Add module parameter 'nfs4_inherit_referral_transport' (default: Y)
> to control this behavior, allowing administrators to restore the
> previous "always try RDMA" behavior if needed.
>=20
> This eliminates connection delays for TCP-based referrals in
> environments where RDMA is compiled in but not deployed.

Do we really need the module parameter? If you go back to Chuck's
commit 530ea4219231 ("nfs: Referrals should use the same proto setting
as their parent") then his intention was to make the RDMA behaviour
inheritable, and that has always been my preference too.

It is all the more important now that we also have TLS protection,
which would break when we default to RDMA.

>=20
> Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
> ---
> =C2=A0fs/nfs/nfs4_fs.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfs/nfs4client.c | 18 +++++++++++++-----
> =C2=A0fs/nfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> =C2=A03 files changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index c34c89af9c7d..d8516fb8a711 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -548,6 +548,7 @@ extern unsigned short max_session_cb_slots;
> =C2=A0extern unsigned short send_implementation_id;
> =C2=A0extern bool recover_lost_locks;
> =C2=A0extern short nfs_delay_retrans;
> +extern bool nfs4_inherit_referral_transport;
> =C2=A0
> =C2=A0#define NFS4_CLIENT_ID_UNIQ_LEN		(64)
> =C2=A0extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 3a4baed993c9..7fb39bf662af 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1258,12 +1258,20 @@ struct nfs_server
> *nfs4_create_referral_server(struct fs_context *fc)
> =C2=A0	nfs_server_copy_userdata(server, parent_server);
> =C2=A0
> =C2=A0	/* Get a client representation */
> +	/*
> +	 * If nfs4_inherit_referral_transport is enabled (default),
> only try
> +	 * RDMA if the parent client is using RDMA. This avoids
> connection
> +	 * delays when parent uses TCP and referral server doesn't
> support RDMA.
> +	 */
> =C2=A0#if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
> -	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
> -	cl_init.proto =3D XPRT_TRANSPORT_RDMA;
> -	error =3D nfs4_set_client(server, &cl_init);
> -	if (!error)
> -		goto init_server;
> +	if (!nfs4_inherit_referral_transport ||
> +	=C2=A0=C2=A0=C2=A0 parent_client->cl_proto =3D=3D XPRT_TRANSPORT_RDMA) =
{
> +		rpc_set_port(&ctx->nfs_server.address,
> NFS_RDMA_PORT);
> +		cl_init.proto =3D XPRT_TRANSPORT_RDMA;
> +		error =3D nfs4_set_client(server, &cl_init);
> +		if (!error)
> +			goto init_server;
> +	}
> =C2=A0#endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
> =C2=A0
> =C2=A0	cl_init.proto =3D XPRT_TRANSPORT_TCP;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 72dee6f3050e..cb9618a0df0f 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1426,6 +1426,8 @@ unsigned short max_session_cb_slots =3D
> NFS4_DEF_CB_SLOT_TABLE_SIZE;
> =C2=A0unsigned short send_implementation_id =3D 1;
> =C2=A0char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN] =3D "";
> =C2=A0bool recover_lost_locks =3D false;
> +/* Inherit parent transport for referral mounts */
> +bool nfs4_inherit_referral_transport =3D true;
> =C2=A0short nfs_delay_retrans =3D -1;
> =C2=A0
> =C2=A0EXPORT_SYMBOL_GPL(nfs_callback_nr_threads);
> @@ -1437,6 +1439,7 @@ EXPORT_SYMBOL_GPL(max_session_cb_slots);
> =C2=A0EXPORT_SYMBOL_GPL(send_implementation_id);
> =C2=A0EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier);
> =C2=A0EXPORT_SYMBOL_GPL(recover_lost_locks);
> +EXPORT_SYMBOL_GPL(nfs4_inherit_referral_transport);
> =C2=A0EXPORT_SYMBOL_GPL(nfs_delay_retrans);
> =C2=A0
> =C2=A0#define NFS_CALLBACK_MAXPORTNR (65535U)
> @@ -1486,6 +1489,11 @@ MODULE_PARM_DESC(recover_lost_locks,
> =C2=A0		 "If the server reports that a lock might be lost, "
> =C2=A0		 "try to recover it risking data corruption.");
> =C2=A0
> +module_param(nfs4_inherit_referral_transport, bool, 0644);
> +MODULE_PARM_DESC(nfs4_inherit_referral_transport,
> +		 "Referral mounts inherit parent's transport
> protocol. "
> +		 "If disabled, always try RDMA first (default=3DY)");
> +
> =C2=A0module_param_named(delay_retrans, nfs_delay_retrans, short, 0644);
> =C2=A0MODULE_PARM_DESC(delay_retrans,
> =C2=A0		 "Unless negative, specifies the number of times the
> NFSv4 "

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

