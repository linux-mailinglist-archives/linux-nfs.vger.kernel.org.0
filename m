Return-Path: <linux-nfs+bounces-10367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA5A465AC
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E434E1641FA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BE218ACA;
	Wed, 26 Feb 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+4YoYln"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3FA19ABC3
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584657; cv=none; b=FXDAyV21cR4/ZjaX7um3KsRFqLYdxR3mzRKMFbcUemlMVP6Skr/IJ6+ZxdMQNhFt+Tx+lZ21Qyo1fK4Urhcf2EB8KyY5Jt/RImtIJTXDBWYGDfA6PpVJ19cqYu7vqQU9fNhLnMG6OeelhBEky/V56kwya5ozMGL6YQC7KjiifCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584657; c=relaxed/simple;
	bh=8dEsgtqTU/tGSbWi38tS+O41CwAYK5wgCdXuIisEbuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEW/A4kqopfoffiC/Yf1dVyPOAMMBcQxOid4B2Be3/8jPcLk3b4aZocT/b1zLQ4rq5ApEHNc+xxlOwr2rur0LdCpFEkHtCnemt5P76s4KtKGPhDnlmNn6IJkhArmWXlzooz2kOm+PvR/KqwcbDpGDeqItIwo7zQmd/ERXKXEwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+4YoYln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7BCC4CED6;
	Wed, 26 Feb 2025 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584656;
	bh=8dEsgtqTU/tGSbWi38tS+O41CwAYK5wgCdXuIisEbuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+4YoYlnn/WyUEqfpUpNJ34EadJXcyAEulZ+GzsKWJuxYJwb/LzFemowkRfY5Agxs
	 jXoyUp/QIhpn6iNhmg5+BThflQVrcpTlMQkIbnRzHIZVlKi34WM6UNZf+46RrLZZ2H
	 GyWjlnm8sOC4xe629ZPseqx1QWlKRmmKD8b7iBLf1jyUYxjLDPS7jmK8fXM+duStBq
	 LlCrqIT4cJaiQnQMHALrRQmQdcM7uczlAln1WtTrD51ohZFEFMxzrw/EtSotwQP8aB
	 AIttx8r8+Ph03PrV5ziASc8JY71BvgztUIa42JXA10zOftqzKhgFkRtv/54ktMd1JP
	 YEW4PTLGYOYoA==
Date: Wed, 26 Feb 2025 10:44:15 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not call nfs_wb_folio() from kcompactd
Message-ID: <Z782z2suQAtBcS9j@kernel.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
 <Z78sA-7_u5SyuFSw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78sA-7_u5SyuFSw@infradead.org>

On Wed, Feb 26, 2025 at 06:58:11AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 24, 2025 at 07:33:01PM -0500, Mike Snitzer wrote:
> > Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
> > it so nfs_release_folio() can skip calling nfs_wb_folio() from
> > kcompactd.
> > 
> > Otherwise NFS can deadlock waiting for kcompactd enduced writeback
> > which recurses back to NFS (which triggers writeback to NFSD via
> > NFS loopback mount on the same host, NFSD blocks waiting for XFS's
> > call to __filemap_get_folio):
> 
> Having a flag for a specific kernel thread feels wrong.  I'm not an
> expert in this area, but as fast as I can tell the problem is that
> kcompactd should be calling into ->release_folio without __GFP_IO
> set.

We can easily remove PF_KCOMPACTD and current_is_kcompactd() if/when
more analysis and a cleaner fix emerges (from you, mm experts, etc).
I'm not saying you're wrong about GFP flags needing to be clamped by
kcompactd's call to ->release_folio, but it seems more finishing work
needed.

As you can tell from my patch, we already have kswapd specialization
with PF_KSWAPD and current_is_kswapd().  A consumer of large folios
knowing that it being called as kcompactd is useful, hence my fix for
deadlock seen with NFS loopback mounts on memory constrained systems.

Mike

