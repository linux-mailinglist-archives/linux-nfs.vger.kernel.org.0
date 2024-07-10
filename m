Return-Path: <linux-nfs+bounces-4768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4F92D1EB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491B81F23976
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56681922CC;
	Wed, 10 Jul 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d92J7h+g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0511922C7
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615752; cv=none; b=H5aHqcuo1xTu5bHI1srlXBef7KPifN9Uza/cW/GQBa+vV0exHR48cyJmFG0ose+b1ZB1Y82bal9S6vLtnDPCbX+Awwb8R4bZPm1+jFa/ljldjj/xdVW7t9Gddb3N219ZxKNDk9IHQEEfpz/dpKf4080nyimADlrvOT247xmtDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615752; c=relaxed/simple;
	bh=8AgfJyTPX5JXvpUu37a9a+MYQWgrAS+NdUe0MP00+KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfTH8T8a8CaBUdPSe/9IrnFOQYYR8RtEIa4GaFMtNaWKLvRqr66JlLNb8kIdX3rC8Ta+xFVHULROQ3hP2kIxsYsBGFDbA1BO5HY0s0BTS7bW2PDvalOr2S5hqQDkKUcv8S+DqgEhktMbVkO7QQqNwZmIOlykkAbHLZn+zG/LZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d92J7h+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C061CC32781;
	Wed, 10 Jul 2024 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720615752;
	bh=8AgfJyTPX5JXvpUu37a9a+MYQWgrAS+NdUe0MP00+KU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d92J7h+glMnqUhlFLbIuygrTUNapZGoZcSByluAoSsxOkxaQP1BaiHVr4ZMC2faBX
	 vb9vCcUuk9QacjhanVpXZvTgl7BODFPRtsrp/jR0TNuYgeyKX+v6L3/FkX/cgdHgEy
	 S0urayG/JUmujr1nZWvCLUUFYuLH6wxexQEOIXg+ws20NS8/oV03l+abMgxVfUy/wa
	 eiyss4kFbCJOmj3xKZ1gO7dBgW03fN2hDD6rq1DuOzsmbsxtJt28KpuhwuzsbgNoeO
	 fLc4Ov1DsYzWERM9Bk7LKqcT0rOZWzA+h6qSnc5RhERZU2D9JvAWdXtEyx0JrsuMPb
	 AeJ/ubBMosSJg==
Message-ID: <3bb40da41e450141a0c91f32f184f465d3c5f203.camel@kernel.org>
Subject: Re: Leaked nfsd_file due to race condition and early unhash
 (fs/nfsd/filecache.c)
From: Jeff Layton <jlayton@kernel.org>
To: Youzhong Yang <youzhong@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Wed, 10 Jul 2024 08:49:10 -0400
In-Reply-To: <CADpNCvbfrDr7WbgKc+-TMHV-C+p9Fzp7vLNz6VB==29EcjqVYg@mail.gmail.com>
References: 
	<CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
	 <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
	 <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
	 <0445d64ebcc7185bf48cc05f72ca29b859f45c26.camel@poochiereds.net>
	 <CADpNCvZ-kEc6hOQHsbn7yHtvB-acg_gQwzEjN9zcjw0oM2RgGw@mail.gmail.com>
	 <321ddc16356d75f9eb6e5ab15c4e28fae1466267.camel@kernel.org>
	 <CADpNCvb5kpghbEj+yU1OgKF0BJS9dYDtFgRz3ArfCamCnyn_Ww@mail.gmail.com>
	 <c138dd82bb493abe7b0c34b1e2803437bd163c54.camel@kernel.org>
	 <CADpNCvY-hTbO6OGAHO4N43UZjEtv5eyDmNU-S19ULn1iUOES3A@mail.gmail.com>
	 <e1480c3a6ec15d6df9edd26bdb9e39a2edb51c6a.camel@kernel.org>
	 <CADpNCvbfrDr7WbgKc+-TMHV-C+p9Fzp7vLNz6VB==29EcjqVYg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ok, thanks. I went crawling over the filecache code, and found a couple
of potential nfsd_file leaks. I'm testing patches now and will likely
send them along later today.

I think we do still want the patch to add nf_gc list_head. I'm not
certain there is a race there, but it's safer to just use a separate
list_head and it doesn't represent a lot of memory.

Could you post that one individually so that Chuck can pick it up?

Thanks,
Jeff

On Tue, 2024-07-09 at 15:13 -0400, Youzhong Yang wrote:
> It's not on the LRU:
>=20
> crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_gc
> ffff898107b95980
>   nf_flags =3D 12,
>   nf_ref.refs.counter =3D 1
>   nf_lru =3D {
>     next =3D 0xffff898107b959c8,
>     prev =3D 0xffff898107b959c8
>   },
>   nf_gc =3D {
>     next =3D 0xffff898107b959d8,
>     prev =3D 0xffff898107b959d8
>   },
>=20
> I don't have an easy reproducer now as I am having difficulty
> generating tons of NFS read/write ops using a limited number of nfs
> clients. I use our in-house testing farm to test the patch.
>=20
> Thanks.
>=20
> On Tue, Jul 9, 2024 at 3:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Tue, 2024-07-09 at 14:37 -0400, Youzhong Yang wrote:
> > > Thanks Jeff.
> > >=20
> > > Unfortunately the early unhash easily leads to leaks:
> > >=20
> > > crash> kmem -S nfsd_file | grep '\[ffff' | sed -e 's|\[||' -e
> > > 's|\]||'
> > > > xargs -i echo struct nfsd_file.nf_flags,nf_ref.refs.counter '{}' >
> > > /var/tmp/nfsd_files
> > > crash> !wc -l /var/tmp/nfsd_files
> > > 19 /var/tmp/nfsd_files
> > > crash> < /var/tmp/nfsd_files
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88865c778900
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 2
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88865c778cc0
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 3
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff8885d5f35e00
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 1
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88817443e780
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 3
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88818b3f0600
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 2
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88a4490f8300
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 1
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88a0dab183c0
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 40
> >=20
> > That's a lot of references! Might be interesting to look more closely
> > at that one, but the refcounts are all over the place, so it really
> > does look like we just have a refcount leak somewhere.
> >=20
> > > ...
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff89209535f200
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 2
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff8980e15138c0
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 7
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff898107b95800
> > >   nf_flags =3D 8,
> > >   nf_ref.refs.counter =3D 3
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff898107b95980
> > >   nf_flags =3D 12,
> >=20
> > The others are NFSD_FILE_GC. This one is also NFSD_FILE_REFERENCED. Are
> > these objects on the LRU?
> >=20
> > >   nf_ref.refs.counter =3D 1
> > >=20
> > > nfsd_file_do_acquire() -> nfsd_file_lookup_locked() relies on the
> > > hash
> > > table to find the nfsd_file,
> > > but I am still scratching my head why and how this happens.
> > >=20
> > > FYI, here is the patch I applied for testing:
> > >=20
> >=20
> > The above suggests to me that there is a garden-variety refcount leak
> > somewhere. Whenever some bit of the code takes a reference to an object
> > (like a nfsd_file), it's implicitly required to eventually put that
> > reference. Typically that means that the code needs to maintain a
> > pointer to that object, as it can be unhashed at any time and it can't
> > rely on finding the same object later.
> >=20
> > Do you have a reproducer for this?
> >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index ad9083ca144b..22ebd7fb8639 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode
> > > *inode, unsigned char need,
> > >                 return NULL;
> > >=20
> > >         INIT_LIST_HEAD(&nf->nf_lru);
> > > +       INIT_LIST_HEAD(&nf->nf_gc);
> > >         nf->nf_birthtime =3D ktime_get();
> > >         nf->nf_file =3D NULL;
> > >         nf->nf_cred =3D get_current_cred();
> > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
> > >         struct nfsd_file *nf;
> > >=20
> > >         while (!list_empty(dispose)) {
> > > -               nf =3D list_first_entry(dispose, struct nfsd_file,
> > > nf_lru);
> > > -               list_del_init(&nf->nf_lru);
> > > +               nf =3D list_first_entry(dispose, struct nfsd_file,
> > > nf_gc);
> > > +               list_del_init(&nf->nf_gc);
> > >                 nfsd_file_free(nf);
> > >         }
> > >  }
> > > @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct list_head
> > > *dispose)
> > >  {
> > >         while(!list_empty(dispose)) {
> > >                 struct nfsd_file *nf =3D list_first_entry(dispose,
> > > -                                               struct nfsd_file,
> > > nf_lru);
> > > +                                               struct nfsd_file,
> > > nf_gc);
> > >                 struct nfsd_net *nn =3D net_generic(nf->nf_net,
> > > nfsd_net_id);
> > >                 struct nfsd_fcache_disposal *l =3D nn->fcache_disposa=
l;
> > >=20
> > >                 spin_lock(&l->lock);
> > > -               list_move_tail(&nf->nf_lru, &l->freeme);
> > > +               list_move_tail(&nf->nf_gc, &l->freeme);
> > >                 spin_unlock(&l->lock);
> > >                 svc_wake_up(nn->nfsd_serv);
> > >         }
> > > @@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item, struct
> > > list_lru_one *lru,
> > >=20
> > >         /* Refcount went to zero. Unhash it and queue it to the
> > > dispose list */
> > >         nfsd_file_unhash(nf);
> > > -       list_lru_isolate_move(lru, &nf->nf_lru, head);
> > > +       list_lru_isolate(lru, &nf->nf_lru);
> > > +       list_add(&nf->nf_gc, head);
> > >         this_cpu_inc(nfsd_file_evictions);
> > >         trace_nfsd_file_gc_disposed(nf);
> > >         return LRU_REMOVED;
> > > @@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> > > list_head *dispose)
> > >=20
> > >         /* If refcount goes to 0, then put on the dispose list */
> > >         if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > -               list_add(&nf->nf_lru, dispose);
> > > +               list_add(&nf->nf_gc, dispose);
> > >                 trace_nfsd_file_closing(nf);
> > >         }
> > >  }
> > > @@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
> > >=20
> > >         nfsd_file_queue_for_close(inode, &dispose);
> > >         while (!list_empty(&dispose)) {
> > > -               nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > nf_lru);
> > > -               list_del_init(&nf->nf_lru);
> > > +               nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > nf_gc);
> > > +               list_del_init(&nf->nf_gc);
> > >                 nfsd_file_free(nf);
> > >         }
> > >  }
> > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > index c61884def906..3fbec24eea6c 100644
> > > --- a/fs/nfsd/filecache.h
> > > +++ b/fs/nfsd/filecache.h
> > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > >=20
> > >         struct nfsd_file_mark   *nf_mark;
> > >         struct list_head        nf_lru;
> > > +       struct list_head        nf_gc;
> > >         struct rcu_head         nf_rcu;
> > >         ktime_t                 nf_birthtime;
> > >  };
> > >=20
> > > On Mon, Jul 8, 2024 at 10:55=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg>
> > > wrote:
> > > >=20
> > > > On Mon, 2024-07-08 at 10:23 -0400, Youzhong Yang wrote:
> > > > > Thanks Jeff.
> > > > >=20
> > > > > I am ok with reverting the unhash/dispose list reordering in
> > > > > nfsd_file_lru_cb(), as it doesn't make much of a difference,
> > > > > but for nfsd_file_cond_queue(), imagining this:
> > > > >=20
> > > > > - A nfsd_file is hashed
> > > > > - In nfsd_file_cond_queue(), [if (!nfsd_file_unhash(nf))] will
> > > > > get it
> > > > > unhashed, doesn't it?
> > > > > - It continues to get a reference by nfsd_file_get()
> > > > > - It continues to remove itself from LRU by
> > > > > nfsd_file_lru_remove() if
> > > > > it is on the LRU.
> > > > > - Now it runs refcount_sub_and_test(), what happens if the refcnt
> > > > > does
> > > > > not go to 0? How can this nfsd_file be found again? Through the
> > > > > hash
> > > > > table? Through the LRU walk? how?
> > > > >=20
> > > > > Thanks again.
> > > > >=20
> > > > > -Youzhong
> > > > >=20
> > > >=20
> > > > It won't need to be found again. The holders of the extra
> > > > references
> > > > will put those references when they are finished. Since the object
> > > > is
> > > > no longer HASHED, nfsd_file_put just does this:
> > > >=20
> > > >         if (refcount_dec_and_test(&nf->nf_ref))
> > > >                 nfsd_file_free(nf);
> > > >=20
> > > > So that should be fine.
> > > >=20
> > > > > On Mon, Jul 8, 2024 at 9:35=E2=80=AFAM Jeff Layton <jlayton@kerne=
l.org>
> > > > > wrote:
> > > > > >=20
> > > > > > On Mon, 2024-07-08 at 08:58 -0400, Youzhong Yang wrote:
> > > > > > > Thank you Jeff for your invaluable insights. I was leaning
> > > > > > > towards
> > > > > > > adding a new list_head too, and tested this approach on
> > > > > > > kernel
> > > > > > > 6.6 by
> > > > > > > continuously hammering the server with heavy nfs load for the
> > > > > > > last few
> > > > > > > days, not a single leak.
> > > > > > >=20
> > > > > > > Here goes the patch (based on Linux kernel master branch),
> > > > > > > please
> > > > > > > review:
> > > > > > >=20
> > > > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > > > Date: Thu, 4 Jul 2024 11:25:40 -0400
> > > > > > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to mixed use
> > > > > > > of
> > > > > > > nf->nf_lru
> > > > > > >=20
> > > > > > > nfsd_file_put() in one thread can race with another thread
> > > > > > > doing
> > > > > > > garbage collection (running nfsd_file_gc() -> list_lru_walk()
> > > > > > > ->
> > > > > > > nfsd_file_lru_cb()):
> > > > > > >=20
> > > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > > > nfsd_file_lru_add().
> > > > > > >   * nfsd_file_lru_add() returns true (with
> > > > > > > NFSD_FILE_REFERENCED
> > > > > > > bit set)
> > > > > > >   * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > > > > > REFERENCED bit and
> > > > > > >     returns LRU_ROTATE.
> > > > > > >   * garbage collector kicks in again, nfsd_file_lru_cb() now
> > > > > > > decrements nf->nf_ref
> > > > > > >     to 0, runs nfsd_file_unhash(), removes it from the LRU
> > > > > > > and
> > > > > > > adds to
> > > > > > > the dispose
> > > > > > >     list [list_lru_isolate_move(lru, &nf->nf_lru, head)]
> > > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > > > so
> > > > > > > it
> > > > > > > tries to remove
> > > > > > >     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))].
> > > > > > > The
> > > > > > > 'nf'
> > > > > > > has been added
> > > > > > >     to the 'dispose' list by nfsd_file_lru_cb(), so
> > > > > > > nfsd_file_lru_remove(nf) simply
> > > > > > >     treats it as part of the LRU and removes it, which leads
> > > > > > > to
> > > > > > > its removal from
> > > > > > >     the 'dispose' list.
> > > > > > >   * At this moment, 'nf' is unhashed with its nf_ref being 0,
> > > > > > > and
> > > > > > > not
> > > > > > > on the LRU.
> > > > > > >     nfsd_file_put() continues its execution [if
> > > > > > > (refcount_dec_and_test(&nf->nf_ref))],
> > > > > > >     as nf->nf_ref is already 0, nf->nf_ref is set to
> > > > > > > REFCOUNT_SATURATED, and the 'nf'
> > > > > > >     gets no chance of being freed.
> > > > > > >=20
> > > > > > > nfsd_file_put() can also race with nfsd_file_cond_queue():
> > > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > > > nfsd_file_lru_add().
> > > > > > >   * nfsd_file_lru_add() sets REFERENCED bit and returns true.
> > > > > > >   * Some userland application runs 'exportfs -f' or something
> > > > > > > like
> > > > > > > that, which triggers
> > > > > > >     __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> > > > > > >   * In nfsd_file_cond_queue(), it runs [if
> > > > > > > (!nfsd_file_unhash(nf))],
> > > > > > > unhash is done
> > > > > > >     successfully.
> > > > > > >   * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))],
> > > > > > > now
> > > > > > > nf->nf_ref goes to 2.
> > > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > > (nfsd_file_lru_remove(nf))],
> > > > > > > it succeeds.
> > > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > > (refcount_sub_and_test(decrement,
> > > > > > > &nf->nf_ref))]
> > > > > > >     (with "decrement" being 2), so the nf->nf_ref goes to 0,
> > > > > > > the
> > > > > > > 'nf'
> > > > > > > is added to the
> > > > > > >     dispose list [list_add(&nf->nf_lru, dispose)]
> > > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > > > so
> > > > > > > it
> > > > > > > tries to remove
> > > > > > >     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))],
> > > > > > > although
> > > > > > > the 'nf' is not
> > > > > > >     in the LRU, but it is linked in the 'dispose' list,
> > > > > > > nfsd_file_lru_remove() simply
> > > > > > >     treats it as part of the LRU and removes it. This leads
> > > > > > > to
> > > > > > > its removal from
> > > > > > >     the 'dispose' list!
> > > > > > >   * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
> > > > > > > execution and set
> > > > > > >     nf->nf_ref to REFCOUNT_SATURATED.
> > > > > > >=20
> > > > > > > As shown in the above analysis, using nf_lru for both the LRU
> > > > > > > list and
> > > > > > > dispose list
> > > > > > > can cause the leaks. This patch adds a new list_head nf_gc in
> > > > > > > struct
> > > > > > > nfsd_file, and uses
> > > > > > > it for the dispose list. It's not expected to have a
> > > > > > > nfsd_file
> > > > > > > unhashed but it's not
> > > > > > > added to the dispose list, so in nfsd_file_cond_queue() and
> > > > > > > nfsd_file_lru_cb() nfsd_file
> > > > > > > is unhashed after being added to the dispose list.
> > > > > > >=20
> > > > > >=20
> > > > > > I don't see where we require the object to be either hashed or
> > > > > > on
> > > > > > the
> > > > > > dispose list.  I think you probably just want to do a patch
> > > > > > that
> > > > > > changes the dispose list to use a dedicated list_head without
> > > > > > reordering when the these things are unhashed.
> > > > > >=20
> > > > > > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > > > > > ---
> > > > > > >  fs/nfsd/filecache.c | 23 ++++++++++++++---------
> > > > > > >  fs/nfsd/filecache.h |  1 +
> > > > > > >  2 files changed, 15 insertions(+), 9 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > index ad9083ca144b..3aef2ddfce94 100644
> > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct
> > > > > > > inode
> > > > > > > *inode, unsigned char need,
> > > > > > >                 return NULL;
> > > > > > >=20
> > > > > > >         INIT_LIST_HEAD(&nf->nf_lru);
> > > > > > > +       INIT_LIST_HEAD(&nf->nf_gc);
> > > > > > >         nf->nf_birthtime =3D ktime_get();
> > > > > > >         nf->nf_file =3D NULL;
> > > > > > >         nf->nf_cred =3D get_current_cred();
> > > > > > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head
> > > > > > > *dispose)
> > > > > > >         struct nfsd_file *nf;
> > > > > > >=20
> > > > > > >         while (!list_empty(dispose)) {
> > > > > > > -               nf =3D list_first_entry(dispose, struct
> > > > > > > nfsd_file,
> > > > > > > nf_lru);
> > > > > > > -               list_del_init(&nf->nf_lru);
> > > > > > > +               nf =3D list_first_entry(dispose, struct
> > > > > > > nfsd_file,
> > > > > > > nf_gc);
> > > > > > > +               list_del_init(&nf->nf_gc);
> > > > > > >                 nfsd_file_free(nf);
> > > > > > >         }
> > > > > > >  }
> > > > > > > @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct
> > > > > > > list_head *dispose)
> > > > > > >  {
> > > > > > >         while(!list_empty(dispose)) {
> > > > > > >                 struct nfsd_file *nf =3D
> > > > > > > list_first_entry(dispose,
> > > > > > > -                                               struct
> > > > > > > nfsd_file,
> > > > > > > nf_lru);
> > > > > > > +                                               struct
> > > > > > > nfsd_file,
> > > > > > > nf_gc);
> > > > > > >                 struct nfsd_net *nn =3D net_generic(nf->nf_ne=
t,
> > > > > > > nfsd_net_id);
> > > > > > >                 struct nfsd_fcache_disposal *l =3D nn-
> > > > > > > > fcache_disposal;
> > > > > > >=20
> > > > > > >                 spin_lock(&l->lock);
> > > > > > > -               list_move_tail(&nf->nf_lru, &l->freeme);
> > > > > > > +               list_move_tail(&nf->nf_gc, &l->freeme);
> > > > > > >                 spin_unlock(&l->lock);
> > > > > > >                 svc_wake_up(nn->nfsd_serv);
> > > > > > >         }
> > > > > > > @@ -502,8 +503,10 @@ nfsd_file_lru_cb(struct list_head *item,
> > > > > > > struct
> > > > > > > list_lru_one *lru,
> > > > > > >         }
> > > > > > >=20
> > > > > > >         /* Refcount went to zero. Unhash it and queue it to
> > > > > > > the
> > > > > > > dispose list */
> > > > > > > +       list_lru_isolate(lru, &nf->nf_lru);
> > > > > > > +       list_add(&nf->nf_gc, head);
> > > > > > > +       /* Unhash after removing from LRU and adding to
> > > > > > > dispose
> > > > > > > list */
> > > > > > >         nfsd_file_unhash(nf);
> > > > > > > -       list_lru_isolate_move(lru, &nf->nf_lru, head);
> > > > > >=20
> > > > > > I don't see the point in reordering these operations. Hashing
> > > > > > is
> > > > > > all
> > > > > > about making the thing findable by nfsd operations. The _last_
> > > > > > thing we
> > > > > > want to do is put it on the dispose list while the thing can
> > > > > > still
> > > > > > be
> > > > > > found by nfsd threads doing operations.
> > > > > >=20
> > > > > > >         this_cpu_inc(nfsd_file_evictions);
> > > > > > >         trace_nfsd_file_gc_disposed(nf);
> > > > > > >         return LRU_REMOVED;
> > > > > > > @@ -565,7 +568,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > *nf,
> > > > > > > struct
> > > > > > > list_head *dispose)
> > > > > > >         int decrement =3D 1;
> > > > > > >=20
> > > > > > >         /* If we raced with someone else unhashing, ignore it
> > > > > > > */
> > > > > > > -       if (!nfsd_file_unhash(nf))
> > > > > > > +       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > >=20
> > > > > > The above change looks wrong. I don't think we need to change
> > > > > > this.
> > > > > >=20
> > > > > > >                 return;
> > > > > > >=20
> > > > > > >         /* If we can't get a reference, ignore it */
> > > > > > > @@ -578,7 +581,9 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > *nf,
> > > > > > > struct
> > > > > > > list_head *dispose)
> > > > > > >=20
> > > > > > >         /* If refcount goes to 0, then put on the dispose
> > > > > > > list */
> > > > > > >         if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > > > > > -               list_add(&nf->nf_lru, dispose);
> > > > > > > +               list_add(&nf->nf_gc, dispose);
> > > > > > > +               /* Unhash after adding to dispose list */
> > > > > > > +               nfsd_file_unhash(nf);
> > > > > >=20
> > > > > > This too looks wrong? Maybe I'm unclear on the race you're
> > > > > > trying
> > > > > > to
> > > > > > fix with this? What's the harm in unhashing it early?
> > > > > >=20
> > > > > > >                 trace_nfsd_file_closing(nf);
> > > > > > >         }
> > > > > > >  }
> > > > > > > @@ -654,8 +659,8 @@ nfsd_file_close_inode_sync(struct inode
> > > > > > > *inode)
> > > > > > >=20
> > > > > > >         nfsd_file_queue_for_close(inode, &dispose);
> > > > > > >         while (!list_empty(&dispose)) {
> > > > > > > -               nf =3D list_first_entry(&dispose, struct
> > > > > > > nfsd_file,
> > > > > > > nf_lru);
> > > > > > > -               list_del_init(&nf->nf_lru);
> > > > > > > +               nf =3D list_first_entry(&dispose, struct
> > > > > > > nfsd_file,
> > > > > > > nf_gc);
> > > > > > > +               list_del_init(&nf->nf_gc);
> > > > > > >                 nfsd_file_free(nf);
> > > > > > >         }
> > > > > > >  }
> > > > > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > > > > index c61884def906..3fbec24eea6c 100644
> > > > > > > --- a/fs/nfsd/filecache.h
> > > > > > > +++ b/fs/nfsd/filecache.h
> > > > > > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > > > > > >=20
> > > > > > >         struct nfsd_file_mark   *nf_mark;
> > > > > > >         struct list_head        nf_lru;
> > > > > > > +       struct list_head        nf_gc;
> > > > > > >         struct rcu_head         nf_rcu;
> > > > > > >         ktime_t                 nf_birthtime;
> > > > > > >  };
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >=20
> > > > > > > On Thu, Jul 4, 2024 at 7:14=E2=80=AFAM Jeff Layton
> > > > > > > <jlayton@poochiereds.net> wrote:
> > > > > > > >=20
> > > > > > > > On Wed, 2024-07-03 at 16:46 -0400, Youzhong Yang wrote:
> > > > > > > > > Thank you Chuck. Here are my quick answers to your
> > > > > > > > > comments:
> > > > > > > > >=20
> > > > > > > > > - I don't have a quick reproducer. I reproduced it by
> > > > > > > > > using
> > > > > > > > > hundreds
> > > > > > > > > of nfs clients generating +600K ops under our workload in
> > > > > > > > > the
> > > > > > > > > testing
> > > > > > > > > environment. Theoretically it should be possible to
> > > > > > > > > simplify
> > > > > > > > > the
> > > > > > > > > reproduction but I am still working on it.
> > > > > > > > >=20
> > > > > > > > > -  I understand zfs is an out-of-tree file system. That's
> > > > > > > > > fine. But
> > > > > > > > > this leaking can happen to any file system, and leaking
> > > > > > > > > is
> > > > > > > > > not a good
> > > > > > > > > thing no matter what file system it is.
> > > > > > > > >=20
> > > > > > > > > -  I will try to come up with a reproducer using xfs or
> > > > > > > > > btrfs
> > > > > > > > > if possible.
> > > > > > > > >=20
> > > > > > > > > Now back to the problem itself, here are my findings:
> > > > > > > > >=20
> > > > > > > > > - nfsd_file_put() in one thread can race with another
> > > > > > > > > thread
> > > > > > > > > doing
> > > > > > > > > garbage collection (running nfsd_file_gc() ->
> > > > > > > > > list_lru_walk()
> > > > > > > > > ->
> > > > > > > > > nfsd_file_lru_cb()):
> > > > > > > > >=20
> > > > > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to
> > > > > > > > > do
> > > > > > > > > nfsd_file_lru_add().
> > > > > > > > >   * nfsd_file_lru_add() returns true (thus
> > > > > > > > > NFSD_FILE_REFERENCED bit
> > > > > > > > > set for nf->nf_flags)
> > > > > > > > >   * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > > > > > > > REFERENCED
> > > > > > > > > bit and returns LRU_ROTATE.
> > > > > > > > >   * garbage collector kicks in again, nfsd_file_lru_cb()
> > > > > > > > > now
> > > > > > > > > decrements nf->nf_ref to 0, runs nfsd_file_unhash(),
> > > > > > > > > removes
> > > > > > > > > it from
> > > > > > > > > the LRU and adds to the dispose list
> > > > > > > > > [list_lru_isolate_move(lru,
> > > > > > > > > &nf->nf_lru, head);]
> > > > > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is
> > > > > > > > > cleared,
> > > > > > > > > so it
> > > > > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > > > > (!nfsd_file_lru_remove(nf))]
> > > > > > > > >   * The 'nf' has been added to the 'dispose' list by
> > > > > > > > > nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply
> > > > > > > > > treats
> > > > > > > > > it as
> > > > > > > > > part of the LRU and removes it, which leads it to be
> > > > > > > > > removed
> > > > > > > > > from the
> > > > > > > > > 'dispose' list.
> > > > > > > > >   * At this moment, nf->nf_ref is 0, it's unhashed, and
> > > > > > > > > not
> > > > > > > > > on the
> > > > > > > > > LRU. nfsd_file_put() continues its execution [if
> > > > > > > > > (refcount_dec_and_test(&nf->nf_ref))], as nf->nf_ref is
> > > > > > > > > already 0, now
> > > > > > > > > bad thing happens: nf->nf_ref is set to
> > > > > > > > > REFCOUNT_SATURATED,
> > > > > > > > > and the
> > > > > > > > > 'nf' is leaked.
> > > > > > > > >=20
> > > > > > > > > To make this happen, the right timing is crucial. It can
> > > > > > > > > be
> > > > > > > > > reproduced
> > > > > > > > > by adding artifical delays in filecache.c, or hammering
> > > > > > > > > the
> > > > > > > > > nfsd with
> > > > > > > > > tons of ops.
> > > > > > > > >=20
> > > > > > > > > - Let's see how nfsd_file_put() can race with
> > > > > > > > > nfsd_file_cond_queue():
> > > > > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to
> > > > > > > > > do
> > > > > > > > > nfsd_file_lru_add().
> > > > > > > > >   * nfsd_file_lru_add() sets REFERENCED bit and returns
> > > > > > > > > true.
> > > > > > > > >   * 'exportfs -f' or something like that triggers
> > > > > > > > > __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> > > > > > > > >   * In nfsd_file_cond_queue(), it runs [if
> > > > > > > > > (!nfsd_file_unhash(nf))],
> > > > > > > > > unhash is done successfully.
> > > > > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > > > > (!nfsd_file_get(nf))],
> > > > > > > > > now
> > > > > > > > > nf->nf_ref goes to 2.
> > > > > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > > > > (nfsd_file_lru_remove(nf))], it succeeds.
> > > > > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > > > > (refcount_sub_and_test(decrement,
> > > > > > > > > &nf->nf_ref))] (with "decrement" being 2), so the nf-
> > > > > > > > > > nf_ref
> > > > > > > > > goes to
> > > > > > > > > 0, the 'nf' is added to the dispost list [list_add(&nf-
> > > > > > > > > > nf_lru,
> > > > > > > > > dispose)]
> > > > > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is
> > > > > > > > > cleared,
> > > > > > > > > so it
> > > > > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > > > > (!nfsd_file_lru_remove(nf))], although the 'nf' is not in
> > > > > > > > > the
> > > > > > > > > LRU, but
> > > > > > > > > it is linked in the 'dispose' list,
> > > > > > > > > nfsd_file_lru_remove()
> > > > > > > > > simply
> > > > > > > > > treats it as part of the LRU and removes it. This leads
> > > > > > > > > to
> > > > > > > > > its removal
> > > > > > > > > from the 'dispose' list!
> > > > > > > > >   * Now nf->ref is 0, unhashed. nfsd_file_put() continues
> > > > > > > > > its
> > > > > > > > > execution and sets nf->nf_ref to REFCOUNT_SATURATED.
> > > > > > > > >=20
> > > > > > > > > The purpose of nf->nf_lru is problematic. As you can see,
> > > > > > > > > it
> > > > > > > > > is used
> > > > > > > > > for the LRU list, and also the 'dispose' list. Adding
> > > > > > > > > another
> > > > > > > > > 'struct
> > > > > > > > > list_head' specifically for the 'dispose' list seems to
> > > > > > > > > be a
> > > > > > > > > better
> > > > > > > > > way of fixing this race condition. Either way works for
> > > > > > > > > me.
> > > > > > > > >=20
> > > > > > > > > Would you agree my above analysis makes sense? Thanks.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I think so. It's been a while since I've done much work in
> > > > > > > > this
> > > > > > > > code,
> > > > > > > > but it does sound like there is a race in the LRU handling.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Like Chuck said, the nf->nf_lru list should be safe to use
> > > > > > > > for
> > > > > > > > multiple
> > > > > > > > purposes, but that's only the case if we're not using that
> > > > > > > > list
> > > > > > > > as an
> > > > > > > > indicator.
> > > > > > > >=20
> > > > > > > > The list_lru code does check this:
> > > > > > > >=20
> > > > > > > >     if (!list_empty(item)) {
> > > > > > > >=20
> > > > > > > > ...so if we ever check this while it's sitting on the
> > > > > > > > dispose
> > > > > > > > list, it
> > > > > > > > will handle it incorrectly. It sounds like that's the root
> > > > > > > > cause of the
> > > > > > > > problem you're seeing?
> > > > > > > >=20
> > > > > > > > If so, then maybe a separate list_head for disposal would
> > > > > > > > be
> > > > > > > > better.
> > > > > > > >=20
> > > > > > > > > Here is my patch with signed-off-by:
> > > > > > > > >=20
> > > > > > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > > > > > Date: Mon, 1 Jul 2024 06:45:22 -0400
> > > > > > > > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to race
> > > > > > > > > condition and early
> > > > > > > > >  unhash
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  fs/nfsd/filecache.c | 14 +++++++++++++-
> > > > > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > > > > >                         if (!nfsd_file_lru_remove(nf))
> > > > > > > > >                                 return;
> > > > > > > > >                 }
> > > > > > > > > +               /*
> > > > > > > > > +                * Racing with nfsd_file_cond_queue() or
> > > > > > > > > nfsd_file_lru_cb(),
> > > > > > > > > +                * it's unhashed but then removed from
> > > > > > > > > the
> > > > > > > > > dispose list,
> > > > > > > > > +                * so we need to free it.
> > > > > > > > > +                */
> > > > > > > > > +               if (refcount_read(&nf->nf_ref) =3D=3D 0 &=
&
> > > > > > > >=20
> > > > > > > > A refcount_read in this path is a red flag to me. Anytime
> > > > > > > > you're just
> > > > > > > > looking at the refcount without changing anything just
> > > > > > > > screams
> > > > > > > > out
> > > > > > > > "race condition".
> > > > > > > >=20
> > > > > > > > In this case, what guarantee is there that this won't run
> > > > > > > > afoul
> > > > > > > > of the
> > > > > > > > timing? We could check this and find out it's 1 just before
> > > > > > > > it
> > > > > > > > goes to
> > > > > > > > 0 and you check the other conditions.
> > > > > > > >=20
> > > > > > > > Does anything prevent that?
> > > > > > > >=20
> > > > > > > > > +                   !test_bit(NFSD_FILE_HASHED, &nf-
> > > > > > > > > > nf_flags) &&
> > > > > > > > > +                   list_empty(&nf->nf_lru)) {
> > > > > > > > > +                       nfsd_file_free(nf);
> > > > > > > > > +                       return;
> > > > > > > > > +               }
> > > > > > > > >         }
> > > > > > > > >         if (refcount_dec_and_test(&nf->nf_ref))
> > > > > > > > >                 nfsd_file_free(nf);
> > > > > > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > > > *nf, struct
> > > > > > > > > list_head *dispose)
> > > > > > > > >         int decrement =3D 1;
> > > > > > > > >=20
> > > > > > > > >         /* If we raced with someone else unhashing,
> > > > > > > > > ignore it
> > > > > > > > > */
> > > > > > > > > -       if (!nfsd_file_unhash(nf))
> > > > > > > > > +       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > > > > >                 return;
> > > > > > > >=20
> > > > > > > > Same here: you're just testing for the HASHED bit, but
> > > > > > > > could
> > > > > > > > this also
> > > > > > > > race with someone who is setting it just after you get
> > > > > > > > here.
> > > > > > > > Why is
> > > > > > > > that not a problem?
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >         /* If we can't get a reference, ignore it */
> > > > > > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > > > *nf, struct
> > > > > > > > > list_head *dispose)
> > > > > > > > >         /* If refcount goes to 0, then put on the dispose
> > > > > > > > > list */
> > > > > > > > >         if (refcount_sub_and_test(decrement, &nf-
> > > > > > > > > > nf_ref)) {
> > > > > > > > >                 list_add(&nf->nf_lru, dispose);
> > > > > > > > > +               nfsd_file_unhash(nf);
> > > > > > > > >                 trace_nfsd_file_closing(nf);
> > > > > > > > >         }
> > > > > > > > >  }
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >=20
> > > > > > > > > On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck Lever
> > > > > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang
> > > > > > > > > > wrote:
> > > > > > > > > > > Hello,
> > > > > > > > > > >=20
> > > > > > > > > > > I'd like to report a nfsd_file leaking issue and
> > > > > > > > > > > propose
> > > > > > > > > > > a fix for it.
> > > > > > > > > > >=20
> > > > > > > > > > > When I tested Linux kernel 6.8 and 6.6, I noticed
> > > > > > > > > > > nfsd_file leaks
> > > > > > > > > > > which led to undestroyable file systems (zfs),
> > > > > > > > > >=20
> > > > > > > > > > Thanks for the report. Some initial comments:
> > > > > > > > > >=20
> > > > > > > > > > - Do you have a specific reproducer? In other words,
> > > > > > > > > > what
> > > > > > > > > > is the
> > > > > > > > > >   simplest program that can run on an NFS client that
> > > > > > > > > > will
> > > > > > > > > > trigger
> > > > > > > > > >   this leak, and can you post it?
> > > > > > > > > >=20
> > > > > > > > > > - "zfs" is an out-of-tree file system, so it's not
> > > > > > > > > > directly
> > > > > > > > > >   supported for NFSD.
> > > > > > > > > >=20
> > > > > > > > > > - The guidelines for patch submission require us to fix
> > > > > > > > > > issues in
> > > > > > > > > >   upstream Linux first (currently that's v6.10-rc6).
> > > > > > > > > > Then
> > > > > > > > > > that fix
> > > > > > > > > >   can be backported to older stable kernels like 6.6.
> > > > > > > > > >=20
> > > > > > > > > > Can you reproduce the leak with one of the in-kernel
> > > > > > > > > > filesystems
> > > > > > > > > > (either xfs or btrfs would be great) and with NFSD in
> > > > > > > > > > 6.10-
> > > > > > > > > > rc6?
> > > > > > > > > >=20
> > > > > > > > > > One more comment below.
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > here are some examples:
> > > > > > > > > > >=20
> > > > > > > > > > > crash> struct nfsd_file -x ffff88e160db0460
> > > > > > > > > > > struct nfsd_file {
> > > > > > > > > > >   nf_rlist =3D {
> > > > > > > > > > >     rhead =3D {
> > > > > > > > > > >       next =3D 0xffff8921fa2392f1
> > > > > > > > > > >     },
> > > > > > > > > > >     next =3D 0x0
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_inode =3D 0xffff8882bc312ef8,
> > > > > > > > > > >   nf_file =3D 0xffff88e2015b1500,
> > > > > > > > > > >   nf_cred =3D 0xffff88e3ab0e7800,
> > > > > > > > > > >   nf_net =3D 0xffffffff83d41600 <init_net>,
> > > > > > > > > > >   nf_flags =3D 0x8,
> > > > > > > > > > >   nf_ref =3D {
> > > > > > > > > > >     refs =3D {
> > > > > > > > > > >       counter =3D 0xc0000000
> > > > > > > > > > >     }
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_may =3D 0x4,
> > > > > > > > > > >   nf_mark =3D 0xffff88e1bddfb320,
> > > > > > > > > > >   nf_lru =3D {
> > > > > > > > > > >     next =3D 0xffff88e160db04a8,
> > > > > > > > > > >     prev =3D 0xffff88e160db04a8
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_rcu =3D {
> > > > > > > > > > >     next =3D 0x10000000000,
> > > > > > > > > > >     func =3D 0x0
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_birthtime =3D 0x73d22fc1728
> > > > > > > > > > > }
> > > > > > > > > > >=20
> > > > > > > > > > > crash> struct
> > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file
> > > > > > > > > > > -x
> > > > > > > > > > > ffff88839a53d850
> > > > > > > > > > >   nf_flags =3D 0x8,
> > > > > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > > > > >   nf_lru =3D {
> > > > > > > > > > >     next =3D 0xffff88839a53d898,
> > > > > > > > > > >     prev =3D 0xffff88839a53d898
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_file =3D 0xffff88810ede8700,
> > > > > > > > > > >=20
> > > > > > > > > > > crash> struct
> > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file
> > > > > > > > > > > -x
> > > > > > > > > > > ffff88c32b11e850
> > > > > > > > > > >   nf_flags =3D 0x8,
> > > > > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > > > > >   nf_lru =3D {
> > > > > > > > > > >     next =3D 0xffff88c32b11e898,
> > > > > > > > > > >     prev =3D 0xffff88c32b11e898
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_file =3D 0xffff88c20a701c00,
> > > > > > > > > > >=20
> > > > > > > > > > > crash> struct
> > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file
> > > > > > > > > > > -x
> > > > > > > > > > > ffff88e372709700
> > > > > > > > > > >   nf_flags =3D 0xc,
> > > > > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > > > > >   nf_lru =3D {
> > > > > > > > > > >     next =3D 0xffff88e372709748,
> > > > > > > > > > >     prev =3D 0xffff88e372709748
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_file =3D 0xffff88e0725e6400,
> > > > > > > > > > >=20
> > > > > > > > > > > crash> struct
> > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file
> > > > > > > > > > > -x
> > > > > > > > > > > ffff8982864944d0
> > > > > > > > > > >   nf_flags =3D 0xc,
> > > > > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > > > > >   nf_lru =3D {
> > > > > > > > > > >     next =3D 0xffff898286494518,
> > > > > > > > > > >     prev =3D 0xffff898286494518
> > > > > > > > > > >   },
> > > > > > > > > > >   nf_file =3D 0xffff89803c0ff700,
> > > > > > > > > > >=20
> > > > > > > > > > > The leak occurs when nfsd_file_put() races with
> > > > > > > > > > > nfsd_file_cond_queue()
> > > > > > > > > > > or nfsd_file_lru_cb(). With the following patch, I
> > > > > > > > > > > haven't observed
> > > > > > > > > > > any leak after a few days heavy nfs load:
> > > > > > > > > >=20
> > > > > > > > > > Our patch submission guidelines require a Signed-off-
> > > > > > > > > > by:
> > > > > > > > > > line at the end of the patch description. See the "Sign
> > > > > > > > > > your work -
> > > > > > > > > > the Developer's Certificate of Origin" section of
> > > > > > > > > >=20
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/tree/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6
> > > > > > > > > >=20
> > > > > > > > > > (Needed here in case your fix is acceptable).
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > diff --git a/fs/nfsd/filecache.c
> > > > > > > > > > > b/fs/nfsd/filecache.c
> > > > > > > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file
> > > > > > > > > > > *nf)
> > > > > > > > > > >   if (!nfsd_file_lru_remove(nf))
> > > > > > > > > > >   return;
> > > > > > > > > > >   }
> > > > > > > > > > > + /*
> > > > > > > > > > > + * Racing with nfsd_file_cond_queue() or
> > > > > > > > > > > nfsd_file_lru_cb(),
> > > > > > > > > > > + * it's unhashed but then removed from the dispose
> > > > > > > > > > > list,
> > > > > > > > > > > + * so we need to free it.
> > > > > > > > > > > + */
> > > > > > > > > > > + if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > > > > > > > > > +     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> > > > > > > > > > > +     list_empty(&nf->nf_lru)) {
> > > > > > > > > > > + nfsd_file_free(nf);
> > > > > > > > > > > + return;
> > > > > > > > > > > + }
> > > > > > > > > > >   }
> > > > > > > > > > >   if (refcount_dec_and_test(&nf->nf_ref))
> > > > > > > > > > >   nfsd_file_free(nf);
> > > > > > > > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct
> > > > > > > > > > > nfsd_file
> > > > > > > > > > > *nf, struct
> > > > > > > > > > > list_head *dispose)
> > > > > > > > > > >   int decrement =3D 1;
> > > > > > > > > > >=20
> > > > > > > > > > >   /* If we raced with someone else unhashing, ignore
> > > > > > > > > > > it
> > > > > > > > > > > */
> > > > > > > > > > > - if (!nfsd_file_unhash(nf))
> > > > > > > > > > > + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > > > > > > >   return;
> > > > > > > > > > >=20
> > > > > > > > > > >   /* If we can't get a reference, ignore it */
> > > > > > > > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct
> > > > > > > > > > > nfsd_file
> > > > > > > > > > > *nf, struct
> > > > > > > > > > > list_head *dispose)
> > > > > > > > > > >   /* If refcount goes to 0, then put on the dispose
> > > > > > > > > > > list
> > > > > > > > > > > */
> > > > > > > > > > >   if (refcount_sub_and_test(decrement, &nf->nf_ref))
> > > > > > > > > > > {
> > > > > > > > > > >   list_add(&nf->nf_lru, dispose);
> > > > > > > > > > > + nfsd_file_unhash(nf);
> > > > > > > > > > >   trace_nfsd_file_closing(nf);
> > > > > > > > > > >   }
> > > > > > > > > > >  }
> > > > > > > > > > >=20
> > > > > > > > > > > Please kindly review the patch and let me know if it
> > > > > > > > > > > makes sense.
> > > > > > > > > > >=20
> > > > > > > > > > > Thanks,
> > > > > > > > > > >=20
> > > > > > > > > > > -Youzhong
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > --
> > > > > > > > > > Chuck Lever
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > --
> > > > > > > > Jeff Layton <jlayton@poochiereds.net>
> > > > > >=20
> > > > > > --
> > > > > > Jeff Layton <jlayton@poochiereds.net>
> > > > > >=20
> > > > > > --
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > >=20
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

