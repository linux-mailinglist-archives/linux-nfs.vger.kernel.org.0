Return-Path: <linux-nfs+bounces-13010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB44B0337B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12167A2D0B
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Jul 2025 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28720C47C;
	Sun, 13 Jul 2025 23:34:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DC2046A9;
	Sun, 13 Jul 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449649; cv=none; b=WgeKAGwxvProddVmGFH/LRgyUQiX3nQAHzT52Lrev05L3RapW2+KxypDNpgP2qyhlcLDW52VYFoBSAFKd3YM5uAmQtGNxTI+j+yj/yM7iL5cMgpP9uwds70BEgvXr0AHZgI57KpoL7cPu5bo/SpcUDRrzQZYd3JT1QrNe1L/Pb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449649; c=relaxed/simple;
	bh=6DG8NAACMILXKaMlbU8GB8DRW2CNIB9FDBfmc0ujtLo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=noWPr9txrY6J+ZbkCRQTA1KB2p39iMu1yTU0tW5vctUviyUeAgHvylnfQ7XpxM+3xHQPiCCvqBlH7TYVJfo240Gl8AHmb7N1kH/oGT1rDZPrYj/igLERRZX/j9cdZvI0IDRtYYihp+pfwxuoRj0VlAwpWtNwE8OcRrkAOl+6dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub6Cf-001vVc-PP;
	Sun, 13 Jul 2025 23:33:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Tom Talpey" <tom@talpey.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Su Hui" <suhui@nfschina.com>,
 jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
In-reply-to: <ea472081-a522-4c5a-8658-909793f460c8@talpey.com>
References: <>, <ea472081-a522-4c5a-8658-909793f460c8@talpey.com>
Date: Mon, 14 Jul 2025 09:33:54 +1000
Message-id: <175244963489.2234665.13068379727765444902@noble.neil.brown.name>

On Sat, 12 Jul 2025, Tom Talpey wrote:
> On 7/11/2025 10:22 AM, Chuck Lever wrote:
> > On 6/24/25 6:15 PM, NeilBrown wrote:
> >> On Wed, 25 Jun 2025, Chuck Lever wrote:
> > 
> >>> What is more interesting to me is trying out more sophisticated abstract
> >>> data types for the DRC hashtable. rhashtable is one alternative; so is
> >>> Maple tree, which is supposed to handle lookups with more memory
> >>> bandwidth efficiency than walking a linked list.
> >>>
> >>
> >> While I generally like rhashtable there is an awkwardness.  It doesn't
> >> guarantee that an insert will always succeed.  If you get lots of new
> >> records that hash to the same value, it will start failing insert
> >> requests until is hash re-hashed the table with a new seed.
> > 
> > Hm. I hadn't thought of that.
> > 
> > 
> >> This is
> >> intended to defeat collision attacks.  That means we would need to drop
> >> requests sometimes.  Maybe that is OK.  The DRC could be the target of
> >> collision attacks so maybe we really do want to drop requests if
> >> rhashtable refuses to store them.
> > 
> > Well I can imagine, in a large cohort of clients, there is a pretty good
> > probability of non-malicious XID collisions due to the birthday paradox.
> > 
> > 
> >> I think the other area that could use improvement is pruning old entries.
> >> I would not include RC_INPROG entries in the lru at all - they are
> >> always ignored, and will be added when they are switched to RCU_DONE.
> > 
> > That sounds intriguing.
> > 
> > 
> >> I'd generally like to prune less often in larger batches, but removing
> >> each of the batch from the rbtree could hold the lock for longer than we
> >> would like.
> > 
> > Have a look at 8847ecc9274a ("NFSD: Optimize DRC bucket pruning").
> > Pruning frequently by small amounts seems to have the greatest benefit.
> > 
> > It certainly does keep request latency jitter down, since NFSD prunes
> > while the client is waiting. If we can move some management of the cache
> > until after the reply is sent, that might offer opportunities to prune
> > more aggressively without impacting server responsiveness.
> > 
> > 
> >> I wonder if we could have an 'old' and a 'new' rbtree and
> >> when the 'old' gets too old or the 'new' get too full, we extract 'old',
> >> move 'new' to 'old', and outside the spinlock we free all of the moved
> >> 'old'.
> > 
> > One observation I've had is that nearly every DRC lookup will fail to
> > find an entry that matches the XID, because when things are operating
> > smoothly, every incoming RPC contains an XID that hasn't been seen
> > before.
> > 
> > That means DRC lookups are walking the entire bucket in the common
> > case. Pointer chasing of any kind is a well-known ADT performance
> > killer. My experience with the kernel's r-b tree is that is does not
> > perform well due to the number of memory accesses needed for lookups.
> > 
> > This is why I suggested using rhashtable -- it makes an effort to keep
> > bucket sizes small by widening the table frequently. The downside is
> > that this will definitely introduce some latency when an insertion
> > triggers a table-size change.
> > 
> > What might be helpful is a per-bucket Bloom filter that would make
> > checking if an XID is in the hashed bucket an O(1) operation -- and
> > in particular, would require few, if any, pointer dereferences.
> > 
> > 
> >> But if we switched to rhashtable, we probably wouldn't need an lru -
> >> just walk the entire table occasionally - there would be little conflict
> >> with concurrent lookups.
> > When the DRC is at capacity, pruning needs to find something to evict
> > on every insertion. My thought is that a pruning walk would need to be
> > done quite frequently to ensure clients don't overrun the cache. Thus
> > attention needs to be paid to keep pruning efficient (although perhaps
> > an LRU isn't the only choice here).
> 
> As a matter of fact, LRU is a *bad* choice for DRC eviction. It will
> evict the very entries that are most important! The newest ones are
> coming from clients that are working properly. The oldest ones were
> from the ones still attempting to retry.

Isn't this just the standard complaint about LRU cache management?  We
throw out the old ones, but they are mostly likely to be used soon..

My understanding is that LRU cache management is a bit like democracy:
it is the worst solution to the problem - except for all the others.

Without more concrete information about how the client is behaving (like
the information that SEQUENCE gives us in 4.1) you cannot reliably do
any better, and you can certainly do a lot worse.

I don't think there is any value in revising the basic approach we are
taking to DRC cache management.  There might be value in optimising the
code (removing unused assignments, changing data structures, moving some
tasks to a different place in request processing to adjust latency)
while keeping the core approach the same.

> 
> This is pretty subtle, and it may not be a simple thing to implement.
> But at a high level, evicting entries from a client that is regularly
> issuing new requests is a much safer strategy. Looking at the age of
> the requests themselves, without considering their source, is much more
> risky.

Past behaviour cannot usefully predict future behaviour when the
particular behaviour that we care about (lost replies) it typically
caused by a discontinuity.

There might be value is using different tuning (and possibly separate
data structures) for UDP vs TCP sessions as the expected failure mode is
quite different.  With UDP loss of an individual reply would not be a
surprise.  With TCP loss is much less likely, but when it happens it
would be expected to affect all outstanding replies.  Of course the
server doesn't know which are outstanding.

Possibly a count per client, rather than a global count, might make
sense.

Thanks,
NeilBrown


> 
> Tom.
> 


