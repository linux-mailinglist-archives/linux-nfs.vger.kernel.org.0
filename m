Return-Path: <linux-nfs+bounces-9506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC8A19AAA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 23:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0B31881DDE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2501C5D72;
	Wed, 22 Jan 2025 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rQA6uVFa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ai5wipUI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HepSs5DK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w8Q/LiK3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3071C5D61
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583823; cv=none; b=H38uYBNk0U7U8tv8toaz1U6rFVoFrb1TjTTWWxiPeGTSfo6oUyxAdLnXVGfa8ps6AKUCtIrTVxT8Ub2GLFwFGadEBuxtlKe6KagrLnLxzrQo5FWdv9lHMuqz5y9e5dbApBaV19AlWGfzqhLSOup3cqJb3mSHLARRu/eeEjOdSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583823; c=relaxed/simple;
	bh=+4kzCpVpiz3WaRCzWPtTGWLzc2Dv6taEbLpKp2XEg0Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qtdJh5egZ2p/P4a36sYGAXY9bZBy/hNsV1HYfXwKUk5R5xtIMe1LYpabQM8BQO6d6MQLyXXZrDj+nP9oR/XXEPflvsuwOL1aye/0INPl9Lv4rddz5uIXj9jamwMA6UEenWahgejtoPCUAQyX05fW0SrUOmGzZJc+Y2Qx+mBswEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rQA6uVFa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ai5wipUI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HepSs5DK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w8Q/LiK3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0ACB21170;
	Wed, 22 Jan 2025 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737583819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GW5U27bv2WJr855+kUbhNqbLga3uGEeMzeNSMAPrjjU=;
	b=rQA6uVFaRrAJoTgSkswFKLYtM3B89ufQoPL/2C7lbBo2KdNIonl8gm0ENthtexBSuf3Yhh
	2v9IPLuRv9IHi8Bud6b/iOwdX5Ln8Buq9ZOt6M9ZnoGpv21x7vk9Yj6cL5evFIEcnXWuuL
	qY6sILiEjAi50BIOeLIraTWMliockss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737583819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GW5U27bv2WJr855+kUbhNqbLga3uGEeMzeNSMAPrjjU=;
	b=Ai5wipUIzAhaSCnUXhURqfRc2uTBTNeHVjG2VnXHqka6dza6DMsPpJLCTI+jTLcr/b/Hso
	QeS3fxsKNd/3r9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737583818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GW5U27bv2WJr855+kUbhNqbLga3uGEeMzeNSMAPrjjU=;
	b=HepSs5DKScVibkXpx72ngHKecinRb3MetI18KSwACyWcpZNlhwyzn0oMmE9lMG9WmP49qI
	dDuWiaS+CEj4xGyVRtTYyPX85vHraKEX8EQ9fesAOXRltqZCTRyMwnHpuL0jPnno1gCQST
	T75u2ByuHfxKY2DM94cPhNseRiiiwSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737583818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GW5U27bv2WJr855+kUbhNqbLga3uGEeMzeNSMAPrjjU=;
	b=w8Q/LiK35/0jwI3bo8Qwjg+ysDKKcebmw2M7FJsfRe1muvuiP8sf2KgO82W6fSDe3qbT35
	hUR0TXQNM7V5NwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32CE1397D;
	Wed, 22 Jan 2025 22:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPOgHchskWfRTAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 22:10:16 +0000
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
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
In-reply-to: <e24e9a9d-1416-460b-ad22-b15f9e9e5e6d@oracle.com>
References: <>, <e24e9a9d-1416-460b-ad22-b15f9e9e5e6d@oracle.com>
Date: Thu, 23 Jan 2025 09:10:05 +1100
Message-id: <173758380546.22054.5803528057434555102@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 23 Jan 2025, Chuck Lever wrote:
> On 1/21/25 10:54 PM, NeilBrown wrote:
> > The final freeing of nfsd files is done by per-net nfsd threads (which
> > call nfsd_file_net_dispose()) so it makes some sense to make more of the
> > freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
> >=20
> > This is a step towards replacing the list_lru with simple lists which
> > each share the per-net lock in nfsd_fcache_disposal and will require
> > less list walking.
> >=20
> > As the net is always shutdown before there is any chance that the rest
> > of the filecache is shut down we can removed the tests on
> > NFSD_FILE_CACHE_UP.
> >=20
> > For the filecache stats file, which assumes a global lru, we keep a
> > separate counter which includes all files in all netns lrus.
>=20
> Hey Neil -
>=20
> One of the issues with the current code is that the contention for
> the LRU lock has been effectively buried. It would be nice to have a
> way to expose that contention in the new code.
>=20
> Can this patch or this series add some lock class infrastructure to
> help account for the time spent contending for these dynamically
> allocated spin locks?

Unfortunately I don't know anything about accounting for lock contention
time.

I know about lock classes for the purpose of lockdep checking but not
how they relate to contention tracking.
Could you give me some pointers?

Thanks,
NeilBrown


>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   fs/nfsd/filecache.c | 125 ++++++++++++++++++++++++--------------------
> >   1 file changed, 68 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d8f98e847dc0..4f39f6632b35 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -63,17 +63,19 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evicti=
ons);
> >  =20
> >   struct nfsd_fcache_disposal {
> >   	spinlock_t lock;
> > +	struct list_lru file_lru;
> >   	struct list_head freeme;
> > +	struct delayed_work filecache_laundrette;
> > +	struct shrinker *file_shrinker;
> >   };
> >  =20
> >   static struct kmem_cache		*nfsd_file_slab;
> >   static struct kmem_cache		*nfsd_file_mark_slab;
> > -static struct list_lru			nfsd_file_lru;
> >   static unsigned long			nfsd_file_flags;
> >   static struct fsnotify_group		*nfsd_file_fsnotify_group;
> > -static struct delayed_work		nfsd_filecache_laundrette;
> >   static struct rhltable			nfsd_file_rhltable
> >   						____cacheline_aligned_in_smp;
> > +static atomic_long_t			nfsd_lru_total =3D ATOMIC_LONG_INIT(0);
> >  =20
> >   static bool
> >   nfsd_match_cred(const struct cred *c1, const struct cred *c2)
> > @@ -109,11 +111,18 @@ static const struct rhashtable_params nfsd_file_rha=
sh_params =3D {
> >   };
> >  =20
> >   static void
> > -nfsd_file_schedule_laundrette(void)
> > +nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
> >   {
> > -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> > -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> > -				   NFSD_LAUNDRETTE_DELAY);
> > +	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
> > +			   NFSD_LAUNDRETTE_DELAY);
> > +}
> > +
> > +static void
> > +nfsd_file_schedule_laundrette_net(struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> > +	nfsd_file_schedule_laundrette(nn->fcache_disposal);
> >   }
> >  =20
> >   static void
> > @@ -318,11 +327,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> >   		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> >   }
> >  =20
> > -
> >   static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >   {
> > +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > +
> >   	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> > +	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
> > +		atomic_long_inc(&nfsd_lru_total);
> >   		trace_nfsd_file_lru_add(nf);
> >   		return true;
> >   	}
> > @@ -331,7 +343,11 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >  =20
> >   static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> >   {
> > -	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
> > +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > +
> > +	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
> > +		atomic_long_dec(&nfsd_lru_total);
> >   		trace_nfsd_file_lru_del(nf);
> >   		return true;
> >   	}
> > @@ -373,7 +389,7 @@ nfsd_file_put(struct nfsd_file *nf)
> >   		if (nfsd_file_lru_add(nf)) {
> >   			/* If it's still hashed, we're done */
> >   			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > -				nfsd_file_schedule_laundrette();
> > +				nfsd_file_schedule_laundrette_net(nf->nf_net);
> >   				return;
> >   			}
> >  =20
> > @@ -539,18 +555,18 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
> >   }
> >  =20
> >   static void
> > -nfsd_file_gc(void)
> > +nfsd_file_gc(struct nfsd_fcache_disposal *l)
> >   {
> > -	unsigned long remaining =3D list_lru_count(&nfsd_file_lru);
> > +	unsigned long remaining =3D list_lru_count(&l->file_lru);
> >   	LIST_HEAD(dispose);
> >   	unsigned long ret;
> >  =20
> >   	while (remaining > 0) {
> >   		unsigned long num_to_scan =3D min(remaining, NFSD_FILE_GC_BATCH);
> >  =20
> > -		ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > +		ret =3D list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
> >   				    &dispose, num_to_scan);
> > -		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > +		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
> >   		nfsd_file_dispose_list_delayed(&dispose);
> >   		remaining -=3D num_to_scan;
> >   	}
> > @@ -559,32 +575,36 @@ nfsd_file_gc(void)
> >   static void
> >   nfsd_file_gc_worker(struct work_struct *work)
> >   {
> > -	nfsd_file_gc();
> > -	if (list_lru_count(&nfsd_file_lru))
> > -		nfsd_file_schedule_laundrette();
> > +	struct nfsd_fcache_disposal *l =3D container_of(
> > +		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
> > +	nfsd_file_gc(l);
> > +	if (list_lru_count(&l->file_lru))
> > +		nfsd_file_schedule_laundrette(l);
> >   }
> >  =20
> >   static unsigned long
> >   nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
> >   {
> > -	return list_lru_count(&nfsd_file_lru);
> > +	struct nfsd_fcache_disposal *l =3D s->private_data;
> > +
> > +	return list_lru_count(&l->file_lru);
> >   }
> >  =20
> >   static unsigned long
> >   nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
> >   {
> > +	struct nfsd_fcache_disposal *l =3D s->private_data;
> > +
> >   	LIST_HEAD(dispose);
> >   	unsigned long ret;
> >  =20
> > -	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> > +	ret =3D list_lru_shrink_walk(&l->file_lru, sc,
> >   				   nfsd_file_lru_cb, &dispose);
> > -	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> > +	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
> >   	nfsd_file_dispose_list_delayed(&dispose);
> >   	return ret;
> >   }
> >  =20
> > -static struct shrinker *nfsd_file_shrinker;
> > -
> >   /**
> >    * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
> >    * @nf: nfsd_file to attempt to queue
> > @@ -764,29 +784,10 @@ nfsd_file_cache_init(void)
> >   		goto out_err;
> >   	}
> >  =20
> > -	ret =3D list_lru_init(&nfsd_file_lru);
> > -	if (ret) {
> > -		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
> > -		goto out_err;
> > -	}
> > -
> > -	nfsd_file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> > -	if (!nfsd_file_shrinker) {
> > -		ret =3D -ENOMEM;
> > -		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> > -		goto out_lru;
> > -	}
> > -
> > -	nfsd_file_shrinker->count_objects =3D nfsd_file_lru_count;
> > -	nfsd_file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> > -	nfsd_file_shrinker->seeks =3D 1;
> > -
> > -	shrinker_register(nfsd_file_shrinker);
> > -
> >   	ret =3D lease_register_notifier(&nfsd_file_lease_notifier);
> >   	if (ret) {
> >   		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
> > -		goto out_shrinker;
> > +		goto out_err;
> >   	}
> >  =20
> >   	nfsd_file_fsnotify_group =3D fsnotify_alloc_group(&nfsd_file_fsnotify_=
ops,
> > @@ -799,17 +800,12 @@ nfsd_file_cache_init(void)
> >   		goto out_notifier;
> >   	}
> >  =20
> > -	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
> >   out:
> >   	if (ret)
> >   		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
> >   	return ret;
> >   out_notifier:
> >   	lease_unregister_notifier(&nfsd_file_lease_notifier);
> > -out_shrinker:
> > -	shrinker_free(nfsd_file_shrinker);
> > -out_lru:
> > -	list_lru_destroy(&nfsd_file_lru);
> >   out_err:
> >   	kmem_cache_destroy(nfsd_file_slab);
> >   	nfsd_file_slab =3D NULL;
> > @@ -861,13 +857,36 @@ nfsd_alloc_fcache_disposal(void)
> >   	if (!l)
> >   		return NULL;
> >   	spin_lock_init(&l->lock);
> > +	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
> >   	INIT_LIST_HEAD(&l->freeme);
> > +	l->file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> > +	if (!l->file_shrinker) {
> > +		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> > +		kfree(l);
> > +		return NULL;
> > +	}
> > +	l->file_shrinker->count_objects =3D nfsd_file_lru_count;
> > +	l->file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> > +	l->file_shrinker->seeks =3D 1;
> > +	l->file_shrinker->private_data =3D l;
> > +
> > +	if (list_lru_init(&l->file_lru)) {
> > +		pr_err("nfsd: failed to init nfsd_file_lru\n");
> > +		shrinker_free(l->file_shrinker);
> > +		kfree(l);
> > +		return NULL;
> > +	}
> > +
> > +	shrinker_register(l->file_shrinker);
> >   	return l;
> >   }
> >  =20
> >   static void
> >   nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
> >   {
> > +	cancel_delayed_work_sync(&l->filecache_laundrette);
> > +	shrinker_free(l->file_shrinker);
> > +	list_lru_destroy(&l->file_lru);
> >   	nfsd_file_dispose_list(&l->freeme);
> >   	kfree(l);
> >   }
> > @@ -899,8 +918,7 @@ void
> >   nfsd_file_cache_purge(struct net *net)
> >   {
> >   	lockdep_assert_held(&nfsd_mutex);
> > -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
> > -		__nfsd_file_cache_purge(net);
> > +	__nfsd_file_cache_purge(net);
> >   }
> >  =20
> >   void
> > @@ -920,14 +938,7 @@ nfsd_file_cache_shutdown(void)
> >   		return;
> >  =20
> >   	lease_unregister_notifier(&nfsd_file_lease_notifier);
> > -	shrinker_free(nfsd_file_shrinker);
> > -	/*
> > -	 * make sure all callers of nfsd_file_lru_cb are done before
> > -	 * calling nfsd_file_cache_purge
> > -	 */
> > -	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
> >   	__nfsd_file_cache_purge(NULL);
> > -	list_lru_destroy(&nfsd_file_lru);
> >   	rcu_barrier();
> >   	fsnotify_put_group(nfsd_file_fsnotify_group);
> >   	nfsd_file_fsnotify_group =3D NULL;
> > @@ -1298,7 +1309,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
> >   		struct bucket_table *tbl;
> >   		struct rhashtable *ht;
> >  =20
> > -		lru =3D list_lru_count(&nfsd_file_lru);
> > +		lru =3D atomic_long_read(&nfsd_lru_total);
> >  =20
> >   		rcu_read_lock();
> >   		ht =3D &nfsd_file_rhltable.ht;
>=20
>=20
> --=20
> Chuck Lever
>=20


