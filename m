Return-Path: <linux-nfs+bounces-4778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0E92D473
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF9C1F22A35
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9F194150;
	Wed, 10 Jul 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R32ivEux"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E732194081
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622636; cv=none; b=s8jBFK4XHMZDK1fzQmvNNotr8771yYnLM1KnGl+W3w8egJ/v26GGo4tyJFYViX4Wj5w2AbGBfQMIQdDl8YStrhtAt7f2tJVahNWKZYGXTdQ1pVFrPwXND8Q1aYv1uN1AzyFcDEf5UwiwE4OQacfZueiFfFiyc5oUxqvm2z85x8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622636; c=relaxed/simple;
	bh=KRrUKW+XWqaTMe0u4QaYCAHv/4roKWzgNcKI7GHemXI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYyXYLqfp9wVn7H1Tj+li6HB8koR0gLmQh3Egsn3NY3heggbXRSm4g1kZ70NoXjv8B9hbbv2zCJQwwAnS76hJZIDGHsbbad+yA4MlErbIxVHKZvumgJOoCBIMAitQTjhAp5i2duqnAFE1x4yS0TqYNgoS1kjByGhQoWHeILh2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R32ivEux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657CEC4AF0E;
	Wed, 10 Jul 2024 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720622635;
	bh=KRrUKW+XWqaTMe0u4QaYCAHv/4roKWzgNcKI7GHemXI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=R32ivEuxv0L9EHQ8ulRIS6lnzD1xXPWAqMFCZKIGFGakjf4FF5klIy4+TdamVCmHM
	 TpzQaPFAwzcI4a4cC8dXhC6o4vdf7gDMaljE3KKCXtZ5F1RhPVla/f2zUpXQ2HpQ1w
	 ATq/UM9ANuXxoXhEua2cyH8NSuJaLqhEBTkuJIgTsNRU2JxhAI0TXPtVtiB1X8CGIl
	 0mcORaO1CzPVbEPetqB62aKEfao2LRhExTPOdTMu3tqMKkAIoPngJ3W9Wdf7qzRhPs
	 Qr6t3qTpWj3Hk6SjDJJm7ZoAHVixCQoyp7p5psJiBJb0lu77nsS2jeuYzPm5mIRnQM
	 xlAeUgqUeWavA==
Message-ID: <c194e534afe2b262783e71659f4956c8ac4d4b60.camel@kernel.org>
Subject: Re: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
From: Jeff Layton <jlayton@kernel.org>
To: Youzhong Yang <youzhong@gmail.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org
Date: Wed, 10 Jul 2024 10:43:54 -0400
In-Reply-To: <20240710144122.61685-1-youzhong@gmail.com>
References: <20240710144122.61685-1-youzhong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 10:40 -0400, Youzhong Yang wrote:
> nfsd_file_put() in one thread can race with another thread doing
> garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
> nfsd_file_lru_cb()):
>=20
> =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file=
_lru_add().
> =C2=A0 * nfsd_file_lru_add() returns true (with NFSD_FILE_REFERENCED bit =
set)
> =C2=A0 * garbage collector kicks in, nfsd_file_lru_cb() clears REFERENCED=
 bit and
> =C2=A0=C2=A0=C2=A0 returns LRU_ROTATE.
> =C2=A0 * garbage collector kicks in again, nfsd_file_lru_cb() now decreme=
nts nf->nf_ref
> =C2=A0=C2=A0=C2=A0 to 0, runs nfsd_file_unhash(), removes it from the LRU=
 and adds to the dispose
> =C2=A0=C2=A0=C2=A0 list [list_lru_isolate_move(lru, &nf->nf_lru, head)]
> =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it t=
ries to remove
> =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]=
. The 'nf' has been added
> =C2=A0=C2=A0=C2=A0 to the 'dispose' list by nfsd_file_lru_cb(), so nfsd_f=
ile_lru_remove(nf) simply
> =C2=A0=C2=A0=C2=A0 treats it as part of the LRU and removes it, which lea=
ds to its removal from
> =C2=A0=C2=A0=C2=A0 the 'dispose' list.
> =C2=A0 * At this moment, 'nf' is unhashed with its nf_ref being 0, and no=
t on the LRU.
> =C2=A0=C2=A0=C2=A0 nfsd_file_put() continues its execution [if (refcount_=
dec_and_test(&nf->nf_ref))],
> =C2=A0=C2=A0=C2=A0 as nf->nf_ref is already 0, nf->nf_ref is set to REFCO=
UNT_SATURATED, and the 'nf'
> =C2=A0=C2=A0=C2=A0 gets no chance of being freed.
>=20
> nfsd_file_put() can also race with nfsd_file_cond_queue():
> =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file=
_lru_add().
> =C2=A0 * nfsd_file_lru_add() sets REFERENCED bit and returns true.
> =C2=A0 * Some userland application runs 'exportfs -f' or something like t=
hat, which triggers
> =C2=A0=C2=A0=C2=A0 __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> =C2=A0 * In nfsd_file_cond_queue(), it runs [if (!nfsd_file_unhash(nf))],=
 unhash is done
> =C2=A0=C2=A0=C2=A0 successfully.
> =C2=A0 * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now nf->n=
f_ref goes to 2.
> =C2=A0 * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))], it =
succeeds.
> =C2=A0 * nfsd_file_cond_queue() runs [if (refcount_sub_and_test(decrement=
, &nf->nf_ref))]
> =C2=A0=C2=A0=C2=A0 (with "decrement" being 2), so the nf->nf_ref goes to =
0, the 'nf' is added to the
> =C2=A0=C2=A0=C2=A0 dispose list [list_add(&nf->nf_lru, dispose)]
> =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it t=
ries to remove
> =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]=
, although the 'nf' is not
> =C2=A0=C2=A0=C2=A0 in the LRU, but it is linked in the 'dispose' list, nf=
sd_file_lru_remove() simply
> =C2=A0=C2=A0=C2=A0 treats it as part of the LRU and removes it. This lead=
s to its removal from
> =C2=A0=C2=A0=C2=A0 the 'dispose' list!
> =C2=A0 * Now nf->ref is 0, unhashed. nfsd_file_put() continues its execut=
ion and set
> =C2=A0=C2=A0=C2=A0 nf->nf_ref to REFCOUNT_SATURATED.
>=20
> As shown in the above analysis, using nf_lru for both the LRU list and di=
spose list
> can cause the leaks. This patch adds a new list_head nf_gc in struct nfsd=
_file, and uses
> it for the dispose list. This does not fix the nfsd_file leaking issue co=
mpletely.
>=20
> Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> ---
> =C2=A0fs/nfsd/filecache.c | 18 ++++++++++--------
> =C2=A0fs/nfsd/filecache.h |=C2=A0 1 +
> =C2=A02 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..22ebd7fb8639 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode,=
 unsigned char need,
> =C2=A0		return NULL;
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&nf->nf_lru);
> +	INIT_LIST_HEAD(&nf->nf_gc);
> =C2=A0	nf->nf_birthtime =3D ktime_get();
> =C2=A0	nf->nf_file =3D NULL;
> =C2=A0	nf->nf_cred =3D get_current_cred();
> @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
> =C2=A0	struct nfsd_file *nf;
> =C2=A0
> =C2=A0	while (!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> +		nf =3D list_first_entry(dispose, struct nfsd_file, nf_gc);
> +		list_del_init(&nf->nf_gc);
> =C2=A0		nfsd_file_free(nf);
> =C2=A0	}
> =C2=A0}
> @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct list_head *di=
spose)
> =C2=A0{
> =C2=A0	while(!list_empty(dispose)) {
> =C2=A0		struct nfsd_file *nf =3D list_first_entry(dispose,
> -						struct nfsd_file, nf_lru);
> +						struct nfsd_file, nf_gc);
> =C2=A0		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> =C2=A0		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> =C2=A0
> =C2=A0		spin_lock(&l->lock);
> -		list_move_tail(&nf->nf_lru, &l->freeme);
> +		list_move_tail(&nf->nf_gc, &l->freeme);
> =C2=A0		spin_unlock(&l->lock);
> =C2=A0		svc_wake_up(nn->nfsd_serv);
> =C2=A0	}
> @@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_=
lru_one *lru,
> =C2=A0
> =C2=A0	/* Refcount went to zero. Unhash it and queue it to the dispose li=
st */
> =C2=A0	nfsd_file_unhash(nf);
> -	list_lru_isolate_move(lru, &nf->nf_lru, head);
> +	list_lru_isolate(lru, &nf->nf_lru);
> +	list_add(&nf->nf_gc, head);
> =C2=A0	this_cpu_inc(nfsd_file_evictions);
> =C2=A0	trace_nfsd_file_gc_disposed(nf);
> =C2=A0	return LRU_REMOVED;
> @@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct lis=
t_head *dispose)
> =C2=A0
> =C2=A0	/* If refcount goes to 0, then put on the dispose list */
> =C2=A0	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> -		list_add(&nf->nf_lru, dispose);
> +		list_add(&nf->nf_gc, dispose);
> =C2=A0		trace_nfsd_file_closing(nf);
> =C2=A0	}
> =C2=A0}
> @@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
> =C2=A0
> =C2=A0	nfsd_file_queue_for_close(inode, &dispose);
> =C2=A0	while (!list_empty(&dispose)) {
> -		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_gc);
> +		list_del_init(&nf->nf_gc);
> =C2=A0		nfsd_file_free(nf);
> =C2=A0	}
> =C2=A0}
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index c61884def906..3fbec24eea6c 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -44,6 +44,7 @@ struct nfsd_file {
> =C2=A0
> =C2=A0	struct nfsd_file_mark	*nf_mark;
> =C2=A0	struct list_head	nf_lru;
> +	struct list_head	nf_gc;
> =C2=A0	struct rcu_head		nf_rcu;
> =C2=A0	ktime_t			nf_birthtime;
> =C2=A0};


Thanks for the contribution and resending!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

