Return-Path: <linux-nfs+bounces-8972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC92A05FBD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE96A18893CD
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA16126C13;
	Wed,  8 Jan 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY0CpU/Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02A2594BC
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349332; cv=none; b=Ro/BAQhQo4QggexLjpNKDxbDtKJnxMTFDvh0b3v7Buji7VyuVvucl7O4oXUZJtjlia5XF1sxN6NNwR2TzIcqoOM7ejqXnRIyIGv+Igx4/vRfks1pGj0x2rOLWg3MMsz/JKKuSUu+BmAr3qKw8U9Cav3Gwg7k/fivBzvxIS/Xabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349332; c=relaxed/simple;
	bh=e+Ave9hKzCOhYr8hDJzvpJ27kmPUDpjoFK633E9qEFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P28j0VjigpdrFWwpDvwzs0WCCsY+gzWtpuUzV+o50LjLgjd4+eXBX75/azNWoO36MJmlbCwUDlzpoRGC5BdbK0fUhPOQd8dMWWAaYVQYOAOiUA/ebGwevdlQmovZaRhqVWTUSfygHa9jp0nFjc+OTQkcXPeEetgphtIYPBszZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY0CpU/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A0C4CED3;
	Wed,  8 Jan 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736349332;
	bh=e+Ave9hKzCOhYr8hDJzvpJ27kmPUDpjoFK633E9qEFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XY0CpU/ZnmuOAwKz+j65TfPi3khwHXTNJPpxuvJcfIoOlSeGudKtrM5ZsOwxthDQA
	 S/Tl3e4BdaCpcn96rFl2IylWwiA4GzvvJRErJF/7ZM5CV63wyCfneevpJv1SSsXvM+
	 dQIKehs+NLB7scrbe9fdHaq+G/dsu2hGPVQ3mziHA8pdH2iD2vCznL+Ydh27DHjeeT
	 oVaj2b69HqAFa4A2TDQyuPxYuD1j4pRrWNTG9VgZIN2AI66+oLYWGxSj3B4UiTDENe
	 FOQT9msqLYM6ds1nFYbZHVCei1Co+6iPubi3evvavgHkXNM/d3SwyBUgzGZ27WTUvP
	 ExMyUcJrZ2H1Q==
Message-ID: <f7d70ec4119c7c15f12589004f09dc1ddb48fe01.camel@kernel.org>
Subject: Re: [PATCH RFC] nfsd: change filecache garbage collection list
 management.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Wed, 08 Jan 2025 10:15:30 -0500
In-Reply-To: <173629103327.22054.7411711418787098876@noble.neil.brown.name>
References: <173629103327.22054.7411711418787098876@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-08 at 10:03 +1100, NeilBrown wrote:
> The nfsd filecache currently uses list_lru for tracking files recently
> used in NFSv3 requests which need to be "garbage collected" when they
> have becoming idle - unused for 2-4 seconds.
>=20
> I do not believe list_lru is a good tool for this.  It does no allow the
> timeout which filecache requires so we have to add a timeout mechanism
> which holds the list_lru for while the whole list is scanned looking for
> entries that haven't been recently accessed.  When the list is largish
> (even a few hundred) this can block new requests which need the lock to
> remove a file to access it.
>=20

Wait, what? The whole point of an LRU list is that the least-recently-
used entries are at the head of the list. We should only need to walk
down to the first entry that can't be reaped and then stop there. Why
is it walking the whole list?


> This patch removes the list_lru and instead uses 2 simple linked lists.
> When a file is accessed it is removed from whichever list it is one,
> then added to the tail of the first list.  Every 2 seconds the second
> list is moved to the "freeme" list and the first list is moved to the
> second list.  This avoids any need to walk a list to find old entries.
>=20

I do like the above idea though. That does seem more efficient than
having to scan lists.

> These lists are per-netns rather than global as the freeme list is
> per-netns as the actual freeing is done in nfsd threads which are
> per-netns.
>=20
> Also the shrinker is moved to be per-netns so that it can access just
> the lists of that netns.
>=20
> We don't need a work_item for the gc pass as it never sleeps.  We can
> use a simple timer instead.  This requires taking the spinlock with
> "_bh".
>=20
> Previously a file would be unhashed before being moved to the freeme
> list.  We don't do that any more.  The freeme list is much like the
> other two lists (recent and older) in that they all hold a reference to
> the file and the file is still hashed.
>=20
>   When the nfsd thread processes
> the freeme list it now use the new nfsd_file_release_list() which uses
> nfsd_file_cond_queue() to unhash and drop the refcount.
>
> We no longer have a precise cound of the size of the lru (recent +
> older) as we don't know how big "older" is when it is moved to "freeme".
> How the shrinker can with an approximation.  So when we keep a count of
> number in the lru and hwen "older" is moved to "freeme" we divide that
> count by 2.  When we remove anything from the lru we decrement that
> counter but ensure it never goes negative.  Naturally when we add to the
> lru we increase the counter.
>=20
> For the filecache stats file, which assumes a global lru, we keep a
> separate counter which includes all files in all netns in recent or
> older of freeme.
>=20
> We discard the nf_gc linkage in an nfsd_file and only use nf_lru.
> We discard NFSD_FILE_REFERENCED.
> nfsd_file_close_inode_sync() included a copy of
> nfsd_file_dispose_list().  This has been change to call that function
> instead.
>=20
> Possibly this patch could be broken into a few smaller patches.
>=20

Yeah, that would help.


> Tracepoints should be revieed.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 304 +++++++++++++++++++++++---------------------
>  fs/nfsd/filecache.h |   4 +-
>  fs/nfsd/trace.h     |   1 -
>  3 files changed, 157 insertions(+), 152 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..319c60234f09 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -34,7 +34,6 @@
>  #include <linux/file.h>
>  #include <linux/pagemap.h>
>  #include <linux/sched.h>
> -#include <linux/list_lru.h>
>  #include <linux/fsnotify_backend.h>
>  #include <linux/fsnotify.h>
>  #include <linux/seq_file.h>
> @@ -63,17 +62,22 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evicti=
ons);
> =20
>  struct nfsd_fcache_disposal {
>  	spinlock_t lock;
> -	struct list_head freeme;
> +	struct timer_list timer;
> +	struct list_head recent; /* have been used in last 0-2 seconds */
> +	struct list_head older;	/* haven't been used in last 0-2 seconds */
> +	struct list_head freeme; /* ready to be discarded */
> +	unsigned long num_gc; /* Approximate size of recent plus older */
> +	struct shrinker *file_shrinker;
> +	struct nfsd_net *nn;
>  };
> =20
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
> -static struct list_lru			nfsd_file_lru;
>  static unsigned long			nfsd_file_flags;
>  static struct fsnotify_group		*nfsd_file_fsnotify_group;
> -static struct delayed_work		nfsd_filecache_laundrette;
>  static struct rhltable			nfsd_file_rhltable
>  						____cacheline_aligned_in_smp;
> +static atomic_long_t			nfsd_lru_total =3D ATOMIC_LONG_INIT(0);
> =20
>  static bool
>  nfsd_match_cred(const struct cred *c1, const struct cred *c2)
> @@ -109,11 +113,14 @@ static const struct rhashtable_params nfsd_file_rha=
sh_params =3D {
>  };
> =20
>  static void
> -nfsd_file_schedule_laundrette(void)
> +nfsd_file_schedule_laundrette(struct net *net)
>  {
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> -				   NFSD_LAUNDRETTE_DELAY);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> +	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) &&
> +	    !timer_pending(&l->timer))
> +		mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
>  }
> =20
>  static void
> @@ -218,7 +225,6 @@ nfsd_file_alloc(struct net *net, struct inode *inode,=
 unsigned char need,
> =20
>  	this_cpu_inc(nfsd_file_allocations);
>  	INIT_LIST_HEAD(&nf->nf_lru);
> -	INIT_LIST_HEAD(&nf->nf_gc);
>  	nf->nf_birthtime =3D ktime_get();
>  	nf->nf_file =3D NULL;
>  	nf->nf_cred =3D get_current_cred();
> @@ -318,23 +324,40 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
> =20
> -
>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
> -	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> +	spin_lock_bh(&l->lock);
> +	if (list_empty(&nf->nf_lru)) {
> +		list_add_tail(&nf->nf_lru, &l->recent);
> +		l->num_gc +=3D 1;
> +		atomic_long_inc(&nfsd_lru_total);
> +		spin_unlock_bh(&l->lock);
>  		trace_nfsd_file_lru_add(nf);
>  		return true;
>  	}
> +	spin_unlock_bh(&l->lock);
>  	return false;
>  }
> =20
>  static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>  {
> -	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> +	spin_lock_bh(&l->lock);
> +	if (!list_empty(&nf->nf_lru)) {
> +		list_del_init(&nf->nf_lru);
> +		atomic_long_dec(&nfsd_lru_total);
> +		if (l->num_gc > 0)
> +			l->num_gc -=3D 1;
> +		spin_unlock_bh(&l->lock);
>  		trace_nfsd_file_lru_del(nf);
>  		return true;
>  	}
> +	spin_unlock_bh(&l->lock);
>  	return false;
>  }
> =20
> @@ -373,7 +396,7 @@ nfsd_file_put(struct nfsd_file *nf)
>  		if (nfsd_file_lru_add(nf)) {
>  			/* If it's still hashed, we're done */
>  			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -				nfsd_file_schedule_laundrette();
> +				nfsd_file_schedule_laundrette(nf->nf_net);
>  				return;
>  			}
> =20
> @@ -424,12 +447,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  	struct nfsd_file *nf;
> =20
>  	while (!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_gc);
> -		list_del_init(&nf->nf_gc);
> +		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
>  		nfsd_file_free(nf);
>  	}
>  }
> =20
> +static void
> +nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose);
> +
> +static void
> +nfsd_file_release_list(struct list_head *dispose)
> +{
> +	LIST_HEAD(dispose2);
> +	struct nfsd_file *nf, *nf2;
> +
> +	list_for_each_entry_safe(nf, nf2, dispose, nf_lru)
> +		nfsd_file_cond_queue(nf, &dispose2);
> +	nfsd_file_dispose_list(&dispose2);
> +}
> +
>  /**
>   * nfsd_file_dispose_list_delayed - move list of dead files to net's fre=
eme list
>   * @dispose: list of nfsd_files to be disposed
> @@ -442,13 +479,13 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
>  {
>  	while(!list_empty(dispose)) {
>  		struct nfsd_file *nf =3D list_first_entry(dispose,
> -						struct nfsd_file, nf_gc);
> +						struct nfsd_file, nf_lru);
>  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
>  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> =20
> -		spin_lock(&l->lock);
> -		list_move_tail(&nf->nf_gc, &l->freeme);
> -		spin_unlock(&l->lock);
> +		spin_lock_bh(&l->lock);
> +		list_move_tail(&nf->nf_lru, &l->freeme);
> +		spin_unlock_bh(&l->lock);
>  		svc_wake_up(nn->nfsd_serv);
>  	}
>  }
> @@ -470,115 +507,97 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
>  		LIST_HEAD(dispose);
>  		int i;
> =20
> -		spin_lock(&l->lock);
> -		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++)
> -			list_move(l->freeme.next, &dispose);
> -		spin_unlock(&l->lock);
> +		spin_lock_bh(&l->lock);
> +		for (i =3D 0; i < 8 && !list_empty(&l->freeme); i++) {
> +			struct nfsd_file *nf =3D list_first_entry(
> +				&l->freeme, struct nfsd_file, nf_lru);
> +
> +			/*
> +			 * Don't throw out files that are still
> +			 * undergoing I/O or that have uncleared errors
> +			 * pending.
> +			 */
> +			if (nfsd_file_check_writeback(nf)) {
> +				list_move(&nf->nf_lru, &l->recent);
> +				l->num_gc +=3D 1;
> +			} else {
> +				list_move(&nf->nf_lru, &dispose);
> +				this_cpu_inc(nfsd_file_evictions);
> +			}
> +		}
> +		spin_unlock_bh(&l->lock);
>  		if (!list_empty(&l->freeme))
>  			/* Wake up another thread to share the work
>  			 * *before* doing any actual disposing.
>  			 */
>  			svc_wake_up(nn->nfsd_serv);
> -		nfsd_file_dispose_list(&dispose);
> -	}
> -}
> -
> -/**
> - * nfsd_file_lru_cb - Examine an entry on the LRU list
> - * @item: LRU entry to examine
> - * @lru: controlling LRU
> - * @arg: dispose list
> - *
> - * Return values:
> - *   %LRU_REMOVED: @item was removed from the LRU
> - *   %LRU_ROTATE: @item is to be moved to the LRU tail
> - *   %LRU_SKIP: @item cannot be evicted
> - */
> -static enum lru_status
> -nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
> -		 void *arg)
> -{
> -	struct list_head *head =3D arg;
> -	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> -
> -	/* We should only be dealing with GC entries here */
> -	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> -
> -	/*
> -	 * Don't throw out files that are still undergoing I/O or
> -	 * that have uncleared errors pending.
> -	 */
> -	if (nfsd_file_check_writeback(nf)) {
> -		trace_nfsd_file_gc_writeback(nf);
> -		return LRU_SKIP;
> -	}
> -
> -	/* If it was recently added to the list, skip it */
> -	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_referenced(nf);
> -		return LRU_ROTATE;
> -	}
> -
> -	/*
> -	 * Put the reference held on behalf of the LRU. If it wasn't the last
> -	 * one, then just remove it from the LRU and ignore it.
> -	 */
> -	if (!refcount_dec_and_test(&nf->nf_ref)) {
> -		trace_nfsd_file_gc_in_use(nf);
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		return LRU_REMOVED;
> +		nfsd_file_release_list(&dispose);
>  	}
> -
> -	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> -	nfsd_file_unhash(nf);
> -	list_lru_isolate(lru, &nf->nf_lru);
> -	list_add(&nf->nf_gc, head);
> -	this_cpu_inc(nfsd_file_evictions);
> -	trace_nfsd_file_gc_disposed(nf);
> -	return LRU_REMOVED;
> -}
> -
> -static void
> -nfsd_file_gc(void)
> -{
> -	LIST_HEAD(dispose);
> -	unsigned long ret;
> -
> -	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> -			    &dispose, list_lru_count(&nfsd_file_lru));
> -	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_dispose_list_delayed(&dispose);
>  }
> =20
>  static void
> -nfsd_file_gc_worker(struct work_struct *work)
> +nfsd_file_gc_worker(struct timer_list *t)
>  {
> -	nfsd_file_gc();
> -	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +	struct nfsd_fcache_disposal *l =3D container_of(
> +		t, struct nfsd_fcache_disposal, timer);
> +	bool wakeup =3D false;
> +
> +	spin_lock_bh(&l->lock);
> +	list_splice_init(&l->older, &l->freeme);
> +	list_splice_init(&l->recent, &l->older);
> +	/* We don't know how many were moved to 'freeme' and don't want
> +	 * to waste time counting - guess a half.
> +	 */
> +	l->num_gc /=3D 2;
> +	if (!list_empty(&l->freeme))
> +		wakeup =3D true;
> +	if (!list_empty(&l->older) || !list_empty(&l->recent))
> +		mod_timer(t, jiffies + NFSD_LAUNDRETTE_DELAY);
> +	spin_unlock_bh(&l->lock);
> +	if (wakeup)
> +		svc_wake_up(l->nn->nfsd_serv);
>  }
> =20
>  static unsigned long
>  nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
>  {
> -	return list_lru_count(&nfsd_file_lru);
> +	struct nfsd_fcache_disposal *l =3D s->private_data;
> +	return l->num_gc;
>  }
> =20
>  static unsigned long
>  nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
>  {
> -	LIST_HEAD(dispose);
> -	unsigned long ret;
> +	struct nfsd_fcache_disposal *l =3D s->private_data;
> +	struct nfsd_file *nf;
> +	int scanned =3D 0;
> +
> +	spin_lock_bh(&l->lock);
> +	while (scanned < sc->nr_to_scan &&
> +	       (nf =3D list_first_entry_or_null(&l->older,
> +					      struct nfsd_file, nf_lru)) !=3D NULL) {
> +		list_del_init(&nf->nf_lru);
> +		list_add_tail(&nf->nf_lru, &l->freeme);
> +		if (l->num_gc > 0)
> +			l->num_gc -=3D 1;
> +		scanned +=3D 1;
> +	}
> +	if (scanned > 0)
> +		svc_wake_up(l->nn->nfsd_serv);
> +
> +	while (scanned < sc->nr_to_scan &&
> +	       (nf =3D list_first_entry_or_null(&l->recent,
> +					      struct nfsd_file, nf_lru)) !=3D NULL) {
> +		list_del_init(&nf->nf_lru);
> +		list_add_tail(&nf->nf_lru, &l->older);
> +		scanned +=3D 1;
> +	}
> +	spin_unlock_bh(&l->lock);
> =20
> -	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> -				   nfsd_file_lru_cb, &dispose);
> -	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_dispose_list_delayed(&dispose);
> -	return ret;
> +	trace_nfsd_file_shrinker_removed(scanned, l->num_gc);
> +	return scanned;
>  }
> =20
> -static struct shrinker *nfsd_file_shrinker;
> -
>  /**
>   * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
>   * @nf: nfsd_file to attempt to queue
> @@ -589,7 +608,6 @@ static struct shrinker *nfsd_file_shrinker;
>   */
>  static void
>  nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
> -	__must_hold(RCU)
>  {
>  	int decrement =3D 1;
> =20
> @@ -607,7 +625,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct lis=
t_head *dispose)
> =20
>  	/* If refcount goes to 0, then put on the dispose list */
>  	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> -		list_add(&nf->nf_gc, dispose);
> +		list_add(&nf->nf_lru, dispose);
>  		trace_nfsd_file_closing(nf);
>  	}
>  }
> @@ -676,17 +694,12 @@ nfsd_file_close_inode(struct inode *inode)
>  void
>  nfsd_file_close_inode_sync(struct inode *inode)
>  {
> -	struct nfsd_file *nf;
>  	LIST_HEAD(dispose);
> =20
>  	trace_nfsd_file_close(inode);
> =20
>  	nfsd_file_queue_for_close(inode, &dispose);
> -	while (!list_empty(&dispose)) {
> -		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_gc);
> -		list_del_init(&nf->nf_gc);
> -		nfsd_file_free(nf);
> -	}
> +	nfsd_file_dispose_list(&dispose);
>  }
> =20
>  static int
> @@ -763,29 +776,10 @@ nfsd_file_cache_init(void)
>  		goto out_err;
>  	}
> =20
> -	ret =3D list_lru_init(&nfsd_file_lru);
> -	if (ret) {
> -		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
> -		goto out_err;
> -	}
> -
> -	nfsd_file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> -	if (!nfsd_file_shrinker) {
> -		ret =3D -ENOMEM;
> -		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> -		goto out_lru;
> -	}
> -
> -	nfsd_file_shrinker->count_objects =3D nfsd_file_lru_count;
> -	nfsd_file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> -	nfsd_file_shrinker->seeks =3D 1;
> -
> -	shrinker_register(nfsd_file_shrinker);
> -
>  	ret =3D lease_register_notifier(&nfsd_file_lease_notifier);
>  	if (ret) {
>  		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
> -		goto out_shrinker;
> +		goto out_err;
>  	}
> =20
>  	nfsd_file_fsnotify_group =3D fsnotify_alloc_group(&nfsd_file_fsnotify_o=
ps,
> @@ -798,17 +792,12 @@ nfsd_file_cache_init(void)
>  		goto out_notifier;
>  	}
> =20
> -	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>  out:
>  	if (ret)
>  		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>  	return ret;
>  out_notifier:
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -out_shrinker:
> -	shrinker_free(nfsd_file_shrinker);
> -out_lru:
> -	list_lru_destroy(&nfsd_file_lru);
>  out_err:
>  	kmem_cache_destroy(nfsd_file_slab);
>  	nfsd_file_slab =3D NULL;
> @@ -860,14 +849,38 @@ nfsd_alloc_fcache_disposal(void)
>  	if (!l)
>  		return NULL;
>  	spin_lock_init(&l->lock);
> +	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
> +	INIT_LIST_HEAD(&l->recent);
> +	INIT_LIST_HEAD(&l->older);
>  	INIT_LIST_HEAD(&l->freeme);
> +	l->num_gc =3D 0;
> +	l->file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> +	if (!l->file_shrinker) {
> +		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> +		kfree(l);
> +		return NULL;
> +	}
> +	l->file_shrinker->count_objects =3D nfsd_file_lru_count;
> +	l->file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> +	l->file_shrinker->seeks =3D 1;
> +	l->file_shrinker->private_data =3D l;
> +
> +	shrinker_register(l->file_shrinker);
> +
>  	return l;
>  }
> =20
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> -	nfsd_file_dispose_list(&l->freeme);
> +	del_timer_sync(&l->timer);
> +	shrinker_free(l->file_shrinker);
> +	nfsd_file_release_list(&l->recent);
> +	WARN_ON_ONCE(!list_empty(&l->recent));
> +	nfsd_file_release_list(&l->older);
> +	WARN_ON_ONCE(!list_empty(&l->older));
> +	nfsd_file_release_list(&l->freeme);
> +	WARN_ON_ONCE(!list_empty(&l->freeme));
>  	kfree(l);
>  }
> =20
> @@ -886,6 +899,8 @@ nfsd_file_cache_start_net(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
>  	nn->fcache_disposal =3D nfsd_alloc_fcache_disposal();
> +	if (nn->fcache_disposal)
> +		nn->fcache_disposal->nn =3D nn;
>  	return nn->fcache_disposal ? 0 : -ENOMEM;
>  }
> =20
> @@ -919,14 +934,7 @@ nfsd_file_cache_shutdown(void)
>  		return;
> =20
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -	shrinker_free(nfsd_file_shrinker);
> -	/*
> -	 * make sure all callers of nfsd_file_lru_cb are done before
> -	 * calling nfsd_file_cache_purge
> -	 */
> -	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
>  	__nfsd_file_cache_purge(NULL);
> -	list_lru_destroy(&nfsd_file_lru);
>  	rcu_barrier();
>  	fsnotify_put_group(nfsd_file_fsnotify_group);
>  	nfsd_file_fsnotify_group =3D NULL;
> @@ -1297,7 +1305,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
>  		struct bucket_table *tbl;
>  		struct rhashtable *ht;
> =20
> -		lru =3D list_lru_count(&nfsd_file_lru);
> +		lru =3D atomic_long_read(&nfsd_lru_total);
> =20
>  		rcu_read_lock();
>  		ht =3D &nfsd_file_rhltable.ht;
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index d5db6b34ba30..d88ae287c01f 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -36,15 +36,13 @@ struct nfsd_file {
>  	struct net		*nf_net;
>  #define NFSD_FILE_HASHED	(0)
>  #define NFSD_FILE_PENDING	(1)
> -#define NFSD_FILE_REFERENCED	(2)
> -#define NFSD_FILE_GC		(3)
> +#define NFSD_FILE_GC		(2)
>  	unsigned long		nf_flags;
>  	refcount_t		nf_ref;
>  	unsigned char		nf_may;
> =20
>  	struct nfsd_file_mark	*nf_mark;
>  	struct list_head	nf_lru;
> -	struct list_head	nf_gc;
>  	struct rcu_head		nf_rcu;
>  	ktime_t			nf_birthtime;
>  };
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index ad2c0c432d08..a266f1f21adc 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1038,7 +1038,6 @@ DEFINE_CLID_EVENT(confirmed_r);
>  	__print_flags(val, "|",						\
>  		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>  		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
>  		{ 1 << NFSD_FILE_GC,		"GC" })
> =20
>  DECLARE_EVENT_CLASS(nfsd_file_class,
>=20
> base-commit: 5e5a0681df5068efbd000dcfcbc34ae064fda1cc

--=20
Jeff Layton <jlayton@kernel.org>

