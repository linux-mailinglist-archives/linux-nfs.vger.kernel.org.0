Return-Path: <linux-nfs+bounces-2109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711686B637
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D95B1C21516
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5033FBB0;
	Wed, 28 Feb 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tol+y/yf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C507D3FBA3
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142024; cv=none; b=NUaCya5axlQ5arLfZhnbzsgjD0/zd86dsmNFTauhLzXqWQBNpkxwBzoHHs8Ab+fvs/2QRU/OI9Bvf3RqVpgJzotM897+7RMd+U2MvLKk5LzSyQUumRwWSvt9m5+bg1TJlnD6BBun5/ybBO4wnaV20rRaHs30IYYA82IgXqktqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142024; c=relaxed/simple;
	bh=+Y4pXGNbUtmCde6v5RqLCHahs4SfJ0FfiGMViLPxNVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yqm103yxWK3wgsO9NkKSltRbfGBgBhIt3BSYbLtUeYawuG/nUsGnSZCpaWp15d2TS62Fhh3XhOPCAbU0EpJSEwsE0K4DRYaDEYI4pTab5i+1LMn2zokc+Mh6d+2tvjoVWA7Xmo3wrSEkPckwA3C+44F1ta1yH6w1SUY7JL8zngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tol+y/yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B48C433F1;
	Wed, 28 Feb 2024 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709142024;
	bh=+Y4pXGNbUtmCde6v5RqLCHahs4SfJ0FfiGMViLPxNVQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tol+y/yfvWygyBfSpPPZjiibm71tdmjQRpCfFAPxgSIFq0EncUuCfcBLrAe8iOfAt
	 fJ2HNDqHB3rOh7wRZ3s9ukaWipQzz7PMWfyfcmRtSIZipG5Fdj1tvH2PrbhFa2pYbA
	 z1sv33N4/BEDVRKT+eiYWoskSgUHExOuk0FYniAcPKomtdYBotaalvy/A+JVQmg4/D
	 MtFK49+vz7UBBtQgqWuS8nF+jrGhbRZ12iOnbcU1GfIY0+Y0Nx7I7Di1FhG3H07hQT
	 mep9BEh/NCiVThLbu5li05h89HQEXrzymzntgmV/VdBVKazu3rmJsghHnIYFlCzjxs
	 HwzoD+gGdYf8A==
Message-ID: <6926f1be34dfb66fc5395a7465c2f3970ac7652a.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, "J.
	Bruce Fields" <bfields@fieldses.org>
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
	Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Date: Wed, 28 Feb 2024 12:40:22 -0500
In-Reply-To: <170546328406.23031.11217818844350800811@noble.neil.brown.name>
References: <170546328406.23031.11217818844350800811@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: multipart/mixed; boundary="=-cb5gXYureLGrx5xcEcvo"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-cb5gXYureLGrx5xcEcvo
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-17 at 14:48 +1100, NeilBrown wrote:
> move_to_close_lru() is currently called with ->st_mutex and .rp_mutex hel=
d.
> This can lead to a deadlock as move_to_close_lru() waits for sc_count to
> drop to 2, and some threads holding a reference might be waiting for eith=
er
> mutex.  These references will never be dropped so sc_count will never
> reach 2.
>=20
> There can be no harm in dropping ->st_mutex to before
> move_to_close_lru() because the only place that takes the mutex is
> nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
> NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.
>=20
> Similarly dropping .rp_mutex is safe after the state is closed and so
> no longer usable.  Another way to look at this is that nothing
> significant happens between when nfsd4_close() now calls
> nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
> nfsd4_cstate_clear_replay() a little later.
>=20
> See also
>  https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
> where this problem was raised but not successfully resolved.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 40415929e2ae..0850191f9920 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  	return status;
>  }
> =20
> -static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
> +static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>  {
>  	struct nfs4_client *clp =3D s->st_stid.sc_client;
>  	bool unhashed;
> @@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_=
ol_stateid *s)
>  		list_for_each_entry(stp, &reaplist, st_locks)
>  			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>  		free_ol_stateid_reaplist(&reaplist);
> +		return false;
>  	} else {
>  		spin_unlock(&clp->cl_lock);
>  		free_ol_stateid_reaplist(&reaplist);
> -		if (unhashed)
> -			move_to_close_lru(s, clp->net);
> +		return unhashed;
>  	}
>  }
> =20
> @@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	struct nfs4_ol_stateid *stp;
>  	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	bool need_move_to_close_list;
> =20
>  	dprintk("NFSD: nfsd4_close on file %pd\n",=20
>  			cstate->current_fh.fh_dentry);
> @@ -7114,8 +7115,17 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  	 */
>  	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
> =20
> -	nfsd4_close_open_stateid(stp);
> +	need_move_to_close_list =3D nfsd4_close_open_stateid(stp);
>  	mutex_unlock(&stp->st_mutex);
> +	if (need_move_to_close_list) {
> +		/* Drop the replay mutex early as move_to_close_lru()
> +		 * can wait for other threads which hold that mutex.
> +		 * This call is idempotent, so that fact that it will
> +		 * be called twice is harmless.
> +		 */
> +		nfsd4_cstate_clear_replay(cstate);
> +		move_to_close_lru(stp, net);
> +	}
> =20
>  	/* v4.1+ suggests that we send a special stateid in here, since the
>  	 * clients should just ignore this anyway. Since this is not useful

There is a recent regression in pynfs test CLOSE12 in Chuck's nfsd-next
branch. In the attached capture, there is an extra 40 bytes on the end
of the CLOSE response in frame 112.

A bisect landed on this patch, though I don't see the cause just yet.

Thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

--=-cb5gXYureLGrx5xcEcvo
Content-Type: application/x-xz; name="nfs.pcap.xz"
Content-Disposition: attachment; filename="nfs.pcap.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==


--=-cb5gXYureLGrx5xcEcvo--

