Return-Path: <linux-nfs+bounces-10366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE9A463E0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECE91899811
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4D22257B;
	Wed, 26 Feb 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qivxHtE+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14B2222CB
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581895; cv=none; b=c8W0pTKCEg+cPDs6Ysh6kQRgIt5Zv/ysVjvpD+Sq7Yz1ZIaJ5tgmgVCoKuxcpKYVQUV76NYQpXjzUvxZlWw0b6hbvr6TkKmj+y9/ztps59CxngkCd6/u0qFTeVobxIHps1psHac0VgrNyoqI2QUWhwu8y5EGbuVEiXt3RibR0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581895; c=relaxed/simple;
	bh=hfd7YktAJEL/+4x55BPXs30FRvmOb85yJAlZE29LPBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F01YT2EyNiQDeJB/tP3ciTTt7bDwYy9vIPKkYgpL2aFgglTZ7a+Mnekjc1Dj5CpnB7FoNTL2jUW3VAP8nQ9/+5Kc7ykl9ZmK06z2RMeq38E6mJj6SctEUorEAO1fCfsphbMI0NZnwH7RS+vKTU3/Zz8RlaZpTTBc+FpOpotPTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qivxHtE+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PznC79PO5IpcxM7GcKI/cT7ngDfHrWz/MtQoqsCph5k=; b=qivxHtE+QBcrilK0C2FCy0Ua6p
	1+tkxM5bIUTIeTL7lG6+t/IafF6JgK+dqUyjOsg6sdUxaZgxR7T7LUOltTVE8SwxNdAX2bJL9FMML
	xYCZ1ckMfhHd3Ej5yd19D4593gKQcaq56DZdFhCIh16PlEzluHs9MOpRy2gqIVkt/OHXA02YoMLF2
	sQPUy5bLBih3TCPhsKMzkjAxW3BDXLWTbTqF+XOlUWIOHnS8TRrllRU3JHFehnPki7Z4aC3iwmJpD
	oRE2Ppst40+u0Kk5fu/sq1bxqYDx1q/lIeiY8xR9XQs1RQxIV53PBVOOJS79DMo35FN3RZoqAOCDn
	+rOrIH5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnIrT-00000004Bqu-2wi9;
	Wed, 26 Feb 2025 14:58:11 +0000
Date: Wed, 26 Feb 2025 06:58:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not call nfs_wb_folio() from kcompactd
Message-ID: <Z78sA-7_u5SyuFSw@infradead.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225003301.25693-1-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 24, 2025 at 07:33:01PM -0500, Mike Snitzer wrote:
> Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
> it so nfs_release_folio() can skip calling nfs_wb_folio() from
> kcompactd.
> 
> Otherwise NFS can deadlock waiting for kcompactd enduced writeback
> which recurses back to NFS (which triggers writeback to NFSD via
> NFS loopback mount on the same host, NFSD blocks waiting for XFS's
> call to __filemap_get_folio):

Having a flag for a specific kernel thread feels wrong.  I'm not an
expert in this area, but as fast as I can tell the problem is that
kcompactd should be calling into ->release_folio without __GFP_IO
set.


