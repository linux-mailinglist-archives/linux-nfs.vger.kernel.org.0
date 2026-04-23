Return-Path: <linux-nfs+bounces-21022-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WfuaLMSz6WkDiAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21022-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 07:53:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2C44D548
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA63B3020EB9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1438B7B1;
	Thu, 23 Apr 2026 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oqW5LJG9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B322868A9;
	Thu, 23 Apr 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776923578; cv=none; b=GHw09UVK1a22UzD505X24hbJzzz4Pw9CnTq1FlhPwwCLiD1ikzgFR69kIQo6VnA0tXpHF9CspV+O0hZZXVZdxyKpyhVxEfLUNnsFniQXfkuT16vY2uxzx1bf6p3ayruZEtCCG1dXPORIkMMFityZoQbEze5HBr2XNoE6GTsMXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776923578; c=relaxed/simple;
	bh=IzCwPU5c6Gq1BGhh1bSpdiyTomucNDB4qIjOeZl0cpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ4u6wPibtEhfoWDBWaiZjbnsoECYQ617yYyzpO/AoY/j/S0Ky6MYkTNyDWkY8Zv+i/4FD3j3+2jiBnB3uG4i9tDWSrfhX4ceOPbj2KYCWDSrmSjIhggDdxDlPYdNqeVhy1F5AJRJXeTiPpOG1LV7JAUj196cOwW5ttvLhw0SUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oqW5LJG9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9rvPFEC2MVsXs7hPa8zHFKo530p+I6oXYlmvjIl2f6c=; b=oqW5LJG9fBwRuI/xBRFobENbPC
	E2uvZY4hTPcJzshqHMNSCNbAq1dXR74jh5AhK6rjwJQopAwWdBcjljK/TRLi4yKxlGuQUND23+U8U
	w5Zkbj04KaIgmIEimRnmZGsrkmc9AMWznDHn4iFp/gJ+S7Wu9MyD79MuzxqNJa8IhFk2I4Y9/iTJ5
	AUSWR3mcrOicr1F20MyexfpWI0aRj2+sdb+t1QJtkJxTvNn7Uub/5MGetU1EoNeTpgEUYEx53Lf4R
	5ndHsoHJi23cbvWDVNz5n8B0GgeU76CG/iM63b2QSXHz+1hzOM3mbKOjt0jsx3G9XerWvX2ydjtku
	rEQfaDWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFmze-0000000B5Fr-2IF8;
	Thu, 23 Apr 2026 05:52:54 +0000
Date: Wed, 22 Apr 2026 22:52:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	samba-technical@lists.samba.org, Tom Talpey <tom@talpey.com>,
	Steve French <smfrench@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to
 fs/smb/smbdirect/
Message-ID: <aemztk8jTqgfKu4y@infradead.org>
References: <20260419192018.3046449-1-metze@samba.org>
 <aehrPuY60VMcYGU8@infradead.org>
 <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21022-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,lists.samba.org,talpey.com,gmail.com,linux-foundation.org,kernel.org,redhat.com,dubeyko.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: C1B2C44D548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:16:41AM +0200, Stefan Metzmacher wrote:
> > Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?
> 
> Yes, I also thought about net/smbdirect.
> 
> As IPPROTO_SMBDIRECT or PF_SMBDIRECT will be the next step,
> see the open discussion here:
> https://lore.kernel.org/linux-cifs/cover.1775571957.git.metze@samba.org/
> (I'll follow with that discussion soon)

Seems like it is the right fit then.

> I was just unsure about the consequences, e.g. would
> the maintainer/pull request flow have to change in that case?
> Or would Steve be able to take the changes via his trees?
> Any I also didn't want to offend anybody, so I just took
> what Linus proposed.

You might want to ask the sunrpc or ceph maintainers as they have a
similar split.


