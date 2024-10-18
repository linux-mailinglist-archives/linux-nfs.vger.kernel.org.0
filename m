Return-Path: <linux-nfs+bounces-7292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39C9A46F8
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C0A2841E2
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760842040A2;
	Fri, 18 Oct 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCbZRztQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695216EB4C;
	Fri, 18 Oct 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279771; cv=none; b=myB+qc5qFYhj4GfSPG/SIFrTka9z2pqPu+6DdMXKN6oWjOuLzsEIv+0oA8O3G2V/+GBj7uW44HoLt55Fcmg4pXRdqE6ntSAYqRzA5LmoyUcwr7Qbpq04eC3vH/vCq8BaxEBXrmpHzEgfahC01D52trtHywlU0/7VcduxMxiOuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279771; c=relaxed/simple;
	bh=iQxfjQYkl6dUY315dPTjZ5db4L3LgvJc18ke5FgVVFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CO7Zs5RwFBx7bYXYY5zy4AihSC6F4EC1juJ3p4SOw/RfRMDc8GDOxTbwgvblxKSUNRivXWsoQQkN6Ep+MdpdXo7l5kI2uzmMny5+MtAHc9hqdCSEveWOybERBseNt5mrvSLrxDT1vQczmSS08c99YElWCJxTLyP1ut9NxVczwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCbZRztQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E1C4CEC3;
	Fri, 18 Oct 2024 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729279770;
	bh=iQxfjQYkl6dUY315dPTjZ5db4L3LgvJc18ke5FgVVFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iCbZRztQnuHwT3glkrG+MFxqj1nyPNksF10f7/btHgsCwlzY8mASC/8N5GsL+l3kH
	 7XDif3x9z9OG+zo4BTy07vkGJ/JfT+zkxNt4bKBrCiLd28TtLz22ilOXbF/HMNRjMi
	 AGvSl28cw4My22HPk9BG3utB9A9SVVcdBVWbRHtiJQNTv6m1lPp6aU5eg6igfG0q1S
	 tfK8PR8lMVM2Hv5u/WPvVbR6uiYwKOJsJRJLdTsqFnLNw84w/0ITK1Z3g0MElZVVh4
	 v8ZUkCZNS9H3cA9qRNCGB6EUh0MHvhXRe1FevfMRDhuG0JhHsS3MQ/E0xRon2tU3lc
	 fq+ES6YiqkEZA==
Message-ID: <0063757a2fd9a889f2e7a58505ce19ed913ce9d7.camel@kernel.org>
Subject: Re: [PATCH v3 1/1] nfsd: fix race between laundromat and
 free_stateid
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 18 Oct 2024 15:29:29 -0400
In-Reply-To: <20241018192458.84833-1-okorniev@redhat.com>
References: <20241018192458.84833-1-okorniev@redhat.com>
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

On Fri, 2024-10-18 at 15:24 -0400, Olga Kornievskaia wrote:
> There is a race between laundromat handling of revoked delegations
> and a client sending free_stateid operation. Laundromat thread
> finds that delegation has expired and needs to be revoked so it
> marks the delegation stid revoked and it puts it on a reaper list
> but then it unlock the state lock and the actual delegation revocation
> happens without the lock. Once the stid is marked revoked a racing
> free_stateid processing thread does the following (1) it calls
> list_del_init() which removes it from the reaper list and (2) frees
> the delegation stid structure. The laundromat thread ends up not
> calling the revoke_delegation() function for this particular delegation
> but that means it will no release the lock lease that exists on
> the file.
>=20
> Now, a new open for this file comes in and ends up finding that
> lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> up trying to derefence a freed delegation stateid. Leading to the
> followint use-after-free KASAN warning:
>=20
> kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x140/=
0x160 [nfsd]
> kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> kernel:
> kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.11=
.0-rc7+ #9
> kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform, =
BIOS 2069.0.0.0.0 08/03/2024
> kernel: Call trace:
> kernel: dump_backtrace+0x98/0x120
> kernel: show_stack+0x1c/0x30
> kernel: dump_stack_lvl+0x80/0xe8
> kernel: print_address_description.constprop.0+0x84/0x390
> kernel: print_report+0xa4/0x268
> kernel: kasan_report+0xb4/0xf8
> kernel: __asan_report_load8_noabort+0x1c/0x28
> kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> kernel: nfsd+0x270/0x400 [nfsd]
> kernel: kthread+0x288/0x310
> kernel: ret_from_fork+0x10/0x20
>=20
> This patch proposes a fixed that's based on adding 2 new additional
> stid's sc_status values that help coordinate between the laundromat
> and other operations (nfsd4_free_stateid() and nfsd4_delegreturn()).
>=20
> First to make sure, that once the stid is marked revoked, it is not
> removed by the nfsd4_free_stateid(), the laundromat take a reference
> on the stateid. Then, coordinating whether the stid has been put
> on the cl_revoked list or we are processing FREE_STATEID and need to
> make sure to remove it from the list, each check that state and act
> accordingly. If laundromat has added to the cl_revoke list before
> the arrival of FREE_STATEID, then nfsd4_free_stateid() knows to remove
> it from the list. If nfsd4_free_stateid() finds that operations arrived
> before laundromat has placed it on cl_revoke list, it marks the state
> freed and then laundromat will no longer add it to the list.
>=20
> Also, for nfsd4_delegreturn() when looking for the specified stid,
> we need to access stid that are marked removed or freeable, it means
> the laundromat has started processing it but hasn't finished and this
> delegreturn needs to return nfserr_deleg_revoked and not
> nfserr_bad_stateid. The latter will not trigger a FREE_STATEID and the
> lack of it will leave this stid on the cl_revoked list indefinitely.
>=20
> Fixes: 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is
> protected by clp->cl_lock")
> CC: stable@vger.kernel.org
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>=20
> --- v3. (1) adds refcount to nfsd4_revoke_states() (2) adds comments
> to revoke_delegation(), adds the WARN_ON_ONCE to make sure stid
> state is what is expected and changes unlock placement.
> ---
>  fs/nfsd/nfs4state.c | 46 +++++++++++++++++++++++++++++++++++++--------
>  fs/nfsd/state.h     |  2 ++
>  2 files changed, 40 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7905ab9d8bc6..28e9b52b01fd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1351,21 +1351,47 @@ static void destroy_delegation(struct nfs4_delega=
tion *dp)
>  		destroy_unhashed_deleg(dp);
>  }
> =20
> +/**
> + * revoke_delegation - perform nfs4 delegation structure cleanup
> + * @dp: pointer to the delegation
> + *
> + * This function assumes that it's called either from the administrative
> + * interface (nfsd4_revoke_states()) that's revoking a specific delegati=
on
> + * stateid or it's called from a laundromat thread (nfsd4_landromat()) t=
hat
> + * determined that this specific state has expired and needs to be revok=
ed
> + * (both mark state with the appropriate stid sc_status mode). It is als=
o
> + * assumed that a reference was take on the @dp state.
> + *
> + * If this function finds that the @dp state is SC_STATUS_FREED it means
> + * that a FREE_STATEID operation for this stateid has been processed and
> + * we can proceed to removing it from recalled list. However, if @dp sta=
te
> + * isn't marked SC_STATUS_FREED, it means we need place it on the cl_rev=
oked
> + * list and wait for the FREE_STATEID to arrive from the client. At the =
same
> + * time, we need to mark it as SC_STATUS_FREEABLE to indicate to the
> + * nfsd4_free_stateid() function that this stateid has already been adde=
d
> + * to the cl_revoked list and that nfsd4_free_stateid() is now responsib=
le
> + * for removing it from the list. Inspection of where the delegation sta=
te
> + * in the revocation process is protected by the clp->cl_lock.
> + */
>  static void revoke_delegation(struct nfs4_delegation *dp)
>  {
>  	struct nfs4_client *clp =3D dp->dl_stid.sc_client;
> =20
>  	WARN_ON(!list_empty(&dp->dl_recall_lru));
> +	WARN_ON_ONCE(!(dp->dl_stid.sc_status &
> +            (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)));
> =20
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
> =20
> -	if (dp->dl_stid.sc_status &
> -	    (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)) {
> -		spin_lock(&clp->cl_lock);
> -		refcount_inc(&dp->dl_stid.sc_count);
> -		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> -		spin_unlock(&clp->cl_lock);
> +	spin_lock(&clp->cl_lock);
> +	if (dp->dl_stid.sc_status & SC_STATUS_FREED) {
> +		list_del_init(&dp->dl_recall_lru);
> +		goto out;
>  	}
> +	list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> +	dp->dl_stid.sc_status |=3D SC_STATUS_FREEABLE;
> +out:
> +	spin_unlock(&clp->cl_lock);
>  	destroy_unhashed_deleg(dp);
>  }
> =20
> @@ -1772,6 +1798,7 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
>  					mutex_unlock(&stp->st_mutex);
>  					break;
>  				case SC_TYPE_DELEG:
> +					refcount_inc(&stid->sc_count);
>  					dp =3D delegstateid(stid);
>  					spin_lock(&state_lock);
>  					if (!unhash_delegation_locked(
> @@ -6606,6 +6633,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> +		refcount_inc(&dp->dl_stid.sc_count);
>  		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
> @@ -7218,7 +7246,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>  			s->sc_status |=3D SC_STATUS_CLOSED;
>  			spin_unlock(&s->sc_lock);
>  			dp =3D delegstateid(s);
> -			list_del_init(&dp->dl_recall_lru);
> +			if (s->sc_status & SC_STATUS_FREEABLE)
> +				list_del_init(&dp->dl_recall_lru);
> +			s->sc_status |=3D SC_STATUS_FREED;
>  			spin_unlock(&cl->cl_lock);
>  			nfs4_put_stid(s);
>  			ret =3D nfs_ok;
> @@ -7548,7 +7578,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
>  	if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
> =20
> -	status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, =
nn);
> +	status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STAT=
US_REVOKED|SC_STATUS_FREEABLE, &s, nn);
>  	if (status)
>  		goto out;
>  	dp =3D delegstateid(s);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 6351e6eca7cc..cc00d6b64b88 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -114,6 +114,8 @@ struct nfs4_stid {
>  /* For a deleg stateid kept around only to process free_stateid's: */
>  #define SC_STATUS_REVOKED	BIT(1)
>  #define SC_STATUS_ADMIN_REVOKED	BIT(2)
> +#define SC_STATUS_FREEABLE	BIT(3)
> +#define SC_STATUS_FREED		BIT(4)
>  	unsigned short		sc_status;
> =20
>  	struct list_head	sc_cp_list;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

