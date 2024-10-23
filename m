Return-Path: <linux-nfs+bounces-7382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A109AC966
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2343B214C2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A93130E58;
	Wed, 23 Oct 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzlmjCMi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3749652
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684121; cv=none; b=tXc2TSGUy65XNWGvj5LLKDUGYLkTu+oQwhjvll5xYNHxwzOlzs6YEBsxpsteqd0Y40DaoBA6+EUOux++C/8w2VO0zo8dKsLbWbLk/R2OMMXzB/ZvJ/mWF9WozBg0gqQCtVEwxjlMzUb3H/H2a5TBdoiWW/jrZXa+CRKcji17c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684121; c=relaxed/simple;
	bh=i8nmOIehxBiV6FzMUwrviraDibSt3hqDBl4NAGJb274=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rc9ubqxn6/uy5nJv6EJZPKHtR7uMod3rdW7gHXdUlDKpPcJdIMoGoxUzDZemHT8rRPIPeYKyky+G2AO/fQM0TzJJHe0clxTnoEeVLTVUueah9pxjF9tUgIjflmGSQQ7RC36vgvwJD9TdYRs0YBs6H3rt2qSKczC0a/4kBPFrPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzlmjCMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FDAC4CECD;
	Wed, 23 Oct 2024 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684120;
	bh=i8nmOIehxBiV6FzMUwrviraDibSt3hqDBl4NAGJb274=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FzlmjCMiMxB0gsmwX5a5hDnnLL1/L20kdT6LUPzFUqbsnAL+ZPv2rnaR62Xvv+eIs
	 7vWfQQLjSISe1vwOpQpCxEiW85XKovL4tOSU2wQZGje9g1BUF9nQ/fHiihno3YppjG
	 aFR+6Wqao7OUPt09kIfHWalHV3TYg3zTUSS3xhSDBFFJ2W2M2hEes2anDgwzpKjNYz
	 YiHhbGDqK2/yd/CsUc+ZCRoA5zKyLMM4WcjW07j39skKEsIrpBHHZ9tQqbXfsquRZn
	 mH++aVNFqhoZEeAJ9LZnkwD/QDGhwvJ7kY95tAoXjlLwN77pDiOQYr9kM/BdSkytck
	 oCr3+SSqHuB1g==
Message-ID: <534a72c76b630b01d33cf0b5742952cc4b9b3614.camel@kernel.org>
Subject: Re: [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 23 Oct 2024 07:48:38 -0400
In-Reply-To: <20241023024222.691745-4-neilb@suse.de>
References: <20241023024222.691745-1-neilb@suse.de>
	 <20241023024222.691745-4-neilb@suse.de>
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

On Wed, 2024-10-23 at 13:37 +1100, NeilBrown wrote:
> Currently per-client DRC slot limits (for v4.1+) are calculated when the
> client connects, and they are left unchanged.  So earlier clients can
> get a larger share when memory is tight.
>=20
> The heuristic for choosing a number includes the number of configured
> server threads.  This is problematic for 2 reasons.
> 1/ sv_nrthreads is different in different net namespaces, but the
>    memory allocation is global across all namespaces.  So different
>    namespaces get treated differently without good reason.
> 2/ a future patch will auto-configure number of threads based on
>    load so that there will be no need to preconfigure a number.  This wil=
l
>    make the current heuristic even more arbitrary.
>=20
> NFSv4.1 allows the number of slots to be varied dynamically - in the
> reply to each SEQUENCE op.  With this patch we provide a provisional
> upper limit in the EXCHANGE_ID reply which might end up being too big,
> and adjust it with each SEQUENCE reply.
>=20
> The goal for when memory is tight is to allow each client to have a
> similar number of slots.  So clients that ask for larger slots get more
> memory.   This may not be ideal.  It could be changed later.
>=20
> So we track the sum of the slot sizes of all active clients, and share
> memory out based on the ratio of the slot size for a given client with
> the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
> did in the EXCHANGE_ID reply.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++---------------------
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsd.h      |  6 +++-
>  fs/nfsd/nfssvc.c    |  7 ++--
>  fs/nfsd/state.h     |  2 +-
>  fs/nfsd/xdr4.h      |  2 --
>  6 files changed, 56 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ca6b5b52f77d..834e9aa12b82 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel=
_attrs *ca)
>  }
> =20
>  /*
> - * XXX: If we run out of reserved DRC memory we could (up to a point)
> - * re-negotiate active sessions and reduce their slot usage to make
> - * room for new connections. For now we just fail the create session.
> + * When a client connects it gets a max_requests number that would allow
> + * it to use 1/8 of the memory we think can reasonably be used for the D=
RC.
> + * Later in response to SEQUENCE operations we further limit that when t=
here
> + * are more than 8 concurrent clients.
>   */
> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd=
_net *nn)
> +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  {
>  	u32 slotsize =3D slot_bytes(ca);
>  	u32 num =3D ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
> +	unsigned long avail;
> =20
>  	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> -		total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> -		/* We have handed out more space than we chose in
> -		 * set_max_drc() to allow.  That isn't really a
> -		 * problem as long as that doesn't make us think we
> -		 * have lots more due to integer overflow.
> -		 */
> -		total_avail =3D 0;
> -	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> =20
> -	avail =3D clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num =3D min_t(int, num, avail / slotsize);
> -	num =3D max_t(int, num, 1);
> -	nfsd_drc_mem_used +=3D num * slotsize;
> +	avail =3D min(NFSD_MAX_MEM_PER_SESSION,
> +		    nfsd_drc_max_mem / 8);
> +
> +	num =3D clamp_t(int, num, 1, avail / slotsize);
> +
> +	nfsd_drc_slotsize_sum +=3D slotsize;
> +
>  	spin_unlock(&nfsd_drc_lock);
> =20
>  	return num;
> @@ -1957,10 +1939,33 @@ static void nfsd4_put_drc_mem(struct nfsd4_channe=
l_attrs *ca)
>  	int slotsize =3D slot_bytes(ca);
> =20
>  	spin_lock(&nfsd_drc_lock);
> -	nfsd_drc_mem_used -=3D slotsize * ca->maxreqs;
> +	nfsd_drc_slotsize_sum -=3D slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  }
> =20
> +/*
> + * Report the number of slots that we would like the client to limit
> + * itself to.  When the number of clients is large, we start sharing
> + * memory so all clients get the same number of slots.
> + */
> +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
> +{
> +	u32 slotsize =3D slot_bytes(&session->se_fchannel);
> +	unsigned long avail;
> +	unsigned long slotsize_sum =3D READ_ONCE(nfsd_drc_slotsize_sum);
> +
> +	if (slotsize_sum < slotsize)
> +		slotsize_sum =3D slotsize;
> +
> +	/* Find our share of avail mem across all active clients,
> +	 * then limit to 1/8 of total, and configured max
> +	 */
> +	avail =3D min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
> +		     nfsd_drc_max_mem / 8,
> +		     NFSD_MAX_MEM_PER_SESSION);
> +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
> +}
> +
>  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *f=
attrs,
>  					   struct nfsd4_channel_attrs *battrs)
>  {
> @@ -3735,7 +3740,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
>  	 * Note that we always allow at least one slot, because our
>  	 * accounting is soft and provides no guarantees either way.
>  	 */
> -	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> +	ca->maxreqs =3D nfsd4_get_drc_mem(ca);
> =20
>  	return nfs_ok;
>  }
> @@ -4229,10 +4234,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
>  	slot =3D session->se_slots[seq->slotid];
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> =20
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots =3D session->se_fchannel.maxreqs;
> +	/* Negotiate number of slots: set the target, and use the
> +	 * same for max as long as it doesn't decrease the max
> +	 * (that isn't allowed).
> +	 */
> +	seq->target_maxslots =3D nfsd4_get_drc_slots(session);
> +	seq->maxslots =3D max(seq->maxslots, seq->target_maxslots);
> =20
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3..e4e706872e54 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *res=
p, __be32 nfserr,
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr =3D nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4b56ba1e8e48..33c9db3ee8b6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_ve=
rsion3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
>  extern unsigned long		nfsd_drc_max_mem;
> -extern unsigned long		nfsd_drc_mem_used;
> +/* Storing the sum of the slot sizes for all active clients (across
> + * all net-namespaces) allows a share of total available memory to
> + * be allocaed to each client based on its slot size.

nit: "allocated"

> + */
> +extern unsigned long		nfsd_drc_slotsize_sum;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> =20
>  extern const struct seq_operations nfs_exports_op;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..e596eb5d10db 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
>   */
>  DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
> -unsigned long	nfsd_drc_mem_used;
> +unsigned long	nfsd_drc_slotsize_sum;
> =20
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] =3D {
> @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>   */
>  static void set_max_drc(void)
>  {
> +	if (nfsd_drc_max_mem)
> +		return;
> +
>  	#define NFSD_DRC_SIZE_SHIFT	7

Not a comment on your patch, per-se, but, it would be nice to document
the above constant. 44d8660d3bb0a just says:

    To prevent a few CREATE_SESSIONs from consuming all of memory we set an
    upper limit based on nr_free_buffer_pages().  1/2^10 has been too
    limiting in practice; 1/2^7 is still less than one percent.

So I guess that's 1/128 of the available free pages? Unfortunately,
that commit doesn't spell out why that's the magical ratio.

>  	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
>  					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> -	nfsd_drc_mem_used =3D 0;
> +	nfsd_drc_slotsize_sum =3D 0;
>  	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>  }
> =20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 79c743c01a47..fe71ae3c577b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(st=
ruct nfs4_stid *s)
>  /* Maximum number of slots per session. 160 is useful for long haul TCP =
*/
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
>  /* Maximum  session per slot cache size */
> -#define NFSD_SLOT_CACHE_SIZE		2048
> +#define NFSD_SLOT_CACHE_SIZE		2048UL
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>  #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
>  #define NFSD_MAX_MEM_PER_SESSION  \
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a21a7662e03..71b87190a4a6 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -575,9 +575,7 @@ struct nfsd4_sequence {
>  	u32			slotid;			/* request/response */
>  	u32			maxslots;		/* request/response */
>  	u32			cachethis;		/* request */
> -#if 0
>  	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>  	u32			status_flags;		/* response */
>  };
> =20

Your rationale and new algorithm for this seems sound.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

