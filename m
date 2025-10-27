Return-Path: <linux-nfs+bounces-15667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E4EC0DF98
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C663AAEA0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E184280312;
	Mon, 27 Oct 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uz2pKmM2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB59280335
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571160; cv=none; b=DpQkaCYrYu7MbUP/HMxTjCyEDQC/B5p9HA8xRio82tsJWdmTO9GGQNJzJkDdZFqtxbsIj9j2QH1hJRoGtZ4jkQdvI4lUtST+Q1sjan+nc8pDdbC5DNFri/pTkraqYiyK2WAJ9c/6ScQR51J4opai8uYHTbjPr8HM5bEfNMCgye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571160; c=relaxed/simple;
	bh=u7IaoCtlCvqCGDWIDOJDmPsfaIiuussJbq9cnUc5Wqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsgZg2PKySTp7NWl2Mu9vFqQ0sjPnPhTMDapXSZi5/k0XL+wk7iShdf4r3yqgtJuVja+rec9klTdXCNUHHVkU0W68Ogv4zMZqb7KFkDiFV+0IgmvmejvZ/VhcQMuxfBps6ELJbhbpa3WqbIkMrXjkeb7SU9rPsBiGdm1grV+TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uz2pKmM2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b0+KylqGMWzzQnhSfPcyQcm0Lt+7Udinn7c0bHAy37s=; b=uz2pKmM2n/2/CkTq61PQRRlC7F
	TbvaG0XT1epJ67aSYneyXN41ZQMPTbHbTvlAB+CXu6jGoPSoUoJDw5E6VoCGmbRFByWuiL0+YMLbb
	KehC3UnUad08i39WfDriOTa6svOVxVk1pPhXZNQy2RRC5i2+w38b+7D0OoqJezgebYU5D4E5QZCqD
	tjVd6EDRM+hNIM7rmL3AbtQXaE0tgh8cNs9RrSm/8aWV6qnmrzd+yudmOUjVZ2ROnoz283ijQhGid
	omlc+K6wz1lhS6jqzt3r1bfiXC3NnqgmYJNJhuDm61s4b60f1UIfTWnm0MwzAbuMjsQrRDXv1Pa7m
	db9L0Okg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDN80-0000000E0E6-2ZiC;
	Mon, 27 Oct 2025 13:19:16 +0000
Date: Mon, 27 Oct 2025 06:19:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb
 IO associated with NFS pgio header
Message-ID: <aP9xVCiY5mYowEoN@infradead.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
 <20251027130833.96571-3-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027130833.96571-3-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:08:32AM -0400, Mike Snitzer wrote:
> Improve completion handling of as many as 3 IOs associated with each
> misaligned DIO by using a atomic_t to track completion of each IO.
> 
> Update nfs_local_pgio_done() to use precise atomic_t accounting for
> remaining iov_iter (up to 3) associated with each iocb, so that each
> NFS LOCALIO pgio header is only released after all IOs have completed.
> But also allow early return if/when a short read or write occurs.

Maybe just split the pgio instead?  That's what a lot of the pnfs code
does.


