Return-Path: <linux-nfs+bounces-18462-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIn3FbMHd2lGawEAu9opvQ
	(envelope-from <linux-nfs+bounces-18462-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:20:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBDB8470B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B42830115AD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE61F4C96;
	Mon, 26 Jan 2026 06:17:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23D21B196;
	Mon, 26 Jan 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408276; cv=none; b=Xw88Zmz6L4GnK3qrak1P/5N9nQEmJjY6I+I9x5sS4i8gC9tjGm2i3/p1aHVxfaEaPR+XSFOijHGO9kPB3RzEpUwyYPn8Wzn9sFEKs+oO3/aJdz2yqECUwJoBpf5jorq+hNi3uAW1MnY97Wg54+p/ebfnVMoWv9NYu/PSo3BM+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408276; c=relaxed/simple;
	bh=ZNAsFMwYdOscjhBC2JVjrGl3KU/m6pUXdnQViafuL5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhWGtWuGCKwWnYz9pT+h1fT8ktYZjT99250hm4/1CyfrAUzt3QbIQPWb4i5aIDleRxellgd5GJasparipD66lm3artR+6EwVkrUEUP+IVSw5SL0YhIvxC4lTbITXX/cFCU4tSlkY/bcrOokJ5Qi9w9koEc2coTPOFcuhHfQX9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22E30227A8E; Mon, 26 Jan 2026 07:17:53 +0100 (CET)
Date: Mon, 26 Jan 2026 07:17:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260126061752.GC1638@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org> <20260122220401.1143331-4-cel@kernel.org> <20260123063622.GA26025@lst.de> <d868e180-b6ed-4b3b-afc6-7f08083615c1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d868e180-b6ed-4b3b-afc6-7f08083615c1@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18462-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.973];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: ACBDB8470B
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:06:36AM -0500, Chuck Lever wrote:
> >> +	nents = ctx->reg.sgt.nents;
> >> +	for (i = 0; i < ctx->nr_ops; i++) {
> >> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
> >> +		u32 sge_cnt = min(nents, pages_per_mr);
> >> +
> >> +		ret = rdma_rw_init_one_mr(qp, port_num, reg, sg, sge_cnt, 0);
> >
> > I guess you looked into that, but never replied, but this still
> > looks like it duplicates most of rdma_rw_init_mr_wrs.  Is there something
> > that prevents reusing that directly or with minor refactoring?
> 
> IIRC I interpreted your earlier review comment as "let's defer that clean-up".
> I'll look at it again.

I was hoping we could just reuse the code instead of duplicating it.
The one earlier comment was about sharing code where we actualy
pass in the bvec and scatterlist, and that might or might not be useful.
But for this case where we have to actually create a scatterlist first,
not reusing the existing scatterlist code to then work on it feels
wrong.


