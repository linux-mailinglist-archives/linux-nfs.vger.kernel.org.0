Return-Path: <linux-nfs+bounces-1235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C778363BA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E179F1C225AC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9783A1CF;
	Mon, 22 Jan 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx/Bu9p4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D091E4A9
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927991; cv=none; b=quszA+7CbVoAfR6DloVS/A7DXkJhcYLSTDOzzXXPC7ec+MjOOMEj+TTL1r8gnuJjWnRJAkOdzWBWfriODlZotuV1RGIGPqN5Mitp64qSPzAR5Gs7LqzxchHaUIxlitqAAIlvSokBvZ+pBeFUENtDShyapj1ERl0i9VSKKV0jxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927991; c=relaxed/simple;
	bh=Gj+MOI9mUJkMjww2rZFG0jGXxyKjljVkqv9J2JfskQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qn8Wb4PHk4xrjdTzl3n+sGXZQkF5sgIdIkZRWoDQ0tMe2JC2VUNMffYSca29/89ULGJHRUYAi4safbODQAl27/gQw/1Pq65+2WdPlknRaRPZNZigcY4FeHa/Q11rH7YYrSsnbdWPac+OvU4319sOKzFD0LYsRwwbS1/2my3+Hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx/Bu9p4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB1DC433C7;
	Mon, 22 Jan 2024 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705927991;
	bh=Gj+MOI9mUJkMjww2rZFG0jGXxyKjljVkqv9J2JfskQY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gx/Bu9p42UPimwv70a8xXZ5VkTMEsJauben4HHw+N6CC0T6lc/yMcTR5ZYbv9Kaxs
	 mRE6XVp6sHFTMRnVWv9sjhu7U4ri7GBpJtq0fAAZuZ6tCnNfFMvy2XN+s2R1tyjeQG
	 GCbR9geer8jWPpe7il4nBCs9VaI/cs+YkKA2qIOJE/fX1dj/rp7At8ttnvI9I7OyZG
	 6XeuacYf3TOMrex8WsVkK4vp+Hr7c7XYb/89nggONwdK7DOPaHXPNI7S61rFkGmHVc
	 spxvSQBUiQ5jOaeuUy3KnC8E9dol8OcYgNMiCX1l8CF/Q9k/IFgpC0kdUMmT02+jWw
	 w4npJBRxSORJA==
Message-ID: <df56708aced4ec40e62592ed055ba0075b429d8f.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>, Tom Talpey
	 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 22 Jan 2024 07:53:09 -0500
In-Reply-To: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
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

On Mon, 2024-01-22 at 14:58 +1100, NeilBrown wrote:
> The test on so_count in nfsd4_release_lockowner() is nonsense and
> harmful.  Revert to using check_for_locks(), changing that to not sleep.
>=20
> First: harmful.
> As is documented in the kdoc comment for nfsd4_release_lockowner(), the
> test on so_count can transiently return a false positive resulting in a
> return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
> clearly a protocol violation and with the Linux NFS client it can cause
> incorrect behaviour.
>=20
> If NFS4_RELEASE_LOCKOWNER is sent while some other thread is still
> processing a LOCK request which failed because, at the time that request
> was received, the given owner held a conflicting lock, then the nfsd
> thread processing that LOCK request can hold a reference (conflock) to
> the lock owner that causes nfsd4_release_lockowner() to return an
> incorrect error.
>=20
> The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
> never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks, so
> it knows that the error is impossible.  It assumes the lock owner was in
> fact released so it feels free to use the same lock owner identifier in
> some later locking request.
>=20
> When it does reuse a lock owner identifier for which a previous RELEASE
> failed, it will naturally use a lock_seqid of zero.  However the server,
> which didn't release the lock owner, will expect a larger lock_seqid and
> so will respond with NFS4ERR_BAD_SEQID.
>=20
> So clearly it is harmful to allow a false positive, which testing
> so_count allows.
>=20
> The test is nonsense because ... well... it doesn't mean anything.
>=20
> so_count is the sum of three different counts.
> 1/ the set of states listed on so_stateids
> 2/ the set of active vfs locks owned by any of those states
> 3/ various transient counts such as for conflicting locks.
>=20
> When it is tested against '2' it is clear that one of these is the
> transient reference obtained by find_lockowner_str_locked().  It is not
> clear what the other one is expected to be.
>=20
> In practice, the count is often 2 because there is precisely one state
> on so_stateids.  If there were more, this would fail.
>=20
> It my testing I see two circumstances when RELEASE_LOCKOWNER is called.
> In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results in
> all the lock states being removed, and so the lockowner being discarded
> (it is removed when there are no more references which usually happens
> when the lock state is discarded).  When nfsd4_release_lockowner() finds
> that the lock owner doesn't exist, it returns success.
>=20
> The other case shows an so_count of '2' and precisely one state listed
> in so_stateid.  It appears that the Linux client uses a separate lock
> owner for each file resulting in one lock state per lock owner, so this
> test on '2' is safe.  For another client it might not be safe.
>=20
> So this patch changes check_for_locks() to use the (newish)
> find_any_file_locked() so that it doesn't take a reference on the
> nfs4_file and so never calls nfsd_file_put(), and so never sleeps.  With
> this check is it safe to restore the use of check_for_locks() rather
> than testing so_count against the mysterious '2'.
>=20
> Fixes: ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_locko=
wner()")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..6dc6340e2852 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7911,14 +7911,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4=
_lockowner *lowner)
>  {
>  	struct file_lock *fl;
>  	int status =3D false;
> -	struct nfsd_file *nf =3D find_any_file(fp);
> +	struct nfsd_file *nf;
>  	struct inode *inode;
>  	struct file_lock_context *flctx;
> =20
> +	spin_lock(&fp->fi_lock);
> +	nf =3D find_any_file_locked(fp);
>  	if (!nf) {
>  		/* Any valid lock stateid should have some sort of access */
>  		WARN_ON_ONCE(1);
> -		return status;
> +		goto out;
>  	}
> =20
>  	inode =3D file_inode(nf->nf_file);
> @@ -7934,7 +7936,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_l=
ockowner *lowner)
>  		}
>  		spin_unlock(&flctx->flc_lock);
>  	}
> -	nfsd_file_put(nf);
> +out:
> +	spin_unlock(&fp->fi_lock);
>  	return status;
>  }
> =20

^^^
Nice cleanup here! Not having to take a reference in this path is great.

> @@ -7944,10 +7947,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_=
lockowner *lowner)
>   * @cstate: NFSv4 COMPOUND state
>   * @u: RELEASE_LOCKOWNER arguments
>   *
> - * The lockowner's so_count is bumped when a lock record is added
> - * or when copying a conflicting lock. The latter case is brief,
> - * but can lead to fleeting false positives when looking for
> - * locks-in-use.
> + * Check if theree are any locks still held and if not - free the lockow=
ner
> + * and any lock state that is owned.
>   *
>   * Return values:
>   *   %nfs_ok: lockowner released or not found
> @@ -7983,10 +7984,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>  		spin_unlock(&clp->cl_lock);
>  		return nfs_ok;
>  	}
> -	if (atomic_read(&lo->lo_owner.so_count) !=3D 2) {
> -		spin_unlock(&clp->cl_lock);
> -		nfs4_put_stateowner(&lo->lo_owner);
> -		return nfserr_locks_held;
> +
> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
> +		if (check_for_locks(stp->st_stid.sc_file, lo)) {
> +			spin_unlock(&clp->cl_lock);
> +			nfs4_put_stateowner(&lo->lo_owner);
> +			return nfserr_locks_held;
> +		}
>  	}
>  	unhash_lockowner_locked(lo);
>  	while (!list_empty(&lo->lo_owner.so_stateids)) {


Anytime I see codepaths checking reference counts for specific values,
that's always a red flag to me, and I've hated this particular so_count
check since we added it several years ago.

This is a much better solution.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

