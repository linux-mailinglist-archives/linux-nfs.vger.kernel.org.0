Return-Path: <linux-nfs+bounces-9995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9944FA2E171
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 00:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC1518860C2
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF08248C;
	Sun,  9 Feb 2025 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pu2x7a77";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cbimnui9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yQfaW6Qc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eu4cQcEr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF079288DB
	for <linux-nfs@vger.kernel.org>; Sun,  9 Feb 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739143406; cv=none; b=CBpw1tX+9HeVypajf3j2QnsJQfWGrWyzsdlYnHoFkSvzG47p4hWE+dxJ+5xcZxBPl765/jY27c7Lu9vAI3xN5JUw90OaD7rioU+1ynuKvMyeyDbjQqSB4htq6Odu7QfrK3hu8ELr/2SsH7jhLWKitNDk5HaQPMKKb9DM1LMTTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739143406; c=relaxed/simple;
	bh=ClVzEQqrrgiHinHTFtB/ulHAHriybe+TTWbH/tyKLuc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hLI8VFSUEAG0HgYfMxYNI/U1tuI8T2+BVci0BexsKXG8mugrl5OJC6rn/5nQ2H8D+YIV/i1AkVKlzaf7+drY5OsZazlI2kDTQrAEUbdGPLHzQIQPUT1tpf3zDMR70GKRjWtbWMQ4jduHDzF/tLQIVgjkUY/kl/LD9yxlte993LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pu2x7a77; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cbimnui9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yQfaW6Qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eu4cQcEr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9231F365;
	Sun,  9 Feb 2025 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739143402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZaqq6kzK5DJgS/JT8KpqSbOWzSLzSnxT87GSXpJH0=;
	b=pu2x7a77Hx0dL9DJgafOBt68Kj5l7/3JSWTfaZAnsHnDCRCvyiDcI8LFXaX9KquRt/Fort
	77wpaj/GHiTM5JrIjm8wnyqBgtUOw24SOXHQEh/tjxJ64I4A0ZS4+PLG4sLu3fDVvrZp2O
	WGdkGfsDsG+9uzpWTG56itVcAKO15no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739143402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZaqq6kzK5DJgS/JT8KpqSbOWzSLzSnxT87GSXpJH0=;
	b=cbimnui9kBZHIvxqfVOC7WeP7MccgPRfTHwt3oHuIoxUy0f8JvZaXTrGYxM6/xNV5gHK9F
	uEH/LCqFqt+/JACQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739143401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZaqq6kzK5DJgS/JT8KpqSbOWzSLzSnxT87GSXpJH0=;
	b=yQfaW6QcTbM0npNP3ILLQy0urPrq7VNqhU513t2sjoHSGAggu5IrTK69gUEGOPK0VNngmI
	ecFnkQBEIefJpmWX15JvZJuUR4JzjQCVbPGafco+n2YbNQ2sAnRUZ9/U/tkgB1K5pSS9kA
	B2CsGL9fWCfn0dTCkGKL3oRDJi1FnAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739143401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VZaqq6kzK5DJgS/JT8KpqSbOWzSLzSnxT87GSXpJH0=;
	b=Eu4cQcEr6yl8VmEGRNZHQA+0N46JzgRqZiMuBhbeeqCo+q4/faP0+a1UC+2f28hKDeGa1Z
	TMwyO/FYGxRBygDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C02F13796;
	Sun,  9 Feb 2025 23:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvYqLOY4qWeSGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 09 Feb 2025 23:23:18 +0000
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
In-reply-to: <9340215f-9c4d-490c-acc8-0450862a99e1@oracle.com>
References: <>, <9340215f-9c4d-490c-acc8-0450862a99e1@oracle.com>
Date: Mon, 10 Feb 2025 10:23:15 +1100
Message-id: <173914339595.22054.11127298752860400864@noble.neil.brown.name>
X-Spam-Score: -4.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 08 Feb 2025, Chuck Lever wrote:
> On 2/7/25 12:15 AM, NeilBrown wrote:
> > The filecache lru is walked in 2 circumstances for 2 different reasons.
> >=20
> > 1/ When called from the shrinker we want to discard the first few
> >    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
> >    because they should really be at the end of the LRU as they have been
> >    referenced recently.  So those ones are ROTATED.
> >=20
> > 2/ When called from the nfsd_file_gc() timer function we want to discard
> >    anything that hasn't been used since before the previous call, and
> >    mark everything else as unused at this point in time.
> >=20
> > Using the same flag for both of these can result in some unexpected
> > outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
> > nfsd_file_gc() will think the file hasn't been used in a while, while
> > really it has.
> >=20
> > I think it is easier to reason about the behaviour if we instead have
> > two flags.
> >=20
> >  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
> >      put it there when convenient"
> >  NFSD_FILE_RECENT means "this has been used recently - since the last
> >      run of nfsd_file_gc()
> >=20
> > When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> > should be moved to the end of the LRU and the flag cleared.  This can
> > safely happen at any time.  The actual order on the lru might not be
> > strictly least-recently-used, but that is normal for linux lrus.
> >=20
> > The shrinker callback can ignore the "recent" flag.  If it ends up
> > freeing something that is "recent" that simply means that memory
> > pressure is sufficient to limit the acceptable cache age to less than
> > the nfsd_file_gc frequency.
> >=20
> > The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
> > free everything that doesn't have this flag set, and should clear the
> > flag on everything else.  When it clears the flag it is convenient to
> > clear the "REFERENCED" flag and move to the end of the LRU too.
> >=20
> > With this, calls from the shrinker do not prematurely age files.  It
> > will focus only on freeing those that are least recently used.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> >  fs/nfsd/filecache.h |  1 +
> >  fs/nfsd/trace.h     |  3 +++
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 04588c03bdfe..9faf469354a5 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> >  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> >  }
> > =20
> > -
> >  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >  {
> >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> >  	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> >  		trace_nfsd_file_lru_add(nf);
> >  		return true;
> > @@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> >  	return LRU_REMOVED;
> >  }
> > =20
> > +static enum lru_status
> > +nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
> > +		 void *arg)
> > +{
> > +	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> > +
> > +	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
> > +		/* "REFERENCED" really means "should be at the end of the LRU.
> > +		 * As we are putting it there we can clear the flag
> > +		 */
> > +		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > +		trace_nfsd_file_gc_aged(nf);
> > +		return LRU_ROTATE;
> > +	}
> > +	return nfsd_file_lru_cb(item, lru, arg);
> > +}
> > +
> >  static void
> >  nfsd_file_gc(void)
> >  {
> > @@ -537,7 +554,7 @@ nfsd_file_gc(void)
> > =20
> >  	for_each_node_state(nid, N_NORMAL_MEMORY) {
> >  		unsigned long nr =3D list_lru_count_node(&nfsd_file_lru, nid);
> > -		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
> > +		ret +=3D list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
> >  					  &dispose, &nr);
> >  	}
> >  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index d5db6b34ba30..de5b8aa7fcb0 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -38,6 +38,7 @@ struct nfsd_file {
> >  #define NFSD_FILE_PENDING	(1)
> >  #define NFSD_FILE_REFERENCED	(2)
> >  #define NFSD_FILE_GC		(3)
> > +#define NFSD_FILE_RECENT	(4)
> >  	unsigned long		nf_flags;
> >  	refcount_t		nf_ref;
> >  	unsigned char		nf_may;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index ad2c0c432d08..9af723eeb2b0 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
> >  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
> >  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> >  		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
> > +		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
> >  		{ 1 << NFSD_FILE_GC,		"GC" })
> > =20
> >  DECLARE_EVENT_CLASS(nfsd_file_class,
> > @@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_dispose=
d);
> >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
> >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
> >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
> > +DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
> >  DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
> > =20
> >  DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
> > @@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
> >  	TP_ARGS(removed, remaining))
> > =20
> >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
> > +DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
> >  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
> > =20
> >  TRACE_EVENT(nfsd_file_close,
>=20
> The other patches in this series look like solid improvements. This one
> could be as well, but it will take me some time to understand it.
>=20
> I am generally in favor of replacing the logic that removes and adds
> these items with a single atomic bitop, and I'm happy to see NFSD stick
> with the use of an existing LRU facility while documenting its unique
> requirements ("nfsd_file_gc_aged" and so on).
>=20
> I would still prefer the backport to be lighter -- looks like the key
> changes are 3/6 and 6/6. Is there any chance the series can be
> reorganized to facilitate backporting? I have to ask, and the answer
> might be "no", I realize.

I'm going with "no".
To be honest, I was hoping that the complexity displayed here needed
to work around the assumptions of list_lru what don't match our needs
would be sufficient to convince you that list_lru isn't worth pursuing.=20
I see that didn't work.

So I am no longer invested in this patch set.  You are welcome to use it
if you wish and to make any changes that you think are suitable, but I
don't think it is a good direction to go and will not be offering any
more code changes to support the use of list_lru here.

Thanks,
NeilBrown

