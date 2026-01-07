Return-Path: <linux-nfs+bounces-17579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB8CFF4D7
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DE236604C9
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80933376BE5;
	Wed,  7 Jan 2026 16:22:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5B36C0AD
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802938; cv=none; b=qflKlLnkXhr4/oH6HNhKPzHC66UlNnohzHE4UySioZH2KFi/rwJwvx7ZM5t8Fu78nwSbX78mgY0iVmRp+TdVpxMFpgjWNd5wOwapZWDbASOJgLj70whCKiY0SonkLZgFmOPJ16UfGRrVF8ZgLjWITH452Gu6fd16xGpDbPARwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802938; c=relaxed/simple;
	bh=6wo9UX8hScbiGWTYegUqS0Kp016qURG5O4b6W7A5W1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPnGyY8v6x5/ibU6xx9D4oyspYnYvI2MMy98RL4HbKyCSC+IFHNyaorflgPMIBKdBkPzncQFxu8M3sgWSHXtAEPhfTjPcMYs2R1OPIApLSkHmqu4ciZSLyXN19r86aryyf090BjXPBRF0eTu9rGL4drijJUr5VrwFZ560Nf837A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47981227A87; Wed,  7 Jan 2026 17:22:03 +0100 (CET)
Date: Wed, 7 Jan 2026 17:22:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: add a LRU for delegations
Message-ID: <20260107162202.GA23066@lst.de>
References: <20260107072720.1744129-1-hch@lst.de> <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 10:18:04AM -0500, Chuck Lever wrote:
> > currently the NFS client is rather inefficient at managing delegations
> > not associated with an open file.  If the number of delegations is above
> > the watermark, the delegation for a free file is immediately returned,
> > even if delegations that were unused for much longer would be available.
> > Also the periodic freeing marks delegations as not referenced for return,
> > even if the file was open and thus force the return on close.
> >
> > This series reworks the code to introduce an LRU and return the least
> > used delegations instead.
> 
> I'm curious if you tried other methodologies like LFU to decide which
> delegation to return?

Not really.  LFU I guess means least frequently used.  That would
imply tracking usage frequency, and rotating a list of other lookup
structure a lot.  The first is something not really provided in the
delegation code, and the latter tends to be really horrible for in
terms of cache dirtying.


