Return-Path: <linux-nfs+bounces-15659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71180C0DBA8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F6534FB523
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9222D785;
	Mon, 27 Oct 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El/ezT3b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE541DFCE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569333; cv=none; b=aXTyWdf0JMglM3jeXWW3zx5yvNUf+NdqKhy7SJiCmvZ5FhApOu8c2aSIwVrfhPK1iXqHUP7R/f3FX+7+DgSCVIASarpbU5AFmZlFJQG0q8G4qSjKmt0FGb7Sb0/cvYDrUvOGoLY/0/CInNUI5YscwdaeqN91qtPndGXKxuQf8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569333; c=relaxed/simple;
	bh=Tj57ocU4khFtwks+R+xJ4IhsjTeeGtczyVCSFPv8FUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX/QZ/AZTBWodCHH2niNwjquafZ2o16y6oOKwVnOaTkMvqwA2SETRUHS0UM7v/31aHjCyqTAidWcffi+5J4Kdr5TfHMlzsbbB4BJ/QXEaQq+XCRze+SjyQjWSjStB311IVPywJ45PXqPL7ni99HwdbRKhaiMFmtnQ+DsEzUz/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El/ezT3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AA4C4CEF1;
	Mon, 27 Oct 2025 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569332;
	bh=Tj57ocU4khFtwks+R+xJ4IhsjTeeGtczyVCSFPv8FUA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=El/ezT3b3pKQd2ygJNiwmQ6WGGUyb5BzHUkYVPv9uThrzAtLdxvpILSalIrZTZrGs
	 VAFByBon+B0Q35hfYZuRGp/vGag1mzE5147PEIoBk+v9fP8EljCpXVHsmkuh1yJsmY
	 itKa0YQ1EqbqHpC648yLFtZO0cDUrNWdyzIC1Xis8SBhjZYIHnNZA8Jin/gKPQYl72
	 CXqsAY4GK0mkSLYKNzO2Tet8WHRGePsOZnGyVolM+RE78GVnaT3u9VqtMcHMLbkqob
	 VIWVKhtd8bv6upHU+K3Z+GEMqEwHNbDj38Vmr5jsm8dj+8ea0tQNDDcwQdzQxrtkym
	 gQ5vFY1lHmtQQ==
Message-ID: <e7d0dcf25d578c64634ec841a551b6463954a29b.camel@kernel.org>
Subject: Re: [PATCH v3 04/10] nfsd: prepare XXX_current_stateid() functions
 to be non-static
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Date: Mon, 27 Oct 2025 08:48:51 -0400
In-Reply-To: <20251026222655.3617028-5-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
	 <20251026222655.3617028-5-neilb@ownmail.net>
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
> A future patch will call the current_stateid accessor from both
> nfs4state.c and nfs4proc.c.  To prepare for that some cleanup and
> documentation is in order:
>=20
> - rename to have a nfs4v1_ prefix, to mention "_current_stateid"
>   consisently, and change "put" to "save" as that seems more meaningful.
>=20
> - provide kernel doc for the three functions
>=20
> - move the "v4.1 only" test from put_stateid to get_stateid as it seems
>   to make more sense there: it is only reasonable to test
>   IS_CURRENT_STATE() when we know that session are in use.
>=20
> - place the extern declaration in nfs4xdr.h rather than
>   current_stateid.h as future patch will remove the latter file.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/current_stateid.h |  1 -
>  fs/nfsd/nfs4proc.c        |  2 +-
>  fs/nfsd/nfs4state.c       | 75 ++++++++++++++++++++++++++-------------
>  fs/nfsd/xdr4.h            |  6 ++++
>  4 files changed, 58 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> index c28540d86742..24d769043207 100644
> --- a/fs/nfsd/current_stateid.h
> +++ b/fs/nfsd/current_stateid.h
> @@ -5,7 +5,6 @@
>  #include "state.h"
>  #include "xdr4.h"
> =20
> -extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
>  /*
>   * functions to set current state id
>   */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2222bb283baf..a2b78577ddb2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2967,7 +2967,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				op->opdesc->op_set_currentstateid(cstate, &op->u);
> =20
>  			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
> -				clear_current_stateid(cstate);
> +				nfsd41_clear_current_stateid(cstate);
> =20
>  			if (current_fh->fh_export &&
>  					need_wrongsec_check(rqstp))
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index cd8214a53145..83f05dec2bf0 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9083,27 +9083,54 @@ nfs4_state_shutdown(void)
>  	shrinker_free(nfsd_slot_shrinker);
>  }
> =20
> -static void
> -get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
> +/**
> + * nfsd41_get_current_stated - use the saved v4.1 stateid if appropriate
> + * @cstate - the state of the current COMPOUND procedure
> + * @stateid - the stateid field of the current operation
> + *
> + * If the current operation requests use of the v4.1 "current_stateid" a=
nd
> + * if a stateid has been saved by a previous operation in this COMPOUND,
> + * then copy that saved stateid into the current op so it will be availa=
ble
> + * for use.
> + */
> +void
> +nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate, stateid_=
t *stateid)

nit: consider a different verb from "get" here. Maybe "fetch" or even
"restore"?

We have a lot of get/put functions in nfsd that refer to refcounting,
so this looks like it's going to take a reference to something even
when it doesn't.

>  {
> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> +	if (nfsd4_has_session(cstate) &&
> +	    HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
>  	    IS_CURRENT_STATEID(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
> =20
> -static void
> -put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *statei=
d)
> +/**
> + * nfsd41_save_current_stated - const saved a v4.1 stateid for future op=
erations
> + * @cstate - the state of the current COMPOUND procedure
> + * @stateid - the stateid field of the current operation
> + *
> + * This should be called from operations which create or update a statei=
d
> + * that should be available for future v4.1 ops in the same COMPOUND.
> + * It saves the stateid and records that there is a saved stateid.
> + * It is safe to call this with any states including v4.0.  v4.0 states
> + * will simply be ignored.
> + */
> +void
> +nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate, const s=
tateid_t *stateid)
>  {
> -	if (cstate->minorversion) {
> -		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> -	}
> +	memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> +	SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
>  }
> =20
> -void
> -clear_current_stateid(struct nfsd4_compound_state *cstate)
> +/**
> + * nfsd41_clear_current_stated - clear the saved v4.1 stateid
> + * @cstate - the state of the current COMPOUND procedure
> + *
> + * Store the anon_stateid in the current_stateid as required by
> + * RFC 8881 section 16.2.3.1.2 when the current filehandle changes
> + * without a regular stateid being available.
> + */
> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate)
>  {
> -	put_stateid(cstate, &anon_stateid);
> +	nfsd41_save_current_stateid(cstate, &anon_stateid);
>  }
> =20
>  /*
> @@ -9113,28 +9140,28 @@ void
>  nfsd4_set_opendowngradestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	put_stateid(cstate, &u->open_downgrade.od_stateid);
> +	nfsd41_save_current_stateid(cstate, &u->open_downgrade.od_stateid);
>  }
> =20
>  void
>  nfsd4_set_openstateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	put_stateid(cstate, &u->open.op_stateid);
> +	nfsd41_save_current_stateid(cstate, &u->open.op_stateid);
>  }
> =20
>  void
>  nfsd4_set_closestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	put_stateid(cstate, &u->close.cl_stateid);
> +	nfsd41_save_current_stateid(cstate, &u->close.cl_stateid);
>  }
> =20
>  void
>  nfsd4_set_lockstateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	put_stateid(cstate, &u->lock.lk_resp_stateid);
> +	nfsd41_save_current_stateid(cstate, &u->lock.lk_resp_stateid);
>  }
> =20
>  /*
> @@ -9145,56 +9172,56 @@ void
>  nfsd4_get_opendowngradestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->open_downgrade.od_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->open_downgrade.od_stateid);
>  }
> =20
>  void
>  nfsd4_get_delegreturnstateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->delegreturn.dr_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->delegreturn.dr_stateid);
>  }
> =20
>  void
>  nfsd4_get_freestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->free_stateid.fr_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->free_stateid.fr_stateid);
>  }
> =20
>  void
>  nfsd4_get_setattrstateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->setattr.sa_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->setattr.sa_stateid);
>  }
> =20
>  void
>  nfsd4_get_closestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->close.cl_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->close.cl_stateid);
>  }
> =20
>  void
>  nfsd4_get_lockustateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->locku.lu_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->locku.lu_stateid);
>  }
> =20
>  void
>  nfsd4_get_readstateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->read.rd_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->read.rd_stateid);
>  }
> =20
>  void
>  nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>  		union nfsd4_op_u *u)
>  {
> -	get_stateid(cstate, &u->write.wr_stateid);
> +	nfsd41_get_current_stateid(cstate, &u->write.wr_stateid);
>  }
> =20
>  /**
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ae75846b3cd7..e2a5fb926848 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -202,6 +202,12 @@ static inline bool nfsd4_has_session(struct nfsd4_co=
mpound_state *cs)
>  	return cs->slot !=3D NULL;
>  }
> =20
> +void nfsd41_get_current_stateid(struct nfsd4_compound_state *cstate,
> +				stateid_t *stateid);
> +void nfsd41_save_current_stateid(struct nfsd4_compound_state *cstate,
> +				 const stateid_t *stateid);
> +void nfsd41_clear_current_stateid(struct nfsd4_compound_state *cstate);
> +
>  struct nfsd4_change_info {
>  	u32		atomic;
>  	u64		before_change;

Otherwise the patch is fine though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

