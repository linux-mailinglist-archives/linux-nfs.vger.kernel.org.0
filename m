Return-Path: <linux-nfs+bounces-22276-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkWwDx2SIWqMJAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22276-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:56:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D082964124F
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=niy8gQ+G;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22276-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22276-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 936D8312CF27
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB432D7DE9;
	Thu,  4 Jun 2026 14:46:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09A2EA732;
	Thu,  4 Jun 2026 14:46:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584403; cv=none; b=nYCgH+12EcwSHr53FlXnGbFBYs/M5z4cU8SEGFH8l4bvlzfGjKf1Qxui73hyqfhCDmYmg8rO7jE3rIi2Omt/WTjOnARItL7LwVTwFzoVnwU8FGBmUnhcZr3Crm1YqPnJNyzeJ9bQcS7wWHlGB0D/mZ02g659AaTRdYv0YZbMb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584403; c=relaxed/simple;
	bh=kUWiuBPrxX5exwSfkCtfd/7XL6RB7gxIWFebCVnPH+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDtUT33FqSpfxCRlqFR1WRslNubLxUu7ci2cXZKqm9UaA3L6VfGIkdXH2J3uQ43Itk8yvR/kIHeaZyWWPztXzqYre2QdZ/+ORf7nct7Y0iEjSFzhQbuAz1gDY4F8YVbBJ/+fuzkPFEjnb7mRVIzAnyaQcv41e4m7Ow7VEA15bIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=niy8gQ+G; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V97EjziPWX7/aWg2UdD5uDnb3HG95TQLDqrOqOVej0g=; b=niy8gQ+GsklXMudI64cl6QUE5W
	PusadtssOexwTK1gOY6YfSiIZk8qPfZMLZqZKDbr2D9LPzlERlOwh09zygRqx6HxjXCXGcJdtAmMZ
	POnFqCq8OdkcmIyEb3PuLPIJ/nK6lenV0stesjXWfqY6rKtaoE3LSDfNLS78swMmacO3n535Gxceq
	wKrVGtNXL+RjdTXGduiuwW/Q4ykv06GRzswmQ0A/KbL0BfZHRne1PUTDKZ+lC8lW4UKqno0rOScRt
	IfLWtpjB3ixeK+TFnCGQOcwvyFIDtsJICOpf/lUWnYXrasc19dnYxhzIBgS838XtY6oODL/hZp1Im
	/tbghusA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV9Kt-000000064Qn-0gwN;
	Thu, 04 Jun 2026 14:46:19 +0000
Date: Thu, 4 Jun 2026 15:46:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Mike Rapoport <rppt@kernel.org>, Jan Kara <jack@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <aiGPu2XwaM31fvl9@casper.infradead.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
 <yfzx3jgzwesernofl7mzixa2mhjfii5v3o7yapghtmozixrpfu@6bsh7iixyiov>
 <aiEX4UTxEnBTjVKo@kernel.org>
 <ximvn6jwgtam665a4droqkp73o55kwvd5uukyidwjesmysobth@oe7rigpsjfkz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ximvn6jwgtam665a4droqkp73o55kwvd5uukyidwjesmysobth@oe7rigpsjfkz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22276-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:rppt@kernel.org,m:jack@suse.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:konishi.ryusuke@gmail.com,m:slava@dubeyko.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shaggy@kernel.org,m:miklos@szeredi.hu,m:a.hindborg@kernel.org,m:leitao@debian.org,m:kees@kernel.org,m:aivazian.tigran@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:konishiryusuke@gmail.com,m:aivaziantigran@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,casper.infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:from_mime,infradead.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D082964124F

I'm hoping you'll take my "Remove special jbd2 slabs" patch instead of
this one, but answering here anyway ...

On Thu, Jun 04, 2026 at 10:05:52AM -0400, Theodore Tso wrote:
> On Thu, Jun 04, 2026 at 09:14:57AM +0300, Mike Rapoport wrote:
> > There's no memory overhead when order == 1.
> > As for the CPU overhead, the difference for the fast path allocations is
> > not measurable and for the slow path it is anyway determined by the amount
> > of reclaim involved rather than by what allocator is used.
> 
> Thanks for confirming!
> 
> > Larger allocations (> PAGE_SIZE * 2) go straight to the page allocator.

That is a detail subject to change.  I have some ideas ...

What users are guaranteed is that kmalloc returns physically contiguous
memory.  And that if it's a power-of-two that it's naturally aligned.

> Another question: Today, we can either use kmalloc() (or
> __get_free_pages, previously) or vmalloc().  Is there a way a file
> system can say, "give me physically contiguous pages if possible, but
> if it's too hard --- with some TBD to specify what 'too hard' means or
> can be specified --- fall back to a vmalloc-style approach, with the
> page table / TLB overhead that this might imply"?
> 
> I suppose we could do it with kmalloc() with some flags which to
> prevent forced reclaim / compaction, and if that fails, then fall back
> to vmalloc().  Is there a better way?

I think we'd like to avoid doing that.  A lot of code has various
workarounds for deficiencies in the memory allocator (some of which have
been fixed and thus the workarounds only complicate matters).  If the
memory allocator(s) aren't providing what you need (be it performance
under load, fragmentation avoidance or whatever), it's best to get that
fixed rather than having fallback paths.

There have been people who have suggested "What if folios could be
physically discontiguous", and sometimes I've hhumoured them, but the
simplifications enabled by requiring folios to be contiguous are quite
immense.

We've been trying to move in the direction of exposing more high-level
APIs so people can say "I want to allocate 10MB of memory but it doesn't
need to be contiguous" and have the allocator either fail the whole
thing up front or make efforts to ensure that you get the whole 10MB.
It's a lot more efficient than calling get_free_page() 2500 times
and possibly having reclaim run a dozen different times.

(anyone else try to create a brd that's actually larger than system ram?
;-)

