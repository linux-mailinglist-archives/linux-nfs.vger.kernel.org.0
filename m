Return-Path: <linux-nfs+bounces-1536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A688404DA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26ED2843C0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491AB5EE89;
	Mon, 29 Jan 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6LpZ4fy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B05B202
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530868; cv=none; b=Q4FrB8N3SkXIit/wQNriSwbnuUDsML8A2MmbV1x24K51lX7h9NyYpO0oL+caoM2Kci/9BRqGAoAXhaJdoeK0RU2scCVEFxWv+tuRCofOCVqqjyBnrke5SdWwb+tpwi9y2ALufbVVQ5AvZt37kfTOLQRyg3+cukzIl3b0xIQdHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530868; c=relaxed/simple;
	bh=BTzr8TmG5BQyNgmF1n5a4yTO/UAf2AuAIpoGVyeWIco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/+T0UZsWjTyvS4UhiTqQo2iJm+i51yBzllAu+q4R4G0sgz4v3HllrG4t8CVBAbBXOkyW0QqSe6DhPRXMAOobVsuA193AW31uEvxNlvU2Mhr/fWd4Lol+4oNJIT0q+/QZJ4M1cUWqDbJ86QS35aI4AlsVkgqEdon+J1NZ/t1Ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6LpZ4fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEE4C433F1;
	Mon, 29 Jan 2024 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530866;
	bh=BTzr8TmG5BQyNgmF1n5a4yTO/UAf2AuAIpoGVyeWIco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t6LpZ4fyoC619xOK2sNGGTCd6FqhvsXHAG8QEmWep1Z82DTQEmpJ1lIRzO/GZTZyv
	 S9ZydwV2+4NUcXmdfXfT6WAeEMPiBWZeYQOI79+uswiQ4pPO4tUaZfj7bTQhMmK11B
	 3xrlU/k4BXQNqsOMxQ1ji3Q2/IqRcZtL9ZoeW2B0S2gr/tiXsyHpOnVNkKntrREeVV
	 wga0PH+ZKFd2Y3khiyZvDbrHU900HoLQrwIN1Pvop9COeG2kUAjM2BPhz3JyylDgds
	 wxz4IiHR5D8z12vQAe3P45bdU1if3GfMkPJExsR0JPk80Ira1Du17R51+cGhELSKTf
	 /fSBEu5WVwwFA==
Message-ID: <5e2b0d038dcdd4054b92bf3171466f24639e0ba9.camel@kernel.org>
Subject: Re: [PATCH 05/13] nfsd: split sc_status out of sc_type
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Christoph Hellwig
 <hch@lst.de>,  Tom Haynes <loghyr@gmail.com>
Date: Mon, 29 Jan 2024 07:21:04 -0500
In-Reply-To: <20240129033637.2133-6-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
	 <20240129033637.2133-6-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 14:29 +1100, NeilBrown wrote:
> sc_type identifies the type of a state - open, lock, deleg, layout - and
> also the status of a state - closed or revoked.
>=20
> This is a bit untidy and could get worse when "admin-revoked" states are
> added.  So clean it up.
>=20
> With this patch, the type is now all that is stored in sc_type.  This is
> zero when the state is first added to ->cl_stateids (causing it to be
> ignored), and is then set appropriately once it is fully initialised.
> It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
> never cleared.
>=20
> sc_type is still a bit-set even though at most one bit is set.  This allo=
ws
> lookup functions to be given a bitmap of acceptable types.
>=20
> sc_type is now an unsigned short rather than char.  There is no value in
> restricting to just 8 bits.
>=20
> All the constants now start SC_TYPE_ matching the field in which they
> are stored.  Keeping the existing names and ensuring clear separation
> from non-type flags would have required something like
> NFS4_STID_TYPE_CLOSED which is cumbersome.  The "NFS4" prefix is
> redundant was they only appear in NFS4 code, so remove that and change
> STID to SC to match the field.
>=20
> The status is stored in a separate unsigned short named "sc_status".  It
> has two flags: SC_STATUS_CLOSED and SC_STATUS_REVOKED.
> CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
> for SC_TYPE_LOCK and SC_TYPE_LAYOUT instead of setting the sc_type to zer=
o.
> These flags are only ever set, never cleared.
> For deleg stateids they are set under the global state_lock.
> For open and lock stateids they are set under ->cl_lock.
> For layout stateids they are set under ->ls_lock
>=20
> nfs4_unhash_stid() has been removed, and we never set sc_type =3D 0.  Thi=
s
> was only used for LOCK and LAYOUT stids and they now use
> SC_STATUS_CLOSED.
>=20
> Also TRACE_DEFINE_NUM() calls for the various STID #define have been
> removed because these things are not enums, and so that call is
> incorrect.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |  14 +--
>  fs/nfsd/nfs4state.c   | 207 +++++++++++++++++++++---------------------
>  fs/nfsd/state.h       |  40 +++++---
>  fs/nfsd/trace.h       |  31 +++----
>  4 files changed, 151 insertions(+), 141 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..857b822450b4 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -236,7 +236,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_stat=
e *cstate,
>  	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
>  			NFSPROC4_CLNT_CB_LAYOUT);
> =20
> -	if (parent->sc_type =3D=3D NFS4_DELEG_STID)
> +	if (parent->sc_type =3D=3D SC_TYPE_DELEG)
>  		ls->ls_file =3D nfsd_file_get(fp->fi_deleg_file);
>  	else
>  		ls->ls_file =3D find_any_file(fp);
> @@ -250,7 +250,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_stat=
e *cstate,
>  	}
> =20
>  	spin_lock(&clp->cl_lock);
> -	stp->sc_type =3D NFS4_LAYOUT_STID;
> +	stp->sc_type =3D SC_TYPE_LAYOUT;
>  	list_add(&ls->ls_perclnt, &clp->cl_lo_states);
>  	spin_unlock(&clp->cl_lock);
> =20
> @@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rq=
stp,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask =3D NFS4_LAYOUT_STID;
> +	unsigned short typemask =3D SC_TYPE_LAYOUT;
>  	__be32 status;
> =20
>  	if (create)
> -		typemask |=3D (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
> +		typemask |=3D (SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG);
> =20
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
> +	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
>  			net_generic(SVC_NET(rqstp), nfsd_net_id));
>  	if (status)
>  		goto out;
> @@ -286,7 +286,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqst=
p,
>  		goto out_put_stid;
>  	}
> =20
> -	if (stid->sc_type !=3D NFS4_LAYOUT_STID) {
> +	if (stid->sc_type !=3D SC_TYPE_LAYOUT) {
>  		ls =3D nfsd4_alloc_layout_stateid(cstate, stid, layout_type);
>  		nfs4_put_stid(stid);
> =20
> @@ -518,7 +518,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
>  		lrp->lrs_present =3D true;
>  	} else {
>  		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
> -		nfs4_unhash_stid(&ls->ls_stid);
> +		ls->ls_stid.sc_status |=3D SC_STATUS_CLOSED;
>  		lrp->lrs_present =3D false;
>  	}
>  	spin_unlock(&ls->ls_lock);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dbf9ed84610e..6bccdd0af814 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1260,11 +1260,6 @@ static void destroy_unhashed_deleg(struct nfs4_del=
egation *dp)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
> =20
> -void nfs4_unhash_stid(struct nfs4_stid *s)
> -{
> -	s->sc_type =3D 0;
> -}
> -
>  /**
>   * nfs4_delegation_exists - Discover if this delegation already exists
>   * @clp:     a pointer to the nfs4_client we're granting a delegation to
> @@ -1317,7 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, =
struct nfs4_file *fp)
>  	if (nfs4_delegation_exists(clp, fp))
>  		return -EAGAIN;
>  	refcount_inc(&dp->dl_stid.sc_count);
> -	dp->dl_stid.sc_type =3D NFS4_DELEG_STID;
> +	dp->dl_stid.sc_type =3D SC_TYPE_DELEG;
>  	list_add(&dp->dl_perfile, &fp->fi_delegations);
>  	list_add(&dp->dl_perclnt, &clp->cl_delegations);
>  	return 0;
> @@ -1329,7 +1324,7 @@ static bool delegation_hashed(struct nfs4_delegatio=
n *dp)
>  }
> =20
>  static bool
> -unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
> +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short stat=
usmask)
>  {
>  	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> =20
> @@ -1339,8 +1334,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp=
, unsigned char type)
>  		return false;
> =20
>  	if (dp->dl_stid.sc_client->cl_minorversion =3D=3D 0)
> -		type =3D NFS4_CLOSED_DELEG_STID;
> -	dp->dl_stid.sc_type =3D type;
> +		statusmask =3D SC_STATUS_CLOSED;
> +	dp->dl_stid.sc_status |=3D statusmask;
> +
>  	/* Ensure that deleg break won't try to requeue it */
>  	++dp->dl_time;
>  	spin_lock(&fp->fi_lock);
> @@ -1356,7 +1352,7 @@ static void destroy_delegation(struct nfs4_delegati=
on *dp)
>  	bool unhashed;
> =20
>  	spin_lock(&state_lock);
> -	unhashed =3D unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +	unhashed =3D unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -1370,7 +1366,7 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
> =20
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
> =20
> -	if (dp->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID) {
> +	if (dp->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		spin_lock(&clp->cl_lock);
>  		refcount_inc(&dp->dl_stid.sc_count);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> @@ -1379,8 +1375,8 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
>  	destroy_unhashed_deleg(dp);
>  }
> =20
> -/*=20
> - * SETCLIENTID state=20
> +/*
> + * SETCLIENTID state
>   */
> =20
>  static unsigned int clientid_hashval(u32 id)
> @@ -1543,7 +1539,7 @@ static bool unhash_lock_stateid(struct nfs4_ol_stat=
eid *stp)
>  	if (!unhash_ol_stateid(stp))
>  		return false;
>  	list_del_init(&stp->st_locks);
> -	nfs4_unhash_stid(&stp->st_stid);
> +	stp->st_stid.sc_status |=3D SC_STATUS_CLOSED;
>  	return true;
>  }
> =20
> @@ -1622,6 +1618,7 @@ static void release_open_stateid(struct nfs4_ol_sta=
teid *stp)
>  	LIST_HEAD(reaplist);
> =20
>  	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |=3D SC_STATUS_CLOSED;
>  	if (unhash_open_stateid(stp, &reaplist))
>  		put_ol_stateid_locked(stp, &reaplist);
>  	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> @@ -2230,7 +2227,7 @@ __destroy_client(struct nfs4_client *clp)
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp =3D list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl=
_perclnt);
> -		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -2462,14 +2459,16 @@ find_stateid_locked(struct nfs4_client *cl, state=
id_t *t)
>  }
> =20
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask=
)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned short typemask, unsigned short ok_states)
>  {
>  	struct nfs4_stid *s;
> =20
>  	spin_lock(&cl->cl_lock);
>  	s =3D find_stateid_locked(cl, t);
>  	if (s !=3D NULL) {
> -		if (typemask & s->sc_type)
> +		if ((s->sc_status & ~ok_states) =3D=3D 0 &&
> +		    (typemask & s->sc_type))
>  			refcount_inc(&s->sc_count);
>  		else
>  			s =3D NULL;
> @@ -2622,7 +2621,7 @@ static int nfs4_show_open(struct seq_file *s, struc=
t nfs4_stid *st)
>  	struct nfs4_stateowner *oo;
>  	unsigned int access, deny;
> =20
> -	if (st->sc_type !=3D NFS4_OPEN_STID && st->sc_type !=3D NFS4_LOCK_STID)
> +	if (st->sc_type !=3D SC_TYPE_OPEN && st->sc_type !=3D SC_TYPE_LOCK)
>  		return 0; /* XXX: or SEQ_SKIP? */
>  	ols =3D openlockstateid(st);
>  	oo =3D ols->st_stateowner;
> @@ -2754,13 +2753,13 @@ static int states_show(struct seq_file *s, void *=
v)
>  	struct nfs4_stid *st =3D v;
> =20
>  	switch (st->sc_type) {
> -	case NFS4_OPEN_STID:
> +	case SC_TYPE_OPEN:
>  		return nfs4_show_open(s, st);
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_LOCK:
>  		return nfs4_show_lock(s, st);
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		return nfs4_show_deleg(s, st);
> -	case NFS4_LAYOUT_STID:
> +	case SC_TYPE_LAYOUT:
>  		return nfs4_show_layout(s, st);
>  	default:
>  		return 0; /* XXX: or SEQ_SKIP? */
> @@ -4532,7 +4531,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, stru=
ct nfsd4_open *open)
>  			continue;
>  		if (local->st_stateowner !=3D &oo->oo_owner)
>  			continue;
> -		if (local->st_stid.sc_type =3D=3D NFS4_OPEN_STID) {
> +		if (local->st_stid.sc_type =3D=3D SC_TYPE_OPEN &&
> +		    !local->st_stid.sc_status) {
>  			ret =3D local;
>  			refcount_inc(&ret->st_stid.sc_count);
>  			break;
> @@ -4546,17 +4546,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret =3D nfs_ok;
> =20
> -	switch (s->sc_type) {
> -	default:
> -		break;
> -	case 0:
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
> -		ret =3D nfserr_bad_stateid;
> -		break;
> -	case NFS4_REVOKED_DELEG_STID:
> +	if (s->sc_status & SC_STATUS_REVOKED)
>  		ret =3D nfserr_deleg_revoked;
> -	}
> +	else if (s->sc_status & SC_STATUS_CLOSED)
> +		ret =3D nfserr_bad_stateid;
>  	return ret;
>  }
> =20
> @@ -4642,7 +4635,7 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd=
4_open *open)
> =20
>  	open->op_stp =3D NULL;
>  	refcount_inc(&stp->st_stid.sc_count);
> -	stp->st_stid.sc_type =3D NFS4_OPEN_STID;
> +	stp->st_stid.sc_type =3D SC_TYPE_OPEN;
>  	INIT_LIST_HEAD(&stp->st_locks);
>  	stp->st_stateowner =3D nfs4_get_stateowner(&oo->oo_owner);
>  	get_nfs4_file(fp);
> @@ -4869,9 +4862,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callba=
ck *cb,
> =20
>  	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
> =20
> -	if (dp->dl_stid.sc_type =3D=3D NFS4_CLOSED_DELEG_STID ||
> -	    dp->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID)
> -	        return 1;
> +	if (dp->dl_stid.sc_status)
> +		/* CLOSED or REVOKED */
> +		return 1;
> =20
>  	switch (task->tk_status) {
>  	case 0:
> @@ -5116,12 +5109,12 @@ static int share_access_to_flags(u32 share_access=
)
>  	return share_access =3D=3D NFS4_SHARE_ACCESS_READ ? RD_STATE : WR_STATE=
;
>  }
> =20
> -static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl=
, stateid_t *s)
> +static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl=
,
> +						  stateid_t *s)
>  {
>  	struct nfs4_stid *ret;
> =20
> -	ret =3D find_stateid_by_type(cl, s,
> -				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
> +	ret =3D find_stateid_by_type(cl, s, SC_TYPE_DELEG, SC_STATUS_REVOKED);
>  	if (!ret)
>  		return NULL;
>  	return delegstateid(ret);
> @@ -5144,7 +5137,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfs=
d4_open *open,
>  	deleg =3D find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg =3D=3D NULL)
>  		goto out;
> -	if (deleg->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID) {
> +	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
>  		status =3D nfserr_deleg_revoked;
>  		goto out;
> @@ -5777,7 +5770,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct =
svc_fh *current_fh, struct nf
>  	} else {
>  		status =3D nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
> -			stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
>  			mutex_unlock(&stp->st_mutex);
>  			goto out;
> @@ -6169,7 +6161,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> -		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -6408,22 +6400,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_=
client *cl, stateid_t *stateid)
>  	status =3D nfsd4_stid_check_stateid_generation(stateid, s, 1);
>  	if (status)
>  		goto out_unlock;
> +	status =3D nfsd4_verify_open_stid(s);
> +	if (status)
> +		goto out_unlock;
> +
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		status =3D nfs_ok;
>  		break;
> -	case NFS4_REVOKED_DELEG_STID:
> -		status =3D nfserr_deleg_revoked;
> -		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		status =3D nfsd4_check_openowner_confirmed(openlockstateid(s));
>  		break;
>  	default:
>  		printk("unknown stateid type %x\n", s->sc_type);
> -		fallthrough;
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
>  		status =3D nfserr_bad_stateid;
>  	}
>  out_unlock:
> @@ -6433,7 +6423,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
> =20
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid,
> +		     unsigned short typemask, unsigned short statusmask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6444,10 +6435,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state =
*cstate,
>  	 *  only return revoked delegations if explicitly asked.
>  	 *  otherwise we report revoked or bad_stateid status.
>  	 */
> -	if (typemask & NFS4_REVOKED_DELEG_STID)
> +	if (statusmask & SC_STATUS_REVOKED)
>  		return_revoked =3D true;
> -	else if (typemask & NFS4_DELEG_STID)
> -		typemask |=3D NFS4_REVOKED_DELEG_STID;
> +	if (typemask & SC_TYPE_DELEG)
> +		/* Always allow REVOKED for DELEG so we can
> +		 * retturn the appropriate error.
> +		 */
> +		statusmask |=3D SC_STATUS_REVOKED;
> =20
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> @@ -6460,14 +6454,12 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state =
*cstate,
>  	}
>  	if (status)
>  		return status;
> -	stid =3D find_stateid_by_type(cstate->clp, stateid, typemask);
> +	stid =3D find_stateid_by_type(cstate->clp, stateid, typemask, statusmas=
k);
>  	if (!stid)
>  		return nfserr_bad_stateid;
> -	if ((stid->sc_type =3D=3D NFS4_REVOKED_DELEG_STID) && !return_revoked) =
{
> +	if ((stid->sc_status & SC_STATUS_REVOKED) && !return_revoked) {
>  		nfs4_put_stid(stid);
> -		if (cstate->minorversion)
> -			return nfserr_deleg_revoked;
> -		return nfserr_bad_stateid;
> +		return nfserr_deleg_revoked;
>  	}
>  	*s =3D stid;
>  	return nfs_ok;
> @@ -6478,17 +6470,17 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
>  	struct nfsd_file *ret =3D NULL;
> =20
> -	if (!s)
> +	if (!s || s->sc_status)
>  		return NULL;
> =20
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		spin_lock(&s->sc_file->fi_lock);
>  		ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
>  		spin_unlock(&s->sc_file->fi_lock);
>  		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		if (flags & RD_STATE)
>  			ret =3D find_readable_file(s->sc_file);
>  		else
> @@ -6601,7 +6593,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
>  		goto out;
> =20
>  	*stid =3D find_stateid_by_type(found, &cps->cp_p_stateid,
> -			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> +				     SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
> +				     0);
>  	if (*stid)
>  		status =3D nfs_ok;
>  	else
> @@ -6658,8 +6651,8 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	}
> =20
>  	status =3D nfsd4_lookup_stateid(cstate, stateid,
> -				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> -				&s, nn);
> +				SC_TYPE_DELEG|SC_TYPE_OPEN|SC_TYPE_LOCK,
> +				0, &s, nn);
>  	if (status =3D=3D nfserr_bad_stateid)
>  		status =3D find_cpntf_state(nn, stateid, &s);
>  	if (status)
> @@ -6670,16 +6663,13 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp=
,
>  		goto out;
> =20
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
>  		status =3D nfs4_check_delegmode(delegstateid(s), flags);
>  		break;
> -	case NFS4_OPEN_STID:
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_OPEN:
> +	case SC_TYPE_LOCK:
>  		status =3D nfs4_check_olstateid(openlockstateid(s), flags);
>  		break;
> -	default:
> -		status =3D nfserr_bad_stateid;
> -		break;
>  	}
>  	if (status)
>  		goto out;
> @@ -6758,33 +6748,34 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> =20
>  	spin_lock(&cl->cl_lock);
>  	s =3D find_stateid_locked(cl, stateid);
> -	if (!s)
> +	if (!s || s->sc_status & SC_STATUS_CLOSED)
>  		goto out_unlock;
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
> -	case NFS4_DELEG_STID:
> +	case SC_TYPE_DELEG:
> +		if (s->sc_status & SC_STATUS_REVOKED) {
> +			spin_unlock(&s->sc_lock);
> +			dp =3D delegstateid(s);
> +			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&cl->cl_lock);
> +			nfs4_put_stid(s);
> +			ret =3D nfs_ok;
> +			goto out;
> +		}
>  		ret =3D nfserr_locks_held;
>  		break;
> -	case NFS4_OPEN_STID:
> +	case SC_TYPE_OPEN:
>  		ret =3D check_stateid_generation(stateid, &s->sc_stateid, 1);
>  		if (ret)
>  			break;
>  		ret =3D nfserr_locks_held;
>  		break;
> -	case NFS4_LOCK_STID:
> +	case SC_TYPE_LOCK:
>  		spin_unlock(&s->sc_lock);
>  		refcount_inc(&s->sc_count);
>  		spin_unlock(&cl->cl_lock);
>  		ret =3D nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	case NFS4_REVOKED_DELEG_STID:
> -		spin_unlock(&s->sc_lock);
> -		dp =3D delegstateid(s);
> -		list_del_init(&dp->dl_recall_lru);
> -		spin_unlock(&cl->cl_lock);
> -		nfs4_put_stid(s);
> -		ret =3D nfs_ok;
> -		goto out;
>  	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
> @@ -6827,6 +6818,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_com=
pound_state *cstate, stateid_
>   * @seqid: seqid (provided by client)
>   * @stateid: stateid (provided by client)
>   * @typemask: mask of allowable types for this operation
> + * @statusmask: mask of allowed states: 0 or STID_CLOSED
>   * @stpp: return pointer for the stateid found
>   * @nn: net namespace for request
>   *
> @@ -6836,7 +6828,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_com=
pound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid,
> +			 unsigned short typemask, unsigned short statusmask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> @@ -6847,7 +6840,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_stat=
e *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
> =20
>  	*stpp =3D NULL;
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> +	status =3D nfsd4_lookup_stateid(cstate, stateid,
> +				      typemask, statusmask, &s, nn);
>  	if (status)
>  		return status;
>  	stp =3D openlockstateid(s);
> @@ -6869,7 +6863,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(st=
ruct nfsd4_compound_state *cs
>  	struct nfs4_ol_stateid *stp;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -						NFS4_OPEN_STID, &stp, nn);
> +					  SC_TYPE_OPEN, 0, &stp, nn);
>  	if (status)
>  		return status;
>  	oo =3D openowner(stp->st_stateowner);
> @@ -6900,8 +6894,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>  		return status;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate,
> -					oc->oc_seqid, &oc->oc_req_stateid,
> -					NFS4_OPEN_STID, &stp, nn);
> +					  oc->oc_seqid, &oc->oc_req_stateid,
> +					  SC_TYPE_OPEN, 0, &stp, nn);
>  	if (status)
>  		goto out;
>  	oo =3D openowner(stp->st_stateowner);
> @@ -7031,18 +7025,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	dprintk("NFSD: nfsd4_close on file %pd\n",=20
> +	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
> -					&close->cl_stateid,
> -					NFS4_OPEN_STID|NFS4_CLOSED_STID,
> -					&stp, nn);
> +					  &close->cl_stateid,
> +					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
> +					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> -		goto out;=20
> +		goto out;
> =20
> -	stp->st_stid.sc_type =3D NFS4_CLOSED_STID;
> +	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |=3D SC_STATUS_CLOSED;
> +	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> =20
>  	/*
>  	 * Technically we don't _really_ have to increment or copy it, since
> @@ -7084,7 +7080,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>  	if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
> =20
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, n=
n);
> +	status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, =
nn);
>  	if (status)
>  		goto out;
>  	dp =3D delegstateid(s);
> @@ -7351,7 +7347,7 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, stru=
ct nfs4_lockowner *lo,
>  	if (retstp)
>  		goto out_found;
>  	refcount_inc(&stp->st_stid.sc_count);
> -	stp->st_stid.sc_type =3D NFS4_LOCK_STID;
> +	stp->st_stid.sc_type =3D SC_TYPE_LOCK;
>  	stp->st_stateowner =3D nfs4_get_stateowner(&lo->lo_owner);
>  	get_nfs4_file(fp);
>  	stp->st_stid.sc_file =3D fp;
> @@ -7538,9 +7534,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  							&lock_stp, &new);
>  	} else {
>  		status =3D nfs4_preprocess_seqid_op(cstate,
> -				       lock->lk_old_lock_seqid,
> -				       &lock->lk_old_lock_stateid,
> -				       NFS4_LOCK_STID, &lock_stp, nn);
> +						  lock->lk_old_lock_seqid,
> +						  &lock->lk_old_lock_stateid,
> +						  SC_TYPE_LOCK, 0, &lock_stp,
> +						  nn);
>  	}
>  	if (status)
>  		goto out;
> @@ -7853,8 +7850,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  		 return nfserr_inval;
> =20
>  	status =3D nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
> -					&locku->lu_stateid, NFS4_LOCK_STID,
> -					&stp, nn);
> +					  &locku->lu_stateid, SC_TYPE_LOCK, 0,
> +					  &stp, nn);
>  	if (status)
>  		goto out;
>  	nf =3D find_any_file(stp->st_stid.sc_file);
> @@ -8292,7 +8289,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +		unhash_delegation_locked(dp, SC_STATUS_CLOSED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 41bdc913fa71..ffc8920d0558 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,33 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> -/* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +
> +	/* A new stateid is added to the cl_stateids idr early before it
> +	 * is fully initialised.  Its sc_type is then zero.  After
> +	 * initialisation the sc_type it set under cl_lock, and then
> +	 * never changes.
> +	 */
> +#define SC_TYPE_OPEN		BIT(0)
> +#define SC_TYPE_LOCK		BIT(1)
> +#define SC_TYPE_DELEG		BIT(2)
> +#define SC_TYPE_LAYOUT		BIT(3)
> +	unsigned short		sc_type;
> +
> +/* state_lock protects sc_status for delegation stateids.
> + * ->cl_lock protects sc_status for open and lock stateids.
> + * ->st_mutex also protect sc_status for open stateids.
> + * ->ls_lock protects sc_status for layout stateids.
> + */
> +/*
> + * For an open stateid kept around *only* to process close replays.
> + * For deleg stateid, kept in idr until last reference is dropped.
> + */
> +#define SC_STATUS_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> +#define SC_STATUS_REVOKED	BIT(1)
> +	unsigned short		sc_status;
> +
>  	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -672,15 +688,15 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc=
_rqst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> -		     struct nfs4_stid **s, struct nfsd_net *nn);
> +			    stateid_t *stateid, unsigned short typemask,
> +			    unsigned short statusmask,
> +			    struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_ca=
che *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
>  void nfs4_free_copy_state(struct nfsd4_copy *copy);
>  struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn=
,
>  			struct nfs4_stid *p_stid);
> -void nfs4_unhash_stid(struct nfs4_stid *s);
>  void nfs4_put_stid(struct nfs4_stid *s);
>  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
>  void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfs=
d_net *);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1e8cf079b0f..fe08ca18b647 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -641,23 +641,17 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
> =20
> -TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> -TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> -TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> -TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> -
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
> -		{ NFS4_OPEN_STID,		"OPEN" },		\
> -		{ NFS4_LOCK_STID,		"LOCK" },		\
> -		{ NFS4_DELEG_STID,		"DELEG" },		\
> -		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> -		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> -		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
> -		{ NFS4_LAYOUT_STID,		"LAYOUT" })
> +		{ SC_TYPE_OPEN,		"OPEN" },		\
> +		{ SC_TYPE_LOCK,		"LOCK" },		\
> +		{ SC_TYPE_DELEG,		"DELEG" },		\
> +		{ SC_TYPE_LAYOUT,		"LAYOUT" })
> +
> +#define show_stid_status(x)						\
> +	__print_flags(x, "|",						\
> +		{ SC_STATUS_CLOSED,		"CLOSED" },		\
> +		{ SC_STATUS_REVOKED,		"REVOKED" })		\
> =20
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
> @@ -666,6 +660,7 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_ARGS(stid),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, sc_type)
> +		__field(unsigned long, sc_status)
>  		__field(int, sc_count)
>  		__field(u32, cl_boot)
>  		__field(u32, cl_id)
> @@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  		const stateid_t *stp =3D &stid->sc_stateid;
> =20
>  		__entry->sc_type =3D stid->sc_type;
> +		__entry->sc_status =3D stid->sc_status;
>  		__entry->sc_count =3D refcount_read(&stid->sc_count);
>  		__entry->cl_boot =3D stp->si_opaque.so_clid.cl_boot;
>  		__entry->cl_id =3D stp->si_opaque.so_clid.cl_id;
>  		__entry->si_id =3D stp->si_opaque.so_id;
>  		__entry->si_generation =3D stp->si_generation;
>  	),
> -	TP_printk("client %08x:%08x stateid %08x:%08x ref=3D%d type=3D%s",
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=3D%d type=3D%s state=
=3D%s",
>  		__entry->cl_boot, __entry->cl_id,
>  		__entry->si_id, __entry->si_generation,
> -		__entry->sc_count, show_stid_type(__entry->sc_type)
> +		__entry->sc_count, show_stid_type(__entry->sc_type),
> +		show_stid_status(__entry->sc_status)
>  	)
>  );
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

