Return-Path: <linux-nfs+bounces-11642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2EAB1D4E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90C87A93F3
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6CD25D1E2;
	Fri,  9 May 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQLhm5n2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024821CC60
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819133; cv=none; b=f5Ee7uERzfB1UKpls2CCwEL7vPzoy/5FHgTjQ3lYzIT4Mv7nCjFGIUaNv0UeTSEdHGEzkd38cVi5VUx8Yab9w3YAUPT1DrZhOMSE+d7aPz0V2jUV6NH3ujOVPf1q0YtWV2BXjdAqf0kTpPfTpfy2gwjfkaVtKU/1V9LLneoz2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819133; c=relaxed/simple;
	bh=XdOOTe3U5bMl0d+4xae6b4w84P5nwSjPEBXVGIx1Z5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJK27Rzue8WXmcRFdbPeBiJqXPim2tDe3ANVWCnoxqesozNrj2ewNNySzp/CaPleJY6YrGU6ECIFlbeDUQr9G72AWnlRHSNWXcGCEtxSAWqAPMEtjl40Rggoo+9ExC8syHO+sxkZFk942DoPThyGVQa3edSnDYCXtojHLioaYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQLhm5n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A894C4CEE4;
	Fri,  9 May 2025 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746819132;
	bh=XdOOTe3U5bMl0d+4xae6b4w84P5nwSjPEBXVGIx1Z5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oQLhm5n26UekwXXvCqZYIBP0nlMYgdHlXA3fo8925hNFMWCnKOA5OnaQRHBaCE+D3
	 Z6jZDPVrm5sqhQYIjgZOvfPVkPPYv9dPkiiKAIQoXnxSDPMBDMIJkCEzNtZ+wS0KCf
	 sX5v5sFG1a65+b6ISOnLYDb/U6vKv+Mq+BpzgcbUJLgeNyVAwZA3fLN6LY8R8U+xCB
	 F0/SUiLIB+1feG6hdF+5Evr0JfcHh6sgnHm4XYfiI4W6oqnu3iVVo6yqGi91pCZ9fy
	 x06c4ZYv4OcpzgLVBvyTzL4WDoHlAmL6Wt47wO6HTNMV+xFvELieHevh88l8pqZK8b
	 jc1Xg3MdQotIg==
Message-ID: <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@suse.de, 
	okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Fri, 09 May 2025 15:32:10 -0400
In-Reply-To: <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
	 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
> RFC8881, section 9.1.2 says:
>=20
>   "In the case of READ, the server may perform the corresponding
>    check on the access mode, or it may choose to allow READ for
>    OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>    implementation may unavoidably do reads (e.g., due to buffer cache
>    constraints)."
>=20
> and in section 10.4.1:
>    "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>    OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>    is in effect"
>=20
> This patch allow READ using write delegation stateid granted on OPENs
> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
> implementation may unavoidably do (e.g., due to buffer cache
> constraints).
>=20
> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
> a new nfsd_file and a struct file are allocated to use for reads.
> The nfsd_file is freed when the file is closed by release_all_access.
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0f97f2c62b3a..295415fda985 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>  	return ret;
>  }
> =20
> -static struct nfsd_file *
> -find_rw_file(struct nfs4_file *f)
> -{
> -	struct nfsd_file *ret;
> -
> -	spin_lock(&f->fi_lock);
> -	ret =3D nfsd_file_get(f->fi_fds[O_RDWR]);
> -	spin_unlock(&f->fi_lock);
> -
> -	return ret;
> -}
> -
>  struct nfsd_file *
>  find_any_file(struct nfs4_file *f)
>  {
> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>  	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>  	 *   on its own, all opens."
>  	 *
> -	 * Furthermore the client can use a write delegation for most READ
> -	 * operations as well, so we require a O_RDWR file here.
> +	 * Furthermore, section 9.1.2 says:
> +	 *
> +	 *  "In the case of READ, the server may perform the corresponding
> +	 *  check on the access mode, or it may choose to allow READ for
> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
> +	 *  implementation may unavoidably do reads (e.g., due to buffer
> +	 *  cache constraints)."
>  	 *
> -	 * Offer a write delegation in the case of a BOTH open, and ensure
> -	 * we get the O_RDWR descriptor.
> +	 *  We choose to offer a write delegation for OPEN with the
> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>  	 */
> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHARE_=
ACCESS_BOTH) {
> -		nf =3D find_rw_file(fp);
> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		nf =3D find_writeable_file(fp);
>  		dl_type =3D deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE=
_WRITE;
>  	}
> =20
> @@ -6116,7 +6109,7 @@ static bool
>  nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentf=
h,
>  		     struct kstat *stat)
>  {
> -	struct nfsd_file *nf =3D find_rw_file(dp->dl_stid.sc_file);
> +	struct nfsd_file *nf =3D find_writeable_file(dp->dl_stid.sc_file);
>  	struct path path;
>  	int rc;
> =20
> @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, s=
truct svc_fh *currentfh,
>  	return rc =3D=3D 0;
>  }
> =20
> +/*
> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
> + * struct file to be used for read with delegation stateid.
> + *
> + */
> +static bool
> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open =
*open,
> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
> +{
> +	struct nfs4_file *fp;
> +	struct nfsd_file *nf =3D NULL;
> +
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D
> +			NFS4_SHARE_ACCESS_WRITE) {
> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
> +			return (false);
> +		fp =3D stp->st_stid.sc_file;
> +		spin_lock(&fp->fi_lock);
> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
> +		fp =3D stp->st_stid.sc_file;
> +		fp->fi_fds[O_RDONLY] =3D nf;
> +		spin_unlock(&fp->fi_lock);
> +	}
> +	return true;
> +}
> +
>  /*
>   * The Linux NFS server does not offer write delegations to NFSv4.0
>   * clients in order to avoid conflicts between write delegations and
> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, st=
ruct svc_fh *currentfh,
>   * open or lock state.
>   */
>  static void
> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
> -		     struct svc_fh *currentfh)
> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
> +		     struct svc_fh *fh)
>  {
>  	bool deleg_ts =3D open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_T=
IMESTAMPS;
>  	struct nfs4_openowner *oo =3D openowner(stp->st_stateowner);
> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->=
dl_stid.sc_stateid));
> =20
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
> +		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>  			nfs4_put_stid(&dp->dl_stid);
>  			destroy_delegation(dp);
>  			goto out_no_deleg;
> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	* Attempt to hand out a delegation. No error return, because the
>  	* OPEN succeeds even if we fail.
>  	*/
> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
> +	nfs4_open_delegation(rqstp, open, stp,
> +		&resp->cstate.current_fh, current_fh);
> =20
>  	/*
>  	 * If there is an existing open stateid, it must be updated and
> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
>  		return_revoked =3D true;
>  	if (typemask & SC_TYPE_DELEG)
>  		/* Always allow REVOKED for DELEG so we can
> -		 * retturn the appropriate error.
> +		 * return the appropriate error.
>  		 */
>  		statusmask |=3D SC_STATUS_REVOKED;
> =20
> @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
> =20
>  	switch (s->sc_type) {
>  	case SC_TYPE_DELEG:
> -		spin_lock(&s->sc_file->fi_lock);
> -		ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> -		spin_unlock(&s->sc_file->fi_lock);
> -		break;
>  	case SC_TYPE_OPEN:
>  	case SC_TYPE_LOCK:
>  		if (flags & RD_STATE)

I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
landed on this patch. The reproducer is:

1/ set up an exported fs on a server (I used xfs, but it probably
doesn't matter).

2/ mount up the export on a client using v4.2

3/ Run this fio script in the directory:

----------------8<---------------------
[global]
name=3Dfio-seq-write
filename=3Dfio-seq-write
rw=3Dwrite
bs=3D1M
direct=3D0
numjobs=3D1
time_based
runtime=3D60

[file1]
size=3D50G
ioengine=3Dio_uring
iodepth=3D16
----------------8<---------------------

When it completes, shut down the nfs server. You'll see warnings like
this:

    BUG nfsd_file (Tainted: G    B   W          ): Objects remaining on __k=
mem_cache_shutdown()

Dai, can you take a look?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

