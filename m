Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB96C302
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 00:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfGQWMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 18:12:45 -0400
Received: from fieldses.org ([173.255.197.46]:59392 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfGQWMp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 18:12:45 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 028FD1C1B; Wed, 17 Jul 2019 18:12:44 -0400 (EDT)
Date:   Wed, 17 Jul 2019 18:12:44 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
Message-ID: <20190717221244.GO24608@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-5-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
>  static __be32
> +nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
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

I default to WARN_ON_ONCE().

--b.
