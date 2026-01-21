Return-Path: <linux-nfs+bounces-18229-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHIdNHaYcGlyYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18229-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:12:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8C5423B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50F7F5A0D2B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8241B36D;
	Wed, 21 Jan 2026 09:05:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA530F546;
	Wed, 21 Jan 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986318; cv=none; b=DS4x+xnbpErc11Zzd2CaNyOrN0oniEeVztwKQ3rpImLyOQnPTFiShMJtiTkJrgRzeZwemBw7o9IyjvkJiVM8Z0IJoERGCIPOoNlj3OEKb6+qJcOUOCxi61Q2jgKqpI0ZzNP49917EKmHjw5NTStcXqfJ/mTjyGidhtcnUWRgIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986318; c=relaxed/simple;
	bh=oEn7Z67jGHB7ovt2C9arC5AS1bjurZPyU6oMpzUoVNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZTSKHDPEjCqsJWjTpAxH4QYjtLP1UW+XuPJkbGSMLrfNnF9YTCLP3e9kpXlIaJ/bG/KGXYjVhfQM5leBf0Fvf8WQtdSW66Yx7bDO/b6OR1J8ERtWGtmWE6YL8WQi9F/SmyiVka2n6dKhuLDAur4M9ESvX6n9POVZUUgYzBThg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEA0D227AAD; Wed, 21 Jan 2026 10:05:08 +0100 (CET)
Date: Wed, 21 Jan 2026 10:05:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 3/4] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260121090508.GE16458@lst.de>
References: <20260120143124.1822121-1-cel@kernel.org> <20260120143124.1822121-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120143124.1822121-4-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18229-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: 91C8C5423B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static int rdma_rw_init_mr_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> +		u32 port_num, const struct bio_vec *bvec, u32 nr_bvec,
> +		u32 offset, u64 remote_addr, u32 rkey,
> +		enum dma_data_direction dir)

Any reason this is not using the bvec_iter like the other paths?

Yhe mapping to the scatterlist would then basically be a much
simplified version of __blk_rq_map_sg.

> +		dma_addr = ib_dma_map_bvec(dev, bv, dir);
> +		if (ib_dma_mapping_error(dev, dma_addr)) {
> +			ret = -ENOMEM;
> +			goto out_unmap;
> +		}
> +
> +		/* sg_set_page() initializes the entry; ib_map_mr_sg() uses
> +		 * only sg_dma_address/len, ignoring the page pointer.
> +		 */
> +		sg_set_page(&sgl[i], bv->bv_page, len, bv->bv_offset);
> +		sg_dma_address(&sgl[i]) = dma_addr;
> +		sg_dma_len(&sgl[i]) = len;

And once we have a scatterlist, this should probably just use
ib_dma_map_sg* ?  And maybe rdma_rw_init_one_mr?

> +	/*
> +	 * For bvec MR path: store synthetic scatterlist with DMA addresses
> +	 * for cleanup. Only valid when type == RDMA_RW_MR and initialized
> +	 * via rdma_rw_ctx_init_bvec().
> +	 */
> +	struct scatterlist	*mr_sgl;
> +	u32			mr_sg_cnt;
>  };

This probably should be in the reg union arm and thus the separate
allocatiom?

