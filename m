Return-Path: <linux-nfs+bounces-10479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA34A50243
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF64116A670
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0924EA8A;
	Wed,  5 Mar 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7ADzKos"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049424E014
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185399; cv=none; b=EPKGX87rV/q5PGy3Z8eOH4r/XSA/w3XAhbnWw34TMpDiXmaHC06CtSPH3tJ4RaTSx/eF9LPLvNUaF77igkoUr/2slSovFyQa7xbESz1r3vbtJ0pqzslWn6qK05IOOzEKJQBcRbz0J+qMNQrT8PxIpRDl4/YrnM/V3khG/CdMUV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185399; c=relaxed/simple;
	bh=2wCe1MbBRYWfWh1NokWYWv9NDSJ7p2okUp3WBwXr5G4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vnwx2w3pUfz55GrjxIG2+h2bWCeBihl0yDYbY/kFbs1r4DuiqAv9aP90fPG7IXzbjxhVDo9hWdUnQaK3UdqgrF5raScwp5QDWq6YWcyw5kOSOfz6BJ7UxkbwREjsT4Rlc267uDtBS4vIMv6E3hGR/IG3VlcF03eqvUL41qDwI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7ADzKos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D8CC4CED1;
	Wed,  5 Mar 2025 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185398;
	bh=2wCe1MbBRYWfWh1NokWYWv9NDSJ7p2okUp3WBwXr5G4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s7ADzKos7v0yad+b7ZI7NRC49xSXTotaFm/sm6MkGEC1DRM88q8P+leef882+gQbv
	 k/kJkUSZ9BfFv8dE8a9WoI1lfrFWr/OaRXbwm/sJBqpHko+aTBAxG6LpySuIXiYrxG
	 3vWVRItNgXPK9sHlHvhS0zm2+PTbAyHXYkxkVrfakSVS9FEXbAsrXEbnGN9+/fMcVY
	 XF0UB8ZyL9Xuostq96PyvvSPrsuJ0PzLkZD8TySugPBr3NmpE2ZpHyAYGFuE0nzCI+
	 dxK+yL1gWuhE3wdgkwC/WTZBjVpjefX1x/iiFy2sWijQlEyiUYY/r8vlMW2PDcqHrf
	 lZyABH4X7dDqw==
Message-ID: <81bbbea01bb478cad8eb2ad85e10f13e4b433e34.camel@kernel.org>
Subject: Re: [PATCH V4 1/2] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@suse.de, 
	okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Wed, 05 Mar 2025 09:36:37 -0500
In-Reply-To: <1741120693-2517-2-git-send-email-dai.ngo@oracle.com>
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
	 <1741120693-2517-2-git-send-email-dai.ngo@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
> RFC8881, section 9.1.2 says:
>=20
>   "In the case of READ, the server may perform the corresponding
>    check on the access mode, or it may choose to allow READ for
>    OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>    implementation may unavoidably do (e.g., due to buffer cache
>    constraints)."
>=20
> and in section 10.4.1:
>    "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>    OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>    is in effect"
>=20
> This patch offers write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
> only. Also deleted no longer use find_rw_file().
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0f97f2c62b3a..b533225e57cf 100644
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
> @@ -5382,7 +5370,6 @@ static int nfsd4_cb_recall_done(struct nfsd4_callba=
ck *cb,
>  	if (dp->dl_stid.sc_status)
>  		/* CLOSED or REVOKED */
>  		return 1;
> -
>  	switch (task->tk_status) {
>  	case 0:
>  		return 1;
> @@ -5987,14 +5974,19 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
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
> +	 *  implementation may unavoidably do (e.g., due to buffer cache
> +	 *  constraints)."
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
> @@ -6116,7 +6108,7 @@ static bool
>  nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentf=
h,
>  		     struct kstat *stat)
>  {
> -	struct nfsd_file *nf =3D find_rw_file(dp->dl_stid.sc_file);
> +	struct nfsd_file *nf =3D find_writeable_file(dp->dl_stid.sc_file);
>  	struct path path;
>  	int rc;
> =20
> @@ -7063,7 +7055,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
>  		return_revoked =3D true;
>  	if (typemask & SC_TYPE_DELEG)
>  		/* Always allow REVOKED for DELEG so we can
> -		 * retturn the appropriate error.
> +		 * return the appropriate error.
>  		 */
>  		statusmask |=3D SC_STATUS_REVOKED;
> =20

This patch also looks good.

The only other issue I have with this is the patch ordering. If a
bisect lands between these two patches then delegations won't work
quite right. Is there a reason to order the patches this way?

Reviewed-by: Jeff Layton <jlayton@kernel.org>

