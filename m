Return-Path: <linux-nfs+bounces-18460-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNBWMXEGd2lGawEAu9opvQ
	(envelope-from <linux-nfs+bounces-18460-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:15:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39784643
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16356300E707
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21422571C7;
	Mon, 26 Jan 2026 06:14:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2C19C546;
	Mon, 26 Jan 2026 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408078; cv=none; b=elCayyGV1s9+WwG4frFWmY1tqoPMq9VyxwyXt8itG+b/4xOJhAPKFfR8wM7CX4P8oeV17fI/7Npb7ywOCZF1dnjWhNrtFrS3sMIeFrEwQ4iF8ReDn0r9t2j9qxK/sy69euOJspq0/2JIXi0N4ij6FI04XDK62SwKFhToUh8mvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408078; c=relaxed/simple;
	bh=St5IRsZ+uitRICLHUIl3550MUdd7xZVRfychGJe1XIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhbhBWwHySrZYSuaLdq8kcJeBnybkgmUhPCo3z9KYXzlG+Z++gX7qwLQ3xehOlqWQ7mhVawXEydUElHDuQP+8/R90aXyL/zJaykgVuE6b0Q1SAz/zH3uyaDPq3wIAb84eVvogAoP0+OUOuZdfiayu4q44kN0R6iIRkl5IQiLb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1381A227A88; Mon, 26 Jan 2026 07:14:34 +0100 (CET)
Date: Mon, 26 Jan 2026 07:14:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 2/5] RDMA/core: use IOVA-based DMA mapping for bvec
 RDMA operations
Message-ID: <20260126061433.GA1638@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org> <20260122220401.1143331-3-cel@kernel.org> <20260123062844.GB25786@lst.de> <d70b5896-2de8-4417-a149-0fd1c55f4d2d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d70b5896-2de8-4417-a149-0fd1c55f4d2d@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18460-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E39784643
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:04:07AM -0500, Chuck Lever wrote:
> On Fri, Jan 23, 2026, at 1:28 AM, Christoph Hellwig wrote:
> >> +	/* Link all bvecs into the IOVA space */
> >> +	link_iter = *iter;
> >> +	while (link_iter.bi_size) {
> >> +		struct bio_vec bv = mp_bvec_iter_bvec(bvec, link_iter);
> >> +
> >> +		ret = dma_iova_link(dma_dev, &ctx->iova.state, bvec_phys(&bv),
> >> +				    mapped_len, bv.bv_len, dir, 0);
> >> +		if (ret)
> >> +			goto out_destroy;
> >> +
> >> +		mapped_len += bv.bv_len;
> >> +		bvec_iter_advance(bvec, &link_iter, bv.bv_len);
> >> +	}
> >
> > Why is this using a local link_iter?  We're not using iter later.
> 
> I think we don't want to leak a partially-updated iter if the
> API call returns an error.

That's how all the block layer bvec_iter-based API work.  The
functions consume the iter.  If a caller needs to save it for
some reason, it stashes away a copy.


