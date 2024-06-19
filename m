Return-Path: <linux-nfs+bounces-4049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F02C90E2CA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C161F2214A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105654D9EA;
	Wed, 19 Jun 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsXbHdiS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A2FC1F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775888; cv=none; b=MaNXtTeq5dOWGYusWy1RR44eoTZ4A+c7REHEhle0431SGDO74fq5n9HqeO5lUdc5pi5GkHiNg5+Lsv39022kPRiJg/cYUvHyoEj24V+iVpUOxYcaR4+By+9fsGP7c6u/UZcn3vooECd47qTngZ+B4jGxMWhWkVvvCVkS5+c6Vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775888; c=relaxed/simple;
	bh=fpwovLni33tSyglIj6cTJi+cqJxXDYxwZ59vkjKEVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdILKPWgJ+5kmgQ0AAtc6pDrOYsGW/+Dy7RLabZI3SgmZgzPyrfkzc2UZa4uaTnEjK4G5p6jhCs3HARkjzB1SL2zdk9qcfIJsz0MsnWVIkL20Fvc1NL+kcidB1S4GT3+nK7ssPO9FV42N96ayHG+NFEw+eX7RpH/LU2LXBHYLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GsXbHdiS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kyKVXLwYh4dJrRkhLr86NG/l2xBoc+tx5MZKq1MP9HQ=; b=GsXbHdiSjxwGqjtB7Vlavl/N4j
	skTeCTjUPap7rQSkrIvmgFRUWHCWr50Wo3739iKKdkcMzA7Yj7bAGbCzLh28NQ7g7L7PZegaSkTIk
	/Ug9xnC+WNq2CsbEwA8PzP1LOYRhdP1dlA9P9byIEiWnZv/9b4KtdI8kxi6RX35zGs1Gtv3lZJwgW
	zEiYwrlGb/VF9/JmcX5Xl1M+Vp90DVZ6ZvoWHqLnJuiMqCjnobsgynsIfxWvbC7wnRD1e4jmXMKBH
	P8AujzGiIsJEWRa2CX48LI+JGTl9+vVtjiZNr1hF+0oiznwzDkPNvCENgTPQRy2bX+OSW+BaJheHp
	7UQO6o2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJo7h-0000000HY27-2Vih;
	Wed, 19 Jun 2024 05:44:45 +0000
Date: Tue, 18 Jun 2024 22:44:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Message-ID: <ZnJwTaTw5JEOnuLw@infradead.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618153313.3167460-1-dan.aloni@vastdata.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 18, 2024 at 06:33:13PM +0300, Dan Aloni wrote:
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
>  	struct file_lock_context *flctx = locks_inode_context(inode);
>  	struct file_lock *fl;
>  	int ret;
> +	unsigned int mntflags = NFS_SERVER(inode)->flags;
>  
> +	if (mntflags & NFS_MOUNT_NO_EXTEND)
> +		return 0;
>  	if (file->f_flags & O_DSYNC)
>  		return 0;
>  	if (!nfs_folio_write_uptodate(folio, pagelen))

I find the logic in nfs_update_folio to extend the write to the entire
folio rather weird, and especially bad with the larger folio support I
just added.

It makes the client write more (and with large page sizes or large
folios) potentially a lot more than what the application asked for.

The comment above nfs_can_extend_write suggest it is done to avoid
"fragmentation".  My immediate reaction assumed that would be about file
system fragmentation, which seems odd given that I'd expect servers to
either log data, in which case this just increases write amplification
for no good reason, or use something like the Linux page cache in which
case it would be entirely pointless.

But when following git blame over a few rounds of fixes (that all narrow
down the scope of this optimization because it caused problems) the
"fragmentation" eventually becomes:

	/* If we're not using byte range locks, and we know the page
	 * is entirely in cache, it may be more efficient to avoid
	 * fragmenting write requests.
	 */

Which to me suggests it is about struct nfs_page and the on-the-wire
RPCs.  In which case the merging in nfs_try_to_update_request that
merges consecutive I/O should take care of all the interesting cases.

In other words:  I strongly suspect everyone is better off if this
extending write behavior is removed or at least not the default.

