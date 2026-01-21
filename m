Return-Path: <linux-nfs+bounces-18223-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM6PHiGScGkaYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18223-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:45:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1153CA2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94C3F52922D
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BA3A4AD9;
	Wed, 21 Jan 2026 08:42:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0F36656F;
	Wed, 21 Jan 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984944; cv=none; b=FI9CZbeizXZa6w4K9Z0ANct0MJkiumZA45aP4zZoY45tY7qF7GbgcEDirLJbvVFmLSYwKYZbL/c/n2ce9PLE2xOjtsvuoB3b4EGOxk2smSChqXDkEcYvsKY+2X+Gp5xG006kq/kYefRDwUs2nmWrn87JiGmciKrRk4YOXWJKOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984944; c=relaxed/simple;
	bh=xcItrdUgyJnWL9h2AfWiJfoEtRsVD720bMV8yaVFjjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K16GXUsG98CHnnG56igNlGxJ4la9NzmaLa31osGJIlu8t+iNsgKTf/iWg6P8HD7nakzFa6pz0N6ZzDDIAOqdpXF8Y1V227UzOs5nd+LITrpwpPJ/Dg32Dm6FKBf2wE+BuesSwGm2/OPL4qzmKx959b4rwcsJFXXcP5QtX5QD/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99C3A227AAA; Wed, 21 Jan 2026 09:42:17 +0100 (CET)
Date: Wed, 21 Jan 2026 09:42:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260121084217.GA16458@lst.de>
References: <20260120143124.1822121-1-cel@kernel.org> <20260120143124.1822121-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120143124.1822121-2-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-18223-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 19F1153CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:31:21AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The existing rdma_rw_ctx_init() API requires callers to construct a
> scatterlist, which is then DMA-mapped page by page. Callers that
> already have data in bio_vec form (such as the NVMe-oF target) must
> first convert to scatterlist, adding overhead and complexity.
> 
> Introduce rdma_rw_ctx_init_bvec() and rdma_rw_ctx_destroy_bvec() to
> accept bio_vec arrays directly. The new helpers use dma_map_phys()
> for hardware RDMA devices and virtual addressing for software RDMA
> devices (rxe, siw), avoiding intermediate scatterlist construction.
> 
> Memory registration (MR) path support is deferred to a follow-up
> series; callers requiring MR-based transfers (iWARP devices or
> force_mr=1) receive -EOPNOTSUPP and should use the scatterlist API.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/rw.c | 210 +++++++++++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h      |  42 +++++++
>  include/rdma/rw.h            |  10 ++
>  3 files changed, 262 insertions(+)
> 
> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> index 6354ddf2a274..59f32fecf3df 100644
> --- a/drivers/infiniband/core/rw.c
> +++ b/drivers/infiniband/core/rw.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/memremap.h>
>  #include <linux/moduleparam.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/pci-p2pdma.h>
>  #include <rdma/mr_pool.h>
> @@ -274,6 +275,111 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>  	return 1;
>  }
>  
> +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
> +		struct ib_qp *qp, const struct bio_vec *bvec,

Nit: maybe rename bvec to bvecs or bvec_table to make it clear this
is the base array that the iter operates on?

> +		struct bvec_iter *iter,
> +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)

Nit 2: this can be condensed a little:

> +		struct bvec_iter *iter, u64 remote_addr, u32 rkey,
> +		enum dma_data_direction dir)

> +static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> +		const struct bio_vec *bvec, u32 nr_bvec,
> +		struct bvec_iter *iter,
> +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)

Same here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

