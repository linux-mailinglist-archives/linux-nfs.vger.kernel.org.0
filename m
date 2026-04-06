Return-Path: <linux-nfs+bounces-20667-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM50JWtJ02k0gwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20667-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 07:49:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 074283A1A55
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 07:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3B8B300E625
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC331F982;
	Mon,  6 Apr 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aMkntTdZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EB2E1EFC;
	Mon,  6 Apr 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454568; cv=none; b=VMB3tlLUYEuKmI5VaurVQt6VI96OM2B1CcFFNTNr38s+FGrA+689c702m55DovouzQHN6x5NK4syd43BE+8HIoMo58rDAGTnpXTRGgppwqPUHCb/iu2yxLbzfarT55m++XXkhY5JJ77JACiNKy1w3sV3mkmPGXC6mmi2x0KM43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454568; c=relaxed/simple;
	bh=KM+X2KZEqBDA/K5dp30dFrpiPmLj69S+fufNYc2cU2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9T9cchlaGCJoKTOorpkwJsHQy3TdlEXJmsk12cMZ49jf1NYD3t2LFA1bsrAYRCXDu56ZJ8z8JqCwXzE2gPnciyh/ES9mhaVkpM7duyTCZPAiw9BnrhvQjiqXXD6C2SruJ/MaGkOIJ2kmLliO10bvPgLvGJ89tVWt0kS9Iw/Uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aMkntTdZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6WWXWZMI41Am3IOMc7V4QgXpbUSV0Yys/y4z2vFj0+U=; b=aMkntTdZNJnKIOOxVJAW0Dcitj
	5A3rbsHMazHEWugGsyUSoquIwVRWzA+1t4rpE1kiP7C2zi0C+12p3Mg0321M3Gspnxbie8PkrchOf
	YL5gPP30MTxuVja7u8F2A3zQNDCJDMLkZz1MqPrSy930AE6sMtFBo2oRZBRQKzBX+L9M0EpToOCa1
	ociP97dZmUvsZXgZh46Wp+XTT7xCh8Pz6PTJlnZ5owTujnFESE/ni8q27LKuU2dkmlRfwygAqwyC4
	dRFU/zZ0EZ7mtyjztdyfi3muuDiWGVwAAmr3M+AxcQ1zgRt7fIoDGatFJqeUKLRu3nuYUm3KRJKx6
	E8ikz8MA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9cpw-00000004p6U-2Mgw;
	Mon, 06 Apr 2026 05:49:24 +0000
Date: Sun, 5 Apr 2026 22:49:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: add atomic flush guard for IOCB_DONTCACHE
 writeback
Message-ID: <adNJZBXeJomWmhdf@infradead.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
 <20260401-dontcache-v1-2-1f5746fab47a@kernel.org>
 <ac3-SU7BElHJVCEL@infradead.org>
 <629f21c6591903512eb2f3f3c4d6b14a9ac7b91a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629f21c6591903512eb2f3f3c4d6b14a9ac7b91a.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20667-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 074283A1A55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 08:49:45AM -0400, Jeff Layton wrote:
> > Have you considered stopping to do in-caller writeback for
> > IOCB_DONTCACHE vs just leaving it to the writeback daeon?
> > 
> > Either by totally disabling the writeback and just leaving the
> > dropbehind bit, or by queuing up wb_writeback_work instances for
> > the ranges, or by just increasing the pressure for the writeback
> > daemon.  Note that with all schemes including the one in this patch
> > we might eventually run into writeback scalability limits, which
> > will require multiple writeback workers.
> 
> I did test a "dropbehind" mode that just set the dropbehind bit without
> doing the flush at the end of the write. It was better than stock
> dontcache but the tail latencies were still pretty bad.
> 
> I think having each writer do some writeback submission work makes a
> lot of sense. It helps keep the dirty pages below the dirty thresholds
> and doesn't seem to tax each writing task _too_ much. The trick is
> avoiding lock contention while doing it.

Well, an any time you hit a shared resources from multiple threads you
create that lock contention.   Which is why in file system and writeback
land we've moved away from random user processes hitting both data and
metadata (e.g. XFS AIL) writeback as it leads to these scalability
issues.  At some point we might run out of steam in a single thread,
although so far that's mostly been because it does stupid things
(e.g. writeback on file systems doing complex allocator stuff).

> I think what would be ideal would be to have some (lockless) mechanism
> to say "there is enough data touched by the range just written to kick
> off a write that's a suitable size for the backing store". Each writer
> could check that and then kick off writeback for an approprite range.

And that is called the writeback thread.  So what we should do there
is to make sure we queue up writeback on it for each dontcache write.
Initially queuing up a wb_writeback_work for each range might be first
approximation, although we should probably find a way to just increase
a threshold if going down that road.

> I think this even could be beneficial in the normal buffered write
> codepath too.

Yes, we've had lots of observation that the current 30s timeout is
actively harmful.  Especially on SSDs, but even on HDD just keeping
the active might make sense.


