Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED2635F2
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfGIMeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 08:34:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43603 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIMeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 08:34:03 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so42691050ios.10
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2019 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IaJySz96Qf7ozXmNfZ1p2cfFfbDsdSkcFbtmHelAVrg=;
        b=BmuhC3M6j1dhaNaP/FiL3OyQmhdFAbrQkjHOyas1CW12lopveUDL4/YTvZGzauiWYx
         0he1f/sX+BIarXhOdrzFYT14bP16YZ6AR0F9aHQqclBsne4IpDrmRb2iE/6aV+NCro1Q
         MtZCNA2c4GajQoEMbFyGnOlgGLuEdiWfJwWRxJe4h8HcVjbrtTYbisz/1WgMwcqgZnOQ
         iMID1WOa6c5fUxelLvyg1X0pSACFIsBFRy/GPCB3nsoZEJtWoFn2nkktDr2xiJW4LELE
         8pLFSERzHCO6BVWiHnlaW0u7eGkbkR3aKkju9sn3OmOH3vBhcvaePYPbuWzYnmp19/WH
         qX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IaJySz96Qf7ozXmNfZ1p2cfFfbDsdSkcFbtmHelAVrg=;
        b=dp/x2QAeaqCAxOrpGjknWGv/rSCtQTfJaWkWmKotB8iICkDuYhzruNlMyd1bg1Emx7
         ohcpAVTTlyutB2WV8Th3SvUUgG6Es5CdY5yTgSuonwpM/gdqZriPi9ikRTWtGFZVt42f
         XJdnQw8C35hCnazdeUGUOANlBcAaMeZWEjyZdtZdT0n7cT7xMD69hZGDarFP9Zy0W8TE
         WFyYnoAjoJFRACbuOld9oO8DSQPH1xgEDxFIS3xHmzgEf2hUdu8ePrVhwKKeqTYZiCs1
         WpwClonvLksUwQsLdEqGIZpEg8oB+rq5T3F9VNmUmZFtq+zePlPhS0dOvEQ8QVmZAhm9
         kTsQ==
X-Gm-Message-State: APjAAAUBT+6tHyoFTC+nIf2E9Wsyk60h4XNzADqL5WW3fXrcBSVDluH3
        sRIPoE0Ct0VuJmVFO7SjhJg=
X-Google-Smtp-Source: APXvYqyB+kYP0MzuqfxpJlUNssNM0j7WAXWFc36VM4q4uH6r4AHlH9o3epnciE3OdSb7NZYS9mtTOQ==
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr492112ioh.70.1562675642320;
        Tue, 09 Jul 2019 05:34:02 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.googlemail.com with ESMTPSA id z19sm13487216ioh.12.2019.07.09.05.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:34:01 -0700 (PDT)
Message-ID: <575cff296594929d5aff6925aaaa1493de4c46f7.camel@gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>, bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 09 Jul 2019 08:34:00 -0400
In-Reply-To: <20190708192352.12614-5-olga.kornievskaia@gmail.com>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
         <20190708192352.12614-5-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On Mon, 2019-07-08 at 15:23 -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Introducing the COPY_NOTIFY operation.
> 
> Create a new unique stateid that will keep track of the copy
> state and the upcoming READs that will use that stateid. Keep
> it in the list associated with parent stateid.
> 
> Return single netaddr to advertise to the copy.
> 
> Signed-off-by: Andy Adamson <andros@netapp.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4proc.c  | 71 +++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4state.c | 64 +++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4xdr.c   | 97
> +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/state.h     | 18 ++++++++--
>  fs/nfsd/xdr4.h      | 13 +++++++
>  5 files changed, 247 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index cfd8767..c39fa72 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -37,6 +37,7 @@
>  #include <linux/falloc.h>
>  #include <linux/slab.h>
>  #include <linux/kthread.h>
> +#include <linux/sunrpc/addr.h>
>  
>  #include "idmap.h"
>  #include "cache.h"
> @@ -1033,7 +1034,8 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
> *rqstp, struct svc_fh *fh)
>  static __be32
>  nfsd4_verify_copy(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
>  		  stateid_t *src_stateid, struct file **src,
> -		  stateid_t *dst_stateid, struct file **dst)
> +		  stateid_t *dst_stateid, struct file **dst,
> +		  struct nfs4_stid **stid)
>  {
>  	__be32 status;
>  
> @@ -1050,7 +1052,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
> *rqstp, struct svc_fh *fh)
>  
>  	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate-
> >current_fh,
>  					    dst_stateid, WR_STATE, dst,
> NULL,
> -					    NULL);
> +					    stid);
>  	if (status) {
>  		dprintk("NFSD: %s: couldn't process dst stateid!\n",
> __func__);
>  		goto out_put_src;
> @@ -1081,7 +1083,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst
> *rqstp, struct svc_fh *fh)
>  	__be32 status;
>  
>  	status = nfsd4_verify_copy(rqstp, cstate, &clone-
> >cl_src_stateid, &src,
> -				   &clone->cl_dst_stateid, &dst);
> +				   &clone->cl_dst_stateid, &dst, NULL);
>  	if (status)
>  		goto out;
>  
> @@ -1228,7 +1230,7 @@ static void dup_copy_fields(struct nfsd4_copy
> *src, struct nfsd4_copy *dst)
>  
>  static void cleanup_async_copy(struct nfsd4_copy *copy)
>  {
> -	nfs4_free_cp_state(copy);
> +	nfs4_free_copy_state(copy);
>  	fput(copy->file_dst);
>  	fput(copy->file_src);
>  	spin_lock(&copy->cp_clp->async_lock);
> @@ -1268,7 +1270,7 @@ static int nfsd4_do_async_copy(void *data)
>  
>  	status = nfsd4_verify_copy(rqstp, cstate, &copy-
> >cp_src_stateid,
>  				   &copy->file_src, &copy-
> >cp_dst_stateid,
> -				   &copy->file_dst);
> +				   &copy->file_dst, NULL);
>  	if (status)
>  		goto out;
>  
> @@ -1282,7 +1284,7 @@ static int nfsd4_do_async_copy(void *data)
>  		async_copy = kzalloc(sizeof(struct nfsd4_copy),
> GFP_KERNEL);
>  		if (!async_copy)
>  			goto out;
> -		if (!nfs4_init_cp_state(nn, copy)) {
> +		if (!nfs4_init_copy_state(nn, copy)) {
>  			kfree(async_copy);
>  			goto out;
>  		}
> @@ -1346,6 +1348,42 @@ struct nfsd4_copy *
>  }
>  
>  static __be32
> +nfsd4_copy_notify(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
> +		  union nfsd4_op_u *u)
> +{
> +	struct nfsd4_copy_notify *cn = &u->copy_notify;
> +	__be32 status;
> +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_stid *stid;
> +	struct nfs4_cpntf_state *cps;
> +
> +	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate-
> >current_fh,
> +					&cn->cpn_src_stateid, RD_STATE,
> NULL,
> +					NULL, &stid);
> +	if (status)
> +		return status;
> +
> +	cn->cpn_sec = nn->nfsd4_lease;
> +	cn->cpn_nsec = 0;
> +
> +	status = nfserrno(-ENOMEM);
> +	cps = nfs4_alloc_init_cpntf_state(nn, stid);
> +	if (!cps)
> +		return status;
> +	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid,
> sizeof(stateid_t));
> +
> +	/* For now, only return one server address in cpn_src, the
> +	 * address used by the client to connect to this server.
> +	 */
> +	cn->cpn_src.nl4_type = NL4_NETADDR;
> +	status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
> +				 &cn->cpn_src.u.nl4_addr);
> +	WARN_ON_ONCE(status);
> +
> +	return status;
> +}
> +
> +static __be32
>  nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state
> *cstate,
>  		struct nfsd4_fallocate *fallocate, int flags)
>  {
> @@ -2298,6 +2336,21 @@ static inline u32
> nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
>  		1 /* osr_complete<1> optional 0 for now */) *
> sizeof(__be32);
>  }
>  
> +static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
> +					struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size +
> +		3 /* cnr_lease_time */ +
> +		1 /* We support one cnr_source_server */ +
> +		1 /* cnr_stateid seq */ +
> +		op_encode_stateid_maxsz /* cnr_stateid */ +
> +		1 /* num cnr_source_server*/ +
> +		1 /* nl4_type */ +
> +		1 /* nl4 size */ +
> +		XDR_QUADLEN(NFS4_OPAQUE_LIMIT) /*nl4_loc + nl4_loc_sz
> */)
> +		* sizeof(__be32);
> +}
> +
>  #ifdef CONFIG_NFSD_PNFS
>  static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp,
> struct nfsd4_op *op)
>  {
> @@ -2722,6 +2775,12 @@ static inline u32 nfsd4_seek_rsize(struct
> svc_rqst *rqstp, struct nfsd4_op *op)
>  		.op_name = "OP_OFFLOAD_CANCEL",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> +	[OP_COPY_NOTIFY] = {
> +		.op_func = nfsd4_copy_notify,
> +		.op_flags = OP_MODIFIES_SOMETHING,
> +		.op_name = "OP_COPY_NOTIFY",
> +		.op_rsize_bop = nfsd4_copy_notify_rsize,
> +	},
>  };
>  
>  /**
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 05c0295..2555eb9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -707,6 +707,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct
> nfs4_client *cl, struct kmem_cache *sla
>  	/* Will be incremented before return to client: */
>  	refcount_set(&stid->sc_count, 1);
>  	spin_lock_init(&stid->sc_lock);
> +	INIT_LIST_HEAD(&stid->sc_cp_list);
>  
>  	/*
>  	 * It shouldn't be a problem to reuse an opaque stateid value.
> @@ -726,24 +727,53 @@ struct nfs4_stid *nfs4_alloc_stid(struct
> nfs4_client *cl, struct kmem_cache *sla
>  /*
>   * Create a unique stateid_t to represent each COPY.
>   */
> -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> +static int nfs4_init_cp_state(struct nfsd_net *nn, void *ptr,
> stateid_t *stid)
>  {
>  	int new_id;
>  
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&nn->s2s_cp_lock);
> -	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0,
> GFP_NOWAIT);
> +	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, ptr, 0, 0,
> GFP_NOWAIT);
>  	spin_unlock(&nn->s2s_cp_lock);
>  	idr_preload_end();
>  	if (new_id < 0)
>  		return 0;
> -	copy->cp_stateid.si_opaque.so_id = new_id;
> -	copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
> -	copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> +	stid->si_opaque.so_id = new_id;
> +	stid->si_opaque.so_clid.cl_boot = nn->boot_time;
> +	stid->si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
>  	return 1;
>  }
>  
> -void nfs4_free_cp_state(struct nfsd4_copy *copy)
> +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy
> *copy)
> +{
> +	return nfs4_init_cp_state(nn, copy, &copy->cp_stateid);
> +}
> +
> +struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net
> *nn,
> +						     struct nfs4_stid
> *p_stid)
> +{
> +	struct nfs4_cpntf_state *cps;
> +
> +	cps = kzalloc(sizeof(struct nfs4_cpntf_state), GFP_KERNEL);
> +	if (!cps)
> +		return NULL;
> +	if (!nfs4_init_cp_state(nn, cps, &cps->cp_stateid))
> +		goto out_free;
> +	cps->cp_p_stid = p_stid;
> +	cps->cp_active = false;
> +	cps->cp_timeout = jiffies + (nn->nfsd4_lease * HZ);
> +	INIT_LIST_HEAD(&cps->cp_list);
> +	spin_lock(&nn->s2s_cp_lock);
> +	list_add(&cps->cp_list, &p_stid->sc_cp_list);
> +	spin_unlock(&nn->s2s_cp_lock);
> +
> +	return cps;
> +out_free:
> +	kfree(cps);
> +	return NULL;
> +}
> +
> +void nfs4_free_copy_state(struct nfsd4_copy *copy)
>  {
>  	struct nfsd_net *nn;
>  
> @@ -753,6 +783,27 @@ void nfs4_free_cp_state(struct nfsd4_copy *copy)
>  	spin_unlock(&nn->s2s_cp_lock);
>  }
>  
> +static void nfs4_free_cpntf_statelist(struct net *net, struct
> nfs4_stid *stid)
> +{
> +	struct nfs4_cpntf_state *cps;
> +	struct nfsd_net *nn;
> +
> +	nn = net_generic(net, nfsd_net_id);
> +
> +	might_sleep();
> +
> +	spin_lock(&nn->s2s_cp_lock);
> +	while (!list_empty(&stid->sc_cp_list)) {
> +		cps = list_first_entry(&stid->sc_cp_list,
> +				       struct nfs4_cpntf_state,
> cp_list);
> +		list_del(&cps->cp_list);
> +		idr_remove(&nn->s2s_cp_stateids,
> +			   cps->cp_stateid.si_opaque.so_id);
> +		kfree(cps);
> +	}
> +	spin_unlock(&nn->s2s_cp_lock);
> +}
> +
>  static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct
> nfs4_client *clp)
>  {
>  	struct nfs4_stid *stid;
> @@ -901,6 +952,7 @@ static void block_delegations(struct knfsd_fh
> *fh)
>  	}
>  	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
>  	spin_unlock(&clp->cl_lock);
> +	nfs4_free_cpntf_statelist(clp->net, s);
>  	s->sc_free(s);
>  	if (fp)
>  		put_nfs4_file(fp);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 15f53bb..ed37528 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1847,6 +1847,22 @@ static __be32 nfsd4_decode_nl4_server(struct
> nfsd4_compoundargs *argp,
>  }
>  
>  static __be32
> +nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
> +			 struct nfsd4_copy_notify *cn)
> +{
> +	int status;
> +
> +	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
> +	if (status)
> +		return status;
> +	status = nfsd4_decode_nl4_server(argp, &cn->cpn_dst);

Maybe this could be simplified to "return nfsd4_decode_nl4_server()" ?

> +	if (status)
> +		return status;
> +
> +	return status;
> +}
> +
> +static __be32
>  nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek
> *seek)
>  {
>  	DECODE_HEAD;
> @@ -1947,7 +1963,7 @@ static __be32 nfsd4_decode_nl4_server(struct
> nfsd4_compoundargs *argp,
>  	/* new operations for NFSv4.2 */
>  	[OP_ALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
>  	[OP_COPY]		= (nfsd4_dec)nfsd4_decode_copy,
> -	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_notsupp,
> +	[OP_COPY_NOTIFY]	= (nfsd4_dec)nfsd4_decode_copy_notify,
>  	[OP_DEALLOCATE]		= (nfsd4_dec)nfsd4_decode_fallocate,
>  	[OP_IO_ADVISE]		= (nfsd4_dec)nfsd4_decode_notsupp,
>  	[OP_LAYOUTERROR]	= (nfsd4_dec)nfsd4_decode_notsupp,
> @@ -4336,6 +4352,45 @@ static __be32 nfsd4_encode_readv(struct
> nfsd4_compoundres *resp,
>  }
>  
>  static __be32
> +nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct
> nl4_server *ns)
> +{
> +	struct xdr_stream *xdr = &resp->xdr;
> +	struct nfs42_netaddr *addr;
> +	__be32 *p;
> +
> +	p = xdr_reserve_space(xdr, 4);
> +	*p++ = cpu_to_be32(ns->nl4_type);
> +
> +	switch (ns->nl4_type) {
> +	case NL4_NETADDR:
> +		addr = &ns->u.nl4_addr;
> +
> +		/* netid_len, netid, uaddr_len, uaddr (port included
> +		 * in RPCBIND_MAXUADDRLEN)
> +		 */
> +		p = xdr_reserve_space(xdr,
> +			4 /* netid len */ +
> +			(XDR_QUADLEN(addr->netid_len) * 4) +
> +			4 /* uaddr len */ +
> +			(XDR_QUADLEN(addr->addr_len) * 4));
> +		if (!p)
> +			return nfserr_resource;
> +
> +		*p++ = cpu_to_be32(addr->netid_len);
> +		p = xdr_encode_opaque_fixed(p, addr->netid,
> +					    addr->netid_len);
> +		*p++ = cpu_to_be32(addr->addr_len);
> +		p = xdr_encode_opaque_fixed(p, addr->addr,
> +					addr->addr_len);
> +		break;
> +	default:
> +		WARN_ON(ns->nl4_type != NL4_NETADDR);
> +	}
> +
> +	return 0;
> +}
> +
> +static __be32
>  nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		  struct nfsd4_copy *copy)
>  {
> @@ -4369,6 +4424,44 @@ static __be32 nfsd4_encode_readv(struct
> nfsd4_compoundres *resp,
>  }
>  
>  static __be32
> +nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32
> nfserr,
> +			 struct nfsd4_copy_notify *cn)
> +{
> +	struct xdr_stream *xdr = &resp->xdr;
> +	__be32 *p;
> +
> +	if (nfserr)
> +		return nfserr;
> +
> +	/* 8 sec, 4 nsec */
> +	p = xdr_reserve_space(xdr, 12);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	/* cnr_lease_time */
> +	p = xdr_encode_hyper(p, cn->cpn_sec);
> +	*p++ = cpu_to_be32(cn->cpn_nsec);
> +
> +	/* cnr_stateid */
> +	nfserr = nfsd4_encode_stateid(xdr, &cn->cpn_cnr_stateid);
> +	if (nfserr)
> +		return nfserr;
> +
> +	/* cnr_src.nl_nsvr */
> +	p = xdr_reserve_space(xdr, 4);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	*p++ = cpu_to_be32(1);
> +
> +	nfserr = nfsd42_encode_nl4_server(resp, &cn->cpn_src);

This could be simplified, too: "return nfsd42_encode_nl4_server()" 

Thanks,
Anna

> +	if (nfserr)
> +		return nfserr;
> +
> +	return nfserr;
> +}
> +
> +static __be32
>  nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
>  		  struct nfsd4_seek *seek)
>  {
> @@ -4465,7 +4558,7 @@ static __be32 nfsd4_encode_readv(struct
> nfsd4_compoundres *resp,
>  	/* NFSv4.2 operations */
>  	[OP_ALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_COPY]		= (nfsd4_enc)nfsd4_encode_copy,
> -	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_noop,
> +	[OP_COPY_NOTIFY]	= (nfsd4_enc)nfsd4_encode_copy_notify,
>  	[OP_DEALLOCATE]		= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_IO_ADVISE]		= (nfsd4_enc)nfsd4_encode_noop,
>  	[OP_LAYOUTERROR]	= (nfsd4_enc)nfsd4_encode_noop,
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 5da9cc3..106ed56 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -95,6 +95,7 @@ struct nfs4_stid {
>  #define NFS4_REVOKED_DELEG_STID 16
>  #define NFS4_CLOSED_DELEG_STID 32
>  #define NFS4_LAYOUT_STID 64
> +	struct list_head	sc_cp_list;
>  	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
> @@ -103,6 +104,17 @@ struct nfs4_stid {
>  	void			(*sc_free)(struct nfs4_stid *);
>  };
>  
> +/* Keep a list of stateids issued by the COPY_NOTIFY, associate it
> with the
> + * parent OPEN/LOCK/DELEG stateid.
> + */
> +struct nfs4_cpntf_state {
> +	stateid_t		cp_stateid;
> +	struct list_head	cp_list;	/* per parent nfs4_stid */
> +	struct nfs4_stid	*cp_p_stid;	/* pointer to parent */
> +	bool			cp_active;	/* has the copy
> started */
> +	unsigned long		cp_timeout;	/* copy timeout */
> +};
> +
>  /*
>   * Represents a delegation stateid. The nfs4_client holds references
> to these
>   * and they are put when it is being destroyed or when the
> delegation is
> @@ -614,8 +626,10 @@ __be32 nfsd4_lookup_stateid(struct
> nfsd4_compound_state *cstate,
>  		     struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct
> kmem_cache *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
> -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy
> *copy);
> -void nfs4_free_cp_state(struct nfsd4_copy *copy);
> +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy
> *copy);
> +void nfs4_free_copy_state(struct nfsd4_copy *copy);
> +struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net
> *nn,
> +			struct nfs4_stid *p_stid);
>  void nfs4_unhash_stid(struct nfs4_stid *s);
>  void nfs4_put_stid(struct nfs4_stid *s);
>  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid
> *stid);
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 513c9ff..bade8e5 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -568,6 +568,18 @@ struct nfsd4_offload_status {
>  	u32		status;
>  };
>  
> +struct nfsd4_copy_notify {
> +	/* request */
> +	stateid_t		cpn_src_stateid;
> +	struct nl4_server	cpn_dst;
> +
> +	/* response */
> +	stateid_t		cpn_cnr_stateid;
> +	u64			cpn_sec;
> +	u32			cpn_nsec;
> +	struct nl4_server	cpn_src;
> +};
> +
>  struct nfsd4_op {
>  	int					opnum;
>  	const struct nfsd4_operation *		opdesc;
> @@ -627,6 +639,7 @@ struct nfsd4_op {
>  		struct nfsd4_clone		clone;
>  		struct nfsd4_copy		copy;
>  		struct nfsd4_offload_status	offload_status;
> +		struct nfsd4_copy_notify	copy_notify;
>  		struct nfsd4_seek		seek;
>  	} u;
>  	struct nfs4_replay *			replay;

