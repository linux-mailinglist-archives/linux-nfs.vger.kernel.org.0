Return-Path: <linux-nfs+bounces-18341-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFQBBJAPc2ntrwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18341-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 07:05:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DA70B81
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4A75301625D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F46287507;
	Fri, 23 Jan 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FDjGp9D5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C723ABBD
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148299; cv=none; b=bA/t/TVje0LAl2spopqq0SarTdcuiCv+aKcGJ9HwEnDfKoxPpNmR10FRJDK01gATE+wPDbs78xP0JorXyQXG8uKdS/R1Dwe/1upXG7Lz2SLZ3FgazvUq0zZGP8ma5456wnrf2JjwiXrordVmY5kwlNFJEVknWgSh0EfQ2Bk7JvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148299; c=relaxed/simple;
	bh=h9g2gyRuNShziaYijgJlBgvgS/UY03RUaLaxQiejYLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUYhSygz5GbDQPySBYf0u/ykeoR8nnC2rNQsdhuSnuzZlwVYBAhNc2+QdGvC4hgxE+ebi8SCDFl121q48+zd48V6tb6MwJe9tAxyHDvKwRjv3MvV50uT/kZB1zn107LrD9BKrLjRbFbfFFeovXWmFkjYT/dH1UQVKShdnIbImtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FDjGp9D5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c02ab348-5243-4e97-b916-6bd59ffe769a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769148291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBjPnAPLtIJQgYd9Yf7ajYQCnwWpwqRQJkI1YWyJuP0=;
	b=FDjGp9D52m5EaikR8iM3b52LZyCo3lZ7rh025hmcIikxPAPpLNFlEbkeEgP0tS1PK5pm+7
	fDqoWZYrIxP5XPp3VZdbUt6jUec/nApqH+bJgrFORFTwOg0lJGpHDZzwoTXxaVgZ+dYkzf
	TKbvZ8/IoWLQUKHp33HeKtn/J2RPTNo=
Date: Thu, 22 Jan 2026 22:04:39 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] Add a bio_vec based API to core/rw.c
To: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260122220401.1143331-1-cel@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260122220401.1143331-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18341-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 609DA70B81
X-Rspamd-Action: no action

在 2026/1/22 14:03, Chuck Lever 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series introduces a bio_vec based API for RDMA read and write
> operations in the RDMA core, eliminating unnecessary scatterlist
> conversions for callers that already work with bvecs.
> 
> Current users of rdma_rw_ctx_init() must convert their native data
> structures into scatterlists. For subsystems like svcrdma that
> maintain data in bvec format, this conversion adds overhead both in
> CPU cycles and memory footprint. The new API accepts bvec arrays
> directly.
> 
> For hardware RDMA devices, the implementation uses the IOVA-based
> DMA mapping API to reduce IOTLB synchronization overhead from O(n)
> per-page syncs to a single O(1) sync after all mappings complete.
> Software RDMA devices (rxe, siw) continue using virtual addressing.
> 
> The series includes MR registration support for bvec arrays,
> enabling iWARP devices and the force_mr debug parameter. The MR
> path reuses existing ib_map_mr_sg() infrastructure by constructing
> a synthetic scatterlist from the bvec DMA addresses.

Hi, Chuck Lever

I’ve read through the patch series. As I understand it, the new 
bio_vec–based RDMA read/write API allows callers that already operate on 
bvecs (for example, svcrdma and potentially NVMe-oF) to avoid converting 
their data into scatterlists, which should reduce CPU overhead and 
memory usage in the data path.

For hardware RDMA devices, the use of the IOVA-based DMA mapping API 
also seems likely to reduce IOTLB synchronization overhead compared to 
the existing per-page approach, while software devices (rxe, siw) retain 
the current virtual-addressing model.

Do you happen to have any performance or functional test results you 
could share for this series, in particular:

Hardware RDMA devices (e.g., latency, bandwidth, or CPU utilization 
changes), and/or

Software RDMA devices such as rxe or siw?

Any data points or qualitative observations would be very helpful for 
evaluating the impact of the new API.

Zhu Yanjun

> 
> The final patch adds the first consumer for the new API: svcrdma.
> 
> Based on v6.19-rc6.
> 
> ---
> 
> Changes since v2:
> - Add bvec iter arguments to the new API
> - Add a synthetic SGL in the MR mapping function
> - Try IOVA coalescing before max_sgl_rd triggers MR in bvec path
> - Attempt once again to address SQ/CQ/max_rdma_ctxs sizing issues
> 
> Changes since v1:
> - Simplify rw.c by using bvec iters internally
> - IOVA mapping produces a contiguous DMA address range
> - Clarify the comment that documents struct svc_rdma_rw_ctxt
> - svcrdma now uses pre-allocated bio_vec arrays
> 
> Chuck Lever (5):
>    RDMA/core: add bio_vec based RDMA read/write API
>    RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
>    RDMA/core: add MR support for bvec-based RDMA operations
>    RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
>    svcrdma: use bvec-based RDMA read/write API
> 
>   drivers/infiniband/core/rw.c             | 591 ++++++++++++++++++++---
>   drivers/infiniband/ulp/isert/ib_isert.c  |   4 +-
>   drivers/nvme/target/rdma.c               |   4 +-
>   include/rdma/ib_verbs.h                  |  42 ++
>   include/rdma/rw.h                        |  36 +-
>   net/sunrpc/xprtrdma/svc_rdma_rw.c        | 155 +++---
>   net/sunrpc/xprtrdma/svc_rdma_transport.c |   8 +-
>   7 files changed, 699 insertions(+), 141 deletions(-)
> 


