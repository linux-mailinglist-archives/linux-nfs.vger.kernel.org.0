Return-Path: <linux-nfs+bounces-17973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A42D2EE62
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B9E30B5147
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BDC35773C;
	Fri, 16 Jan 2026 09:38:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53431197F;
	Fri, 16 Jan 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556326; cv=none; b=hn5kudxvfVrajAtUfHfj1uND73Qdnt5QslKUbgDjKP1krW9iPCIGG1Pm4MxW+zcUBA0ziNoclSljPgy/TkMC8pLhZt/Py+enaIi0jOYVzsYxfkdKvQn4IMh+XGHkCQTQjN/UtV/4tAI/TNeGaFT6FhHgtNTNDAoUahPrc1FQGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556326; c=relaxed/simple;
	bh=zeqUPdyGEJMzDVs1XrZI+QEXXIIdIxdAcdyviJcItII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DynzAbAzHV3NMEYTjchem0h/a10B9hlsWCofqkjx0ZhxMid0XmtIQC57uGqiAOSkWNufcHGC0I5E+ceYvwUDNFNBOFJufS3suGnaLL1TJjeGyqWChuYjrOhMJv6QmlpzVwGCJGAt+ZEFo/ZvPZdUm5D5akyauoYxiyZ9OqHCyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54651227AAA; Fri, 16 Jan 2026 10:38:38 +0100 (CET)
Date: Fri, 16 Jan 2026 10:38:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Message-ID: <20260116093836.GA23431@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-5-cel@kernel.org> <20260115162929.GC17257@lst.de> <e85b5f0f-dbe1-4b4a-8e1c-56ecfe5853ea@app.fastmail.com> <bdcf6391-5d92-4bec-b351-f8fe75b1ea43@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcf6391-5d92-4bec-b351-f8fe75b1ea43@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 04:53:23PM -0500, Chuck Lever wrote:
> These are contiguous because the xdr_buf "pages" field is an array
> of "struct page *" pointers. So these don't have per-entry offsets.
> There is one "page_offset" field in the xdr_buf that applies only
> to the first entry in that array.
> 
> Therefore the payload buffer starts at an offset of zero or greater
> in the first page in that array, but after that, the buffer continues
> across the boundaries of each page from offset 4095 on page N to
> byte 0 of page N+1, for all N.
> 
> The comment is a little misleading -- it documents an assumption
> that is due to each entry of the xdr_buf pages array being "struct
> page *" and there not being an offset field for each entry.

Yeah.  I also realized both the classic RDMA memory registrations,
and the IOVA based DMA mapping requires the subsequent entries to
be at least page aligned.  There is a Mellanox-specific MR type that
doesn't require that, but that obviously doesn't help iWarp, and the
IOVA coalescing is nice to have as well.

