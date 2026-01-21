Return-Path: <linux-nfs+bounces-18224-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCEBLpGTcGlyYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18224-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:51:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9953E0F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2D314F3CEA
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5BA283FC5;
	Wed, 21 Jan 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTJLo5oB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F72BDC2C;
	Wed, 21 Jan 2026 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985326; cv=none; b=ulFBw0RvJoJv5c/4jN83eY4GspPmTSQoFknqojU69fTstiiFjsvZ0FfcEdB48b2dxW/NU79o+11JDFigkBPNyejbRqy39uT1jCFzC8rj+YTSirDeCS90DdTg4nvRwuaLQlV8NJGGUqp2Q7BnJnqZiTAz9KA/K98tTazCV3Z1+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985326; c=relaxed/simple;
	bh=ZhWulX1j5BVwjXsmu/ks3+pXjQCrpn4IXfUh8mK18zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtNHvFwELsSi6P53/KJcmJBrn865myLfT1/k9LUgANkNAhr8raKMwyywGJDoDGr2od33VPalL/RFb2dvCGVMv5YxCR1lqYLZJTURtCcH6nfpzwuqrJlTsBvtoWZJSDdVd19IjKncbbkLHyJf+HLPDH+IDxHjxXrr+WuL02Eiw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTJLo5oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BFCC116D0;
	Wed, 21 Jan 2026 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768985326;
	bh=ZhWulX1j5BVwjXsmu/ks3+pXjQCrpn4IXfUh8mK18zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTJLo5oBGpNpjfzEN18O8fgN9xWNwxeBMl5E3T6U/ER06ZxUfzG5KXzvXg+l2G3nB
	 5Uwvk4oDDSsZ12892Al0/MwevxUoIIl1xk8dF1C63QR2JaaBhVLcLqeSsHzN/140Bn
	 j8jU1fR0HbUIh5JjoiwwaFPdkqNj/nPV17mV36TZiO5YpNvVe3TWCaFefscNLZ/jRJ
	 NoWGEITwV+5FOXhjv7+MGMLPAwG6iF8oRKuiHw5sFYmmumfJYOSobbi0DPBsSw6exX
	 ZZaxUQVGvo8ROGNFzI12PIBpe0hxx1cmEGkfnCPFyD6WB0LSfm/ksETGLr045eMcHV
	 Oo4RKc8zeeVaA==
Date: Wed, 21 Jan 2026 10:48:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260121084840.GX13201@unreal>
References: <20260120143124.1822121-1-cel@kernel.org>
 <20260120143124.1822121-2-cel@kernel.org>
 <20260121084217.GA16458@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121084217.GA16458@lst.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18224-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 4CD9953E0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:42:17AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 09:31:21AM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The existing rdma_rw_ctx_init() API requires callers to construct a
> > scatterlist, which is then DMA-mapped page by page. Callers that
> > already have data in bio_vec form (such as the NVMe-oF target) must
> > first convert to scatterlist, adding overhead and complexity.
> > 
> > Introduce rdma_rw_ctx_init_bvec() and rdma_rw_ctx_destroy_bvec() to
> > accept bio_vec arrays directly. The new helpers use dma_map_phys()
> > for hardware RDMA devices and virtual addressing for software RDMA
> > devices (rxe, siw), avoiding intermediate scatterlist construction.
> > 
> > Memory registration (MR) path support is deferred to a follow-up
> > series; callers requiring MR-based transfers (iWARP devices or
> > force_mr=1) receive -EOPNOTSUPP and should use the scatterlist API.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  drivers/infiniband/core/rw.c | 210 +++++++++++++++++++++++++++++++++++
> >  include/rdma/ib_verbs.h      |  42 +++++++
> >  include/rdma/rw.h            |  10 ++
> >  3 files changed, 262 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> > index 6354ddf2a274..59f32fecf3df 100644
> > --- a/drivers/infiniband/core/rw.c
> > +++ b/drivers/infiniband/core/rw.c
> > @@ -4,6 +4,7 @@
> >   */
> >  #include <linux/memremap.h>
> >  #include <linux/moduleparam.h>
> > +#include <linux/overflow.h>
> >  #include <linux/slab.h>
> >  #include <linux/pci-p2pdma.h>
> >  #include <rdma/mr_pool.h>
> > @@ -274,6 +275,111 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> >  	return 1;
> >  }
> >  
> > +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
> > +		struct ib_qp *qp, const struct bio_vec *bvec,
> 
> Nit: maybe rename bvec to bvecs or bvec_table to make it clear this
> is the base array that the iter operates on?
> 
> > +		struct bvec_iter *iter,
> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> 
> Nit 2: this can be condensed a little:
> 
> > +		struct bvec_iter *iter, u64 remote_addr, u32 rkey,
> > +		enum dma_data_direction dir)
> 
> > +static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> > +		const struct bio_vec *bvec, u32 nr_bvec,
> > +		struct bvec_iter *iter,
> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)

Don't you both think these functions take too many arguments? It might be
worth introducing something like "struct rdma_rw_init_attrs" and passing
that instead.

At the end, these functions are for you to use.

Thanks

> 
> Same here.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

