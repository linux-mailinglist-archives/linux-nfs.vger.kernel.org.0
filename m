Return-Path: <linux-nfs+bounces-10000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD917A2E240
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906BA3A5AEF
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E0DDD3;
	Mon, 10 Feb 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bh+pAtQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A7hviV7l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bh+pAtQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A7hviV7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0E2595
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739154713; cv=none; b=sJqc3dO9gpk/0EpmVioyedF85WT5rO6sdALtSxNQTcU6wVXc/b/8UNUlJK/5MNLJiLm3ZHdULkDDr1wVWq4hVNh0abSQI/cyZlcygNQgqSzRregLuJMZHJaFUsCfZWSt3WHQRbzdlzecba37OIz9XNwcEOJ9COGoYW4KhSvqBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739154713; c=relaxed/simple;
	bh=NFKM1rIP9iPI5oZnHz7PCIT6+56bGdGKtDr/8AileJQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IPPuj61bzMUu0GuGzNX2AioSCNgasTXK0uHlqUj5Kh2GEM5vHbeU8RsdOm8/EP1iI4wBRXtZzTVDFR42ZW4ECdgH6MixUYrHEG259JTJuyGIXf6PskKbCQvOUsTRFwkeA3mmsoEkWYMUUgesCBYev8KIKCy7ZBzjFezmIjKkD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bh+pAtQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A7hviV7l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bh+pAtQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A7hviV7l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F42421111;
	Mon, 10 Feb 2025 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739154709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTe7+EB4hrGAWpYkn/34XmpO4oQdXQ1AIOdOVM/L3qw=;
	b=Bh+pAtQFyGSG/uNxQFP4bcU0VVy1AzjOOoR/Yo0JP0c+qHeJYaIjQ0ny492H5Yu9VAqU1+
	V+Lfbs6DbBpieqFjdiRwoWZCey7F8XeVRSX+iUicNIDMUGY+YfiqISfpEbeSRlKC7/SYuY
	kdvZlHTnhnU82xPa9Ybeo0vjUQlT0Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739154709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTe7+EB4hrGAWpYkn/34XmpO4oQdXQ1AIOdOVM/L3qw=;
	b=A7hviV7l5sDQqltD9gXn+QP0JN6juUtFZsEJ8eafqi3R9dKxeVG4qviaKdIYKUAd35CeZ/
	k8Cm/FEklAWfWHDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bh+pAtQF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A7hviV7l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739154709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTe7+EB4hrGAWpYkn/34XmpO4oQdXQ1AIOdOVM/L3qw=;
	b=Bh+pAtQFyGSG/uNxQFP4bcU0VVy1AzjOOoR/Yo0JP0c+qHeJYaIjQ0ny492H5Yu9VAqU1+
	V+Lfbs6DbBpieqFjdiRwoWZCey7F8XeVRSX+iUicNIDMUGY+YfiqISfpEbeSRlKC7/SYuY
	kdvZlHTnhnU82xPa9Ybeo0vjUQlT0Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739154709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTe7+EB4hrGAWpYkn/34XmpO4oQdXQ1AIOdOVM/L3qw=;
	b=A7hviV7l5sDQqltD9gXn+QP0JN6juUtFZsEJ8eafqi3R9dKxeVG4qviaKdIYKUAd35CeZ/
	k8Cm/FEklAWfWHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48D313707;
	Mon, 10 Feb 2025 02:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kag8FhJlqWfLRgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 10 Feb 2025 02:31:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
In-reply-to: <0efc7c87-25ad-4859-99db-0a33037e5bfd@oracle.com>
References: <>, <0efc7c87-25ad-4859-99db-0a33037e5bfd@oracle.com>
Date: Mon, 10 Feb 2025 13:31:39 +1100
Message-id: <173915469913.22054.2038589010660243237@noble.neil.brown.name>
X-Rspamd-Queue-Id: 6F42421111
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Mon, 10 Feb 2025, Chuck Lever wrote:
> On 2/9/25 6:23 PM, NeilBrown wrote:
> > On Sat, 08 Feb 2025, Chuck Lever wrote:
> >> On 2/7/25 12:15 AM, NeilBrown wrote:
> >>> The filecache lru is walked in 2 circumstances for 2 different reasons.
> >>>
> >>> 1/ When called from the shrinker we want to discard the first few
> >>>    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
> >>>    because they should really be at the end of the LRU as they have been
> >>>    referenced recently.  So those ones are ROTATED.
> >>>
> >>> 2/ When called from the nfsd_file_gc() timer function we want to discard
> >>>    anything that hasn't been used since before the previous call, and
> >>>    mark everything else as unused at this point in time.
> >>>
> >>> Using the same flag for both of these can result in some unexpected
> >>> outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
> >>> nfsd_file_gc() will think the file hasn't been used in a while, while
> >>> really it has.
> >>>
> >>> I think it is easier to reason about the behaviour if we instead have
> >>> two flags.
> >>>
> >>>  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, plea=
se
> >>>      put it there when convenient"
> >>>  NFSD_FILE_RECENT means "this has been used recently - since the last
> >>>      run of nfsd_file_gc()
> >>>
> >>> When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> >>> should be moved to the end of the LRU and the flag cleared.  This can
> >>> safely happen at any time.  The actual order on the lru might not be
> >>> strictly least-recently-used, but that is normal for linux lrus.
> >>>
> >>> The shrinker callback can ignore the "recent" flag.  If it ends up
> >>> freeing something that is "recent" that simply means that memory
> >>> pressure is sufficient to limit the acceptable cache age to less than
> >>> the nfsd_file_gc frequency.
> >>>
> >>> The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
> >>> free everything that doesn't have this flag set, and should clear the
> >>> flag on everything else.  When it clears the flag it is convenient to
> >>> clear the "REFERENCED" flag and move to the end of the LRU too.
> >>>
> >>> With this, calls from the shrinker do not prematurely age files.  It
> >>> will focus only on freeing those that are least recently used.
> >>>
> >>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>> ---
> >>>  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> >>>  fs/nfsd/filecache.h |  1 +
> >>>  fs/nfsd/trace.h     |  3 +++
> >>>  3 files changed, 23 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>> index 04588c03bdfe..9faf469354a5 100644
> >>> --- a/fs/nfsd/filecache.c
> >>> +++ b/fs/nfsd/filecache.c
> >>> @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> >>>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> >>>  }
> >>> =20
> >>> -
> >>>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >>>  {
> >>>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> >>> +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> >>>  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> >>>  		trace_nfsd_file_lru_add(nf);
> >>>  		return true;
> >>> @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct li=
st_lru_one *lru,
> >>>  	return LRU_REMOVED;
> >>>  }
> >>> =20
> >>> +static enum lru_status
> >>> +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
> >>> +		 void *arg)
> >>> +{
> >>> +	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> >>> +
> >>> +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
> >>> +		/* "REFERENCED" really means "should be at the end of the LRU.
> >>> +		 * As we are putting it there we can clear the flag
> >>> +		 */
> >>> +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> >>> +		trace_nfsd_file_gc_aged(nf);
> >>> +		return LRU_ROTATE;
> >>> +	}
> >>> +	return nfsd_file_lru_cb(item, lru, arg);
> >>> +}
> >>> +
> >>>  static void
> >>>  nfsd_file_gc(void)
> >>>  {
> >>> @@ -537,7 +554,7 @@ nfsd_file_gc(void)
> >>> =20
> >>>  	for_each_node_state(nid, N_NORMAL_MEMORY) {
> >>>  		unsigned long nr =3D list_lru_count_node(&nfsd_file_lru, nid);
> >>> -		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
> >>> +		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
> >>>  					  &dispose, &nr);
> >>>  	}
> >>>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> >>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> >>> index d5db6b34ba30..de5b8aa7fcb0 100644
> >>> --- a/fs/nfsd/filecache.h
> >>> +++ b/fs/nfsd/filecache.h
> >>> @@ -38,6 +38,7 @@ struct nfsd_file {
> >>>  #define NFSD_FILE_PENDING	(1)
> >>>  #define NFSD_FILE_REFERENCED	(2)
> >>>  #define NFSD_FILE_GC		(3)
> >>> +#define NFSD_FILE_RECENT	(4)
> >>>  	unsigned long		nf_flags;
> >>>  	refcount_t		nf_ref;
> >>>  	unsigned char		nf_may;
> >>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> >>> index ad2c0c432d08..9af723eeb2b0 100644
> >>> --- a/fs/nfsd/trace.h
> >>> +++ b/fs/nfsd/trace.h
> >>> @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
> >>>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> >>>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> >>>  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> >>> +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
> >>>  		{ 1 << NFSD_FILE_GC,		"GC" })
> >>> =20
> >>>  DECLARE_EVENT_CLASS(nfsd_file_class,
> >>> @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_dispo=
sed);
> >>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
> >>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
> >>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> >>> +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
> >>>  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
> >>> =20
> >>>  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> >>> @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
> >>>  	TP_ARGS(removed, remaining))
> >>> =20
> >>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> >>> +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
> >>>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
> >>> =20
> >>>  TRACE_EVENT(nfsd_file_close,
> >>
> >> The other patches in this series look like solid improvements. This one
> >> could be as well, but it will take me some time to understand it.
> >>
> >> I am generally in favor of replacing the logic that removes and adds
> >> these items with a single atomic bitop, and I'm happy to see NFSD stick
> >> with the use of an existing LRU facility while documenting its unique
> >> requirements ("nfsd_file_gc_aged" and so on).
> >>
> >> I would still prefer the backport to be lighter -- looks like the key
> >> changes are 3/6 and 6/6. Is there any chance the series can be
> >> reorganized to facilitate backporting? I have to ask, and the answer
> >> might be "no", I realize.
> >=20
> > I'm going with "no".
> > To be honest, I was hoping that the complexity displayed here needed
> > to work around the assumptions of list_lru what don't match our needs
> > would be sufficient to convince you that list_lru isn't worth pursuing.=20
> > I see that didn't work.
>=20
> Fair enough.
>=20
>=20
> > So I am no longer invested in this patch set.  You are welcome to use it
> > if you wish and to make any changes that you think are suitable, but I
> > don't think it is a good direction to go and will not be offering any
> > more code changes to support the use of list_lru here.
>=20
> If I may observe, you haven't offered a compelling explanation of why an
> imperfect fit between list_lru and the filecache adds more technical
> debt than does the introduction of a bespoke LRU mechanism.
>=20
> I'm open to that argument, but I need stronger rationale (or performance
> data) to back it up. So far I can agree that the defect rate in this
> area is somewhat abnormal, but that seems to be because we don't
> understand how to use the list_lru API to its best advantage.
>=20

I would characterise the cause of the defect rate differently.
I would say it is because we are treating this as an lru-style problem
when it isn't an lru-style problem.  list_lru is great for lrus.  That
isn't what we have.

What we have is a desire to keep files open between consecutive IO
requests without any clear indication of when we have seen the last in a
series of IO requests.  So we make a policy decision "keep files open
until there have been no IOs for 2 seconds - then close them".
This is a good and sensible policy that nothing to do with the "LRU"
concept.=20

We implement this policy by keeping all unused files on a list, set a
flag every time the file is used, clearing the flag on a timer tick
(every 2 seconds) and closing anything which still has the flag cleared
2 seconds later.

Still nothing in this description that is at all related to LRU
concepts.

Now we decide that it would be good the add a shinker - fair enough as
we don't *need* these to remain.  How should the shrinker choose files
to close?  It probably doesn't matter beyond avoiding files that still
have the not-timed-out flag set.

But we try to also impose an LRU disciple over the list, and we use
list_lru.
The interfaces for list_lru() are well documented but the intent is
not.  Most users of list_lru (gfs2/quota might be an exception) only
explicitly delete things from the lru when it is time to discard them
completely.  They rely on the shrinker to detect things that are in use
again, and to remove them.  And possibly to detect things that have been
referenced and to rotate them.  But if the shrinker doesn't run because
there isn't much memory pressure they are just left alone.

This is what list_lru is optimised for - for shrinker driven scanning
which skips or removes or rotates things that can't or shouldn't
be freed, and frees others.  You would expect to normally only scan a
small fraction of the list, because realistically you want to keep most
of them.

For filecache we don't want to keep them very long.  So I think it
matters a lot less what we choose for shrinking.  I'm tempted to suggest
we don't bother with the shrinker.  Old files will be discarded soon
anyway if they aren't used, and slowness in memory allocation (due to
any memory pressure) will naturally slow down the addition of new files
to the cache.  So the cache will shrink naturally.

I'm not 100% certain of that, but I do think that the needs of the
shrinker should not dominate the design as they currently do.

Note that maybe we *don't* need to close files so quickly.  Maybe we
could discard the whole timer thing, and then it would make sense to use
list_lru().  What is the cost of keeping them open?

All I can think of is that it affects unlink.  An unlinked file won't be
removed while there is a reference to the inode.  Maybe we should
address that by taking a lease on the file while it is in the
filecache??  When the lease is broken, we discard the file from the
cache.=20

If that could work (which might involve creating a new internal lease
type that is only broken on unlink), then we could remove the timeout
and leave files in the cache indefinitely.  Then it would make perfect
sense to use list_lru() because the problem would start to look exactly
like an LRU problem.  But I don't think that is what we have today.

Thanks,
NeilBrown

