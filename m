Return-Path: <linux-nfs+bounces-12404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D3AD80BF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 04:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F581E1C93
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC771A01B9;
	Fri, 13 Jun 2025 02:03:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D29610C
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780216; cv=none; b=g9IP84F+uv3CRnKplxmFNXb9rVzS0Y74iwRTVB5h0SEjlj+a1dPAcNl5Si35s3+KfQK4lqePAMuNEKhcnwimp36B3gfIa/xsYF694OtkTLOP2cfj5E9HLy7bBhpcbx+NM2tNf63Uwku+ni65tTNpysIQDMPUa1Fp+A77cOUUZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780216; c=relaxed/simple;
	bh=P8GnrATqpN12Ly5GXj5MudvkE7trzuwxunxhtZHaMGs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C4jtJkKDvelydw6co5aihfedXubM7+OXY4EMqP0gEAcFfw1PkB6I+wJ7++/EXrtNzej/drAEAXVZTRFP3RSEDkW2ih2sPoJmo3q8iu/pZZ0n99itbl1W43dbDGy/WuE7bwwu/l6znw5XdtTViNrnvDaxerQ/UWNq4+2SshYvrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPtlL-009j3I-7T;
	Fri, 13 Jun 2025 02:03:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [RFC PATCH] NFSD: Use vfs_iocb_iter_read()
In-reply-to: <20250613003653.532114-1-cel@kernel.org>
References: <20250613003653.532114-1-cel@kernel.org>
Date: Fri, 13 Jun 2025 12:03:22 +1000
Message-id: <174978020221.608730.15605514488447335701@noble.neil.brown.name>

On Fri, 13 Jun 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Refactor: Enable the use of RWF_ flags to control individual I/O
> operations.

RWF_ flags such as .... ???

I'm guessing RWF_DIRECT and maybe RWF_NOWAIT based on the earlier
conversation.  Might be useful to provide this as explicit motivation.=20

But seeing they will be passed to kiocb_set_rw_flags(), shouldn't we be
talking about the IOCB_ versions of the flags?  The only caller of
kiocb_set_rw_flags() I can find which doesn't pass zero is aio_prep_rw()
and it uses the IOCB_ versions.

And should we be changing the vfs_iter_write() to vfs_iocb_iter_write()
too, just for consistency?

>=20
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: NeilBrown <neil@brown.name>

3 more callers to go and vfs_iter_read() could be discarded.

NeilBrown


> ---
>  fs/nfsd/vfs.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd689df2ca5d..f20bacd9b224 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1086,10 +1086,18 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  {
>  	unsigned long v, total;
>  	struct iov_iter iter;
> -	loff_t ppos =3D offset;
> +	struct kiocb kiocb;
>  	ssize_t host_err;
>  	size_t len;
> =20
> +	init_sync_kiocb(&kiocb, file);
> +	host_err =3D kiocb_set_rw_flags(&kiocb, 0, READ);
> +	if (host_err) {
> +		*count =3D 0;
> +		goto out;
> +	}
> +	kiocb.ki_pos =3D offset;
> +
>  	v =3D 0;
>  	total =3D *count;
>  	while (total) {
> @@ -1104,7 +1112,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> =20
>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> -	host_err =3D vfs_iter_read(file, &iter, &ppos, 0);
> +	host_err =3D vfs_iocb_iter_read(file, &kiocb, &iter);
> +out:
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
> =20
> --=20
> 2.49.0
>=20
>=20


