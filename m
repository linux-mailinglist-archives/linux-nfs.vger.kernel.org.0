Return-Path: <linux-nfs+bounces-11001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FEA7B915
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A1F7A6F9C
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Apr 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3DE19CCF5;
	Fri,  4 Apr 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBD2Nsm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADD190462;
	Fri,  4 Apr 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756058; cv=none; b=JOFfp/78fLs/Ege+ZDpeWFUmnIXN/GQuLYROQ5NIel7Hg+260PrBruIrjv5mccdmsmF9VzrtX0Q502j0v5XLOR2OcnzCZ9up5oggv7kKMd3tW6zRMPZu/XiOjZIiB9JkAquZjUr/CM1nOS9NZtflKm/joN2TnK53sA0b4GpL2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756058; c=relaxed/simple;
	bh=mgWlpdtAZtS9MzZFKC2ROkD2L4zM4MSAKa2DQRqJcU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgYrUZOP0dMIZV31QcerI+CKaVIr1+qdjeabn7QfRmLGSKq+I3zo5biAl9XaHHDHvvnyBXmAeNIeca7VDrOUP/G+kO8bH90lkU+iK/YBmBYwAHm63H9XxWA/5N3R7vVtI27/RP9AMo7Bgf0Ko3coMtANBJ308DeF4YMUF8mWZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MBD2Nsm5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/o5JY8rHVbpSAUZBEImi6JefrhFq8j8aWHFRiUENmgk=; b=MBD2Nsm5RhEO/7aXU7MI1VmUzm
	LIlfUS2tldABU92HagptKWIGQ7jT8eFKP4RYxwJFLpRmJkT0upfYq4HhnhqI2HZN6rUjvbmyrMjSc
	SVn/Jw1QV5sIvPa/xHmRrarGqknZWnCqg7nLHS9+AsozKOO+ZlYprzBpmAwW+ZH80DH3k+tluQqEy
	pSHunrlka5O9ySNKtoLfSSkdzyrDGlQZ5i58q1LmqHsAPLb6F9rUMCoaS/Qc8wj7LgLQxFdKCkgTB
	2IaSkMK9fU4vfUwpRCbkoMA8p+YSq+96UjQnYqscHvxnkTPNUL0SSBHWcJAaidHWNlYDM8yjjb9Bv
	4mN4596w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cbf-0000000BAtH-3Iu5;
	Fri, 04 Apr 2025 08:40:55 +0000
Date: Fri, 4 Apr 2025 01:40:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sheng Yong <shengyong2021@gmail.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-kernel@vger.kernel.org,
	linux-mm@archiver.kernel.org, Sheng Yong <shengyong1@xiaomi.com>,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] lib/iov_iter: fix to increase non slab folio refcount
Message-ID: <Z--bF9D8FFqVZ-s5@infradead.org>
References: <20250401140255.1249264-1-shengyong1@xiaomi.com>
 <Z-v2ReHKyFIXQlKs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-v2ReHKyFIXQlKs@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 01, 2025 at 03:20:53PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 01, 2025 at 10:02:55PM +0800, Sheng Yong wrote:
> > When testing EROFS file-backed mount over v9fs on qemu, I encounter
> > a folio UAF and page sanity check reports the following call trace.
> > Fix it by increasing non slab folio refcount correctly.
> 
> This report needs to say what the problem _is_, which is that pages may
> be coalesced across a folio boundary.

9p/virtio also really needs to move away from iov_iter_get_pages_alloc
and to iov_iter_extract_pages.  That way it properly pins pages for user
memory and doesn't do the pointless page reference for kernel iters that
triggered this.  Of course until all callers are gone this fix is
needed, but the caller also needs fixing to use the proper interface.

(Same for ceph and nfs)

