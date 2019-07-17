Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755036C272
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGQVNR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 17:13:17 -0400
Received: from fieldses.org ([173.255.197.46]:59344 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfGQVNR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 17:13:17 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0C8991E29; Wed, 17 Jul 2019 17:13:17 -0400 (EDT)
Date:   Wed, 17 Jul 2019 17:13:17 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/8] NFSD fill-in netloc4 structure
Message-ID: <20190717211317.GM24608@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-2-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-2-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:23:45PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> nfs.4 defines nfs42_netaddr structure that represents netloc4.
> 
> Populate needed fields from the sockaddr structure.
> 
> This will be used by flexfiles and 4.2 inter copy
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfsd.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 24187b5..8f4fc50 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -19,6 +19,7 @@
>  #include <linux/sunrpc/svc.h>
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/sunrpc/msg_prot.h>
> +#include <linux/sunrpc/addr.h>
>  
>  #include <uapi/linux/nfsd/debug.h>
>  
> @@ -375,6 +376,37 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
>  
>  extern const u32 nfsd_suppattrs[3][3];
>  
> +static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
> +				    struct nfs42_netaddr *netaddr)
> +{
> +	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
> +	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
> +	unsigned int port;
> +	size_t ret_addr, ret_port;
> +
> +	switch (addr->sa_family) {
> +	case AF_INET:
> +		port = ntohs(sin->sin_port);
> +		sprintf(netaddr->netid, "tcp");
> +		netaddr->netid_len = 3;
> +		break;
> +	case AF_INET6:
> +		port = ntohs(sin6->sin6_port);
> +		sprintf(netaddr->netid, "tcp6");
> +		netaddr->netid_len = 4;
> +		break;
> +	default:
> +		return nfserr_inval;
> +	}
> +	ret_addr = rpc_ntop(addr, netaddr->addr, sizeof(netaddr->addr));
> +	ret_port = snprintf(netaddr->addr + ret_addr,
> +			    RPCBIND_MAXUADDRLEN + 1 - ret_addr,
> +			    ".%u.%u", port >> 8, port & 0xff);
> +	WARN_ON(ret_port >= RPCBIND_MAXUADDRLEN + 1 - ret_addr);
> +	netaddr->addr_len = ret_addr + ret_port;
> +	return 0;
> +}

Kinda surprised we don't already do something like this elsewhere, but I
don't see anything exactly the same.  Might be possible to put this in
net/sunrpc/addr.c and share some code with rpc_sockaddr2uaddr?  I'll
leave it to you whether that looks worth it.

--b.

> +
>  static inline bool bmval_is_subset(const u32 *bm1, const u32 *bm2)
>  {
>  	return !((bm1[0] & ~bm2[0]) ||
> -- 
> 1.8.3.1
