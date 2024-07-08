Return-Path: <linux-nfs+bounces-4718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E13692A52F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50B5B20B4C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0A13FD69;
	Mon,  8 Jul 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpn4mUzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AD78C75
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450503; cv=none; b=dWyHhVSA/h6UO69W4R8gyOfs+stAafhWbkYHAazgzuRfGaCoHQyhWlpX2UCAqClOKa8SQtj24Otiadv5nM34OBehTAW6Qek7mBiFLn+vZ6GH/uWp38lVRXiFI2hcgBn4UcHCzuh0U3ILFAe5RBlcHKpv7t8ln1FkNEnMYFgmBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450503; c=relaxed/simple;
	bh=JDfv3QhdND2GzdPQITpr5FDtE9eRidijOleMUu9KL2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFeBQwwe9Tmt1xh+L6uCVKrqCvv5sSZeZ1PqALgg4OA8rlxbHTpka6zQlauUMnrG/PLeoDpR0PzMqSJE+B9Ubl6tA5tcNfqDXvN13RKbWiM+F3fOrCcYJVz0cU9XoldCDCUoZ0ntyTwd+ABh9r3UL1sY0D2sB8yONd9704L/P4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpn4mUzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A751C116B1;
	Mon,  8 Jul 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450502;
	bh=JDfv3QhdND2GzdPQITpr5FDtE9eRidijOleMUu9KL2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mpn4mUzOPC9zbh5uIHzhVnMY1xrVVbakrWiMHZGKGvA8zRUnZYxNuezLV/fHml8Lp
	 s5QMUG/OrKHKP848gWOBCzaTpZhI5/3G8gTfAuA7RAdZ7PGwNaYcF0wvb250kIkVBf
	 z9Hrw3jDtXNjnhhJzjydXO+k8COpJ6YH4ql60dbCyHTupo/k+8MAvpKHxLxTL3AOf3
	 kUb+7zknfy0skWs3pnsz3KyhOmoaGKumO8M0tdmD2NVhykIlHLan/yFxRCmjxubDW4
	 YN63xMc8Pcbh+57q6AndnFaSN5gLnxGKbTSoz0mAZL3v3bTEHM8JTdj4k+b2Xj+syH
	 vIcAUWuVgDvfg==
Message-ID: <c138dd82bb493abe7b0c34b1e2803437bd163c54.camel@kernel.org>
Subject: Re: Leaked nfsd_file due to race condition and early unhash
 (fs/nfsd/filecache.c)
From: Jeff Layton <jlayton@kernel.org>
To: Youzhong Yang <youzhong@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Mon, 08 Jul 2024 10:55:01 -0400
In-Reply-To: <CADpNCvb5kpghbEj+yU1OgKF0BJS9dYDtFgRz3ArfCamCnyn_Ww@mail.gmail.com>
References: 
	<CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
	 <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
	 <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
	 <0445d64ebcc7185bf48cc05f72ca29b859f45c26.camel@poochiereds.net>
	 <CADpNCvZ-kEc6hOQHsbn7yHtvB-acg_gQwzEjN9zcjw0oM2RgGw@mail.gmail.com>
	 <321ddc16356d75f9eb6e5ab15c4e28fae1466267.camel@kernel.org>
	 <CADpNCvb5kpghbEj+yU1OgKF0BJS9dYDtFgRz3ArfCamCnyn_Ww@mail.gmail.com>
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

On Mon, 2024-07-08 at 10:23 -0400, Youzhong Yang wrote:
> Thanks Jeff.
>=20
> I am ok with reverting the unhash/dispose list reordering in
> nfsd_file_lru_cb(), as it doesn't make much of a difference,
> but for nfsd_file_cond_queue(), imagining this:
>=20
> - A nfsd_file is hashed
> - In nfsd_file_cond_queue(), [if (!nfsd_file_unhash(nf))] will get it
> unhashed, doesn't it?
> - It continues to get a reference by nfsd_file_get()
> - It continues to remove itself from LRU by nfsd_file_lru_remove() if
> it is on the LRU.
> - Now it runs refcount_sub_and_test(), what happens if the refcnt
> does
> not go to 0? How can this nfsd_file be found again? Through the hash
> table? Through the LRU walk? how?
>=20
> Thanks again.
>=20
> -Youzhong
>=20

It won't need to be found again. The holders of the extra references
will put those references when they are finished. Since the object is
no longer HASHED, nfsd_file_put just does this:

        if (refcount_dec_and_test(&nf->nf_ref))
                nfsd_file_free(nf);

So that should be fine.

> On Mon, Jul 8, 2024 at 9:35=E2=80=AFAM Jeff Layton <jlayton@kernel.org>
> wrote:
> >=20
> > On Mon, 2024-07-08 at 08:58 -0400, Youzhong Yang wrote:
> > > Thank you Jeff for your invaluable insights. I was leaning
> > > towards
> > > adding a new list_head too, and tested this approach on kernel
> > > 6.6 by
> > > continuously hammering the server with heavy nfs load for the
> > > last few
> > > days, not a single leak.
> > >=20
> > > Here goes the patch (based on Linux kernel master branch), please
> > > review:
> > >=20
> > > From: Youzhong Yang <youzhong@gmail.com>
> > > Date: Thu, 4 Jul 2024 11:25:40 -0400
> > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to mixed use of
> > > nf->nf_lru
> > >=20
> > > nfsd_file_put() in one thread can race with another thread doing
> > > garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
> > > nfsd_file_lru_cb()):
> > >=20
> > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > nfsd_file_lru_add().
> > > =C2=A0 * nfsd_file_lru_add() returns true (with NFSD_FILE_REFERENCED
> > > bit set)
> > > =C2=A0 * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > REFERENCED bit and
> > > =C2=A0=C2=A0=C2=A0 returns LRU_ROTATE.
> > > =C2=A0 * garbage collector kicks in again, nfsd_file_lru_cb() now
> > > decrements nf->nf_ref
> > > =C2=A0=C2=A0=C2=A0 to 0, runs nfsd_file_unhash(), removes it from the=
 LRU and
> > > adds to
> > > the dispose
> > > =C2=A0=C2=A0=C2=A0 list [list_lru_isolate_move(lru, &nf->nf_lru, head=
)]
> > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so
> > > it
> > > tries to remove
> > > =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if (!nfsd_file_lru_remove(n=
f))]. The
> > > 'nf'
> > > has been added
> > > =C2=A0=C2=A0=C2=A0 to the 'dispose' list by nfsd_file_lru_cb(), so
> > > nfsd_file_lru_remove(nf) simply
> > > =C2=A0=C2=A0=C2=A0 treats it as part of the LRU and removes it, which=
 leads to
> > > its removal from
> > > =C2=A0=C2=A0=C2=A0 the 'dispose' list.
> > > =C2=A0 * At this moment, 'nf' is unhashed with its nf_ref being 0, an=
d
> > > not
> > > on the LRU.
> > > =C2=A0=C2=A0=C2=A0 nfsd_file_put() continues its execution [if
> > > (refcount_dec_and_test(&nf->nf_ref))],
> > > =C2=A0=C2=A0=C2=A0 as nf->nf_ref is already 0, nf->nf_ref is set to
> > > REFCOUNT_SATURATED, and the 'nf'
> > > =C2=A0=C2=A0=C2=A0 gets no chance of being freed.
> > >=20
> > > nfsd_file_put() can also race with nfsd_file_cond_queue():
> > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > nfsd_file_lru_add().
> > > =C2=A0 * nfsd_file_lru_add() sets REFERENCED bit and returns true.
> > > =C2=A0 * Some userland application runs 'exportfs -f' or something
> > > like
> > > that, which triggers
> > > =C2=A0=C2=A0=C2=A0 __nfsd_file_cache_purge() -> nfsd_file_cond_queue(=
).
> > > =C2=A0 * In nfsd_file_cond_queue(), it runs [if
> > > (!nfsd_file_unhash(nf))],
> > > unhash is done
> > > =C2=A0=C2=A0=C2=A0 successfully.
> > > =C2=A0 * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now
> > > nf->nf_ref goes to 2.
> > > =C2=A0 * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))],
> > > it succeeds.
> > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > (refcount_sub_and_test(decrement,
> > > &nf->nf_ref))]
> > > =C2=A0=C2=A0=C2=A0 (with "decrement" being 2), so the nf->nf_ref goes=
 to 0, the
> > > 'nf'
> > > is added to the
> > > =C2=A0=C2=A0=C2=A0 dispose list [list_add(&nf->nf_lru, dispose)]
> > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so
> > > it
> > > tries to remove
> > > =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if (!nfsd_file_lru_remove(n=
f))],
> > > although
> > > the 'nf' is not
> > > =C2=A0=C2=A0=C2=A0 in the LRU, but it is linked in the 'dispose' list=
,
> > > nfsd_file_lru_remove() simply
> > > =C2=A0=C2=A0=C2=A0 treats it as part of the LRU and removes it. This =
leads to
> > > its removal from
> > > =C2=A0=C2=A0=C2=A0 the 'dispose' list!
> > > =C2=A0 * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
> > > execution and set
> > > =C2=A0=C2=A0=C2=A0 nf->nf_ref to REFCOUNT_SATURATED.
> > >=20
> > > As shown in the above analysis, using nf_lru for both the LRU
> > > list and
> > > dispose list
> > > can cause the leaks. This patch adds a new list_head nf_gc in
> > > struct
> > > nfsd_file, and uses
> > > it for the dispose list. It's not expected to have a nfsd_file
> > > unhashed but it's not
> > > added to the dispose list, so in nfsd_file_cond_queue() and
> > > nfsd_file_lru_cb() nfsd_file
> > > is unhashed after being added to the dispose list.
> > >=20
> >=20
> > I don't see where we require the object to be either hashed or on
> > the
> > dispose list.=C2=A0 I think you probably just want to do a patch that
> > changes the dispose list to use a dedicated list_head without
> > reordering when the these things are unhashed.
> >=20
> > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > ---
> > > =C2=A0fs/nfsd/filecache.c | 23 ++++++++++++++---------
> > > =C2=A0fs/nfsd/filecache.h |=C2=A0 1 +
> > > =C2=A02 files changed, 15 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index ad9083ca144b..3aef2ddfce94 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode
> > > *inode, unsigned char need,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&nf->nf_lru=
);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&nf->nf_gc);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_birthtime =3D ktime=
_get();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_file =3D NULL;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_cred =3D get_curren=
t_cred();
> > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head
> > > *dispose)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(dispose=
)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct nfsd_file,
> > > nf_lru);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct nfsd_file,
> > > nf_gc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > > @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct
> > > list_head *dispose)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while(!list_empty(dispose)=
) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf =3D list_first_entry(dispose,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fi=
le,
> > > nf_lru);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fi=
le,
> > > nf_gc);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D net_generic(nf->nf_net,
> > > nfsd_net_id);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fcache_disposal *l =3D nn-
> > > >fcache_disposal;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_lock(&l->lock);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_lru, &l->freeme);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_gc, &l->freeme);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&l->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > @@ -502,8 +503,10 @@ nfsd_file_lru_cb(struct list_head *item,
> > > struct
> > > list_lru_one *lru,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Refcount went to zero. =
Unhash it and queue it to the
> > > dispose list */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate(lru, &nf->nf_l=
ru);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc, head);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unhash after removing from L=
RU and adding to dispose
> > > list */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate_move(lru, &nf-=
>nf_lru, head);
> >=20
> > I don't see the point in reordering these operations. Hashing is
> > all
> > about making the thing findable by nfsd operations. The _last_
> > thing we
> > want to do is put it on the dispose list while the thing can still
> > be
> > found by nfsd threads doing operations.
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu_inc(nfsd_file_evi=
ctions);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_gc_dispose=
d(nf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return LRU_REMOVED;
> > > @@ -565,7 +568,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf,
> > > struct
> > > list_head *dispose)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int decrement =3D 1;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we raced with someon=
e else unhashing, ignore it */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nfsd_file_unhash(nf))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(NFSD_FILE_HASHED,=
 &nf->nf_flags))
> >=20
> > The above change looks wrong. I don't think we need to change this.
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we can't get a refer=
ence, ignore it */
> > > @@ -578,7 +581,9 @@ nfsd_file_cond_queue(struct nfsd_file *nf,
> > > struct
> > > list_head *dispose)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If refcount goes to 0, =
then put on the dispose list */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_sub_and_test(=
decrement, &nf->nf_ref)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru, dispose);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc, dispose);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Unhash after adding to dispose list */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> >=20
> > This too looks wrong? Maybe I'm unclear on the race you're trying
> > to
> > fix with this? What's the harm in unhashing it early?
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_closing(nf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > > @@ -654,8 +659,8 @@ nfsd_file_close_inode_sync(struct inode
> > > *inode)
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_queue_for_close(=
inode, &dispose);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(&dispos=
e)) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > nf_lru);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > nf_gc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > index c61884def906..3fbec24eea6c 100644
> > > --- a/fs/nfsd/filecache.h
> > > +++ b/fs/nfsd/filecache.h
> > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file_mark=C2=
=A0=C2=A0 *nf_mark;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_lru;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_gc;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_head=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_rcu;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 nf_birthtime;
> > > =C2=A0};
> > > --
> > > 2.34.1
> > >=20
> > > On Thu, Jul 4, 2024 at 7:14=E2=80=AFAM Jeff Layton
> > > <jlayton@poochiereds.net> wrote:
> > > >=20
> > > > On Wed, 2024-07-03 at 16:46 -0400, Youzhong Yang wrote:
> > > > > Thank you Chuck. Here are my quick answers to your comments:
> > > > >=20
> > > > > - I don't have a quick reproducer. I reproduced it by using
> > > > > hundreds
> > > > > of nfs clients generating +600K ops under our workload in the
> > > > > testing
> > > > > environment. Theoretically it should be possible to simplify
> > > > > the
> > > > > reproduction but I am still working on it.
> > > > >=20
> > > > > -=C2=A0 I understand zfs is an out-of-tree file system. That's
> > > > > fine. But
> > > > > this leaking can happen to any file system, and leaking is
> > > > > not a good
> > > > > thing no matter what file system it is.
> > > > >=20
> > > > > -=C2=A0 I will try to come up with a reproducer using xfs or btrf=
s
> > > > > if possible.
> > > > >=20
> > > > > Now back to the problem itself, here are my findings:
> > > > >=20
> > > > > - nfsd_file_put() in one thread can race with another thread
> > > > > doing
> > > > > garbage collection (running nfsd_file_gc() -> list_lru_walk()
> > > > > ->
> > > > > nfsd_file_lru_cb()):
> > > > >=20
> > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > nfsd_file_lru_add().
> > > > > =C2=A0 * nfsd_file_lru_add() returns true (thus
> > > > > NFSD_FILE_REFERENCED bit
> > > > > set for nf->nf_flags)
> > > > > =C2=A0 * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > > > REFERENCED
> > > > > bit and returns LRU_ROTATE.
> > > > > =C2=A0 * garbage collector kicks in again, nfsd_file_lru_cb() now
> > > > > decrements nf->nf_ref to 0, runs nfsd_file_unhash(), removes
> > > > > it from
> > > > > the LRU and adds to the dispose list
> > > > > [list_lru_isolate_move(lru,
> > > > > &nf->nf_lru, head);]
> > > > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > so it
> > > > > tries to remove the 'nf' from the LRU [if
> > > > > (!nfsd_file_lru_remove(nf))]
> > > > > =C2=A0 * The 'nf' has been added to the 'dispose' list by
> > > > > nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply treats
> > > > > it as
> > > > > part of the LRU and removes it, which leads it to be removed
> > > > > from the
> > > > > 'dispose' list.
> > > > > =C2=A0 * At this moment, nf->nf_ref is 0, it's unhashed, and not
> > > > > on the
> > > > > LRU. nfsd_file_put() continues its execution [if
> > > > > (refcount_dec_and_test(&nf->nf_ref))], as nf->nf_ref is
> > > > > already 0, now
> > > > > bad thing happens: nf->nf_ref is set to REFCOUNT_SATURATED,
> > > > > and the
> > > > > 'nf' is leaked.
> > > > >=20
> > > > > To make this happen, the right timing is crucial. It can be
> > > > > reproduced
> > > > > by adding artifical delays in filecache.c, or hammering the
> > > > > nfsd with
> > > > > tons of ops.
> > > > >=20
> > > > > - Let's see how nfsd_file_put() can race with
> > > > > nfsd_file_cond_queue():
> > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > nfsd_file_lru_add().
> > > > > =C2=A0 * nfsd_file_lru_add() sets REFERENCED bit and returns true=
.
> > > > > =C2=A0 * 'exportfs -f' or something like that triggers
> > > > > __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> > > > > =C2=A0 * In nfsd_file_cond_queue(), it runs [if
> > > > > (!nfsd_file_unhash(nf))],
> > > > > unhash is done successfully.
> > > > > =C2=A0 * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))],
> > > > > now
> > > > > nf->nf_ref goes to 2.
> > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > (nfsd_file_lru_remove(nf))], it succeeds.
> > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > (refcount_sub_and_test(decrement,
> > > > > &nf->nf_ref))] (with "decrement" being 2), so the nf->nf_ref
> > > > > goes to
> > > > > 0, the 'nf' is added to the dispost list [list_add(&nf-
> > > > > >nf_lru,
> > > > > dispose)]
> > > > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > so it
> > > > > tries to remove the 'nf' from the LRU [if
> > > > > (!nfsd_file_lru_remove(nf))], although the 'nf' is not in the
> > > > > LRU, but
> > > > > it is linked in the 'dispose' list, nfsd_file_lru_remove()
> > > > > simply
> > > > > treats it as part of the LRU and removes it. This leads to
> > > > > its removal
> > > > > from the 'dispose' list!
> > > > > =C2=A0 * Now nf->ref is 0, unhashed. nfsd_file_put() continues it=
s
> > > > > execution and sets nf->nf_ref to REFCOUNT_SATURATED.
> > > > >=20
> > > > > The purpose of nf->nf_lru is problematic. As you can see, it
> > > > > is used
> > > > > for the LRU list, and also the 'dispose' list. Adding another
> > > > > 'struct
> > > > > list_head' specifically for the 'dispose' list seems to be a
> > > > > better
> > > > > way of fixing this race condition. Either way works for me.
> > > > >=20
> > > > > Would you agree my above analysis makes sense? Thanks.
> > > > >=20
> > > >=20
> > > > I think so. It's been a while since I've done much work in this
> > > > code,
> > > > but it does sound like there is a race in the LRU handling.
> > > >=20
> > > >=20
> > > > Like Chuck said, the nf->nf_lru list should be safe to use for
> > > > multiple
> > > > purposes, but that's only the case if we're not using that list
> > > > as an
> > > > indicator.
> > > >=20
> > > > The list_lru code does check this:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 if (!list_empty(item)) {
> > > >=20
> > > > ...so if we ever check this while it's sitting on the dispose
> > > > list, it
> > > > will handle it incorrectly. It sounds like that's the root
> > > > cause of the
> > > > problem you're seeing?
> > > >=20
> > > > If so, then maybe a separate list_head for disposal would be
> > > > better.
> > > >=20
> > > > > Here is my patch with signed-off-by:
> > > > >=20
> > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > Date: Mon, 1 Jul 2024 06:45:22 -0400
> > > > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to race
> > > > > condition and early
> > > > > =C2=A0unhash
> > > > >=20
> > > > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > > > ---
> > > > > =C2=A0fs/nfsd/filecache.c | 14 +++++++++++++-
> > > > > =C2=A01 file changed, 13 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (!nfsd_file_lru_remove(nf))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Racing with nfsd_file_cond_queue() or
> > > > > nfsd_file_lru_cb(),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it's unhashed but then removed from the
> > > > > dispose list,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so we need to free it.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > >=20
> > > > A refcount_read in this path is a red flag to me. Anytime
> > > > you're just
> > > > looking at the refcount without changing anything just screams
> > > > out
> > > > "race condition".
> > > >=20
> > > > In this case, what guarantee is there that this won't run afoul
> > > > of the
> > > > timing? We could check this and find out it's 1 just before it
> > > > goes to
> > > > 0 and you check the other conditions.
> > > >=20
> > > > Does anything prevent that?
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !test_bit(NFSD_FILE_HASHED, &=
nf-
> > > > > >nf_flags) &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_empty(&nf->nf_lru)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_=
file_free(nf);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_dec_and_t=
est(&nf->nf_ref))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > *nf, struct
> > > > > list_head *dispose)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int decrement =3D 1;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we raced with so=
meone else unhashing, ignore it
> > > > > */
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nfsd_file_unhash(nf))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(NFSD_FILE_HAS=
HED, &nf->nf_flags))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > >=20
> > > > Same here: you're just testing for the HASHED bit, but could
> > > > this also
> > > > race with someone who is setting it just after you get here.
> > > > Why is
> > > > that not a problem?
> > > >=20
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we can't get a r=
eference, ignore it */
> > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > *nf, struct
> > > > > list_head *dispose)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If refcount goes to=
 0, then put on the dispose
> > > > > list */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_sub_and_t=
est(decrement, &nf->nf_ref)) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru, dispose);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_closing(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > > --
> > > > > 2.43.0
> > > > >=20
> > > > > On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck Lever
> > > > > <chuck.lever@oracle.com> wrote:
> > > > > >=20
> > > > > > On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang
> > > > > > wrote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I'd like to report a nfsd_file leaking issue and propose
> > > > > > > a fix for it.
> > > > > > >=20
> > > > > > > When I tested Linux kernel 6.8 and 6.6, I noticed
> > > > > > > nfsd_file leaks
> > > > > > > which led to undestroyable file systems (zfs),
> > > > > >=20
> > > > > > Thanks for the report. Some initial comments:
> > > > > >=20
> > > > > > - Do you have a specific reproducer? In other words, what
> > > > > > is the
> > > > > > =C2=A0 simplest program that can run on an NFS client that will
> > > > > > trigger
> > > > > > =C2=A0 this leak, and can you post it?
> > > > > >=20
> > > > > > - "zfs" is an out-of-tree file system, so it's not directly
> > > > > > =C2=A0 supported for NFSD.
> > > > > >=20
> > > > > > - The guidelines for patch submission require us to fix
> > > > > > issues in
> > > > > > =C2=A0 upstream Linux first (currently that's v6.10-rc6). Then
> > > > > > that fix
> > > > > > =C2=A0 can be backported to older stable kernels like 6.6.
> > > > > >=20
> > > > > > Can you reproduce the leak with one of the in-kernel
> > > > > > filesystems
> > > > > > (either xfs or btrfs would be great) and with NFSD in 6.10-
> > > > > > rc6?
> > > > > >=20
> > > > > > One more comment below.
> > > > > >=20
> > > > > >=20
> > > > > > > here are some examples:
> > > > > > >=20
> > > > > > > crash> struct nfsd_file -x ffff88e160db0460
> > > > > > > struct nfsd_file {
> > > > > > > =C2=A0 nf_rlist =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 rhead =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0xffff8921fa2392f1
> > > > > > > =C2=A0=C2=A0=C2=A0 },
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0x0
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_inode =3D 0xffff8882bc312ef8,
> > > > > > > =C2=A0 nf_file =3D 0xffff88e2015b1500,
> > > > > > > =C2=A0 nf_cred =3D 0xffff88e3ab0e7800,
> > > > > > > =C2=A0 nf_net =3D 0xffffffff83d41600 <init_net>,
> > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > =C2=A0 nf_ref =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 refs =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter =3D 0xc0000000
> > > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_may =3D 0x4,
> > > > > > > =C2=A0 nf_mark =3D 0xffff88e1bddfb320,
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88e160db04a8,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88e160db04a8
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_rcu =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0x10000000000,
> > > > > > > =C2=A0=C2=A0=C2=A0 func =3D 0x0
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_birthtime =3D 0x73d22fc1728
> > > > > > > }
> > > > > > >=20
> > > > > > > crash> struct
> > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > ffff88839a53d850
> > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88839a53d898,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88839a53d898
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_file =3D 0xffff88810ede8700,
> > > > > > >=20
> > > > > > > crash> struct
> > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > ffff88c32b11e850
> > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88c32b11e898,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88c32b11e898
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_file =3D 0xffff88c20a701c00,
> > > > > > >=20
> > > > > > > crash> struct
> > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > ffff88e372709700
> > > > > > > =C2=A0 nf_flags =3D 0xc,
> > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88e372709748,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88e372709748
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_file =3D 0xffff88e0725e6400,
> > > > > > >=20
> > > > > > > crash> struct
> > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > ffff8982864944d0
> > > > > > > =C2=A0 nf_flags =3D 0xc,
> > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff898286494518,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff898286494518
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_file =3D 0xffff89803c0ff700,
> > > > > > >=20
> > > > > > > The leak occurs when nfsd_file_put() races with
> > > > > > > nfsd_file_cond_queue()
> > > > > > > or nfsd_file_lru_cb(). With the following patch, I
> > > > > > > haven't observed
> > > > > > > any leak after a few days heavy nfs load:
> > > > > >=20
> > > > > > Our patch submission guidelines require a Signed-off-by:
> > > > > > line at the end of the patch description. See the "Sign
> > > > > > your work -
> > > > > > the Developer's Certificate of Origin" section of
> > > > > >=20
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6
> > > > > >=20
> > > > > > (Needed here in case your fix is acceptable).
> > > > > >=20
> > > > > >=20
> > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > > > =C2=A0 if (!nfsd_file_lru_remove(nf))
> > > > > > > =C2=A0 return;
> > > > > > > =C2=A0 }
> > > > > > > + /*
> > > > > > > + * Racing with nfsd_file_cond_queue() or
> > > > > > > nfsd_file_lru_cb(),
> > > > > > > + * it's unhashed but then removed from the dispose list,
> > > > > > > + * so we need to free it.
> > > > > > > + */
> > > > > > > + if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 !test_bit(NFSD_FILE_HASHED, &nf->nf=
_flags) &&
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 list_empty(&nf->nf_lru)) {
> > > > > > > + nfsd_file_free(nf);
> > > > > > > + return;
> > > > > > > + }
> > > > > > > =C2=A0 }
> > > > > > > =C2=A0 if (refcount_dec_and_test(&nf->nf_ref))
> > > > > > > =C2=A0 nfsd_file_free(nf);
> > > > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > *nf, struct
> > > > > > > list_head *dispose)
> > > > > > > =C2=A0 int decrement =3D 1;
> > > > > > >=20
> > > > > > > =C2=A0 /* If we raced with someone else unhashing, ignore it
> > > > > > > */
> > > > > > > - if (!nfsd_file_unhash(nf))
> > > > > > > + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > > > =C2=A0 return;
> > > > > > >=20
> > > > > > > =C2=A0 /* If we can't get a reference, ignore it */
> > > > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > *nf, struct
> > > > > > > list_head *dispose)
> > > > > > > =C2=A0 /* If refcount goes to 0, then put on the dispose list
> > > > > > > */
> > > > > > > =C2=A0 if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > > > > > =C2=A0 list_add(&nf->nf_lru, dispose);
> > > > > > > + nfsd_file_unhash(nf);
> > > > > > > =C2=A0 trace_nfsd_file_closing(nf);
> > > > > > > =C2=A0 }
> > > > > > > =C2=A0}
> > > > > > >=20
> > > > > > > Please kindly review the patch and let me know if it
> > > > > > > makes sense.
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > >=20
> > > > > > > -Youzhong
> > > > > > >=20
> > > > > >=20
> > > > > > --
> > > > > > Chuck Lever
> > > > >=20
> > > >=20
> > > > --
> > > > Jeff Layton <jlayton@poochiereds.net>
> >=20
> > --
> > Jeff Layton <jlayton@poochiereds.net>
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

