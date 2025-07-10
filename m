Return-Path: <linux-nfs+bounces-12972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC29AFFB4D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC697A9DB7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45D1DFFC;
	Thu, 10 Jul 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5Y7rzio"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222123B626
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133667; cv=none; b=UmE3wpJEZxe3Z4L6zOT33a99Hc6NszdqlsE0T0EDHxqIf1cU70AWSFf5/5D0XWXnlwD/bCfPclfbd+ziy2DSs53LLw6NQYxZqmcEkcziFOiquzYG0Z5irVuwM3ad3he8Nc9hCA0L60cAN0nstOHFvlDAeXfdIenH6390egA49ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133667; c=relaxed/simple;
	bh=7cf7trIEQ3YtKFcJ+ESgUEr8rO62oVogv0Za+1n9Dx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5ZL2FnHa7SGk89oggPl/67hY9Qjm8Bhg0Drk6X3leZj3+6zAHYFGN90Sr5LLlGftYzftq2XoWglB61yb2YDrYV2FPWgts6S7xVjZp32oJ+QBB1QWHFPApbqm2TAi3SocME+Y3pp37JF3BLw6w7OSerK+lQQEEYTkqjyycx+x7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k5Y7rzio; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h8VUqtvr2+3mKyfVaJSgfHOH4o0Gf4zcM0PF8e7nB0s=; b=k5Y7rzioMVEPY8f4pFA7c7YQU9
	RUEuftiFzNnSytH+T5aU5pMuhmFXkjpS+k8Sw1YLrPwKkr+zZrUnnXgRFB+xAUxoXyzjP7L4Nkqoh
	fkJ3Xr2d3QbVs2DeNzmT3KMGFS7oWVeAZqtX+RUMOqgqVeRgHy2R8SMj+7gRDuSLOb2tq9dNMOhwt
	34oaNdPHoxxEM/wFTwU1QhUDJUP5QF9fIlGEBpaIn0yC293pT+PteSx9mz6BZXWOdSDM1FT9F21HF
	8bR9jWo6F8qAqgRL2cuUPQUqO43EIZg4B2voEZIwetOXaga8OH/xjmXuK8wcAr1G3MEAkNhBPxeka
	7OtqNmPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZm0O-0000000B4HI-01Gh;
	Thu, 10 Jul 2025 07:47:44 +0000
Date: Thu, 10 Jul 2025 00:47:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs
 interface
Message-ID: <aG9wH973C-8W2YWw@infradead.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-7-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160619.64800-7-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 08, 2025 at 12:06:17PM -0400, Mike Snitzer wrote:
> Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> read by NFSD will either be:
> - cached using page cache (NFSD_IO_BUFFERED=0)
> - cached but removed from the page cache upon completion
>   (NFSD_IO_DONTCACHE=1).
> - not cached (NFSD_IO_DIRECT=2)
> 
> io_cache_read is 0 by default.  It may be set by writing to:
>   /sys/kernel/debug/nfsd/io_cache_read
> 
> If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
> advertised as supported by the underlying filesystem (e.g. XFS),
> otherwise all IO flagged with RWF_DONTCACHE will fail with
> -EOPNOTSUPP.
> 
> If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
> relative to the underlying block device's logical_block_size. Also the
> memory buffer used to store the read must be aligned relative to the
> underlying block device's dma_alignment.

Does this also need some kind of check that direct I/O is supported
at all by the file system / fops instance?


