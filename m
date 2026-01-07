Return-Path: <linux-nfs+bounces-17578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EF8CFF55B
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643B7341DAFA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9836215A;
	Wed,  7 Jan 2026 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W00jzTOF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D40345CDF
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802667; cv=none; b=LJVpL1Gips253lK050Y/Ukgdwi3wPcXTVemO59PpFyw4jbxs5xBOeV3bGNPKz+swYFIrnLwb37VdOr/ERc1+j1eLD6L8l7RHUdrgksshcTGYiAsY/iE5nFLCstnJ4RAJwg99zCaFIX1IwakVdfEQLUzzep0B0bdeGSl1qSwqFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802667; c=relaxed/simple;
	bh=c5acPMwF/D8Irfog9QC7AVrgkqO2pLNEL4U+95gRuZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkGbbFubloDTiESprhl8hlscCGCFfe4zijSRm9bgyzT1e0IgqAIapNIKIOiZs6/dZvD2wiuNHO0KtNczEOjRCv9FTQtvRp5GnZoAGPRSJRBGVrVEviHdzJlgVsD5u1Ny5C1M3HCC7bXXzxeoUofhHA5fW+cAZ17gN+TWyMAu1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W00jzTOF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNEgP/QsTak0PEo56FIoLf7eoVQOnJn62tsn7Ep12TQ=; b=W00jzTOF842l7L5timrWz6skj8
	CkumLuktT9mfpB/0fLsLl1+pjRVZq8/K2qNM2EBQWUPcyX5LHJhmENJ4UJm/+RcxSMto1uW3ljYCc
	63Vdmx5Xds/VUldYkLbcLZ/HQ4BC511/ngvXARWHIvl0iwYLOZg6/QYNhxwFUwew5WDWu3ZIu+rkv
	KwmkST09wU9gEatUP8c2tZzX30YFlLwh8zyRLCj2Dr6WzKViYgBSva43VSQiWly28Abrlic0s1CTz
	YK/elriIuYVSabLhRZLbGPLNA4t0KGeLniSBn2op8nvjchvj7T9Y4XlnJ+UWIJosER5DFKxakS38G
	zdk1tc4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWE3-0000000FFER-2gKv;
	Wed, 07 Jan 2026 16:17:35 +0000
Date: Wed, 7 Jan 2026 08:17:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] NFSD: Track SCSI Persistent Registration Fencing per
 Client with xarray
Message-ID: <aV6HHwrkoR4OE5qc@infradead.org>
References: <20251227042437.671409-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227042437.671409-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 26, 2025 at 11:24:37PM -0500, Chuck Lever wrote:
> When the server issues a persistent registration key to a client, it
> creates a new xarray entry at the dev_t index with the fenced flag
> initialized to 0.

Hmm, using an xarray only for values is creative.  But I guess it should
work.

That being said, I'm not sure that is the right direction.  Right now
the nfsd code has no object for pNFS device, mostly because:

 a) there can only be one per file system and thus export
 b) there is no per-device state managed by nfsd

This patch changes b).  But I guess for now this works, so I should
demand too much.  But I guess in the long run having a per-device
object, and then tracking fenced clients in that would seem more
natural.

But with all the effort already invested it probably makes sense to
go with it to fix the bug.  Just trying to think about the data
structures in the long run.

> @@ -342,6 +343,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>  		goto out_free_dev;
>  	}
>  
> +	/*
> +	 * xa_store() is idempotent -- the device is added exactly once
> +	 * to a client's cl_dev_fences no matter how many times
> +	 * nfsd4_block_get_device_info_scsi() is invoked. This prevents
> +	 * adding more entries to cl_dev_fences than there are devices on
> +	 * the server. XA_MARK_0 tracks whether the device has been fenced.
> +	 */

Only in the most abstract way, xa_store actually stores the new
entry/value and returns the old one.  In other words, this does
quite a bit of work for the non-initial GETDEVICEINFO.


