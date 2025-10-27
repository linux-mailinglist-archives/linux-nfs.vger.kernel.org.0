Return-Path: <linux-nfs+bounces-15658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CADC0DAAE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A94F55F0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42A30CD91;
	Mon, 27 Oct 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4YPc4+V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E42F39A6
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568838; cv=none; b=A9sz9d0N00jwbwGLcXHwtVhNjI4cT6KSzCgRNCp1oRuxWKJeCsuwHf2422eVL7TRFO/8Sclt8rpEwc0HMdSlQKsB8hJH/hXLdOvr2IrDnsLc0dbzw8EWpMsdqECRXrEapM3iCARizU5fdz5Uom4iMFYRBDh4CzSNvbxGVT/2g3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568838; c=relaxed/simple;
	bh=MRkzWo9pUiXd8s2AkL4Nr2FcwWFhe1URNsdoFBxI7Ug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVINtuC9lzJh9XbKe48mIuiTNdM3C9LUYknLeP1UrgYHKP4SDiiAaSl4D1HBwVAsYlLE0xw+mbZrCo4qu/DckVj+9GUzWfDEEVJqxevYi8Ju5IxGWgNrOHiRhIeC0a3pd2C4wMCLd9ALuPzFBxVMyJeFM7OgHC+3t+XCPUChl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4YPc4+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99249C4CEF1;
	Mon, 27 Oct 2025 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568838;
	bh=MRkzWo9pUiXd8s2AkL4Nr2FcwWFhe1URNsdoFBxI7Ug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c4YPc4+VZdtam+CQlHvr68rWOO5fkIQxhOiAAhT3BQ6edqTJY7JvDFmL8RI0JzbXI
	 dKbHPDZldXMkJkLY2Feod2nYhnHToSBk4V0uBaYJrNVxEe6xEv8P2K7zkYRac89CYg
	 0pdNDpAU344bs62yV+rvDajwWyC8f8SVfWBJ/3JnoF+ukjqKuC7X0yeMLtpQUWtT3d
	 I6AsA4V5I7ER8aKkBuo4e9DBYJGwJ99T4Ts5Nyw/0yseQd1g50Bu29YaVH8MT1jrLz
	 My1GoeigYcQ+x/Gm8lYBv4wY+IO4EqwWxtf/MHHHjyPw8Hdj2dh8d3sqLtbPO8myhq
	 1Cg6b6az4UkJQ==
Message-ID: <9094d88497b5c4661c269219200499c9255d5fe3.camel@kernel.org>
Subject: Re: [PATCH v3 03/10] nfsd: revise names of special stateid, and
 predicate functions.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Date: Mon, 27 Oct 2025 08:40:36 -0400
In-Reply-To: <20251026222655.3617028-4-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
	 <20251026222655.3617028-4-neilb@ownmail.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 09:23 +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> When I see "CURRENT_STATEID(foo)" in the code it is not clear that this
> is testing the stateid to see if it is a special stateid.  I find that
> IS_CURRENT_STATEID(foo) is clearer.
>=20
> There are other special stateid which are described in RFC 8881 Section
> 8.2.3 as "anonymous", "READ bypass", and "invalid".  The nfsd code
> currently names them "zero", "one" and "close" which doesn't help with
> comparing the code to the RFC.
>=20
> So this patch changes the names of those special stateids and adds
> "IS_" to the front of the predicates.
>=20
> As CLOSE_STATEID() was not needed, it is discarded rather than replacing
> with IS_INVALID_STATEID().
>=20
> I felt that IS_READ_BYPASS_STATEID() was a little too verbose, so I made
> it IS_BYPASS_STATEID().
>=20
> For consistency, invalid_stateid is changed to use ~0 rather than
> 0xffffffffU for the generation number.  (RFC 8881 say to use
> "NFS4_UINT32_MAX" for the generation number here, and "all ones" for the
> generation and opaque of anon_stateid).
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 594632998a12..cd8214a53145 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -60,26 +60,32 @@
>  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> =20
>  #define all_ones {{ ~0, ~0}, ~0}
> -static const stateid_t one_stateid =3D {
> +static const stateid_t read_bypass_stateid =3D {
>  	.si_generation =3D ~0,
>  	.si_opaque =3D all_ones,
>  };
> -static const stateid_t zero_stateid =3D {
> +static const stateid_t anon_stateid =3D {
>  	/* all fields zero */
>  };
> -static const stateid_t currentstateid =3D {
> +static const stateid_t current_stateid =3D {
>  	.si_generation =3D 1,
>  };
> -static const stateid_t close_stateid =3D {
> -	.si_generation =3D 0xffffffffU,
> +static const stateid_t invalid_stateid =3D {
> +	.si_generation =3D ~0,
>  };
> =20
>  static u64 current_sessionid =3D 1;
> =20
> -#define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(=
stateid_t)))
> -#define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(s=
tateid_t)))
> -#define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, si=
zeof(stateid_t)))
> -#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, size=
of(stateid_t)))
> +/* These special stateid are defined in RFC 8881 Section 8.2.3 */
> +static inline bool IS_ANON_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &anon_stateid, sizeof(stateid_t));
> +}
> +static inline bool IS_BYPASS_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &read_bypass_stateid, sizeof(stateid_t));
> +}
> +static inline bool IS_CURRENT_STATEID(stateid_t *stateid) {
> +	return memcmp(stateid, &current_stateid, sizeof(stateid_t));
> +}
> =20
>  /* forward declarations */
>  static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner =
*lowner);
> @@ -371,7 +377,7 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *c=
b)
>  static int
>  nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *ta=
sk)
>  {
> -	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
> +	trace_nfsd_cb_notify_lock_done(&anon_stateid, task);
> =20
>  	/*
>  	 * Since this is just an optimization, we don't try very hard if it
> @@ -6495,7 +6501,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	 * open stateid would have to be created.
>  	 */
>  	if (new_stp && open_xor_delegation(open)) {
> -		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
> +		memcpy(&open->op_stateid, &anon_stateid, sizeof(open->op_stateid));
>  		open->op_rflags |=3D OPEN4_RESULT_NO_OPEN_STATEID;
>  		release_open_stateid(stp);
>  	}
> @@ -7059,7 +7065,7 @@ __be32 nfs4_check_openmode(struct nfs4_ol_stateid *=
stp, int flags)
>  static inline __be32
>  check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *s=
tateid, int flags)
>  {
> -	if (ONE_STATEID(stateid) && (flags & RD_STATE))
> +	if (IS_BYPASS_STATEID(stateid) && (flags & RD_STATE))
>  		return nfs_ok;
>  	else if (opens_in_grace(net)) {
>  		/* Answer in remaining cases depends on existence of
> @@ -7068,7 +7074,7 @@ check_special_stateids(struct net *net, svc_fh *cur=
rent_fh, stateid_t *stateid,
>  	} else if (flags & WR_STATE)
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_WRITE);
> -	else /* (flags & RD_STATE) && ZERO_STATEID(stateid) */
> +	else /* (flags & RD_STATE) && IS_ANON_STATEID(stateid) */
>  		return nfs4_share_conflict(current_fh,
>  				NFS4_SHARE_DENY_READ);
>  }
> @@ -7381,7 +7387,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	if (nfp)
>  		*nfp =3D NULL;
> =20
> -	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> +	if (IS_ANON_STATEID(stateid) || IS_BYPASS_STATEID(stateid)) {
>  		status =3D check_special_stateids(net, fhp, stateid, flags);
>  		goto done;
>  	}
> @@ -7803,12 +7809,12 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> =20
>  	/* v4.1+ suggests that we send a special stateid in here, since the
>  	 * clients should just ignore this anyway. Since this is not useful
> -	 * for v4.0 clients either, we set it to the special close_stateid
> +	 * for v4.0 clients either, we set it to the special invalid_stateid
>  	 * universally.
>  	 *
>  	 * See RFC5661 section 18.2.4, and RFC7530 section 16.2.5
>  	 */
> -	memcpy(&close->cl_stateid, &close_stateid, sizeof(close->cl_stateid));
> +	memcpy(&close->cl_stateid, &invalid_stateid, sizeof(close->cl_stateid))=
;
> =20
>  	/* put reference from nfs4_preprocess_seqid_op */
>  	nfs4_put_stid(&stp->st_stid);
> @@ -9081,7 +9087,7 @@ static void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> -	    CURRENT_STATEID(stateid))
> +	    IS_CURRENT_STATEID(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
> =20
> @@ -9097,7 +9103,7 @@ put_stateid(struct nfsd4_compound_state *cstate, co=
nst stateid_t *stateid)
>  void
>  clear_current_stateid(struct nfsd4_compound_state *cstate)
>  {
> -	put_stateid(cstate, &zero_stateid);
> +	put_stateid(cstate, &anon_stateid);
>  }
> =20
>  /*

Reviewed-by: Jeff Layton <jlayton@kernel.org>

