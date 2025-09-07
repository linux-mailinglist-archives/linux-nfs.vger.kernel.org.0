Return-Path: <linux-nfs+bounces-14115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D568B47B06
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C4A3BBC05
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Sep 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15176263889;
	Sun,  7 Sep 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anaaaChA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B8262FDD
	for <linux-nfs@vger.kernel.org>; Sun,  7 Sep 2025 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244927; cv=none; b=spL1YO8afNWlDrUGMu3jdr1i0+9hIZE/IbM6Z1NtZ8attE7338ZmLlQNN68Ul4VSgVnE4Zf+ULAGB6NpRLqMc19UOpfx5fb9TVkigeaZtGJTboXrom+9JCRNrnrneiQZIr0GOPZl+YkfTBaYlNVXYppD6jFvzH7C7C/vcg8RfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244927; c=relaxed/simple;
	bh=T4mzpkm4yKCUHkhpwdtI6imATw3W3Ke7gzib/RSZdxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBdDZh7XHCVJ/CRz48xnJ0dJuHeIqmrO7JebMZU/gPSE5HQ5WD1cKY9ptqINpZXrsGiAj9quiwEdgePAzXH0f1gLd67TPaarjHB42wWeTTNj//jC1Vlr4WiiHUkBN2JKCS7v+VkQnDtwkYn30Wycnuu9hXHTaQr3XJuxYdyc+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anaaaChA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5240C4CEF0;
	Sun,  7 Sep 2025 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757244926;
	bh=T4mzpkm4yKCUHkhpwdtI6imATw3W3Ke7gzib/RSZdxk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=anaaaChAKBNCUNoqZZpUQU+CZeUFvxfxsORnPCyrANa/oWap0dxqoBpTUZySV0VdA
	 4L6OjRzu5cuLdQoIke9GnPj6/hN9KQF+sddXIpWzbutcL/rpqBCiema6K4tactVJfe
	 VzdObYXmyQwslmcPFMuasPHl/4sT3gcygbIUfALg7Erv1Wi7K6WaSZKVpppOoXC6G2
	 9MyroB6V2lsJRcdnY0bA7chbWqask6mCS6PzHC6BvgKZ+OrjnbcUOdnx6k75OXDHBn
	 HMOzkmRG1IJ4dy7mOwJKK2zQRvuIqJRS0blStoG1eRNgKqjt6x2ikdNzsrukDLtz6F
	 T93R1t+iDg9CQ==
Message-ID: <5b56612a687cacc836ec91d4b4f9408a30fa30c4.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: Add io_cache_{read,write} controls to debugfs
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Sun, 07 Sep 2025 07:35:24 -0400
In-Reply-To: <20250906212511.9139-1-cel@kernel.org>
References: <20250906212511.9139-1-cel@kernel.org>
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

On Sat, 2025-09-06 at 17:25 -0400, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> Add 'io_cache_read' to NFSD's debugfs interface so that any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=3D0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=3D1).
>=20
> io_cache_read may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
>=20
> Add 'io_cache_write' to NFSD's debugfs interface so that any data
> written by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=3D0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=3D1).
>=20
> io_cache_write may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_write
>=20
> The default value for both settings is NFSD_IO_BUFFERED, which is
> NFSD's existing behavior for both read and write. Changes to these
> settings take immediate effect for all exports and NFS versions.
>=20
> Currently only xfs and ext4 implement RWF_DONTCACHE. For file
> systems that do not implement RWF_DONTCACHE, NFSD use only buffered
> I/O when the io_cache setting is NFSD_IO_DONTCACHE.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h    |  9 +++++
>  fs/nfsd/vfs.c     | 21 +++++++++++
>  3 files changed, 123 insertions(+)
>=20
> Changes since v1:
> - Corrected patch author
> - Break back to NFSD_IO_BUFFERED when exported file system does not
>   support RWF_DONTCACHE
> - Smoke tested NFSD_IO_DONTCACHE with NFSv3,v4.0,v4.1 on xfs and
>   tmpfs
>=20
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc..2b1bb716b608 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -27,11 +27,98 @@ static int nfsd_dsr_get(void *data, u64 *val)
>  static int nfsd_dsr_set(void *data, u64 val)
>  {
>  	nfsd_disable_splice_read =3D (val > 0) ? true : false;
> +	if (!nfsd_disable_splice_read) {
> +		/*
> +		 * Must use buffered I/O if splice_read is enabled.
> +		 */
> +		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> +	}
>  	return 0;
>  }
> =20
>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%ll=
u\n");
> =20
> +/*
> + * /sys/kernel/debug/nfsd/io_cache_read
> + *
> + * Contents:
> + *   %0: NFS READ will use buffered IO
> + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *
> + * This setting takes immediate effect for all NFS versions,
> + * all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_io_cache_read_get(void *data, u64 *val)
> +{
> +	*val =3D nfsd_io_cache_read;
> +	return 0;
> +}
> +
> +static int nfsd_io_cache_read_set(void *data, u64 val)
> +{
> +	int ret =3D 0;
> +
> +	switch (val) {
> +	case NFSD_IO_BUFFERED:
> +		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +		/*
> +		 * Must disable splice_read when enabling
> +		 * NFSD_IO_DONTCACHE.
> +		 */
> +		nfsd_disable_splice_read =3D true;
> +		nfsd_io_cache_read =3D val;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get=
,
> +			 nfsd_io_cache_read_set, "%llu\n");
> +
> +/*
> + * /sys/kernel/debug/nfsd/io_cache_write
> + *
> + * Contents:
> + *   %0: NFS WRITE will use buffered IO
> + *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> + *
> + * This setting takes immediate effect for all NFS versions,
> + * all exports, and in all NFSD net namespaces.
> + */
> +
> +static int nfsd_io_cache_write_get(void *data, u64 *val)
> +{
> +	*val =3D nfsd_io_cache_write;
> +	return 0;
> +}
> +
> +static int nfsd_io_cache_write_set(void *data, u64 val)
> +{
> +	int ret =3D 0;
> +
> +	switch (val) {
> +	case NFSD_IO_BUFFERED:
> +	case NFSD_IO_DONTCACHE:
> +		nfsd_io_cache_write =3D val;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_write_fops, nfsd_io_cache_write_g=
et,
> +			 nfsd_io_cache_write_set, "%llu\n");
> +
>  void nfsd_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(nfsd_top_dir);
> @@ -44,4 +131,10 @@ void nfsd_debugfs_init(void)
> =20
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +
> +	debugfs_create_file("io_cache_read", 0644, nfsd_top_dir, NULL,
> +			    &nfsd_io_cache_read_fops);
> +
> +	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
> +			    &nfsd_io_cache_write_fops);
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1cd0bed57bc2..809729d41e08 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
> =20
>  extern bool nfsd_disable_splice_read __read_mostly;
> =20
> +enum {
> +	/* Any new NFSD_IO enum value must be added at the end */
> +	NFSD_IO_BUFFERED,
> +	NFSD_IO_DONTCACHE,
> +};
> +
> +extern u64 nfsd_io_cache_read __read_mostly;
> +extern u64 nfsd_io_cache_write __read_mostly;
> +
>  extern int nfsd_max_blksize;
> =20
>  static inline int nfsd_v4client(struct svc_rqst *rq)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3cd3b9e069f4..714777c221ed 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -49,6 +49,8 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
> =20
>  bool nfsd_disable_splice_read __read_mostly;
> +u64 nfsd_io_cache_read __read_mostly =3D NFSD_IO_BUFFERED;
> +u64 nfsd_io_cache_write __read_mostly =3D NFSD_IO_BUFFERED;
> =20
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1099,6 +1101,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  	size_t len;
> =20
>  	init_sync_kiocb(&kiocb, file);
> +
> +	switch (nfsd_io_cache_read) {
> +	case NFSD_IO_BUFFERED:
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +		if (file->f_op->fop_flags & FOP_DONTCACHE)
> +			kiocb.ki_flags =3D IOCB_DONTCACHE;
> +		break;
> +	}
> +
>  	kiocb.ki_pos =3D offset;
> =20
>  	v =3D 0;
> @@ -1224,6 +1236,15 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> +
> +	switch (nfsd_io_cache_write) {
> +	case NFSD_IO_BUFFERED:
> +		break;
> +	case NFSD_IO_DONTCACHE:
> +		if (file->f_op->fop_flags & FOP_DONTCACHE)
> +			kiocb.ki_flags |=3D IOCB_DONTCACHE;
> +		break;
> +	}
>  	host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
>  	if (host_err < 0) {
>  		commit_reset_write_verifier(nn, rqstp, host_err);

Could we get this into v6.18?

Reviewed-by: Jeff Layton <jlayton@kernel.org>

