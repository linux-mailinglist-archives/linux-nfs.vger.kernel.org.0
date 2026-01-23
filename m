Return-Path: <linux-nfs+bounces-18344-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM4hEPAWc2mwsAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18344-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 07:36:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2B710D9
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 07:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9470E30060B9
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96C32AAAB;
	Fri, 23 Jan 2026 06:36:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4C33064B;
	Fri, 23 Jan 2026 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150188; cv=none; b=u7ruYQW26kDKcQ76WQ6KPrCDaXlsDQRSln41BlAmYOJI6qETZX450w5gr+JBku/Cm7RMl8wLSzhq67PRD+y/iEhXOCOB7ZFd6Odx+qM+8rRCSnNQ36XmCRzMjKO2FOB6rrhMMvwUgHMRcBVKn4vhK1HbPDGYIlv4aeMiKRWmRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150188; c=relaxed/simple;
	bh=1omY57Z5zXSGWm3oDxTYyTgQAKrDQvz7GDTvrpfyrnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBJIK1dsxYVZezlm7V6CGIl3PpLfLe6dGdHPmsgw0gcaq3vS3G2+m7mxhuYu376txghNu/H45d3oZB7qhfM7+7vIra1W5cHiZ8w5oEzF8WxGCo4RoDzC/vg6z0yD+4G3OCI5d2hLetOqkvzXFLjxfRJwrDKgxAYT3RQJZ7tNy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2852C227AAE; Fri, 23 Jan 2026 07:36:23 +0100 (CET)
Date: Fri, 23 Jan 2026 07:36:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260123063622.GA26025@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org> <20260122220401.1143331-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122220401.1143331-4-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18344-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 75C2B710D9
X-Rspamd-Action: no action

> +/*
> + * Check if the device requires memory registration for RDMA READs.
> + * iWARP always requires MR for RDMA READ due to protocol limitations.
> + */
> +static inline bool rdma_rw_io_requires_mr(struct ib_device *dev, u32 port_num,

>  static inline bool rdma_rw_io_needs_mr(struct ib_device *dev, u32 port_num,
>  		enum dma_data_direction dir, int dma_nents)

I find the naming really confusing here.  I guess requires is that
the protocol (iWarp) doesn't work with it, needs means we need it for
the the number of entries.

And the new API requires the ULP to size the mapping request to never
hit the latter case?

Maybe just kill off the old rdma_rw_io_needs_mr and open code the
latter case in the only user?:w


>  	for (i = 0; i < ctx->nr_ops; i++) {
> -		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];

Jumping ahead here - why can't the sgtable be stored in ->reg
without renaming?  Is there case where need it, but the rest of
reg?   In 

> +	ctx->nr_ops = DIV_ROUND_UP(ctx->reg.sgt.nents, pages_per_mr);
> +	ctx->reg.ctx = kcalloc(ctx->nr_ops, sizeof(*ctx->reg.ctx), GFP_KERNEL);
> +	if (!ctx->reg.ctx) {
> +		ret = -ENOMEM;
> +		goto out_unmap_sgt;
> +	}
> +
> +	sg = ctx->reg.sgt.sgl;
> +	nents = ctx->reg.sgt.nents;
> +	for (i = 0; i < ctx->nr_ops; i++) {
> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
> +		u32 sge_cnt = min(nents, pages_per_mr);
> +
> +		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sge_cnt, 0);

I guess you looked into that, but never replied, but this still
looks like it duplicates most of rdma_rw_init_mr_wrs.  Is there something
that prevents reusing that directly or with minor refactoring?

> +	memcpy(ctx->reg.ctx->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));

Overly long line.  But this also shows an issue that the details of the
rw context leak for the later added signature MR support :P

