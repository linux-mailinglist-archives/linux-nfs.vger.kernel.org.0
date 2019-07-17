Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578436C2B2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 23:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfGQVkh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 17:40:37 -0400
Received: from fieldses.org ([173.255.197.46]:59358 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfGQVkh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 17:40:37 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F2971E29; Wed, 17 Jul 2019 17:40:36 -0400 (EDT)
Date:   Wed, 17 Jul 2019 17:40:36 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/8] NFSD add ca_source_server<> to COPY
Message-ID: <20190717214036.GN24608@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-3-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-3-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:23:46PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Decode the ca_source_server list that's sent but only use the
> first one. Presence of non-zero list indicates an "inter" copy.
> 
> Signed-off-by: Andy Adamson <andros@netapp.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4xdr.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/xdr4.h    | 12 +++++----
>  2 files changed, 80 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 52c4f6d..15f53bb 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -40,6 +40,7 @@
>  #include <linux/utsname.h>
>  #include <linux/pagemap.h>
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/addr.h>
>  
>  #include "idmap.h"
>  #include "acl.h"
> @@ -1744,11 +1745,58 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
>  	DECODE_TAIL;
>  }
>  
> +static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
> +				      struct nl4_server *ns)
> +{
> +	DECODE_HEAD;
> +	struct nfs42_netaddr *naddr;
> +
> +	READ_BUF(4);
> +	ns->nl4_type = be32_to_cpup(p++);
> +
> +	/* currently support for 1 inter-server source server */
> +	switch (ns->nl4_type) {
> +	case NL4_NAME:
> +	case NL4_URL:
> +		READ_BUF(4);
> +		ns->u.nl4_str_sz = be32_to_cpup(p++);
> +		if (ns->u.nl4_str_sz > NFS4_OPAQUE_LIMIT)
> +			goto xdr_error;
> +
> +		READ_BUF(ns->u.nl4_str_sz);
> +		COPYMEM(ns->u.nl4_str,
> +			ns->u.nl4_str_sz);
> +		break;

Do we actually have plans to use this case?  If not, it's probably not
worth saving these fields.

--b.

> +	case NL4_NETADDR:
> +		naddr = &ns->u.nl4_addr;
> +
> +		READ_BUF(4);
> +		naddr->netid_len = be32_to_cpup(p++);
> +		if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
> +			goto xdr_error;
> +
> +		READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
> +		COPYMEM(naddr->netid, naddr->netid_len);
> +
> +		naddr->addr_len = be32_to_cpup(p++);
> +		if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
> +			goto xdr_error;
> +
> +		READ_BUF(naddr->addr_len);
> +		COPYMEM(naddr->addr, naddr->addr_len);
> +		break;
> +	default:
> +		goto xdr_error;
> +	}
> +	DECODE_TAIL;
> +}
> +
>  static __be32
>  nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
>  {
>  	DECODE_HEAD;
> -	unsigned int tmp;
> +	struct nl4_server *ns_dummy;
> +	int i, count;
>  
>  	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
>  	if (status)
> @@ -1763,8 +1811,31 @@ static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, str
>  	p = xdr_decode_hyper(p, &copy->cp_count);
>  	p++; /* ca_consecutive: we always do consecutive copies */
>  	copy->cp_synchronous = be32_to_cpup(p++);
> -	tmp = be32_to_cpup(p); /* Source server list not supported */
> +	count = be32_to_cpup(p++);
>  
> +	copy->cp_intra = false;
> +	if (count == 0) { /* intra-server copy */
> +		copy->cp_intra = true;
> +		goto intra;
> +	}
> +
> +	/* decode all the supplied server addresses but use first */
> +	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
> +	if (status)
> +		return status;
> +
> +	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
> +	if (ns_dummy == NULL)
> +		return nfserrno(-ENOMEM);
> +	for (i = 0; i < count - 1; i++) {
> +		status = nfsd4_decode_nl4_server(argp, ns_dummy);
> +		if (status) {
> +			kfree(ns_dummy);
> +			return status;
> +		}
> +	}
> +	kfree(ns_dummy);
> +intra:
>  	DECODE_TAIL;
>  }
>  
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index feeb6d4..513c9ff 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -516,11 +516,13 @@ struct nfsd42_write_res {
>  
>  struct nfsd4_copy {
>  	/* request */
> -	stateid_t	cp_src_stateid;
> -	stateid_t	cp_dst_stateid;
> -	u64		cp_src_pos;
> -	u64		cp_dst_pos;
> -	u64		cp_count;
> +	stateid_t		cp_src_stateid;
> +	stateid_t		cp_dst_stateid;
> +	u64			cp_src_pos;
> +	u64			cp_dst_pos;
> +	u64			cp_count;
> +	struct nl4_server	cp_src;
> +	bool			cp_intra;
>  
>  	/* both */
>  	bool		cp_synchronous;
> -- 
> 1.8.3.1
