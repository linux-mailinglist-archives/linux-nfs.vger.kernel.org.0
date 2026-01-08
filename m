Return-Path: <linux-nfs+bounces-17601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00612D03FB5
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C5E35CA8A0
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55A39A805;
	Thu,  8 Jan 2026 13:46:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B7349AF2
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880013; cv=none; b=i3mrK8Q0+xwyBv1RUkkLizOjZpp4UJrulxbspmukkNH7xZrsgsa4QLcjTUwS9dl0ARxTgdotRXneTsnQxfoHEsNiOiSgSS/Ns+UQ4nsjbcQwodo6srYS4cV+OtRGt26dwrGp0uqD10ohs29UyeBYxIck4cq1oeYq6UK5t1tz1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880013; c=relaxed/simple;
	bh=b/Z+JTXZWNmjB7CxvgtNu+juF0L3P9f/JSf4yDa/Ssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEXMtn9mR48tX1kFJDfG5Ge9JqJPi8BNVjxVF8YSqzwRu9FrZMKdYSKeDr5YdVzrkrU2n4rxg+j1Ad7LK6Y5NVX8RS62skUjpVDFCsIH5PjgCMK3f+Sw7PxQYRJWtbnL2Fqg4JJDuOsE5CpsuM6xAemKQgsqFlh0o5p8avEa1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAEE7227A87; Thu,  8 Jan 2026 14:46:36 +0100 (CET)
Date: Thu, 8 Jan 2026 14:46:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: add a LRU for delegations
Message-ID: <20260108134635.GA8624@lst.de>
References: <20260107072720.1744129-1-hch@lst.de> <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com> <20260107162202.GA23066@lst.de> <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 09:22:49PM +0200, Sagi Grimberg wrote:
> I think that there is merit for tracking file usage frequency and 
> accounting it for deleg return
> policy, and I don't necessarily think that it would not be worth the 
> overhead (compared to sending rpcs to the server)...
> but I agree that its a much heavier lift (it can always be done 
> incrementally to this patchset).

There's a reason the rest of the kernel uses fairly simple LRU (or
rather modified LRU / clock like) eviction policies like this, in
that the sampling is quite overboard.   I'm not going to keep you
from looking into this, but I don't think it's worthwhile.

> And, in genenral, I think that the server is in a much better position to 
> solicit preemptive delegation recalls as opposed
> to the client voluntarily return delegations when crossing a somewhat 
> arbitrary delegation_watermark.

Yes.  For that we'd need working RECALL_ANY support, though.  And
the way that works in the spec where the value is a number to keep
instead of a number to returns makes it pretty weird unfortunately.


