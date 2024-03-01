Return-Path: <linux-nfs+bounces-2137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AC86E193
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 14:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF41C21FB9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135386A028;
	Fri,  1 Mar 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoXHIxd/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAA5F483
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298560; cv=none; b=JE9btx6c7UWl7cHckgYfKeGGzoz4gLXJr5ufovBaQzDodyL8c8qgJXSKO7A544AAb5GChCjC6Cxa4vLp/edC+jTbNGSHfnkIYIkwJaV7un7Wqo3KRbsHBzFdhY1owzCQ1k0l4zYR4Zfzas2apCgimUbHjIyieOEpzzp9G5bGL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298560; c=relaxed/simple;
	bh=GIuJC9HzBERIb/zQ4IThJHhWUFXU48q78UwJiHO8SmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oo9RrJV1Vk9tfrYpQ1VZgogCHNzeqYleP6hOD+i5MPOMgNmuF6BbNauF4zU7nP1BBLT69mXxl7r60jabDPvNICa91iTMFvwAEpBEd6/MIR/MlD3VtKHZcRGRxkJCkmuCWhuNL2qSwojVT853cFSBucqVXLD9JXJMbsxoxl3j9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoXHIxd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EA4C433F1;
	Fri,  1 Mar 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709298559;
	bh=GIuJC9HzBERIb/zQ4IThJHhWUFXU48q78UwJiHO8SmI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FoXHIxd/WpJETahQPrpB+7Xffyl0Ya+jIbgmJoBAnk4sMY704awm1BVPqqbDJM6dQ
	 AnAmBaERWX6OLa447R+uoAXeejwpoOgNEx3qvaQKqYfq3JjwVYGliuFw/O+ca06C1Y
	 Pnpi17IKalRd4HgweTyP+eUJrTsiJRZwFlEpzKGO7f10d/+Q1hSsQul8MXumW3HmnJ
	 2ziGOPy6iOPQRYJITMTnf93yi45r2i1NnZG2nl3eht8qUzSummq1XdcVEglEo3L9Jg
	 hISy+XRECyQxMHdosDI1+GCna44SvsOALc8DkMRRgeVPjQTNyn9MnPOKSLvJKidKNp
	 hLVQSVbVSt69g==
Message-ID: <0554a33c0f3e15c24dc6dbe41287febac394dec0.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Fri, 01 Mar 2024 08:09:17 -0500
In-Reply-To: <20240301000950.2306-3-neilb@suse.de>
References: <20240301000950.2306-1-neilb@suse.de>
	 <20240301000950.2306-3-neilb@suse.de>
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

On Fri, 2024-03-01 at 11:07 +1100, NeilBrown wrote:
> move_to_close_lru() waits for sc_count to become zero while holding
> rp_mutex.  This can deadlock if another thread holds a reference and is
> waiting for rp_mutex.
>=20
> By the time we get to move_to_close_lru() the openowner is unhashed and
> cannot be found any more.  So code waiting for the mutex can safely
> retry the lookup if move_to_close_lru() has started.
>=20
> So change rp_mutex to an atomic_t with three states:
>=20
>  RP_UNLOCK   - state is still hashed, not locked for reply
>  RP_LOCKED   - state is still hashed, is locked for reply
>  RP_UNHASHED - state is now hashed, no code can get a lock.
>=20

"is now unhashed", I think...

> Use wait_ver_event() to wait for either a lock, or for the owner to be
> unhashed.  In the latter case, retry the lookup.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 46 ++++++++++++++++++++++++++++++++++++---------
>  fs/nfsd/state.h     |  2 +-
>  2 files changed, 38 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e625f738f7b0..5dab316932d3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4442,21 +4442,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>  	atomic_set(&nn->nfsd_courtesy_clients, 0);
>  }
> =20
> +enum rp_lock {
> +	RP_UNLOCKED,
> +	RP_LOCKED,
> +	RP_UNHASHED,
> +};
> +
>  static void init_nfs4_replay(struct nfs4_replay *rp)
>  {
>  	rp->rp_status =3D nfserr_serverfault;
>  	rp->rp_buflen =3D 0;
>  	rp->rp_buf =3D rp->rp_ibuf;
> -	mutex_init(&rp->rp_mutex);
> +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
>  }
> =20
> -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *csta=
te,
> -		struct nfs4_stateowner *so)
> +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstat=
e,
> +				      struct nfs4_stateowner *so)
>  {
>  	if (!nfsd4_has_session(cstate)) {
> -		mutex_lock(&so->so_replay.rp_mutex);
> +		wait_var_event(&so->so_replay.rp_locked,
> +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> +					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> +		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> +			return -EAGAIN;
>  		cstate->replay_owner =3D nfs4_get_stateowner(so);
>  	}
> +	return 0;
>  }
> =20
>  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> @@ -4465,7 +4476,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compoun=
d_state *cstate)
> =20
>  	if (so !=3D NULL) {
>  		cstate->replay_owner =3D NULL;
> -		mutex_unlock(&so->so_replay.rp_mutex);
> +		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> +		wake_up_var(&so->so_replay.rp_locked);
>  		nfs4_put_stateowner(so);
>  	}
>  }
> @@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struc=
t net *net)
>  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
>  	 * there should be no danger of the refcount going back up again at
>  	 * this point.
> +	 * Some threads with a reference might be waiting for rp_locked,
> +	 * so tell them to stop waiting.
>  	 */
> +	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> +	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
>  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) =3D=3D 2);
> =20
>  	release_all_access(s);
> @@ -5064,6 +5080,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cs=
tate,
>  	clp =3D cstate->clp;
> =20
>  	strhashval =3D ownerstr_hashval(&open->op_owner);
> +retry:
>  	oo =3D find_openstateowner_str(strhashval, open, clp);
>  	open->op_openowner =3D oo;
>  	if (!oo)
> @@ -5074,17 +5091,24 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
cstate,
>  		open->op_openowner =3D NULL;
>  		goto new_owner;
>  	}
> -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAIN) {
> +		nfs4_put_stateowner(&oo->oo_owner);
> +		goto retry;
> +	}
>  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
>  	if (status)
>  		return status;
>  	goto alloc_stateid;
>  new_owner:
>  	oo =3D alloc_init_open_stateowner(strhashval, open, cstate);
> +	open->op_openowner =3D oo;
>  	if (oo =3D=3D NULL)
>  		return nfserr_jukebox;
> -	open->op_openowner =3D oo;
> -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAIN) {
> +		WARN_ON(1);

I don't think you want to WARN here. It seems quite possible for the
client to send simultaneous opens for different files with the same
stateowner.



> +		nfs4_put_stateowner(&oo->oo_owner);
> +		goto new_owner;

Is "goto new_owner" correct here? We likely raced with another RPC that
was using the same owner, so ours probably got inserted and the other
nfsd thread raced in and got the lock before we could. Retrying the
lookup seems more correct in this situation?

That said, it might be best to just call nfsd4_cstate_assign_replay
before hashing the new owner. If you lose the insertion race at that
point, you can just clear it and try to assign the one that won.

> +	}
>  alloc_stateid:
>  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
>  	if (!open->op_stp)
> @@ -6841,11 +6865,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_st=
ate *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
> =20
>  	*stpp =3D NULL;
> +retry:
>  	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
>  	if (status)
>  		return status;
>  	stp =3D openlockstateid(s);
> -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> +	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) =3D=3D -EAGA=
IN) {
> +		nfs4_put_stateowner(stp->st_stateowner);
> +		goto retry;
> +	}
> =20
>  	status =3D nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
>  	if (!status)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 41bdc913fa71..6a3becd86112 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -446,7 +446,7 @@ struct nfs4_replay {
>  	unsigned int		rp_buflen;
>  	char			*rp_buf;
>  	struct knfsd_fh		rp_openfh;
> -	struct mutex		rp_mutex;
> +	atomic_t		rp_locked;
>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
>  };
> =20

--=20
Jeff Layton <jlayton@kernel.org>

