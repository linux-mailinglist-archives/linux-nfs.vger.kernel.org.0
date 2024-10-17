Return-Path: <linux-nfs+bounces-7250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D010F9A2D86
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EECFB275F3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BC21C160;
	Thu, 17 Oct 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueBNHB/k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C321BAFA
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192398; cv=none; b=mMPWY2SUpOPDrB0BWnSE8veiW+86qbwFur6JKlE1JaWRF+DnVCxwr7TmcXVz0Dzwp9u6afIMzwMPxBxKbQ9delCLr1a/22j7Ew35nrPaqaQhltmKfo9J9ZqIYe4fJR7Gcl2Mqq0U3lIZS+VJF6IqnLpVgjPKDEhVkLtT3ruAZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192398; c=relaxed/simple;
	bh=P2YCdO1U42QSmdXbZCVLCfVxB4HY20/pnrdUziHL2mE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQJlTc6Tza1/JPJGHfG/R3npPCApO3SHm2BGQ9CXuFClmRK2YBtbkixOI8YvwMWC36GZRjnc7EJpjNJWqnfQu95lJm6ysRmTDLNdKAze48W4InnnR+6Tfxn1nmbLGqXqnAkAkAMakcrVHjpsixBRwQFL6NxZJhFTiRrRUdBL0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueBNHB/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7562EC4CEC3;
	Thu, 17 Oct 2024 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729192398;
	bh=P2YCdO1U42QSmdXbZCVLCfVxB4HY20/pnrdUziHL2mE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ueBNHB/k//1VWKliOzaqVhs3fpCrpNGq7N9Dc55BRYy11sMCN6eAk005bSRKOa2Ye
	 FGr6mSHlTXxQEkj20DHg6/FQBOFHRRNagHK+WSkuUm0B38y70WBUYQzqoEckDz2zyQ
	 SeX6me6RIQ+DheG0Bz4M+d5y7yJEhSKF1jGCHT6Z1nmscGXfd/ph1guidwa0ZKfmSM
	 IDapX2xMy7sOUzhh1Uofj4X7GiFS4WmNC6gyZ1U2NUsYs3+Dw3VgkOvEoHHO3A6qTn
	 9kto6CdPUqz2W2Ul+lJUd3BtMZDC9JQUifPoXD+k5VAENdCfm1YAGR0BAppAVthDsS
	 etiElxunlBdQg==
Message-ID: <830d2ed641c0a789c0c3d51633f138c0f9f0e81b.camel@kernel.org>
Subject: Re: [PATCH 5/5] lockd: Remove unneeded initialization of
 file_lock::c.flc_flags
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 17 Oct 2024 15:13:16 -0400
In-Reply-To: <20241017133631.213274-6-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>
	 <20241017133631.213274-6-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 09:36 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Since commit 75c7940d2a86 ("lockd: set missing fl_flags field when
> retrieving args"), nlmsvc_retrieve_args() initializes the flc_flags
> field. svcxdr_decode_lock() no longer needs to do this.
>=20
> This clean up removes one dependency on the nlm_lock:fl field. No
> behavior change is expected.
>=20
> Analysis:
>=20
> svcxdr_decode_lock() is called by:
>=20
> nlm4svc_decode_testargs()
> nlm4svc_decode_lockargs()
> nlm4svc_decode_cancargs()
> nlm4svc_decode_unlockargs()
>=20
> nlm4svc_decode_testargs() is used by:
> - NLMPROC4_TEST and NLMPROC4_TEST_MSG, which call nlmsvc_retrieve_args()
> - NLMPROC4_GRANTED and NLMPROC4_GRANTED_MSG, which don't pass the
>   lock's file_lock to the generic lock API
>=20
> nlm4svc_decode_lockargs() is used by:
> - NLMPROC4_LOCK and NLM4PROC4_LOCK_MSG, which call nlmsvc_retrieve_args()
> - NLMPROC4_UNLOCK and NLM4PROC4_UNLOCK_MSG, which call nlmsvc_retrieve_ar=
gs()
> - NLMPROC4_NM_LOCK, which calls nlmsvc_retrieve_args()
>=20
> nlm4svc_decode_cancargs() is used by:
> - NLMPROC4_CANCEL and NLMPROC4_CANCEL_MSG, which call nlmsvc_retrieve_arg=
s()
>=20
> nlm4svc_decode_unlockargs() is used by:
> - NLMPROC4_UNLOCK and NLMPROC4_UNLOCK_MSG, which call nlmsvc_retrieve_arg=
s()
>=20
> All callers except GRANTED/GRANTED_MSG eventually call
> nlmsvc_retrieve_args() before using nlm_lock::fl.c.flc_flags. Thus
> this change is safe.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svc4proc.c | 5 +++--
>  fs/lockd/xdr4.c     | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 2cb603013111..109e5caae8c7 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -46,14 +46,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct =
nlm_args *argp,
>  	if (filp !=3D NULL) {
>  		int mode =3D lock_to_openmode(&lock->fl);
> =20
> +		lock->fl.c.flc_flags =3D FL_POSIX;
> +
>  		error =3D nlm_lookup_file(rqstp, &file, lock);
>  		if (error)
>  			goto no_locks;
>  		*filp =3D file;
> =20
>  		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.c.flc_flags =3D FL_POSIX;
> -		lock->fl.c.flc_file  =3D file->f_file[mode];
> +		lock->fl.c.flc_file =3D file->f_file[mode];
>  		lock->fl.c.flc_pid =3D current->tgid;
>  		lock->fl.fl_start =3D (loff_t)lock->lock_start;
>  		lock->fl.fl_end =3D lock->lock_len ?
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 60466b8bac58..e343c820301f 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -89,7 +89,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_l=
ock *lock)
>  		return false;
> =20
>  	locks_init_lock(fl);
> -	fl->c.flc_flags =3D FL_POSIX;
>  	fl->c.flc_type  =3D F_RDLCK;
>  	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
>  	return true;

1-4 look fine. You can add my R-b to those.

For this one, I think I'd rather see this go the other way, and just
eliminate the setting of flc_flags in nlm4svc_retrieve_args. We only
deal with FL_POSIX locks in svc lockd, and that does it right after
locks_init_lock, so I think that means it'll be done earlier, no?

Also, I think the same duplication is in nlmsvc_retrieve_args and the
nlmv3 version of svcxdr_decode_lock.
--
Jeff Layton <jlayton@kernel.org>

