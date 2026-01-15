Return-Path: <linux-nfs+bounces-17916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B40D25C11
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1232F300C61B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85A3B9607;
	Thu, 15 Jan 2026 16:29:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12F1E5B9E;
	Thu, 15 Jan 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494577; cv=none; b=Z/pCrvlC8qL9HjT0WHgMg6HCeQWbHiC1ck6c4FfGKWxBo/qckbTGFIlm/vNJGewUmBTfrBqsThGH8iBql9xyprGvDzxc2/RMPXibDPL0Glq9vo1wBt8zY0+RdNdsEfRHRVLO2HcA8CPXyba/5IJXYSSSty5bsBus08naFtcSKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494577; c=relaxed/simple;
	bh=m+/097ygvy4jrqQmjW4fnEnVzQnpjKEIpum4XT7Y674=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6s4zxGRZ4gU4efYtJIsZjTH79IvF1XeJT/c02hrFPKeIJ7O1sljPoBAUdkzdE8SlEbjZPiueHrTxApTMUkxacDGtPDMz7/EoIdNR6CJDTDKIt7j5l3krJr0m/23HjMdcF8vTgzdgZe4PWVlMtSyK3oAkdf9alsyLGmtzx/WKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7E31227AAF; Thu, 15 Jan 2026 17:29:29 +0100 (CET)
Date: Thu, 15 Jan 2026 17:29:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Message-ID: <20260115162929.GC17257@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114143948.3946615-5-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 09:39:48AM -0500, Chuck Lever wrote:
> The structure size reduction is significant: the previous inline
> scatterlist array of RPCSVC_MAXPAGES entries (4KB or more) is
> replaced with a pointer to a dynamically allocated bvec array,
> bringing the fixed structure size down to approximately 100 bytes.

Can you explain why this switches to the dynamic allocation?
To me that seems like a separate trade-off to bvec vs scatterlist.

>   * Each WR chain handles a single contiguous server-side buffer,
> - * because scatterlist entries after the first have to start on
> + * because bio_vec entries after the first have to start on
>   * page alignment. xdr_buf iovecs cannot guarantee alignment.

For both the old and new version, can you explain they have to
start on a page boundary?  Because that's not how scatterlists or
bvecs work in general.  I guess this just documents the sunrpc
limits, but somehow projects it to these structures?


