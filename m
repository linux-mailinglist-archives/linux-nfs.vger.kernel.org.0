Return-Path: <linux-nfs+bounces-4675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28777929158
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6414B21741
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8181C6A1;
	Sat,  6 Jul 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPfMdzd1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFF1C69D;
	Sat,  6 Jul 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247863; cv=none; b=XQg5WZVKHFpZ0PMcVYfqHkrw9yziByvT+XX3PtXZNNStxJOlftAiSKAuNarWPsp59N2dYaIeErrmIZxuNubRHFcHZQy2P3ZAdKkSvS2ykOAfrykMFbeF6HDlnNspqe+tPPr6V1eyJhEm9zMpePDRNffGjUCmCAtXCR4gmSSwCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247863; c=relaxed/simple;
	bh=mpVeNGCQNUqckOt9MAHQ6xpXfdejNyp1ZjG2I3Wz070=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHVdtY6csEqwsPys0GoL0SHxl8pM8aoHmeqPNtjSaCtimtn2LyVQqYdPI3S+5W824kvhk7G4syEef4JNtAp7NX+B65CSpFdKIVlSQngF8L1rVAC9kQMc/S9hCen28nCc48RETqzy/AWJqijs7SVNMpOxhlYVg7Jzn9CFQ28Eqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NPfMdzd1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2ei2jHy0tKTz9T+QR59fculXGO1cEmWIvU72GaW0wF8=; b=NPfMdzd1x0PAyW8moGGDTv9KCg
	JDky/xA8TiFd61sHIQ36anL7z9f7WB/EjPLfwMIvqTHRPaJQrqnrE8O7RciZprikyNTvjSoIaif7N
	CinN78ZYVF7dklls3OfaXZyGrR/1+dGEuRT3cU9HlDO8kt/kZjLrDcTgo9I02mQkyVEzqKzCz25Km
	eqU8eXpbITYxX6kAcy2KiMxMZS1RKrG2rl2PormTuNAwA8GLLuSFuBx0z6SqLzyTfxg1KTZaq/rck
	kfoDfVI6zcqFQ9DursPgcsjA1JLWz/IWqNYB1CGWTIrdKb2wfulRE+8V8uQK3QyM3A4nlLplbE3NK
	aTYxYhAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPz3D-0000000HQUr-0Stg;
	Sat, 06 Jul 2024 06:37:39 +0000
Date: Fri, 5 Jul 2024 23:37:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"bfoster@redhat.com" <bfoster@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZojmMx7ERcBJMQ1j@infradead.org>
References: <>
 <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
 <172022597256.11489.7372525202519871550@noble.neil.brown.name>
 <ZojggALtQ3kqaJJo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZojggALtQ3kqaJJo@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Btw, one issue with using direct I/O is that need to synchronize with
page cache access from the server itself.  For pNFS we can do that as
we track outstanding layouts.  Without layouts it will be more work
as we'll need a different data structure tracking grant for bypassing
the server.  Or just piggy back on layouts anyway as that's what they
are doing.

