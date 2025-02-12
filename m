Return-Path: <linux-nfs+bounces-10073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44301A332C9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 23:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63931671D0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7CA204591;
	Wed, 12 Feb 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E4Cqdidh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpAzI6AY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E4Cqdidh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jpAzI6AY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A820408D
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399982; cv=none; b=kktoKq32o2GtvB+yz/fEU7UUerm/Hzf1qYk6LGabCcHAsW75Nl9SV769XfNCpcdOxW43bYvHourXVsKJrAEO7vOsxdQa2ZqJkhKNPp3pRiV+MLcvottNb2d7Px48PWaPT/gFO/CoPdGrfxp0oEJmxOpJZGushF8IHURq0o3akpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399982; c=relaxed/simple;
	bh=GH6P4+Eb1CvK2TSeCsEMXUs3vzEti2wiKHd8DvisY2E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=piNyvBk5gUnWnrZ8Jf9bYrdzyD+484eSQVYbGcHi41xKt2ydPaV3Hp2ArKydP9AaopTxu+MmsMxZ2W/FxXGJdxiEJ5L8m1dB8o9cauoRbMx/8xla/PrH9+ZamUDmqN5C6NmITzk5OWeBsgs4f23VZR9Rd9mpsdJW2T2tkiTUvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E4Cqdidh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpAzI6AY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E4Cqdidh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jpAzI6AY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 416981F7B1;
	Wed, 12 Feb 2025 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739399978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPgZyihqZD2qMFJmReKXsFWugQlUz9t0/dZzDcYaWtk=;
	b=E4CqdidhCGwisUGn0rOHeBVsZCCcvcvc0BfPHXVZRJVVzm0UuDyth41G9npc1VLYpDXvD9
	tl7HnHnllB9tGQReLO5VsvifEL8K2NAKx69EPwjWXckc4pSKD1YyxH4EVvRoGWoPAV4+df
	fyDinXIgvLp20fwLgYWu6WGMj7QJqAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739399978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPgZyihqZD2qMFJmReKXsFWugQlUz9t0/dZzDcYaWtk=;
	b=jpAzI6AYi29KrNcdFCZy1Kq+F4bgKk1g0NUfveLfVs2CTD4YnNLd8GMqYF7Mi0nwUFw2hs
	qk8Qm3LZJdje7pAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739399978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPgZyihqZD2qMFJmReKXsFWugQlUz9t0/dZzDcYaWtk=;
	b=E4CqdidhCGwisUGn0rOHeBVsZCCcvcvc0BfPHXVZRJVVzm0UuDyth41G9npc1VLYpDXvD9
	tl7HnHnllB9tGQReLO5VsvifEL8K2NAKx69EPwjWXckc4pSKD1YyxH4EVvRoGWoPAV4+df
	fyDinXIgvLp20fwLgYWu6WGMj7QJqAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739399978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPgZyihqZD2qMFJmReKXsFWugQlUz9t0/dZzDcYaWtk=;
	b=jpAzI6AYi29KrNcdFCZy1Kq+F4bgKk1g0NUfveLfVs2CTD4YnNLd8GMqYF7Mi0nwUFw2hs
	qk8Qm3LZJdje7pAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97D6E13874;
	Wed, 12 Feb 2025 22:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q9vNEycjrWcpTQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 22:39:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
In-reply-to: <861990916fdd98170abb7b15188dc360566a8937.camel@kernel.org>
References: <>, <861990916fdd98170abb7b15188dc360566a8937.camel@kernel.org>
Date: Thu, 13 Feb 2025 09:39:32 +1100
Message-id: <173939997256.22054.14991770209667672699@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 11 Feb 2025, Jeff Layton wrote:
> On Mon, 2025-02-10 at 13:31 +1100, NeilBrown wrote:
> > On Mon, 10 Feb 2025, Chuck Lever wrote:
> > > On 2/9/25 6:23 PM, NeilBrown wrote:
> > > > On Sat, 08 Feb 2025, Chuck Lever wrote:
> > > > > On 2/7/25 12:15 AM, NeilBrown wrote:
> > > > > > The filecache lru is walked in 2 circumstances for 2 different re=
asons.
> > > > > >=20
> > > > > > 1/ When called from the shrinker we want to discard the first few
> > > > > >    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
> > > > > >    because they should really be at the end of the LRU as they ha=
ve been
> > > > > >    referenced recently.  So those ones are ROTATED.
> > > > > >=20
> > > > > > 2/ When called from the nfsd_file_gc() timer function we want to =
discard
> > > > > >    anything that hasn't been used since before the previous call,=
 and
> > > > > >    mark everything else as unused at this point in time.
> > > > > >=20
> > > > > > Using the same flag for both of these can result in some unexpect=
ed
> > > > > > outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED t=
hen the
> > > > > > nfsd_file_gc() will think the file hasn't been used in a while, w=
hile
> > > > > > really it has.
> > > > > >=20
> > > > > > I think it is easier to reason about the behaviour if we instead =
have
> > > > > > two flags.
> > > > > >=20
> > > > > >  NFSD_FILE_REFERENCED means "this should be at the end of the LRU=
, please
> > > > > >      put it there when convenient"
> > > > > >  NFSD_FILE_RECENT means "this has been used recently - since the =
last
> > > > > >      run of nfsd_file_gc()
> > > > > >=20
> > > > > > When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> > > > > > should be moved to the end of the LRU and the flag cleared.  This=
 can
> > > > > > safely happen at any time.  The actual order on the lru might not=
 be
> > > > > > strictly least-recently-used, but that is normal for linux lrus.
> > > > > >=20
> > > > > > The shrinker callback can ignore the "recent" flag.  If it ends up
> > > > > > freeing something that is "recent" that simply means that memory
> > > > > > pressure is sufficient to limit the acceptable cache age to less =
than
> > > > > > the nfsd_file_gc frequency.
> > > > > >=20
> > > > > > The gc caller should primarily focus on NFSD_FILE_RECENT.  It sho=
uld
> > > > > > free everything that doesn't have this flag set, and should clear=
 the
> > > > > > flag on everything else.  When it clears the flag it is convenien=
t to
> > > > > > clear the "REFERENCED" flag and move to the end of the LRU too.
> > > > > >=20
> > > > > > With this, calls from the shrinker do not prematurely age files. =
 It
> > > > > > will focus only on freeing those that are least recently used.
> > > > > >=20
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> > > > > >  fs/nfsd/filecache.h |  1 +
> > > > > >  fs/nfsd/trace.h     |  3 +++
> > > > > >  3 files changed, 23 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > index 04588c03bdfe..9faf469354a5 100644
> > > > > > --- a/fs/nfsd/filecache.c
> > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file =
*nf)
> > > > > >  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > > > > >  }
> > > > > > =20
> > > > > > -
> > > > > >  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > > > >  {
> > > > > >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > > > +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> > > > > >  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> > > > > >  		trace_nfsd_file_lru_add(nf);
> > > > > >  		return true;
> > > > > > @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, str=
uct list_lru_one *lru,
> > > > > >  	return LRU_REMOVED;
> > > > > >  }
> > > > > > =20
> > > > > > +static enum lru_status
> > > > > > +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
> > > > > > +		 void *arg)
> > > > > > +{
> > > > > > +	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_=
lru);
> > > > > > +
> > > > > > +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
> > > > > > +		/* "REFERENCED" really means "should be at the end of the LRU.
> > > > > > +		 * As we are putting it there we can clear the flag
> > > > > > +		 */
> > > > > > +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > > > +		trace_nfsd_file_gc_aged(nf);
> > > > > > +		return LRU_ROTATE;
> > > > > > +	}
> > > > > > +	return nfsd_file_lru_cb(item, lru, arg);
> > > > > > +}
> > > > > > +
> > > > > >  static void
> > > > > >  nfsd_file_gc(void)
> > > > > >  {
> > > > > > @@ -537,7 +554,7 @@ nfsd_file_gc(void)
> > > > > > =20
> > > > > >  	for_each_node_state(nid, N_NORMAL_MEMORY) {
> > > > > >  		unsigned long nr =3D list_lru_count_node(&nfsd_file_lru, nid);
> > > > > > -		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru=
_cb,
> > > > > > +		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_=
cb,
> > > > > >  					  &dispose, &nr);
> > > > > >  	}
> > > > > >  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > > > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > > > index d5db6b34ba30..de5b8aa7fcb0 100644
> > > > > > --- a/fs/nfsd/filecache.h
> > > > > > +++ b/fs/nfsd/filecache.h
> > > > > > @@ -38,6 +38,7 @@ struct nfsd_file {
> > > > > >  #define NFSD_FILE_PENDING	(1)
> > > > > >  #define NFSD_FILE_REFERENCED	(2)
> > > > > >  #define NFSD_FILE_GC		(3)
> > > > > > +#define NFSD_FILE_RECENT	(4)
> > > > > >  	unsigned long		nf_flags;
> > > > > >  	refcount_t		nf_ref;
> > > > > >  	unsigned char		nf_may;
> > > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > > index ad2c0c432d08..9af723eeb2b0 100644
> > > > > > --- a/fs/nfsd/trace.h
> > > > > > +++ b/fs/nfsd/trace.h
> > > > > > @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
> > > > > >  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> > > > > >  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> > > > > >  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> > > > > > +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
> > > > > >  		{ 1 << NFSD_FILE_GC,		"GC" })
> > > > > > =20
> > > > > >  DECLARE_EVENT_CLASS(nfsd_file_class,
> > > > > > @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del=
_disposed);
> > > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
> > > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
> > > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> > > > > > +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
> > > > > >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
> > > > > > =20
> > > > > >  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> > > > > > @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,=
				\
> > > > > >  	TP_ARGS(removed, remaining))
> > > > > > =20
> > > > > >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> > > > > > +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
> > > > > >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
> > > > > > =20
> > > > > >  TRACE_EVENT(nfsd_file_close,
> > > > >=20
> > > > > The other patches in this series look like solid improvements. This=
 one
> > > > > could be as well, but it will take me some time to understand it.
> > > > >=20
> > > > > I am generally in favor of replacing the logic that removes and adds
> > > > > these items with a single atomic bitop, and I'm happy to see NFSD s=
tick
> > > > > with the use of an existing LRU facility while documenting its uniq=
ue
> > > > > requirements ("nfsd_file_gc_aged" and so on).
> > > > >=20
> > > > > I would still prefer the backport to be lighter -- looks like the k=
ey
> > > > > changes are 3/6 and 6/6. Is there any chance the series can be
> > > > > reorganized to facilitate backporting? I have to ask, and the answer
> > > > > might be "no", I realize.
> > > >=20
> > > > I'm going with "no".
> > > > To be honest, I was hoping that the complexity displayed here needed
> > > > to work around the assumptions of list_lru what don't match our needs
> > > > would be sufficient to convince you that list_lru isn't worth pursuin=
g.=20
> > > > I see that didn't work.
> > >=20
> > > Fair enough.
> > >=20
> > >=20
> > > > So I am no longer invested in this patch set.  You are welcome to use=
 it
> > > > if you wish and to make any changes that you think are suitable, but I
> > > > don't think it is a good direction to go and will not be offering any
> > > > more code changes to support the use of list_lru here.
> > >=20
> > > If I may observe, you haven't offered a compelling explanation of why an
> > > imperfect fit between list_lru and the filecache adds more technical
> > > debt than does the introduction of a bespoke LRU mechanism.
> > >=20
> > > I'm open to that argument, but I need stronger rationale (or performance
> > > data) to back it up. So far I can agree that the defect rate in this
> > > area is somewhat abnormal, but that seems to be because we don't
> > > understand how to use the list_lru API to its best advantage.
> > >=20
> >=20
> > I would characterise the cause of the defect rate differently.
> > I would say it is because we are treating this as an lru-style problem
> > when it isn't an lru-style problem.  list_lru is great for lrus.  That
> > isn't what we have.
> >=20
> > What we have is a desire to keep files open between consecutive IO
> > requests without any clear indication of when we have seen the last in a
> > series of IO requests.  So we make a policy decision "keep files open
> > until there have been no IOs for 2 seconds - then close them".
> > This is a good and sensible policy that nothing to do with the "LRU"
> > concept.=20
> >=20
> > We implement this policy by keeping all unused files on a list, set a
> > flag every time the file is used, clearing the flag on a timer tick
> > (every 2 seconds) and closing anything which still has the flag cleared
> > 2 seconds later.
> >=20
> > Still nothing in this description that is at all related to LRU
> > concepts.
> >=20
> > Now we decide that it would be good the add a shinker - fair enough as
> > we don't *need* these to remain.  How should the shrinker choose files
> > to close?  It probably doesn't matter beyond avoiding files that still
> > have the not-timed-out flag set.
> >=20
> > But we try to also impose an LRU disciple over the list, and we use
> > list_lru.
> > The interfaces for list_lru() are well documented but the intent is
> > not.  Most users of list_lru (gfs2/quota might be an exception) only
> > explicitly delete things from the lru when it is time to discard them
> > completely.  They rely on the shrinker to detect things that are in use
> > again, and to remove them.  And possibly to detect things that have been
> > referenced and to rotate them.  But if the shrinker doesn't run because
> > there isn't much memory pressure they are just left alone.
> >=20
> > This is what list_lru is optimised for - for shrinker driven scanning
> > which skips or removes or rotates things that can't or shouldn't
> > be freed, and frees others.  You would expect to normally only scan a
> > small fraction of the list, because realistically you want to keep most
> > of them.
> >=20
> > For filecache we don't want to keep them very long.  So I think it
> > matters a lot less what we choose for shrinking.  I'm tempted to suggest
> > we don't bother with the shrinker.  Old files will be discarded soon
> > anyway if they aren't used, and slowness in memory allocation (due to
> > any memory pressure) will naturally slow down the addition of new files
> > to the cache.  So the cache will shrink naturally.
> >=20
> > I'm not 100% certain of that, but I do think that the needs of the
> > shrinker should not dominate the design as they currently do.
> >=20
> > Note that maybe we *don't* need to close files so quickly.  Maybe we
> > could discard the whole timer thing, and then it would make sense to use
> > list_lru().  What is the cost of keeping them open?
> >=20
> > All I can think of is that it affects unlink.  An unlinked file won't be
> > removed while there is a reference to the inode.  Maybe we should
> > address that by taking a lease on the file while it is in the
> > filecache??  When the lease is broken, we discard the file from the
> > cache.=20
>=20
>=20
> It may also affect other applications trying to take out leases. The
> filecache has the  nfsd_file_lease_notifier that tells it when someone
> is trying to take out a lease on a file. That happens then it will try
> to close the file first.

It wouldn't have to be an FL_LEASE lease.  We could invent a new thing:
FL_CACHED which gets added to the locks list and triggers a notification
whenever anyone tries to break leases.

The nfsd_file_lease_notifier is interesting... I wasn't aware of that.


>=20
> >
> > If that could work (which might involve creating a new internal lease
> > type that is only broken on unlink), then we could remove the timeout
> > and leave files in the cache indefinitely.  Then it would make perfect
> > sense to use list_lru() because the problem would start to look exactly
> > like an LRU problem.  But I don't think that is what we have today.
> >=20
>=20
> The filecache already sets a fsnotify_mark on the inode to watch for
> its i_nlink to go to 0, and then removes it from the cache when that
> happens. I think we could keep these files open for quite a bit longer
> if we chose to do so.

Chuck mentioned that holding he v3 files open longer could interfere
with v4 DENY_READ etc opens.  But I think they only every test for other
v4 opens.  A v3 (or local) open never blocks a v4 DENY open.  Does that
match your understanding?

Do you know of any other reason that we currently time out files after
2-4 seconds?

>=20
> One thing that Chuck has brought up a few times is that maybe we should
> consider making v4 not use the filecache at all. If that simplifies
> things then that might be a good thing to consider as well.

As v4 stores the file with the open state it shouldn't need the cache.
Maybe the filecache makes life a bit easier for localio?

I don't know that it would make the garbage-collection/shrinking any
simpler but it does superficially seem like an unnecessary indirection.=20
Do you know of any specific benefit it brings v4?

Thanks,
NeilBrown

