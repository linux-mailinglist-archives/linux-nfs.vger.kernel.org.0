Return-Path: <linux-nfs+bounces-4673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055592913D
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079651F220F7
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0941865C;
	Sat,  6 Jul 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olHozxS+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA218645;
	Sat,  6 Jul 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246405; cv=none; b=ghR2Dr15BU5sEcKz31Fyf877WmF8YaAW2u50gZ6oHSYl48utER6qQ0vqUcbQ45owEwPmyT4AGStR1/c9BU9un1X4CCVHjBFlAcim8EzIzgODiGfhdlyl1n+G6sZhidi3i8RD4m/whHKO8kppGe28fVsBG8BgxN4FOYDZ+XPp4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246405; c=relaxed/simple;
	bh=zgPjnyVPvmnhbY1Pjo8pr0KWiS21OdAZwFhXXex+UxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/ElizskM4qDg+Zz58Vl6TQac39ecNA1/mDRvG+80oyNsPqDsiMeJBPnwOSKX7KLIhgTx3rAYtr8fBChRq7zw+J/nYNJxp/x08eJD0xhLGOu9BLnVlat7XTk9Y4NvAb1ecg1oI8j0008WEeMuDfk+ubgYaRS5sstwuJP5sF1wSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olHozxS+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v3Se2tzpNuTkrrZqdh6YZpjETUP8O7FZe/lbqAfc/Wc=; b=olHozxS+VLiB3efAQurFWNtkbO
	627a9kyhUanoLwngJ4Jo0aHI6L+fZnmvsSBhQoomenIMNzzJd5osGsASRtsXUPhVlSwK1p3YqwjvQ
	iVJGXgt+B4MvjkVp2XOSbxLaOWws9y4NMb1i0bZ+NKJiaUgUAm4iCzXqhBYktWgwzuv9KpfYJsonf
	VWJF03un2gdXgBswt9ALBypocUn6M8wM72Q47WPNjpeEjXVKw0XBviEJjNY8eEflvEOUidgmeKa9E
	vwmlLrDl4WYXxdIVlr8H9ysstAkDEHhumC3b22hxV3m93jMqzvqCTsjGAxQNhPhNvYFb7zJ/nkk77
	dJXA0FnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPyfg-0000000HPCS-1uSC;
	Sat, 06 Jul 2024 06:13:20 +0000
Date: Fri, 5 Jul 2024 23:13:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"bfoster@redhat.com" <bfoster@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZojggALtQ3kqaJJo@infradead.org>
References: <>
 <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
 <172022597256.11489.7372525202519871550@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172022597256.11489.7372525202519871550@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 06, 2024 at 10:32:52AM +1000, NeilBrown wrote:
> Would it be reasonable for the partial pages to be written over RPC and
> for only full pages to be sent directly to the server-side file using
> O_DIRECT writes?  Presumably the benefits of localio are most pronounced
> with large writes which will mostly be full-page, or even full-folio.

Yes.  Note that we already have infrastructure to always read the
entire page for pnfs block (PNFS_READ_WHOLE_PAGE /
pnfs_ld_read_whole_page) to make this a lot more common at least for
reads.

> O_DIRECT writes on the NFS side would be more awkward.  open(2)
> documents that NFS places no alignment restrictions on O_DIRECT I/O.  If
> applications depend on that then some copying will have to be done
> before the data is written to a block filesystem - possibly into the
> page cache, possibly into some other buffer.  This wouldn't be more
> copying that we already do.

Yes.  There is precedence for that in pNFS as well:
fs/nfs/blocklayout/blocklayout.c:is_aligned_req().


