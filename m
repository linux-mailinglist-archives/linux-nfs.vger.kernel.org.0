Return-Path: <linux-nfs+bounces-17913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B0D25A9C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE4A30DC31A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F583279903;
	Thu, 15 Jan 2026 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Bdp0ZGI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F3225397
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493396; cv=none; b=olTBgtbsgvWs+Crpcymo7aU3Ad36vKChaQh68OB1rnZv0DUtU4B8TIZLq7kGu08O1e41DOXhS7JUkfMJ7y25FhcJYzpX39ZIjznzODxQduAOACdboeAfTbbN2S/hZTH79Q3ZFnkpO36VsIlkMrPNCNZqs86AK2reAL5PRiDm+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493396; c=relaxed/simple;
	bh=lGBBkkjXG7JLo4Rx5Vt8j8qPhz147l4omtWAl0ULDuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skzhjXWZs9R9zFQSO+/Mbb4n3bRJlaRH6RNsZ/MRvgzwwxA7OJkEkT1hXX7g+JVuUp8MjPcQBuVAGM+ucTgrSaAHjdiTg4d9cyaWN10i118hRyO0IgZn0wpGABPpbU+5LQ6yaNv+iCBzU1auMmdpCLs79iXxAs5Vfg4uuAKnjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Bdp0ZGI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nnvcP7RfK98YxEI54Q/4WDHiSbglB9Cq20ezrCnsuZA=; b=1Bdp0ZGI9ttpzApKid5/iBvtyO
	anfyYZm8fpFaX2qH2tdtNUMZ2ml16ESP0lzrfSTQe75F3TsjTDPisA8xJg2Yvfi6LuwRV2rzy7q+2
	wAA3nTVNZh5OXTk0KgnS0t+DM3fPbWl4WFtptJmiUHoR0HML/nim1psMiVggeVE14XHeKm5fr7KFZ
	B/LM2YfFo7LRapkEBTr2+UHQpRl+AxSgWH9l6ubEJH63WJWebUMfOE69Unc4z6yf8nFLaDbXK2Bv4
	g3Gw4j+MIUbiJtv1bdBiRQT3z+HCyj6wOxZfoYumeGZyRjNOYB9pZfTqqvssPz5ytatJ6h9m089I2
	71kmnaPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgPux-0000000CfBJ-2ALH;
	Thu, 15 Jan 2026 16:09:51 +0000
Date: Thu, 15 Jan 2026 08:09:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: steved@redhat.com, hch@infradead.org, carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] Rename CONFIG_NFSV41 to CONFIG_BLKMAPD and
 disable by default
Message-ID: <aWkRT_3i-yTBniHA@infradead.org>
References: <aWc5dO3fP4J67x0H@infradead.org>
 <20260114145435.826165-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114145435.826165-1-smayhew@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 14, 2026 at 09:54:35AM -0500, Scott Mayhew wrote:
> pNFS block layout is deprecated in favor of pNFS SCSI layout, which
> doesn't require the use of blkmapd.
> 
> Since CONFIG_NFSV41 (enabled by default, but can be disabled via
> --disable-nfsv41) is only used to enable blkmapd, let's rename it to
> CONFIG_BLKMAPD and change the default to disabled.
> 
> Distributions that wish to continue to include blkmapd can do so by
> adding --enable-blkmapd to their configure script invocation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


