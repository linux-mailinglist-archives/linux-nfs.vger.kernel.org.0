Return-Path: <linux-nfs+bounces-18226-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJMzCf2TcGlyYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18226-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:53:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D985E53E80
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B804F528DA6
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC046AEDB;
	Wed, 21 Jan 2026 08:52:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF3329C78;
	Wed, 21 Jan 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985525; cv=none; b=UuSpAsokIIWfUYRoU1oQc45+8AmdCR056JrcsudDTcnSUv+ign6r2X2rfCNkCyZXuegk4xRPnS4l/WNQszQw53G/EZf3Pb2x68uY/zOste3Nc4nUkijtLErnGFg5/gD/aORy5WUsED8chHXnPIEn92tR0Ph4It9vQFDiqFEf2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985525; c=relaxed/simple;
	bh=P2kspXHY6egTlCTHTch5zPJKteIRcITyLc/1XSVFMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaVzENbKZD2460CBZsZtbcDEUsIEncVignG3bEIQ3rTFPW0Htlrjz4UQOJ6sfH8hobmZmu8LTVdUZDQb2BbC5ywiDCgeoL2p0ZNVqlOpVEPXydaqSEO4hp0DwlDlW9kn8zuxvWq0ppItw8NAl4DomXDNWbCtvlBM/cf4gskFc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FDBF227AAA; Wed, 21 Jan 2026 09:51:59 +0100 (CET)
Date: Wed, 21 Jan 2026 09:51:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/4] RDMA/core: use IOVA-based DMA mapping for bvec
 RDMA operations
Message-ID: <20260121085159.GB16458@lst.de>
References: <20260120143124.1822121-1-cel@kernel.org> <20260120143124.1822121-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120143124.1822121-3-cel@kernel.org>
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-18226-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,oracle.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D985E53E80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:31:22AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The bvec RDMA API maps each bvec individually via dma_map_phys(),
> requiring an IOTLB sync for each mapping. For large I/O operations
> with many bvecs, this overhead becomes significant.
> 
> The two-step IOVA API (dma_iova_try_alloc / dma_iova_link /
> dma_iova_sync) allocates a contiguous IOVA range upfront, links
> all physical pages without IOTLB syncs, then performs a single
> sync at the end. This reduces IOTLB flushes from O(n) to O(1).

... and requires only a single output dma_addr_t compared to extra
per-input element storage in struct scatterlist.

> +		const struct bio_vec *bvec, u32 nr_bvec,
> +		struct bvec_iter *iter,
> +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)

Same minor nits as for the previous patch here as well.

> +	struct ib_device *dev = qp->pd->device;
> +	struct device *dma_dev = dev->dma_device;
> +	struct bvec_iter link_iter;
> +	struct bio_vec first_bv;
> +	size_t total_len, mapped_len = 0;
> +	int ret;
> +
> +	/* Virtual DMA devices lack IOVA allocators */
> +	if (ib_uses_virt_dma(dev))
> +		return -EOPNOTSUPP;

No only lacks, but fundamentally can't support it.

> +	total_len = iter->bi_size;

I'd just initialize this at declaration time.

> +	/* Get the first (possibly offset-adjusted) bvec for starting phys addr */

I think this comment is kinda out of date now, as the offset adjustment
is transparently done by the bvec helpers, and there's no visible concept
of a start phys addr.

> +	first_bv = mp_bvec_iter_bvec(bvec, *iter);

I'd also initialize first_bv at declaration time.  The compilers are
smart enough defer the work past past the virtual dma check.

> +		struct bio_vec bv = mp_bvec_iter_bvec(bvec, link_iter);
> +
> +		ret = dma_iova_link(dma_dev, &ctx->iova.state, bvec_phys(&bv),
> +				    mapped_len, bv.bv_len, dir, 0);
> +		if (ret)
> +			goto out_destroy;
> +
> +		if (check_add_overflow(mapped_len, bv.bv_len, &mapped_len)) {
> +			ret = -EOVERFLOW;
> +			goto out_destroy;
> +		}

Do the overflow check before calling dma_iova_link as it's kinda
pointless to continue with that operation.  But then again, I don't
really think we need the overflow check at all.  The length is known
beforehand in bi_size, which is a u32, while mapped_len is a size_t,
so we can't really overflow here at all.

> +	/*
> +	 * Try IOVA-based mapping first for multi-bvec transfers.
> +	 * This reduces IOTLB sync overhead by batching all mappings.
> +	 */
> +	ret = rdma_rw_init_iova_wrs_bvec(ctx, qp, bvec, nr_bvec, &iter,
> +			remote_addr, rkey, dir);
> +	if (ret != -EOPNOTSUPP)
> +		return ret;
> +
> +	/* Fallback path requires iterator at initial state */
> +	iter.bi_sector = 0;
> +	iter.bi_size = total_len;
> +	iter.bi_idx = 0;
> +	iter.bi_bvec_done = offset;

rdma_rw_init_iova_wrs_bvec already avoids advancing the passed in
iter, and this rebuilds it.  In addition, rdma_rw_init_iova_wrs_bvec
only returns -EOPNOTSUPP before advancing even the local iter.

So I think both the local iter copy in rdma_rw_init_iova_wrs_bvec
and this can go away.  But it would be useful to capture that
rdma_rw_init_iova_wrs_bvec must leave the iter unmodified when
returning -EOPNOTSUPP in a comment.


