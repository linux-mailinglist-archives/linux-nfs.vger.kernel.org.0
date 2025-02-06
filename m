Return-Path: <linux-nfs+bounces-9894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1BA29F2A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 04:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D253A605C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDA3B1A4;
	Thu,  6 Feb 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPdTJ+fC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SbKQWpYx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z1s7hr4B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+/Cqy3es"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE82745E
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811107; cv=none; b=bHjhjiwnSKILpQIv0MRW/qMoiI0a/W30PtUHBOJejOLCnF7tB7iP6qxWMKcMtol1JA91MdfAaCMJISlyUllBkPZW0yeZOkupaxbceuo9aYyFJqpo1K1O4iyWaTSfkBH2nN3dIhbgFqlMSVpn2/A1/BojmpAIJFqFwpPwNCuU3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811107; c=relaxed/simple;
	bh=cg2bTiBK1aLekXp3BMxdoGlXD2zfihQmxWpTCbF3sxw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ay/KWZySM+7DNORnq+LWBAWU2QLRQ934oHddvSBgWd9jRERSL9DgoHCD5ZvKBHT24THUiudyYHklzrRG2JK62KfFeNf9sOwUNI1elYNFuHRuAQp70Kd3TzMmX8iHk4KLLZyl4jyDgxzGG0VLCZH3FuNZsvJEWx1halJWXdW8t+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPdTJ+fC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SbKQWpYx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z1s7hr4B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+/Cqy3es; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC0EE1F381;
	Thu,  6 Feb 2025 03:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738811103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvK2nLzO2qibc5e07Z4+BIJcofai1LpI3ZN4MSXAyUU=;
	b=xPdTJ+fCceoiKTsgq3ORN1xxVutfyqqydj23aZRvY+21wMLcJcGmKasORjY2pij/Z1rXn1
	qh2gqg8Llxn9IZNVKjHvXovuYNHC0zIXukb/9Omxu+Pb203Q1mekV+kYoVxhLgV+WWYt1O
	cgVrH2F5wc2xkplEZ8LdICfF24fkARc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738811103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvK2nLzO2qibc5e07Z4+BIJcofai1LpI3ZN4MSXAyUU=;
	b=SbKQWpYxGYdJOEVWCZJcytQoi7oRYRArnUfXw/5WZPCAk+t5Dij+rx2MNX+qi+yqWdv6Rp
	9Jvaj/iwq0ue0SDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738811101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvK2nLzO2qibc5e07Z4+BIJcofai1LpI3ZN4MSXAyUU=;
	b=Z1s7hr4BxtGjHIyxwO0p4Ae6S4FQ7W+oK2Fm2eugXz1FJcOlQ1tbWyrw5wrIpErNgZ/aVe
	Vb+h3JEkm3+pTdo23EoERoMXaLiUdTocobMvw2VPipDv/ryyxlCmQbwC2razb/uA2uDf8H
	yXm8sh3Tm+jYliFAy7KKGBSAy7qF+jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738811101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvK2nLzO2qibc5e07Z4+BIJcofai1LpI3ZN4MSXAyUU=;
	b=+/Cqy3esllQtsGe3BFQo35hcVOiKAnSxPzjWuy42JEv9W1dj9Jg+7y1q0TsMkHnbARn8Jt
	U75GmwmcZ3/1ZLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 558F513694;
	Thu,  6 Feb 2025 03:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 44DcAtsmpGfzXwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 03:04:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <Z6QcwbsFfOahoJ1P@dread.disaster.area>
References: <>, <Z6QcwbsFfOahoJ1P@dread.disaster.area>
Date: Thu, 06 Feb 2025 14:04:55 +1100
Message-id: <173881109569.22054.7095290604295647912@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 06 Feb 2025, Dave Chinner wrote:
> On Thu, Jan 30, 2025 at 08:34:15AM +1100, NeilBrown wrote:
> > On Tue, 28 Jan 2025, Dave Chinner wrote:
> > > On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
> > > > [
> > > > davec added to cc incase I've said something incorrect about list_lru
> > > >=20
> > > > Changes in this version:
> > > >   - no _bh locking
> > > >   - add name for a magic constant
> > > >   - remove unnecessary race-handling code
> > > >   - give a more meaningfule name for a lock for /proc/lock_stat
> > > >   - minor cleanups suggested by Jeff
> > > >=20
> > > > ]
> > > >=20
> > > > The nfsd filecache currently uses  list_lru for tracking files recent=
ly
> > > > used in NFSv3 requests which need to be "garbage collected" when they
> > > > have becoming idle - unused for 2-4 seconds.
> > > >=20
> > > > I do not believe list_lru is a good tool for this.  It does not allow
> > > > the timeout which filecache requires so we have to add a timeout
> > > > mechanism which holds the list_lru lock while the whole list is scann=
ed
> > > > looking for entries that haven't been recently accessed.  When the li=
st
> > > > is largish (even a few hundred) this can block new requests noticably
> > > > which need the lock to remove a file to access it.
> > >=20
> > > Looks entirely like a trivial implementation bug in how the list_lru
> > > is walked in nfsd_file_gc().
> > >=20
> > > static void
> > > nfsd_file_gc(void)
> > > {
> > >         LIST_HEAD(dispose);
> > >         unsigned long ret;
> > >=20
> > >         ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > >                             &dispose, list_lru_count(&nfsd_file_lru));
> > > 			              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >=20
> > >         trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > >         nfsd_file_dispose_list_delayed(&dispose);
> > > }
> > >=20
> > > i.e. the list_lru_walk() has been told to walk the entire list in a
> > > single lock hold if nothing blocks it.
> > >=20
> > > We've known this for a long, long time, and it's something we've
> > > handled for a long time with shrinkers, too. here's the typical way
> > > of doing a full list aging and GC pass in one go without excessively
> > > long lock holds:
> >=20
> > "Typical"?? Can you please point me to an existing example?
>=20
> Of the top of my head: shrink_dcache_sb().

shrink_dcache_sb() contains:

	} while (list_lru_count(&sb->s_dentry_lru) > 0);

i.e. it removes *everything* from the list_lru.

There are 5 callers of list_all_walk() in the kernel.

binder_shrink_scan() appears to be buggy.  Other _scan functions
   use list_lru_shrink_walk which is per-node as you say.
binder_selftest_free_page() calls until the list is empty
shrink_dcache_sb() calls until the list is empty
nfsd_file_gc() call for the whole list but does NOT want the
  list to necessarily be empty
xfs_bufarg_drain() calls until the list is empty

So three call until the list is empty, one should use
list_lru_shrink_walk(), and nfsd wants something quite different.


>=20
> However, *every single shrinker implementation in the kernel* uses
> this algorithm whether they use list-lru or not.

Yes, but we aren't doing shrinking here.  We are doing ageing.  We want
a firm upper limit to how long things remain cached after the last use.

>=20
> > list_lru_walk() iterates over the multiple node lists in a fixed order.
> > Suppose you have 4 nodes, each with 32 items, all of them referenced, and
> > a batch size of 64.
> > The first batch will process the 32 items on the first list clearing the
> > referenced bit and moving them to the end of that list.  Then continue
> > through those 32 again and freeing them all.  The second batch will do the
> > same for the second list.  The last two lists won't be touched.
> >=20
> > list_lru_walk() is only ever used (correctly) for clearing out a
> > list_lru.  It should probably be replaced by a function with a more apt
> > name which is targeted at this: no spinlocks, no return value from the
> > call-back.
> >=20
> > Yes, we could change the above code to use list_lru_walk_node and wrap a
> > for loop around the whole, but then I wonder if list_lru is really
> > giving us anything of value.
>=20
> Apart from scalability and the ability for memory reclaim to do sane
> per-node object reclaim? What about the fact that anyone familiar
> with list-lru doesn't need to look at how the lists are implemented
> to know how the code behaves?

What an odd thing to say...  how does one become familiar except by
looking at the code?

I accept that my current approach loses per-node object reclaim.  I
don't know how important that is.  I believe the primary cost of nfsd
leaving files on the lru is not the memory usage, but the fact the file
file is held open while not is use.

As I said before, nfsd already has some per-node awareness.  Linking the
file ageing into that would be easy enough.

>=20
> Using common infrastructure, even when it's not an exact perfect
> fit, holds a lot more value to the wider community than a one-off
> special snowflake implementation that only one or two people
> understand....

While there is certainly truth in that, it is also true that using
common infrastructure in a non-ideomatic way can cause confusion.
Sometimes things that are different should look different.

From my perspective the nfsd filecache lru is primarily about again, not
about garbage collection.

>=20
> > Walking a linked list just to set a bit in ever entry is a lot more work
> > that a few list manipulation in 5 cache-lines.
>=20
> Maybe so, but the cache gc isn't a performance critical path.

Any yet it was the "gc", which was really "aging", which highlighted the
problem for us.

Normal list_lru never walks the entire list (unless it is short) except
when freeing everything.  With the "reference" bit approach, nfsd needs
to walk the entire lru frequently.  That can make the aging more of a
performance issue.
dcache uses DCACHE_REFERENCED effectively, but in a different way.  It
is only cleared by the shrinker for those entries that are one the lru
before the ones that can be freed - it doesn't want to clear the
DCACHE_REFERENCED bits on everything in the lru (which has it set).
nfsd DOES want to clear the referenced bit on everything for the aging.

>=20
> > > > This patch removes the list_lru and instead uses 2 simple linked list=
s.
> > > > When a file is accessed it is removed from whichever list it is on,
> > > > then added to the tail of the first list.  Every 2 seconds the second
> > > > list is moved to the "freeme" list and the first list is moved to the
> > > > second list.  This avoids any need to walk a list to find old entries.
> > >=20
> > > Yup, that's exactly what the current code does via the laundrette
> > > work that schedules nfsd_file_gc() to run every two seconds does.
> > >=20
> > > > These lists are per-netns rather than global as the freeme list is
> > > > per-netns as the actual freeing is done in nfsd threads which are
> > > > per-netns.
> > >=20
> > > The list_lru is actually multiple lists - it is a per-numa node list
> > > and so moving to global scope linked lists per netns is going to
> > > reduce scalability and increase lock contention on large machines.
> >=20
> > Possibly we could duplicate the filecache_disposal structure across
> > svc_pools instead of net namespaces.  That would fix the scalability
> > issue.  Probably we should avoid removing and re-adding the file in
> > the lru for every access as that probably causes more spinlock
> > contention.  We would need to adjust the ageing mechanism but i suspect
> > it could be made to work.
>=20
> Typical usage of list-lru is lazy removal. i.e. we only add it to
> the LRU list if it's not already there, and only reclaim/gc removes
> it from the list.  This is how the inode and dentry caches have
> worked since before list_lru even existed, and it's a pattern that
> is replicated across many subsystems that use LRUs for gc
> purposes...
>=20
> IOWs, the "object in cache" lookup fast path should never touch
> the LRU at all.

Yes, I agree.  Whichever way we go, this is a change we need to make to
the nfss filecache - not to remove on each access.

>=20
> > > i.e. It's kinda hard to make any real comment on "I do not believe
> > > list_lru is a good tool for this" when there is no actual
> > > measurements provided to back the statement one way or the other...
> >=20
> > It's not about measurements, its about behavioural correctness.  Yes, I
> > should have spelled that out better.  Thanks for encouraging me to do
> > so.
>=20
> So you are saying that you don't care that the existing code can
> easily be fixed, that your one-off solution won't scale as well and
> is less functional from memory reclaim POV, and that the new
> implementation is less maintainable than using generic
> infrastructure to do the same work.

No, I'm saying that it isn't clear to me that the existing code can be
easily fixed.  Certainly there are easy improvements.  But list_lru is
designed for an important access pattern which is different from what
the nfsd filecache needs.

>=20
> If that's the approach you are taking, then I don't know why you
> asked me to point out all the stuff about list_lru that you didn't
> seem to know about in the first place...

It is always useful to have intelligent review, even when one doesn't
agree with all of it.  Thanks!

NeilBrown

