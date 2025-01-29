Return-Path: <linux-nfs+bounces-9765-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC5A225DF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30CA188724F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB531AF0D6;
	Wed, 29 Jan 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U3ykfYJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8q1smYVi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U3ykfYJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8q1smYVi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5322619
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186473; cv=none; b=SczrtwA2I8CwH2QjE6qeEuHtjYoHUG2eQY/VEC8MZifiiLQtU8NsLn6wQbV2qgekhKKt8ZlAQ5j3tjjgFfR2/x4GE5w3Jj1BKOjeRHsPZxHZkocUs/iwaB0Zf6CfQVXbflgWlXgCyXBJqsRKns3OUE90lWYYdqUuNwPqdWrFj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186473; c=relaxed/simple;
	bh=sOaPR5T9moUD8zldWz/Uor7XCLu/USstJCcbYewVUWM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UCBSpoYfxhxkuiWZV+DGX2MC4C4C6dvpLvmj9gRZuwLRom2c3o5StNWSt3kx3aOPNCfklFKGOCBr+MP/EO4yKoe+3ACaIyJf5sgdeXyVKRPMk3EMt6USbCTyTxN1AG6MliOdgSzgBvd1DXTP3YUqrercxSex2qxxpDw4H8TtiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U3ykfYJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8q1smYVi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U3ykfYJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8q1smYVi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 715C821111;
	Wed, 29 Jan 2025 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738186469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmkX7s9yvhDvJWTRWRtfi4AmPpPK3/iQE00K/TzAv+Y=;
	b=U3ykfYJETN9XrTazkd6iflZKZjYZspMYWO2PFE9R3Dee5L6XmIbf9906+yutPXU2Rjw5MR
	DoXdYihexWWGm+/jFjR6/FhCVnRW4xrKGLlRwP+kma8E+3jKR/rv61BtYpuRkWT+RKEwnK
	YWiRRw/0z7bMiMOG3EyNcisCZYN5Uok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738186469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmkX7s9yvhDvJWTRWRtfi4AmPpPK3/iQE00K/TzAv+Y=;
	b=8q1smYViludUXu45ZgbU0AacQ7SOYECbAkfSiPo5JYXpgiTvY0yBJef++nf8VTMuW4nHyD
	tva+xuwT8J59jqBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738186469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmkX7s9yvhDvJWTRWRtfi4AmPpPK3/iQE00K/TzAv+Y=;
	b=U3ykfYJETN9XrTazkd6iflZKZjYZspMYWO2PFE9R3Dee5L6XmIbf9906+yutPXU2Rjw5MR
	DoXdYihexWWGm+/jFjR6/FhCVnRW4xrKGLlRwP+kma8E+3jKR/rv61BtYpuRkWT+RKEwnK
	YWiRRw/0z7bMiMOG3EyNcisCZYN5Uok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738186469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmkX7s9yvhDvJWTRWRtfi4AmPpPK3/iQE00K/TzAv+Y=;
	b=8q1smYViludUXu45ZgbU0AacQ7SOYECbAkfSiPo5JYXpgiTvY0yBJef++nf8VTMuW4nHyD
	tva+xuwT8J59jqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAC91361C;
	Wed, 29 Jan 2025 21:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 598HKOKemmdoFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 29 Jan 2025 21:34:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
In-reply-to: <Z5h7HOogTsM4ysZx@dread.disaster.area>
References: <20250127012257.1803314-1-neilb@suse.de>,
 <Z5h7HOogTsM4ysZx@dread.disaster.area>
Date: Thu, 30 Jan 2025 08:34:15 +1100
Message-id: <173818645556.22054.17713237842941971206@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 28 Jan 2025, Dave Chinner wrote:
> On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
> > [
> > davec added to cc incase I've said something incorrect about list_lru
> > 
> > Changes in this version:
> >   - no _bh locking
> >   - add name for a magic constant
> >   - remove unnecessary race-handling code
> >   - give a more meaningfule name for a lock for /proc/lock_stat
> >   - minor cleanups suggested by Jeff
> > 
> > ]
> > 
> > The nfsd filecache currently uses  list_lru for tracking files recently
> > used in NFSv3 requests which need to be "garbage collected" when they
> > have becoming idle - unused for 2-4 seconds.
> > 
> > I do not believe list_lru is a good tool for this.  It does not allow
> > the timeout which filecache requires so we have to add a timeout
> > mechanism which holds the list_lru lock while the whole list is scanned
> > looking for entries that haven't been recently accessed.  When the list
> > is largish (even a few hundred) this can block new requests noticably
> > which need the lock to remove a file to access it.
> 
> Looks entirely like a trivial implementation bug in how the list_lru
> is walked in nfsd_file_gc().
> 
> static void
> nfsd_file_gc(void)
> {
>         LIST_HEAD(dispose);
>         unsigned long ret;
> 
>         ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>                             &dispose, list_lru_count(&nfsd_file_lru));
> 			              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>         trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>         nfsd_file_dispose_list_delayed(&dispose);
> }
> 
> i.e. the list_lru_walk() has been told to walk the entire list in a
> single lock hold if nothing blocks it.
> 
> We've known this for a long, long time, and it's something we've
> handled for a long time with shrinkers, too. here's the typical way
> of doing a full list aging and GC pass in one go without excessively
> long lock holds:

"Typical"?? Can you please point me to an existing example?

> 
> {
> 	long nr_to_scan = list_lru_count(&nfsd_file_lru);
> 	LIST_HEAD(dispose);
> 
> 	while (nr_to_scan > 0) {
> 		long batch = min(nr_to_scan, 64);
> 
> 		list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 				&dispose, batch);
> 
> 		if (list_empty(&dispose))
> 			break;
> 		dispose_list(&dispose);
> 		nr_to_scan -= batch;
> 	}
> }
> 
> And we don't need two lists to separate recently referenced vs
> gc candidates because we have a referenced bit in the nf->nf_flags.
> i.e.  nfsd_file_lru_cb() does:
> 
> nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>                  void *arg)
> {
> ....
>         /* If it was recently added to the list, skip it */
>         if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>                 trace_nfsd_file_gc_referenced(nf);
>                 return LRU_ROTATE;
>         }
> .....
> 
> Which moves recently referenced entries to the far end of the list,
> resulting in all the reclaimable objects congrating at the end of
> the list that is walked first by list_lru_walk().
> 
> IOWs, a batched walk like above resumes the walk exactly where it
> left off, because it is always either reclaiming or rotating the
> object at the head of the list.

"rotating the object" to the head of the per-node list, not the head of
the whole list_Lru (except in the trivial single-node case).
list_lru_walk() iterates over the multiple node lists in a fixed order.
Suppose you have 4 nodes, each with 32 items, all of them referenced, and
a batch size of 64.
The first batch will process the 32 items on the first list clearing the
referenced bit and moving them to the end of that list.  Then continue
through those 32 again and freeing them all.  The second batch will do the
same for the second list.  The last two lists won't be touched.

list_lru_walk() is only ever used (correctly) for clearing out a
list_lru.  It should probably be replaced by a function with a more apt
name which is targeted at this: no spinlocks, no return value from the
call-back.

Yes, we could change the above code to use list_lru_walk_node and wrap a
for loop around the whole, but then I wonder if list_lru is really
giving us anything of value.

Walking a linked list just to set a bit in ever entry is a lot more work
that a few list manipulation in 5 cache-lines.

> 
> > This patch removes the list_lru and instead uses 2 simple linked lists.
> > When a file is accessed it is removed from whichever list it is on,
> > then added to the tail of the first list.  Every 2 seconds the second
> > list is moved to the "freeme" list and the first list is moved to the
> > second list.  This avoids any need to walk a list to find old entries.
> 
> Yup, that's exactly what the current code does via the laundrette
> work that schedules nfsd_file_gc() to run every two seconds does.
> 
> > These lists are per-netns rather than global as the freeme list is
> > per-netns as the actual freeing is done in nfsd threads which are
> > per-netns.
> 
> The list_lru is actually multiple lists - it is a per-numa node list
> and so moving to global scope linked lists per netns is going to
> reduce scalability and increase lock contention on large machines.

Possibly we could duplicate the filecache_disposal structure across
svc_pools instead of net namespaces.  That would fix the scalability
issue.  Probably we should avoid removing and re-adding the file in
the lru for every access as that probably causes more spinlock
contention.  We would need to adjust the ageing mechanism but i suspect
it could be made to work.

But I really wanted to make it correct first, performant later.  And I
still think that means not using list_lru.

> 
> I also don't see any perf numbers, scalability analysis, latency
> measurement, CPU profiles, etc showing the problems with using list_lru
> for the GC function, nor any improvement this new code brings.
> 
> i.e. It's kinda hard to make any real comment on "I do not believe
> list_lru is a good tool for this" when there is no actual
> measurements provided to back the statement one way or the other...

It's not about measurements, its about behavioural correctness.  Yes, I
should have spelled that out better.  Thanks for encouraging me to do
so.

NeilBrown

