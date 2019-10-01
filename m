Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9FC4227
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJAU7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 16:59:01 -0400
Received: from fieldses.org ([173.255.197.46]:39824 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfJAU7B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 16:59:01 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 08229150D; Tue,  1 Oct 2019 16:59:00 -0400 (EDT)
Date:   Tue, 1 Oct 2019 16:59:00 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 15/19] NFSD add COPY_NOTIFY operation
Message-ID: <20191001205900.GB4926@fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-16-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916211353.18802-16-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 16, 2019 at 05:13:49PM -0400, Olga Kornievskaia wrote:
> @@ -2914,7 +2983,8 @@ static bool client_has_state(struct nfs4_client *clp)
>  #endif
>  		|| !list_empty(&clp->cl_delegations)
>  		|| !list_empty(&clp->cl_sessions)
> -		|| !list_empty(&clp->async_copies);
> +		|| !list_empty(&clp->async_copies)
> +		|| client_has_copy_notifies(clp);

Sorry, remind me--how is the copy_notify stateid cleaned up?  Is it just
timed out by the laundromat thread, or is our client destroying it when
the copy is done?

I'm just wondering if this can result in NFSERR_CLID_INUSE just because
a copy was done recently.

--b.

>  }
>  
>  static __be32 copy_impl_id(struct nfs4_client *clp,
> @@ -5192,6 +5262,9 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>  	struct list_head *pos, *next, reaplist;
>  	time_t cutoff = get_seconds() - nn->nfsd4_lease;
>  	time_t t, new_timeo = nn->nfsd4_lease;
> +	struct nfs4_cpntf_state *cps;
> +	copy_stateid_t *cps_t;
> +	int i;
>  
>  	dprintk("NFSD: laundromat service - starting\n");
>  
> @@ -5202,6 +5275,17 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
>  	dprintk("NFSD: end of grace period\n");
>  	nfsd4_end_grace(nn);
>  	INIT_LIST_HEAD(&reaplist);
> +
> +	spin_lock(&nn->s2s_cp_lock);
> +	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> +		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> +		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
> +				!time_after((unsigned long)cps->cpntf_time,
> +				(unsigned long)cutoff))
> +			_free_cpntf_state_locked(nn, cps);
> +	}
> +	spin_unlock(&nn->s2s_cp_lock);
> +
>  	spin_lock(&nn->client_lock);
>  	list_for_each_safe(pos, next, &nn->client_lru) {
>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> @@ -5577,6 +5661,24 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  out:
>  	return status;
>  }
> +static void
> +_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
> +{
> +	WARN_ON_ONCE(cps->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID);
> +	if (!refcount_dec_and_test(&cps->cp_stateid.sc_count))
> +		return;
> +	list_del(&cps->cp_list);
> +	idr_remove(&nn->s2s_cp_stateids,
> +		   cps->cp_stateid.stid.si_opaque.so_id);
> +	kfree(cps);
> +}
> +
> +void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
> +{
> +	spin_lock(&nn->s2s_cp_lock);
> +	_free_cpntf_state_locked(nn, cps);
> +	spin_unlock(&nn->s2s_cp_lock);
> +}
>  
>  /*
>   * Checks for stateid operations
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index d9e7cbd..967b937 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -56,6 +56,14 @@
>  	stateid_opaque_t        si_opaque;
>  } stateid_t;
>  
> +typedef struct {
> +	stateid_t		stid;
> +#define NFS4_COPY_STID 1
> +#define NFS4_COPYNOTIFY_STID 2
> +	unsigned char		sc_type;
> +	refcount_t		sc_count;
> +} copy_stateid_t;
> +
>  #define STATEID_FMT	"(%08x/%08x/%08x/%08x)"
>  #define STATEID_VAL(s) \
>  	(s)->si_opaque.so_clid.cl_boot, \
> @@ -96,6 +104,7 @@ struct nfs4_stid {
>  #define NFS4_REVOKED_DELEG_STID 16
>  #define NFS4_CLOSED_DELEG_STID 32
>  #define NFS4_LAYOUT_STID 64
> +	struct list_head	sc_cp_list;
>  	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
> @@ -104,6 +113,17 @@ struct nfs4_stid {
>  	void			(*sc_free)(struct nfs4_stid *);
>  };
>  
> +/* Keep a list of stateids issued by the COPY_NOTIFY, associate it with the
> + * parent OPEN/LOCK/DELEG stateid.
> + */
> +struct nfs4_cpntf_state {
> +	copy_stateid_t		cp_stateid;
> +	struct list_head	cp_list;	/* per parent nfs4_stid */
> +	stateid_t		cp_p_stateid;	/* copy of parent's stateid */
> +	clientid_t		cp_p_clid;	/* copy of parent's clid */
> +	time_t			cpntf_time;	/* last time stateid used */
> +};
> +
>  /*
>   * Represents a delegation stateid. The nfs4_client holds references to these
>   * and they are put when it is being destroyed or when the delegation is
> @@ -624,8 +644,10 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		     struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
> -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> -void nfs4_free_cp_state(struct nfsd4_copy *copy);
> +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> +void nfs4_free_copy_state(struct nfsd4_copy *copy);
> +struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
> +			struct nfs4_stid *p_stid);
>  void nfs4_unhash_stid(struct nfs4_stid *s);
>  void nfs4_put_stid(struct nfs4_stid *s);
>  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
> @@ -655,6 +677,8 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
>  extern void nfs4_put_copy(struct nfsd4_copy *copy);
>  extern struct nfsd4_copy *
>  find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
> +extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
> +				 struct nfs4_cpntf_state *cps);
>  static inline void get_nfs4_file(struct nfs4_file *fi)
>  {
>  	refcount_inc(&fi->fi_ref);
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 8231fe0..2937e06 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -542,7 +542,7 @@ struct nfsd4_copy {
>  	struct nfsd_file        *nf_src;
>  	struct nfsd_file        *nf_dst;
>  
> -	stateid_t		cp_stateid;
> +	copy_stateid_t		cp_stateid;
>  
>  	struct list_head	copies;
>  	struct task_struct	*copy_task;
> -- 
> 1.8.3.1
