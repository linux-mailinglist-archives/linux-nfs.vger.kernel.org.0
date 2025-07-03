Return-Path: <linux-nfs+bounces-12885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21AAF8472
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 01:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839716F33F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67F2D3A68;
	Thu,  3 Jul 2025 23:44:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1612CDAE;
	Thu,  3 Jul 2025 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586265; cv=none; b=BFInycYK1TRGXzAoU162KI29XqXy6Q0QCdj2f7ErGNvZf3z/96tV+n2HuT1wjGbCOzBgAyxOd9oRdBEpqRcdAgb69oC3Qi0usIiy21KnRX+NVPrvtCQPFiQGhpo91xdRZcCfspX5x5S0lhStgFufyOEXT0N+XWjwDa5GeiIbnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586265; c=relaxed/simple;
	bh=C5n/3+Yc/0ULIWRm+2EP8wuC5UaJgRnVLl/seRFTxzA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QHjPuPtEiNmfBA/00gpeoinS4xT+2z802Lvkf4UmKaMt80wy4JAqPzPlxNy+li7MEmE/aDuglQZG12Tn61MAVNkDiF15IKyh4xTLqDQhBt6s475jMXqkNbw69Bbksa7cNiOtqX4A4xTtGFBBnF3EY1ODP4gPqzgtBsLJBCGAB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXTbA-0019F8-0Y;
	Thu, 03 Jul 2025 23:44:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
In-reply-to: <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>,
 <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
Date: Fri, 04 Jul 2025 09:44:10 +1000
Message-id: <175158625070.565058.13878074995107810351@noble.neil.brown.name>

On Fri, 04 Jul 2025, Jeff Layton wrote:
> Recent testing has shown that keeping pagecache pages around for too
> long can be detrimental to performance with nfsd. Clients only rarely
> revisit the same data, so the pages tend to just hang around.
>=20
> This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
> COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accessed
> range.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/debugfs.c  |  2 ++
>  fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++-----=
----
>  fs/nfsd/nfsd.h     |  1 +
>  fs/nfsd/nfsproc.c  |  4 ++--
>  fs/nfsd/vfs.c      | 21 ++++++++++++++-----
>  fs/nfsd/vfs.h      |  5 +++--
>  fs/nfsd/xdr3.h     |  3 +++
>  7 files changed, 77 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec84e06=
f577a8fc2b46b 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
> =20
>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
> +	debugfs_create_bool("enable-fadvise-dontneed", 0644,
> +			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);
>  }
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..11261cf67ea817ec566626f08b7=
33e09c9e121de 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -9,6 +9,7 @@
>  #include <linux/ext2_fs.h>
>  #include <linux/magic.h>
>  #include <linux/namei.h>
> +#include <linux/fadvise.h>
> =20
>  #include "cache.h"
>  #include "xdr3.h"
> @@ -206,11 +207,25 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
> =20
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status =3D nfsd_read(rqstp, &resp->fh, argp->offset,
> -				 &resp->count, &resp->eof);
> +				 &resp->count, &resp->eof, &resp->nf);
>  	resp->status =3D nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
> =20
> +static void
> +nfsd3_release_read(struct svc_rqst *rqstp)
> +{
> +	struct nfsd3_readargs *argp =3D rqstp->rq_argp;
> +	struct nfsd3_readres *resp =3D rqstp->rq_resp;
> +
> +	if (nfsd_enable_fadvise_dontneed && resp->status =3D=3D nfs_ok)
> +		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
> +				POSIX_FADV_DONTNEED);
> +	if (resp->nf)
> +		nfsd_file_put(resp->nf);
> +	fh_put(&resp->fh);

This looks wrong - testing resp->nf after assuming it was non-NULL.
I don't think it *is* wrong because ->state =3D=3D nfs_ok ensures
->nf is valid. But still....

How about:

    fh_put(resp->fh);
    if (!resp->nf)
         return;
    if (nfsd_enable_fadvise_dontneed)
	generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
		POSIX_FADV_DONTNEED);
    nfsd_file_put(resp->nf);

??
Note that we don't test ->status because that is identical to testing ->nf.
Ditto for other release functions.

Otherwise it makes sense for exploring how to optimise IO.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown

