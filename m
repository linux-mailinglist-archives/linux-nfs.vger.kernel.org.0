Return-Path: <linux-nfs+bounces-2127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDA86D6D4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A3A1C226EE
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E3274C0E;
	Thu, 29 Feb 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MS3pjJW6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZDJEX44";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MS3pjJW6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZDJEX44"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010674C05;
	Thu, 29 Feb 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245577; cv=none; b=PU6hReXq8VKWUP2AvsO9xHnqAiajUUDp8js1htUFWsz2nUa3jbuQc3uBt6qHUaytrwNm+ardB/G6ehOTj0Byh/NXamJN4YxgiLLYGcNDLMRkeVTUVYxnm9gFsrwynA3QCKRj2ZjzzyNxbT3UR/SEAM+Du4SY+yBDiDaP1tHU9Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245577; c=relaxed/simple;
	bh=GCKf4NzvtDireLM5jhckX6LS/rVF23UYmVzpTj/hb10=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XPiCJDO3g6dzTyMHzrFVEQs+DRukB5EkQX6pc9eGdruXIDnaFv4XAfReCECzim+5euxndX8zxHpZ7+7cgq63BjIBxEMPk8NRN4Wtcg5ZXymHTlHTllk44LmHPq6/PmqnvH0KZXMQPbcpVBAGnUvqVDSwHUDibwCCgW8DyZM/bAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MS3pjJW6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZDJEX44; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MS3pjJW6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZDJEX44; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7115C22021;
	Thu, 29 Feb 2024 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709245573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q2ff3tk7upYT+U6Oils45T4A6BE5V/TKvYs9aQhOf0=;
	b=MS3pjJW6r8bDMR6CiG1ewHmzJ8BB8txTH4E93v03zYvnVGChlfO53iRi3w6FravzY2x7Qn
	4yuRMfvwmAGhKP1iCbmAHY31vZwx4FaTkHYaey2f6KyWzdoE6nT503AeCJBR79qdpHj0D6
	s6z7LuCdvYbL7yZp1PzXXs8nMBrX+jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709245573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q2ff3tk7upYT+U6Oils45T4A6BE5V/TKvYs9aQhOf0=;
	b=4ZDJEX44He0G5lt8Px2VxgM1drHmvCus0ETy/7TbXiI/lW/a2AU7Mq0d4TqaSgxR9Uq4E2
	TppBLK8g1ODDMZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709245573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q2ff3tk7upYT+U6Oils45T4A6BE5V/TKvYs9aQhOf0=;
	b=MS3pjJW6r8bDMR6CiG1ewHmzJ8BB8txTH4E93v03zYvnVGChlfO53iRi3w6FravzY2x7Qn
	4yuRMfvwmAGhKP1iCbmAHY31vZwx4FaTkHYaey2f6KyWzdoE6nT503AeCJBR79qdpHj0D6
	s6z7LuCdvYbL7yZp1PzXXs8nMBrX+jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709245573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1q2ff3tk7upYT+U6Oils45T4A6BE5V/TKvYs9aQhOf0=;
	b=4ZDJEX44He0G5lt8Px2VxgM1drHmvCus0ETy/7TbXiI/lW/a2AU7Mq0d4TqaSgxR9Uq4E2
	TppBLK8g1ODDMZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E47A13503;
	Thu, 29 Feb 2024 22:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jW9rBIIE4WVzEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 29 Feb 2024 22:26:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: return NFS4ERR_DELAY on contention for v4.0
 replay_owner rp_mutex
In-reply-to: <20240229-rp_mutex-v1-1-47deb9e4d32d@kernel.org>
References: <20240229-rp_mutex-v1-1-47deb9e4d32d@kernel.org>
Date: Fri, 01 Mar 2024 09:25:58 +1100
Message-id: <170924555835.24797.12031946610700753493@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Fri, 01 Mar 2024, Jeff Layton wrote:
> move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
> This can lead to a deadlock as move_to_close_lru() waits for sc_count to
> drop to 2, and some threads holding a reference might be waiting for either
> mutex.  These references will never be dropped so sc_count will never
> reach 2.
>=20
> There have been a couple of attempted fixes (see [1] and [2]), but both
> were problematic for different reasons.
>=20
> This patch attempts to break the impasse by simply not waiting for the
> rp_mutex. If it's contended then we just have it return NFS4ERR_DELAY.
> This will likely cause parallel opens by the same openowner to be even
> slower on NFSv4.0, but it should break the deadlock.
>=20
> One way to address the performance impact might be to allow the wait for
> the mutex to time out after a period of time (30ms would be the same as
> NFSD_DELEGRETURN_TIMEOUT). We'd need to add a mutex_lock_timeout
> function in order for that to work.
>=20
> Chuck also suggested that we may be able to utilize the svc_defer
> mechanism instead of returning NFS4ERR_DELAY in this situation, but I'm
> not quite sure how feasible that is.
>=20
> [1]: https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
> [2]: https://lore.kernel.org/linux-nfs/170546328406.23031.11217818844350800=
811@noble.neil.brown.name/
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index aee12adf0598..4b667eeb06c8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4658,13 +4658,16 @@ static void init_nfs4_replay(struct nfs4_replay *rp)
>  	mutex_init(&rp->rp_mutex);
>  }
> =20
> -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
> +static __be32 nfsd4_cstate_assign_replay(struct nfsd4_compound_state *csta=
te,
>  		struct nfs4_stateowner *so)
>  {
>  	if (!nfsd4_has_session(cstate)) {
> -		mutex_lock(&so->so_replay.rp_mutex);
> +		WARN_ON_ONCE(cstate->replay_owner);
> +		if (!mutex_trylock(&so->so_replay.rp_mutex))
> +			return nfserr_jukebox;
>  		cstate->replay_owner =3D nfs4_get_stateowner(so);
>  	}
> +	return nfs_ok;
>  }
> =20
>  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> @@ -5332,15 +5335,17 @@ nfsd4_process_open1(struct nfsd4_compound_state *cs=
tate,
>  	strhashval =3D ownerstr_hashval(&open->op_owner);
>  	oo =3D find_openstateowner_str(strhashval, open, clp);
>  	open->op_openowner =3D oo;
> -	if (!oo) {
> +	if (!oo)
>  		goto new_owner;
> -	}
>  	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
>  		/* Replace unconfirmed owners without checking for replay. */
>  		release_openowner(oo);
>  		open->op_openowner =3D NULL;
>  		goto new_owner;
>  	}
> +	status =3D nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> +	if (status)
> +		return status;
>  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
>  	if (status)
>  		return status;
> @@ -5350,6 +5355,9 @@ nfsd4_process_open1(struct nfsd4_compound_state *csta=
te,
>  	if (oo =3D=3D NULL)
>  		return nfserr_jukebox;
>  	open->op_openowner =3D oo;
> +	status =3D nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> +	if (status)
> +		return status;
>  alloc_stateid:
>  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
>  	if (!open->op_stp)
> @@ -6121,12 +6129,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct s=
vc_fh *current_fh, struct nf
>  void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
>  			      struct nfsd4_open *open)
>  {
> -	if (open->op_openowner) {
> -		struct nfs4_stateowner *so =3D &open->op_openowner->oo_owner;
> -
> -		nfsd4_cstate_assign_replay(cstate, so);
> -		nfs4_put_stateowner(so);
> -	}
> +	if (open->op_openowner)
> +		nfs4_put_stateowner(&open->op_openowner->oo_owner);
>  	if (open->op_file)
>  		kmem_cache_free(file_slab, open->op_file);
>  	if (open->op_stp)
> @@ -7193,9 +7197,9 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state =
*cstate, u32 seqid,
>  	if (status)
>  		return status;
>  	stp =3D openlockstateid(s);
> -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> -
> -	status =3D nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
> +	status =3D nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> +	if (!status)
> +		status =3D nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
>  	if (!status)
>  		*stpp =3D stp;
>  	else
>=20
> ---
> base-commit: 2eb3d14898b97bdc0596d184cbf829b5a81cd639
> change-id: 20240229-rp_mutex-d20e3319e315
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

I haven't reviewed this thoroughly but I think it is heading in the
right direction.
I think moving the nfsd4_cstate_assign_replay() call out of
nfsd4_cleanup_open_state() and into nfsd4_process_open1() is a really
good idea and possible should be a separate patch.

I wonder if return NFS4ERR_DELAY is really best.

I imagine replacing rp_mutex with an atomic_t rp_locked.
This is normally 0, becomes 1 when nfsd4_cstate_assign_replay()
succeeds, and is set to 2 in move_to_close_lru().
In nfsd4_cstate_assign_replay() we wait while the value is 1.
If it becomes 0, we can get the lock and continue.
If it becomes 2, we return an error.
If this happens, the state has been unhashed.  So instead of returning
NFS4ERR_DELAY we can loop back and repeat the nfsd4_lookup_stateid() or
find_openstateowner_str(), which we can be certain won't find the same
owner.

I started writing this, but stumbled over the
nfsd4_cstate_assign_replay() in nfsd4_cleanup_open_state().  Now that
you've shown me how to fix that, I'll have another go.

Thanks,
NeilBrown

