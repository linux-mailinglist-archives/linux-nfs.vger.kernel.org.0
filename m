Return-Path: <linux-nfs+bounces-2490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250688DB8E
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82792980F4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E64F618;
	Wed, 27 Mar 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piPp1u1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422124F1F6
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536640; cv=none; b=IGLLlAhxD/mCI+kKGbQO8l9FYQp74ZgQ6/lZ3GBC2VSuuK+NpS1Lztc0IqLW9DGIXnBJRsjur3sJwH0sln9NPyCV/jOIKLyO5hbYOgwCLUEZbnQDxMHlgbQ3YpB/Ob9/0OBPaHMWnUMfEcK/Mlh/S2EMT/Iw5TRboOIi6u/F2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536640; c=relaxed/simple;
	bh=+wkrM0nSaPgpAZAq8OSHYfHpRkZQQBHXzbk/1O0XDSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oC0xfIICSmi5GdC14O0rPCpXzr9FzUG8Hy/Q+iM0vWIamQfStgVrqI8i/wqABy8IgtlQcZ7ON/6SzXOOLkQ5shEqYGGF88qDh5a6uPNcfJtXDYw64yHyt+65Et0M7NAuu0kT/nDY6Mz3WD9QBZvuHn+SkcnwLJrAXDejzd2a1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piPp1u1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F49FC433F1;
	Wed, 27 Mar 2024 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711536639;
	bh=+wkrM0nSaPgpAZAq8OSHYfHpRkZQQBHXzbk/1O0XDSg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=piPp1u1WlAyv+QGhPFusx1zQ3B3IsP/sp/K5y1ySVztsw0NRlemNOr5Th0mu20AUU
	 CSORGL5+6o8Xf5swqBCIq9HSEul750PCHErGMLfvqkQk4f9dRGRa/v1amChCqDFbdO
	 Wz1gDICYajxE+pZkbxFEsm3QhK2AbUE1hwmGEme5x8Z8KmHKNf0S+6pntc67pYT9Vl
	 sv062fFxNYXYizz/rA4suPBmznvRlNQAVemUWglOUerZC3tmDegCUwaRyDtRgZ+C6/
	 MqoNB18xeAKzIvmhfdvS3j0arIoZKhwf9fcNarCApeitYMWkzxm1CYPgUhJO+rBsmx
	 6twKaJaKjr8Gg==
Message-ID: <009e4477af2b6359c7e9bb549f0982a667c6ffa1.camel@kernel.org>
Subject: Re: [PATCH] NFSD: nfsctl: remove read permission of filehandle
From: Jeff Layton <jlayton@kernel.org>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-nfs@vger.kernel.org, neilb@suse.de, tom@talpey.com
Date: Wed, 27 Mar 2024 06:50:37 -0400
In-Reply-To: <20240327064000.1363-1-chenhx.fnst@fujitsu.com>
References: <21f3580de20445ddd9bdae6eecc316a58b6df97d.camel@kernel.org>
	 <20240327064000.1363-1-chenhx.fnst@fujitsu.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 14:40 +0800, Chen Hanxiao wrote:
> Hi, Jeff
>=20
> I wrote a POC patch, use name_to_handle_at to get nfs root filehandle
> instead of /proc/fs/nfsd/filehandle.
>=20
> I did some simple tests and it works.
>=20
> Pls check the POC patch below:
> ---
>  support/export/cache.c | 95 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 2 deletions(-)
>=20

Very cool!

I do think this is the basic direction we want to go with revising how
mountd gets its filehandles.=20


> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..adecac2e 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -43,6 +43,25 @@
>  #include "blkid/blkid.h"
>  #endif
> =20
> +#define NFS4_FHSIZE           128
> +
> +struct knfsd_fh {
> +	unsigned int	fh_size;	/*
> +					 * Points to the current size while
> +					 * building a new file handle.
> +					 */
> +	union {
> +		char			fh_raw[NFS4_FHSIZE];
> +		struct {
> +			uint8_t		fh_version;	/* =3D=3D 1 */
> +			uint8_t		fh_auth_type;	/* deprecated */
> +			uint8_t		fh_fsid_type;
> +			uint8_t		fh_fileid_type;
> +			uint32_t	fh_fsid[]; /* flexible-array member */
> +		};
> +	};
> +};
> +

This is a large departure from how this has worked in the past. Before
this, userland could always treat a knfsd_fh as opaque. With this change
though, knfsd_fh will need to be part of the kernel's ABI, and we'll
need to be very careful about future changes to the FH format (not that
we're planning any).

I think we probably ought to start by moving the definitions of knfsd_fh
and its component parts into a UAPI header that nfs-utils could then
use. For now, we can add duplicate definitions like above for when the
case where they aren't defined in UAPI headers.

>  enum nfsd_fsid {
>  	FSID_DEV =3D 0,
>  	FSID_NUM,

Side note: I wonder if some of the nfsd_fsid values can (effectively) be
deprecated these days? I don't think we really use FSID_DEV anymore at
all, do we?

> @@ -1827,8 +1846,8 @@ int cache_export(nfs_export *exp, char *path)
>   *   read filehandle <&0
>   * } <> /proc/fs/nfsd/filehandle
>   */
> -struct nfs_fh_len *
> -cache_get_filehandle(nfs_export *exp, int len, char *p)
> +static struct nfs_fh_len *
> +cache_get_filehandle_by_proc(nfs_export *exp, int len, char *p)
>  {
>  	static struct nfs_fh_len fh;
>  	char buf[RPC_CHAN_BUF_SIZE], *bp;
> @@ -1862,6 +1881,78 @@ cache_get_filehandle(nfs_export *exp, int len, cha=
r *p)
>  	return &fh;
>  }
> =20
> +static struct nfs_fh_len *
> +cache_get_filehandle_by_name(nfs_export *exp, char *name)
> +{
> +	static struct nfs_fh_len fh;
> +	struct {
> +		struct file_handle fh;
> +		unsigned char handle[128];
> +	} file_fh;
> +	char buf[RPC_CHAN_BUF_SIZE] =3D {0};
> +	char *mesg =3D buf;
> +	int len, mnt_id;
> +	unsigned int e_fsid;
> +	struct knfsd_fh kfh;
> +	char u[16];
> +
> +	memset(fh.fh_handle, 0, sizeof(fh.fh_handle));
> +=09
> +	file_fh.fh.handle_bytes =3D 128;
> +	if (name_to_handle_at(AT_FDCWD, name, &file_fh.fh, &mnt_id, 0) < 0)
> +		return NULL;
> +
> +	memset(fh.fh_handle, 0, sizeof(fh.fh_handle));
> +	memset(&kfh, 0, sizeof(struct knfsd_fh));
> +	kfh.fh_version =3D 1;
> +	kfh.fh_auth_type =3D 0;
> +	e_fsid =3D exp->m_export.e_fsid;
> +
> +	if (e_fsid > 0) {
> +		len =3D 12;
> +		fh.fh_size =3D 8;
> +		kfh.fh_size =3D 12;
> +		kfh.fh_fsid_type =3D 1;
> +		kfh.fh_fsid[0] =3D e_fsid;
> +	} else {
> +		len =3D file_fh.fh.handle_bytes + 8;
> +		fh.fh_size =3D file_fh.fh.handle_bytes;
> +		kfh.fh_size =3D file_fh.fh.handle_bytes + sizeof(kfh.fh_size);
> +		kfh.fh_fsid_type =3D FSID_UUID16_INUM;

Note that we will need to deal with NFSv2 here too. It has 32-byte
filehandles, and so we likely can't use FSID_UUID16_INUM for those.

> +		if (file_fh.fh.handle_bytes <=3D 12) {
> +			kfh.fh_fsid[0] =3D *(uint32_t *)file_fh.fh.f_handle;
> +			kfh.fh_fsid[1] =3D 0;
> +		} else {
> +			kfh.fh_fsid[0] =3D *(uint32_t *)file_fh.fh.f_handle;
> +			kfh.fh_fsid[1] =3D *((uint32_t *)file_fh.fh.f_handle + 1);
> +		}
> +	}
> +	kfh.fh_fileid_type =3D 0; // FILEID_ROOT
> +
> +	qword_addhex(&mesg, &len, kfh.fh_raw, kfh.fh_size);
> +	mesg =3D buf;
> +	len =3D qword_get(&mesg, (char *)fh.fh_handle, NFS3_FHSIZE);

We may need to pass to this function what version of NFS MNT request was
sent so that we know what sort of FH is needed here.

> +	if (e_fsid =3D=3D 0) {
> +		len =3D 16;
> +		uuid_by_path(name, 0, 16, u);
> +		memcpy((char *)fh.fh_handle+12, u, 16);
> +		fh.fh_size +=3D 16;
> +	}
> +=09
> +	return &fh;
> +}
> +
> +struct nfs_fh_len *
> +cache_get_filehandle(nfs_export *exp, int len, char *p)
> +{
> +	struct nfs_fh_len *fh;
> +	fh =3D cache_get_filehandle_by_name(exp, p);
> +	if (!fh)
> +		fh =3D cache_get_filehandle_by_proc(exp, len, p);
> +
> +	return fh;
> +}
> +
>  /* Wait for all worker child processes to exit and reap them */
>  void
>  cache_wait_for_workers(char *prog)

This looks like a great start -- nice work! There are a number of more
obscure corner-cases that we'll need to deal with, but this does look
like a promising direction.
--=20
Jeff Layton <jlayton@kernel.org>

