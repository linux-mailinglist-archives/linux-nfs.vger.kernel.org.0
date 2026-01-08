Return-Path: <linux-nfs+bounces-17620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE414D03FBB
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 835883024B9E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9A1DF736;
	Thu,  8 Jan 2026 15:35:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F62DB791
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886554; cv=none; b=dtJKdkgb1vmuoDy+Us+NyXWecDghptkUy7VYPnvU1Xnd80NTf3ngR+E9cAKB/7HaSUK4e+asG3yKpks54jfgFcOJxjtoCQwehMyXR9sX0z5p+H9bIK7M/DiOYENKKK0E34erMHqD3bkk+oyBfuD6PWGxuvB5hogY9TtVvQiO8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886554; c=relaxed/simple;
	bh=hW+Vui6mROgnB2D8+UB1HP7nqJ5ZaH0GN9WoITM/W3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J08uS3H1h8ka87ZMKjUivk5ZNO2zyIEYG+XJ2idAVhi8WF4xmVA9KqRPjb5ohqdzTX8Nu912VtOaMX0Afa9RH+vw1UbHid8yjP4i50XBIA4mVBulT/C+vxwYYY7aqVLocz3v3/0C69T3AHbkSlDN3xAlifBNuZ8bkprC54XM4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3716B67373; Thu,  8 Jan 2026 16:35:46 +0100 (CET)
Date: Thu, 8 Jan 2026 16:35:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: add a LRU for delegations
Message-ID: <20260108153546.GA7623@lst.de>
References: <20260107072720.1744129-1-hch@lst.de> <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com> <20260107162202.GA23066@lst.de> <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me> <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 08, 2026 at 09:34:28AM -0500, Chuck Lever wrote:
> The server and client have orthogonal interests here, IMO.
> 
> The server is concerned with resource utilization -- memory consumed,
> slots in tables, and so on -- that other active clients might benefit
> from having freed. The server doesn't really care which delegations
> are returned.
> 
> A client wants to keep delegation state that applications are using,
> and it knows best which ones those are. It can identify specific
> delegations that are not being actively used and return those.

Yes.  A good way to deal with that is implementing RECALLY_ANY as I
mentioned, which with these changes could reclaim off the end of the LRU.
But as this series is a big change already, and doing fine grained
recalls is another huge one I'd rather wait a bit before going there.


