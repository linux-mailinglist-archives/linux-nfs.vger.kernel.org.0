Return-Path: <linux-nfs+bounces-17452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B4CF508E
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714DB30C04AD
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BC21CC58;
	Mon,  5 Jan 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAsn9UUw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE22E65D
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634509; cv=none; b=jCK7WPWg1btDKy3zGWTPYNF7WSt1t1zkLVL7f+5WGs5FmIKqYL6Vx8fZmDdj3HhCmyB4a+6kA+OpvrgWA90np2v5NuScOj71yjjWeK+7sL8pwOXEXpmuh7TFZD6jYYSTluGfElM5JrF2GyLP/trENDkJAr7srbY6MAejcvRtoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634509; c=relaxed/simple;
	bh=z5Sf4zUAaYa9o/g6+BPZv9YweGpnqKTCL9o1PLBWOsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4k+yT3pqMKXixcZJLTuWzfE+t3GjcVW7VNMNn7FDJGGM9lTXCMxdS2XbiBLI9zVhOrbGUXNGpmi6PpLksL/SNl3BixlDbENedb/ZeuW3VoUWj3vYZKh9/nYL6Vr4tZ1SpQVQZDxePaPsda6e3Am4LgPJkXoB8EvoMM0aPsWYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAsn9UUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE06C116D0;
	Mon,  5 Jan 2026 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634508;
	bh=z5Sf4zUAaYa9o/g6+BPZv9YweGpnqKTCL9o1PLBWOsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cAsn9UUwtX/aMoxK2SCLDF0v9LjbVzSq/Gul9v4Ud8uIeLEPXzAtVWLmlAYMkQR2t
	 7uVEXniAupNmc0r75vjRU5uaaQQng2L0SN+1s00oauZqTSaPeY2Tvk5QL/f4gp+4NG
	 /njEP1aD8qjlyNeo8+2dapAawze+LszwZ9v1X0CRsc5YT0+QkqrE1zP9+dw6PY8tS/
	 wrx5K2WpDr3VagQYyiHUa9Bot+ETSirGs8Ci2nkVLDgMQwBhih9+6oyK/fqRG8JvR6
	 rCoDou1e014oAgRQmwN3wlLdl7aoCWqa51R6rGIKfx9Cvs7+QKfeTIMhrw8mO4wiVa
	 kylvh4UjxHozg==
Message-ID: <09331fd9a94cb5bb8ffa7ae4bcfc3f8f5af06def.camel@kernel.org>
Subject: Re: [PATCH 1/4] NFS/localio: Stop further I/O upon hitting an error
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 05 Jan 2026 12:35:07 -0500
In-Reply-To: <aVvyl52wfhyeNGvp@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
	 <d0d1748668398cd6adfb079fed60409b29167ff2.1767459435.git.trond.myklebust@hammerspace.com>
	 <aVvyl52wfhyeNGvp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 12:19 -0500, Mike Snitzer wrote:
> On Sat, Jan 03, 2026 at 12:14:57PM -0500, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > If the call into the filesystem results in an I/O error, then the
> > next
> > chunk of data won't be contiguous with the end of the last
> > successful
> > chunk. So break out of the I/O loop and report the results.
> > Currently the localio code will do this for a short read/write, but
> > not
> > for an error.
> >=20
> > Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-
> > of-order")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Thanks, definitely cleaner to not have the awkward force_done flag,
> sorry for that nastiness.
>=20
> But this one needs to be rebased on tip of linus' master due to
> commit
> 3af870aedbff ("nfs/localio: fix regression due to out-of-order
> __put_cred") which landed after the 6.19 merge.
>=20
> Like so:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Sat, 3 Jan 2026 12:14:57 -0500
> Subject: [PATCH] NFS/localio: Stop further I/O upon hitting an error
>=20
> If the call into the filesystem results in an I/O error, then the
> next
> chunk of data won't be contiguous with the end of the last successful
> chunk. So break out of the I/O loop and report the results.
> Currently the localio code will do this for a short read/write, but
> not
> for an error.
>=20
> Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-
> of-order")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/localio.c | 30 ++++++++++++++----------------
> =C2=A01 file changed, 14 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index ed2a7efaf8f20..97e4733d04714 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -619,7 +619,6 @@ static void nfs_local_call_read(struct
> work_struct *work)
> =C2=A0		container_of(work, struct nfs_local_kiocb, work);
> =C2=A0	struct file *filp =3D iocb->kiocb.ki_filp;
> =C2=A0	const struct cred *save_cred;
> -	bool force_done =3D false;
> =C2=A0	ssize_t status;
> =C2=A0	int n_iters;
> =C2=A0
> @@ -639,13 +638,13 @@ static void nfs_local_call_read(struct
> work_struct *work)
> =C2=A0		status =3D filp->f_op->read_iter(&iocb->kiocb, &iocb-
> >iters[i]);
> =C2=A0		revert_creds(save_cred);
> =C2=A0
> -		if (status !=3D -EIOCBQUEUED) {
> -			if (unlikely(status >=3D 0 && status < iocb-
> >iters[i].count))
> -				force_done =3D true; /* Partial read
> */
> -			if (nfs_local_pgio_done(iocb, status,
> force_done)) {
> -				nfs_local_read_iocb_done(iocb);
> -				break;
> -			}
> +		if (status =3D=3D -EIOCBQUEUED)
> +			continue;
> +		/* Break on completion, errors, or short reads */
> +		if (nfs_local_pgio_done(iocb, status, false) ||
> status < 0 ||
> +		=C2=A0=C2=A0=C2=A0 (size_t)status < iov_iter_count(&iocb-
> >iters[i])) {
> +			nfs_local_read_iocb_done(iocb);
> +			break;
> =C2=A0		}
> =C2=A0	}
> =C2=A0}
> @@ -824,7 +823,6 @@ static void nfs_local_call_write(struct
> work_struct *work)
> =C2=A0	struct file *filp =3D iocb->kiocb.ki_filp;
> =C2=A0	unsigned long old_flags =3D current->flags;
> =C2=A0	const struct cred *save_cred;
> -	bool force_done =3D false;
> =C2=A0	ssize_t status;
> =C2=A0	int n_iters;
> =C2=A0
> @@ -847,13 +845,13 @@ static void nfs_local_call_write(struct
> work_struct *work)
> =C2=A0		status =3D filp->f_op->write_iter(&iocb->kiocb, &iocb-
> >iters[i]);
> =C2=A0		revert_creds(save_cred);
> =C2=A0
> -		if (status !=3D -EIOCBQUEUED) {
> -			if (unlikely(status >=3D 0 && status < iocb-
> >iters[i].count))
> -				force_done =3D true; /* Partial write
> */
> -			if (nfs_local_pgio_done(iocb, status,
> force_done)) {
> -				nfs_local_write_iocb_done(iocb);
> -				break;
> -			}
> +		if (status =3D=3D -EIOCBQUEUED)
> +			continue;
> +		/* Break on completion, errors, or short writes */
> +		if (nfs_local_pgio_done(iocb, status, false) ||
> status < 0 ||
> +		=C2=A0=C2=A0=C2=A0 (size_t)status < iov_iter_count(&iocb-
> >iters[i])) {
> +			nfs_local_write_iocb_done(iocb);
> +			break;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	file_end_write(filp);

Yep. I rebased my testing branch yesterday, and caught that.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

