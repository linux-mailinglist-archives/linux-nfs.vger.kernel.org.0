Return-Path: <linux-nfs+bounces-22973-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q93iIwzGR2pDfAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22973-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 16:24:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35570362A
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 16:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=guFCZvS4;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22973-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22973-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 792F8302BE9F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC83D955D;
	Fri,  3 Jul 2026 14:00:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B543D952F;
	Fri,  3 Jul 2026 14:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087238; cv=none; b=L6oFSJMHtp7zqPmjVVCv0DE8orD+kf/r7IMjWr9hq9aP3oZ/AxRfW6XVnZ3eUrcq12L8TiSBCDQWv2/FyowEykCkZXVoHapozNCNF5/gt4YryH+J1fv3M8bZBv7mAEA3ZWHeNJxd0TtjKY9NOsYew/XhicwuL+7klZvfNjev2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087238; c=relaxed/simple;
	bh=gPdrYyD19U8h5KTS1KpcvRevDkPudiPDTBpd8PPpdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWWpQtqZc3I9DXl4rJk7kDIBh4dYQUyUYELS+D8Kp5ib4RNAI/OZRgEiRWSbincllibYmqesSmgUlIYuz1A2N/oaekp6sogIm9cWjKPzWJZQ4Z74W7/UKB/rHGOda107vv2e0KfhI2Y1pqGw4IIzc6N+rXt21r5i7WPWflhEWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=guFCZvS4; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1o/buuAM70ro2w2qAlzO4GrBf098Us7syxhzhfaB61o=; b=guFCZvS4BN1gP76TeAo6E6tniQ
	Y+eDokXVFHydQ+3Qdpyqn8BcdHR2fIdWupPIrii+HuluXb61w8g4IjyR0BlFBiEUyVJU6sgmgpRJA
	/ZLNf1sB1y7Ycb13cr04jl1xdHr26dMFcCz4F85hXgyYYDqtED4Rzju6P5r/klEEdxlU2oYsT8ja3
	AcIA5A65mTAcK/Q8Q9iv2BpXbkyHQBB/Gw53wFNzn/FMZiBo/5Gb/rjMX1IhjOAtF3wku8Hpgepv+
	aDBt1LheqQchSqB2/lUITW6ngmR1mmjfSkz7nuP3q8aottk/CXOJuq9EO/dejCZinAV2aHvrfkSpm
	ueyFl9Pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfeRX-00000007BgZ-0iaX;
	Fri, 03 Jul 2026 14:00:35 +0000
Date: Fri, 3 Jul 2026 07:00:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <akfAgy52s_Gch2KG@infradead.org>
References: <20260616134000.2733403-1-praan@google.com>
 <20260616134000.2733403-7-praan@google.com>
 <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
 <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akevQfFVteCOD6LM@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22973-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:hch@infradead.org,m:willy@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:from_mime,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF35570362A

On Fri, Jul 03, 2026 at 12:46:58PM +0000, Pranjal Shrivastava wrote:
> Do we have use-cases for a kernel user for direct I/O ? (Just curious to
> know if there's something on the horizon).

Plenty.  Basically any storage on file driver, or storage / file system
server:  loop, zloop, nvmet, scsi target and nfsd ar the ones I know off
by head.


