Return-Path: <linux-nfs+bounces-17907-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F3D257D3
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DBBB3053FA4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D053B5312;
	Thu, 15 Jan 2026 15:46:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3273AE6FB;
	Thu, 15 Jan 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492005; cv=none; b=j2yc6a37aFM5r176CD7WAdfYkQ0CHlYdudjJFcH4gVqQTZfLsJOsXGUtMonNTRJjVd+0BB1KvhIlqr9qSq7HLacIC/FY9GsDYzEGHq6oGaekKQmOU122AwwAA2pNzadczvIzlDzfDR2g2OwKmKuxW2luamgiyr87FsmZCGHaT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492005; c=relaxed/simple;
	bh=R8NmT6/VQ+D4utI+mKMD9aOo0PXtNsOut726Fx7GmrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbu0MgXy5B5/E1Sh7XzLHtSabWdaXxKvikAP1SojTMpwEpzbWjvRurqRemvV1FZudkGE6jCbcBtDrBs9K6D1mieS/QgFGuxgea1ushYPrETgA3Of/hMNvfh6j4tUH8sU8qoQx4QJQmV2i5jSuV46Iq8sm72ogchy3x4DtI6ZmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1BC3227AAA; Thu, 15 Jan 2026 16:46:36 +0100 (CET)
Date: Thu, 15 Jan 2026 16:46:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 0/4] Add a bio_vec based API to core/rw.c
Message-ID: <20260115154635.GA14083@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-1-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 09:39:44AM -0500, Chuck Lever wrote:
> The final patch adds the first consumer for the new API: svcrdma.
> It replaces its scatterlist conversion code, significantly reducing
> the svc_rdma_rw_ctxt structure size. The previous implementation
> embedded a scatterlist array of RPCSVC_MAXPAGES entries (4KB or
> more per context); the new implementation uses a pointer to a
> dynamically allocated bvec array.

But isn't that comparison a little unfair when a preallocated/embedded
data structure is replaced with a dynamic allocation?


