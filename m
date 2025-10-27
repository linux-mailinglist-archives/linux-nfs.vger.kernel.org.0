Return-Path: <linux-nfs+bounces-15645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DAC0C384
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DCE189B502
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC121ADC5;
	Mon, 27 Oct 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5wjy+kT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850019D065
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552263; cv=none; b=EzF74BDuqBgEUzpuquEAAZGy6h/VS/ijQkWHiuUql/nGtyAbwrSR4joiM03F4YKd9dENWSO3aNZMO+8A1ljqGsNdwUK856iKHbNP6hny3MYXtD+TqKIz8fdiEfClGC30sq6a+WRLmevTkIJ4oRiiWDI/lG7U8PwIDpdwXcgBOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552263; c=relaxed/simple;
	bh=BkrVbBoLIw+A+cp2ivYkt4i3GZZzsSGrNqToYFYDtbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPIGuG5n0PP7vYVqRmbyPh2xL45eh+qOWfIx/Hvd+ZLTJ3Q5Hvwp63mZgc4oKckbvmwyk7x/9u1kBSmiDCjZpx3tkBSA/fGwW9idULv7+PNBDO9gAwbLyuHhXDRrrvAnTwzRAFNynYqmGKbv9g47JM806IWQ20BihZjx3gJuuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s5wjy+kT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nahbGIUSVAJYqf/9jKSRfhh/9K/YOZD+GDKO0FLetEY=; b=s5wjy+kTgjU/KA2wHPj5dqOl6g
	41rRyYeIJPDkknl9Pcv9Hio5p83Cv/TIPJffWde2JHSK40W00IsCBP0D0qZJu3R4SCZ29Nure5riS
	aotY/qxHabjBiLL6QeiT0bpqRZGO2v0MjwgzKQbvyM7luhz49ibknC6Pe1p8KskxqGP4gKcEG8+Lm
	fep5ERNOqqXL68mk0Hm7wfIy60a9IyNS94s88rWjqhUkDisjEoXzeTb7znSVaZfUg36IXGJ2VKf7I
	DAofCz4ci9FeVxgugBuS6i5Za4zl2vKZ5Kz5aSf+39WsO/nKHV9BYM/b45M/Tu1HzHsx0aiom64FO
	caa4sD4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIDE-0000000DK0Q-1wWu;
	Mon, 27 Oct 2025 08:04:20 +0000
Date: Mon, 27 Oct 2025 01:04:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v7 03/14] NFSD: Refactor nfsd_vfs_write()
Message-ID: <aP8nhKRySOU9LQFd@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-4-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 10:42:55AM -0400, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> Extract the common code that is to be used in the buffered and
> dontcache I/O modes. This common code will also be used as the
> fallback when direct I/O is requested but cannot be used.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


