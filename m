Return-Path: <linux-nfs+bounces-4364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553A91A490
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85601C2174C
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FB145323;
	Thu, 27 Jun 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2xLMKCt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CF13E40D
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486413; cv=none; b=OrXE05dK3pz1wNpYB0z3OzhFpKdur6P4nRsu6gCOt5Fb77NvGW9924szLwBzHVF1bi58oK4GJJyIZbAAIr7q108uT7YjKfEwQjKsq4oCLemKN8DqCPtftiVh9riQpGClXPfWrd2pIq97iCcvAZ6O+p2R2Lpxrj2xypEYgSI+AZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486413; c=relaxed/simple;
	bh=TydBLU5dS2JkTyclPSWuOb2Y7lUis7gNMDnvdNLzaw8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USLdskY3VpTQ+aGTiG0HC0+g1H+hWZSkCwK3udyqpqwJXgu2hp8SABaY7o8hhkOZqmfQKF4MI52IuBtRdguYf1yT2BX7qlb/9fG1SbhH3cuIQvF9t1hhakQY3D9EaFsL6ag4AHM7bH++lN11RwUbPolK5a+qWjtM88MwOm9x748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2xLMKCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B49C4AF0B;
	Thu, 27 Jun 2024 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719486412;
	bh=TydBLU5dS2JkTyclPSWuOb2Y7lUis7gNMDnvdNLzaw8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=t2xLMKCtfj8ACNDBEbzJbQJQdcPBo4miPQrCRjT6mXhiP/uni/W9e8ggvhHElpWjq
	 Km4qbwwy9tk8IrwzlrR9k40nZj+diy2j3I4QfYgeBu+i7XXe0L4Ce3WjNT3UxdKFtp
	 EPoZFbct/r7DR9C5wFJZDQ7ANB9whobbntalQ0LeC67DznSWsq+wMm7rW/7CuPRKUR
	 mTK5nui3BFmzbLwgcpEWcDWA3zpqZ2RsLMVy2d36qA7X/x4Dt5R+sX3A2QFm8XFPHQ
	 WRXPSfcHwF6bz73E4Qzx7Ufm7tb5FoAERVE9bJ+pARinmtkzH3sIC6EJmt+gGYjNwv
	 UCv+nTE/5pGNA==
Message-ID: <281d9de2146e7d510ec4316fd002248f9a6f148d.camel@kernel.org>
Subject: Re: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost
 writes' prevention
From: Jeff Layton <jlayton@kernel.org>
To: Dan Aloni <dan.aloni@vastdata.com>, linux-nfs@vger.kernel.org
Date: Thu, 27 Jun 2024 07:06:51 -0400
In-Reply-To: <20240627100129.2482408-1-dan.aloni@vastdata.com>
References: <20240627100129.2482408-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 13:01 +0300, Dan Aloni wrote:
> There are some applications that write to predefined non-overlapping
> file offsets from multiple clients and therefore don't need to rely
> on
> file locking. However, if these applications want non-aligned offsets
> and sizes they need to either use locks or risk data corruption, as
> the
> NFS client defaults to extending writes to whole pages.
>=20
> This commit adds a new mount option `noalignwrite`, which allows to
> turn
> that off and avoid the need of locking, as long as these applications
> don't overlap on offsets.
>=20
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
> =C2=A0fs/nfs/fs_context.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 +++++++=
+
> =C2=A0fs/nfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0include/linux/nfs_fs_sb.h | 1 +
> =C2=A04 files changed, 15 insertions(+)
>=20
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 6c9f3f6645dd..7e000d782e28 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -49,6 +49,7 @@ enum nfs_param {
> =C2=A0	Opt_bsize,
> =C2=A0	Opt_clientaddr,
> =C2=A0	Opt_cto,
> +	Opt_alignwrite,
> =C2=A0	Opt_fg,
> =C2=A0	Opt_fscache,
> =C2=A0	Opt_fscache_flag,
> @@ -149,6 +150,7 @@ static const struct fs_parameter_spec
> nfs_fs_parameters[] =3D {
> =C2=A0	fsparam_u32=C2=A0=C2=A0 ("bsize",		Opt_bsize),
> =C2=A0	fsparam_string("clientaddr",	Opt_clientaddr),
> =C2=A0	fsparam_flag_no("cto",		Opt_cto),
> +	fsparam_flag_no("alignwrite",	Opt_alignwrite),
> =C2=A0	fsparam_flag=C2=A0 ("fg",		Opt_fg),
> =C2=A0	fsparam_flag_no("fsc",		Opt_fscache_flag),
> =C2=A0	fsparam_string("fsc",		Opt_fscache),
> @@ -592,6 +594,12 @@ static int nfs_fs_context_parse_param(struct
> fs_context *fc,
> =C2=A0		else
> =C2=A0			ctx->flags |=3D NFS_MOUNT_TRUNK_DISCOVERY;
> =C2=A0		break;
> +	case Opt_alignwrite:
> +		if (result.negated)
> +			ctx->flags |=3D NFS_MOUNT_NO_ALIGNWRITE;
> +		else
> +			ctx->flags &=3D ~NFS_MOUNT_NO_ALIGNWRITE;
> +		break;
> =C2=A0	case Opt_ac:
> =C2=A0		if (result.negated)
> =C2=A0			ctx->flags |=3D NFS_MOUNT_NOAC;
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index cbbd4866b0b7..1382ae19bba4 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -549,6 +549,9 @@ static void nfs_show_mount_options(struct
> seq_file *m, struct nfs_server *nfss,
> =C2=A0	else
> =C2=A0		seq_puts(m, ",local_lock=3Dposix");
> =C2=A0
> +	if (nfss->flags & NFS_MOUNT_NO_ALIGNWRITE)
> +		seq_puts(m, ",noalignwrite");
> +
> =C2=A0	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
> =C2=A0		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
> =C2=A0			seq_puts(m, ",write=3Dwait");
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 2329cbb0e446..cfe8061bf005 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file
> *file, struct folio *folio,
> =C2=A0	struct file_lock_context *flctx =3D
> locks_inode_context(inode);
> =C2=A0	struct file_lock *fl;
> =C2=A0	int ret;
> +	unsigned int mntflags =3D NFS_SERVER(inode)->flags;
> =C2=A0
> +	if (mntflags & NFS_MOUNT_NO_ALIGNWRITE)
> +		return 0;
> =C2=A0	if (file->f_flags & O_DSYNC)
> =C2=A0		return 0;
> =C2=A0	if (!nfs_folio_write_uptodate(folio, pagelen))
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..4d28b4a328a7 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -157,6 +157,7 @@ struct nfs_server {
> =C2=A0#define NFS_MOUNT_WRITE_WAIT		0x02000000
> =C2=A0#define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
> =C2=A0#define NFS_MOUNT_SHUTDOWN			0x08000000
> +#define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
> =C2=A0
> =C2=A0	unsigned int		fattr_valid;	/* Valid attributes
> */
> =C2=A0	unsigned int		caps;		/* server
> capabilities */

While I hate that we need a new mount option for this, I do understand
the need. I do wonder if we'd be better served by a new fadvise64()
flag or something. Either way, this would probably be needed in the
interim, so...

Reviewed-by: Jeff Layton <jlayton@kernel.org>

