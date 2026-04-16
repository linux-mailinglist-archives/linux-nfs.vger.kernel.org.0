Return-Path: <linux-nfs+bounces-20853-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D+iMr5z4GlkgwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20853-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 07:29:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9E40A632
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09A4130157E0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5474367F46;
	Thu, 16 Apr 2026 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uqg96YTR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34F366806;
	Thu, 16 Apr 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317367; cv=none; b=Igdd/S3ddp5G75WZgD8Ws5AxBZSzMWLTJhcv/oi3CMfFTpiU25SuI+/qT1gh50T3TDOyKYi82lcf/mjPSQn4Y0ldDDRbMuHOlRPatcpcRWxWpkDup7FChGbG4cQcrXhuvSfWRCaknnkgcODpGr+aeIUJxsY/MqqYDXHZ9HXt0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317367; c=relaxed/simple;
	bh=65csE4SJIyCmwZ8dOKasKEb0fxc9vZ5B0Nhgq+X83+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGdwrTBZxne4qugV1N1imJN6LoH2jxfyD7J713j6EUDE9jGkXpOM0P/hao0Ab9JnpH5ZEIl6vlfREmW7JR4yO2yZER/Su2vSInzB3oKzCd1483LrYOLjFZ9p9ld+vISdkW4llaihgIoLflwYs5z21ypqJ0i2MRR3XZaHX1UWfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uqg96YTR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lIan6zHo4uwebu6y2FinLY6K38Ivl0WmlT9DFJMlJPU=; b=uqg96YTRFR4uE8Sw/DytpCxomn
	DWJRnzzctG6teekvmOzs+RXN/6ttAC4R1KdyK4+E3ktUQLecw1ivtsqfa/a6smLGECzSL/o0488kE
	VCS5gM4WvNGG+7cSzH8Ue1Kkliry5UVCHx6dvVJYOnr+ZaSha83Om3qAQ9G4MUv6ZryGjUTjb9a1s
	bLm1jEA4h1xmYJ0KSlg8KbM6V6ammX89VyYEPMgqbIkiqzKHc4Bt8qRn+ToBdfxHvEI3eTziNHcuW
	q4UtpRfr1sIcekupj1yzMriQSdg2xH502gX34yfbotVCU5IN11cFLnDF/xHf9fnQAki0e1trdJUVL
	Y8jHROLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDFI1-000000020Je-0k16;
	Thu, 16 Apr 2026 05:29:21 +0000
Date: Wed, 15 Apr 2026 22:29:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, trond.myklebust@hammerspace.com,
	anna@kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, chuck.lever@oracle.com,
	jlayton@kernel.org, tom@talpey.com, okorniev@redhat.com,
	neil@brown.name, dai.ngo@oracle.com, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] nfs: allow P2PDMA in direct I/O path
Message-ID: <aeBzsd3fWKp6YnbL@infradead.org>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-5-praan@google.com>
 <ac35ICYHuw4lEOri@infradead.org>
 <ad6c5fI0HsHkUbKH@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6c5fI0HsHkUbKH@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20853-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15D9E40A632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:00:37PM +0000, Pranjal Shrivastava wrote:
> > Please split theconversion to iov_iter_extract_pages into a separate
> > preparation patch, and even series.  That is a long overdue change
> > that fixes potential data corruption in XFS.
> > 
> 
> Sure, I'll send out a series with the migration to 
> iov_iter_extract_pages, should I club this with the pin-aware + folios
> for direct I/O or send it as a separate series?

I think combining all this sounds find.  I'd just do the P2P separately
as it is bound to get quite a bit more complicated.


