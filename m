Return-Path: <linux-nfs+bounces-4753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D934492C359
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 20:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F811282883
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3418003A;
	Tue,  9 Jul 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwrWliws"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C91B86D8
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jul 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550247; cv=none; b=RgUm70TsmPi6hmvo0RLaYj5xCRtrKKmOhmMsMNXSRI8TERko3N9Iwmx3C5pfgr7udhEUSDVCnUPxldhR/uC/R5FWGCpZNzL8zi6o54/dAtwgMQIy7+BjvJ1ZWO7oNuDnjPEm2rq9t73WZOLPjrjiHsmM7jdJ4kFgi7WaHzfhP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550247; c=relaxed/simple;
	bh=Liicue2b5itGD5tePyurt6+1OhTvu74hp9ha15gCaQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcOSLwzb7HuozumWYNDlPVB+2e1eg/9kCHt8G1ylDj7X053JOJlqomOz0ECjwoMrxKUSon3DH2j+vneufyWGcnxTtd9PT56dPiyX/HQVEbhBUTwEBjqsIBBreMdQvAaRBfcFALuEL5JuGb+e1RJzecCVCea+SeUJjBjJ73K4s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwrWliws; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-650866942aeso50739427b3.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2024 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720550243; x=1721155043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8QPmFhKDusi7C+HeRqjJdKTIrY5bKluq6RNimPrAvc=;
        b=ZwrWliws1IlVSFrA+f/sy6LLJiTpdK/Qd1Yoh0xhCcP4uOzxrhV9TLZbh81IJzUMP5
         7vct4c2EC9Yj0HNlxqqB+uTBnz9rQjvxyazGQc/6ZT9aBTyadBBY9WGU2yJu2Lu2WxcM
         dfk9Ph9s/BpDXdEW2Yq/Ozjf9zhM6fXPz0T4r1g6jUjk5i6dzoIIrfPafONJPfh+eHDm
         JqTIu6AGVs4yL97GQKzGGoll+iUt2hpUSYHPSXzfM3L8n4P4MNJzVvjHduskYhDDtU3U
         /8MfV/Y/HVkbmYvzvu564WoDULoxw5Gqy2f+OSMDw98o42zkr3nXHzeRNOxEDrVZp0JF
         cz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720550243; x=1721155043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8QPmFhKDusi7C+HeRqjJdKTIrY5bKluq6RNimPrAvc=;
        b=DRliJ7eNLC1BW920RAH8wtjKfftBgLW/pYMzHUiF3VUrZHjjkYiqqwZKFXOlCIagEP
         a4YkKa7fYDF5CZ0J+gLG+DP/rIsuNyfMFl3B+m9HLEOTUqOhDB42RiNXbeKMBXQC4E56
         p7NMix2U7K/3k3QtbKvFc6x4TZG2UUWbFSku3pc2m2i+3Qd6dzAiLKUztibSPmD9q5ry
         p85m5wjDndjDDh2ze4ShK01nKzDk2q/49mO7upYDqOIjn5xIdGPR7f+Rpb5fQD4LS7jp
         WXa/ZUTf4vMCr+hr3pbKZEssr24Q1SAzpvNesZGxJ4IbRJ7sjIWUs9gYFZRgXlv+egy2
         XHTA==
X-Forwarded-Encrypted: i=1; AJvYcCUj7oqTbyA2GMbEDCMgs/b/1Gu+9Q35Xi+MUAqHaNVUVVWW2dUTF8kcTR/gqC04aSP/xuCZ1axb0YKACggP65PDvrRMw3yvZfqt
X-Gm-Message-State: AOJu0Yw8isuMnyn6E5xUZgvI5MG+iwDr4EnqUb7kLD2G8jI0Ctqg2Vz1
	jGNa7UWtp3T37mldYy394sE1XePGNYG0lHt/m4QjyFzQLTWFKOWUhTkgYPE+HPIiR5pU+oVY14+
	zFz9TCQ2ga/8VKylAHZEimkivvtc=
X-Google-Smtp-Source: AGHT+IGVKB4l+VhUG5DU/WcaXV5o15POZbGCxZYJZVZFCgD2EY5anRAXHVqCBa8RfCHrB/fKg9F8A+m3PR6y4PvLMJE=
X-Received: by 2002:a0d:f685:0:b0:627:8791:5c4 with SMTP id
 00721157ae682-658ee790bcfmr34041867b3.8.1720550243306; Tue, 09 Jul 2024
 11:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
 <ZoWWis0AgvmiVzBU@tissot.1015granger.net> <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
 <0445d64ebcc7185bf48cc05f72ca29b859f45c26.camel@poochiereds.net>
 <CADpNCvZ-kEc6hOQHsbn7yHtvB-acg_gQwzEjN9zcjw0oM2RgGw@mail.gmail.com>
 <321ddc16356d75f9eb6e5ab15c4e28fae1466267.camel@kernel.org>
 <CADpNCvb5kpghbEj+yU1OgKF0BJS9dYDtFgRz3ArfCamCnyn_Ww@mail.gmail.com> <c138dd82bb493abe7b0c34b1e2803437bd163c54.camel@kernel.org>
In-Reply-To: <c138dd82bb493abe7b0c34b1e2803437bd163c54.camel@kernel.org>
From: Youzhong Yang <youzhong@gmail.com>
Date: Tue, 9 Jul 2024 14:37:12 -0400
Message-ID: <CADpNCvY-hTbO6OGAHO4N43UZjEtv5eyDmNU-S19ULn1iUOES3A@mail.gmail.com>
Subject: Re: Leaked nfsd_file due to race condition and early unhash (fs/nfsd/filecache.c)
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jeff.

Unfortunately the early unhash easily leads to leaks:

crash> kmem -S nfsd_file | grep '\[ffff' | sed -e 's|\[||' -e 's|\]||'
| xargs -i echo struct nfsd_file.nf_flags,nf_ref.refs.counter '{}' >
/var/tmp/nfsd_files
crash> !wc -l /var/tmp/nfsd_files
19 /var/tmp/nfsd_files
crash> < /var/tmp/nfsd_files
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88865c778900
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 2
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88865c778cc0
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 3
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff8885d5f35e00
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 1
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88817443e780
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 3
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88818b3f0600
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 2
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88a4490f8300
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 1
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff88a0dab183c0
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 40
...
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff89209535f200
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 2
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff8980e15138c0
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 7
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff898107b95800
  nf_flags =3D 8,
  nf_ref.refs.counter =3D 3
crash> struct nfsd_file.nf_flags,nf_ref.refs.counter ffff898107b95980
  nf_flags =3D 12,
  nf_ref.refs.counter =3D 1

nfsd_file_do_acquire() -> nfsd_file_lookup_locked() relies on the hash
table to find the nfsd_file,
but I am still scratching my head why and how this happens.

FYI, here is the patch I applied for testing:

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..22ebd7fb8639 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode
*inode, unsigned char need,
                return NULL;

        INIT_LIST_HEAD(&nf->nf_lru);
+       INIT_LIST_HEAD(&nf->nf_gc);
        nf->nf_birthtime =3D ktime_get();
        nf->nf_file =3D NULL;
        nf->nf_cred =3D get_current_cred();
@@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
        struct nfsd_file *nf;

        while (!list_empty(dispose)) {
-               nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
-               list_del_init(&nf->nf_lru);
+               nf =3D list_first_entry(dispose, struct nfsd_file, nf_gc);
+               list_del_init(&nf->nf_gc);
                nfsd_file_free(nf);
        }
 }
@@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct list_head *disp=
ose)
 {
        while(!list_empty(dispose)) {
                struct nfsd_file *nf =3D list_first_entry(dispose,
-                                               struct nfsd_file, nf_lru);
+                                               struct nfsd_file, nf_gc);
                struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id=
);
                struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;

                spin_lock(&l->lock);
-               list_move_tail(&nf->nf_lru, &l->freeme);
+               list_move_tail(&nf->nf_gc, &l->freeme);
                spin_unlock(&l->lock);
                svc_wake_up(nn->nfsd_serv);
        }
@@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item, struct
list_lru_one *lru,

        /* Refcount went to zero. Unhash it and queue it to the dispose lis=
t */
        nfsd_file_unhash(nf);
-       list_lru_isolate_move(lru, &nf->nf_lru, head);
+       list_lru_isolate(lru, &nf->nf_lru);
+       list_add(&nf->nf_gc, head);
        this_cpu_inc(nfsd_file_evictions);
        trace_nfsd_file_gc_disposed(nf);
        return LRU_REMOVED;
@@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
list_head *dispose)

        /* If refcount goes to 0, then put on the dispose list */
        if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-               list_add(&nf->nf_lru, dispose);
+               list_add(&nf->nf_gc, dispose);
                trace_nfsd_file_closing(nf);
        }
 }
@@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode *inode)

        nfsd_file_queue_for_close(inode, &dispose);
        while (!list_empty(&dispose)) {
-               nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru)=
;
-               list_del_init(&nf->nf_lru);
+               nf =3D list_first_entry(&dispose, struct nfsd_file, nf_gc);
+               list_del_init(&nf->nf_gc);
                nfsd_file_free(nf);
        }
 }
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index c61884def906..3fbec24eea6c 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -44,6 +44,7 @@ struct nfsd_file {

        struct nfsd_file_mark   *nf_mark;
        struct list_head        nf_lru;
+       struct list_head        nf_gc;
        struct rcu_head         nf_rcu;
        ktime_t                 nf_birthtime;
 };

On Mon, Jul 8, 2024 at 10:55=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2024-07-08 at 10:23 -0400, Youzhong Yang wrote:
> > Thanks Jeff.
> >
> > I am ok with reverting the unhash/dispose list reordering in
> > nfsd_file_lru_cb(), as it doesn't make much of a difference,
> > but for nfsd_file_cond_queue(), imagining this:
> >
> > - A nfsd_file is hashed
> > - In nfsd_file_cond_queue(), [if (!nfsd_file_unhash(nf))] will get it
> > unhashed, doesn't it?
> > - It continues to get a reference by nfsd_file_get()
> > - It continues to remove itself from LRU by nfsd_file_lru_remove() if
> > it is on the LRU.
> > - Now it runs refcount_sub_and_test(), what happens if the refcnt
> > does
> > not go to 0? How can this nfsd_file be found again? Through the hash
> > table? Through the LRU walk? how?
> >
> > Thanks again.
> >
> > -Youzhong
> >
>
> It won't need to be found again. The holders of the extra references
> will put those references when they are finished. Since the object is
> no longer HASHED, nfsd_file_put just does this:
>
>         if (refcount_dec_and_test(&nf->nf_ref))
>                 nfsd_file_free(nf);
>
> So that should be fine.
>
> > On Mon, Jul 8, 2024 at 9:35=E2=80=AFAM Jeff Layton <jlayton@kernel.org>
> > wrote:
> > >
> > > On Mon, 2024-07-08 at 08:58 -0400, Youzhong Yang wrote:
> > > > Thank you Jeff for your invaluable insights. I was leaning
> > > > towards
> > > > adding a new list_head too, and tested this approach on kernel
> > > > 6.6 by
> > > > continuously hammering the server with heavy nfs load for the
> > > > last few
> > > > days, not a single leak.
> > > >
> > > > Here goes the patch (based on Linux kernel master branch), please
> > > > review:
> > > >
> > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > Date: Thu, 4 Jul 2024 11:25:40 -0400
> > > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to mixed use of
> > > > nf->nf_lru
> > > >
> > > > nfsd_file_put() in one thread can race with another thread doing
> > > > garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
> > > > nfsd_file_lru_cb()):
> > > >
> > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > nfsd_file_lru_add().
> > > >   * nfsd_file_lru_add() returns true (with NFSD_FILE_REFERENCED
> > > > bit set)
> > > >   * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > > REFERENCED bit and
> > > >     returns LRU_ROTATE.
> > > >   * garbage collector kicks in again, nfsd_file_lru_cb() now
> > > > decrements nf->nf_ref
> > > >     to 0, runs nfsd_file_unhash(), removes it from the LRU and
> > > > adds to
> > > > the dispose
> > > >     list [list_lru_isolate_move(lru, &nf->nf_lru, head)]
> > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so
> > > > it
> > > > tries to remove
> > > >     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]. The
> > > > 'nf'
> > > > has been added
> > > >     to the 'dispose' list by nfsd_file_lru_cb(), so
> > > > nfsd_file_lru_remove(nf) simply
> > > >     treats it as part of the LRU and removes it, which leads to
> > > > its removal from
> > > >     the 'dispose' list.
> > > >   * At this moment, 'nf' is unhashed with its nf_ref being 0, and
> > > > not
> > > > on the LRU.
> > > >     nfsd_file_put() continues its execution [if
> > > > (refcount_dec_and_test(&nf->nf_ref))],
> > > >     as nf->nf_ref is already 0, nf->nf_ref is set to
> > > > REFCOUNT_SATURATED, and the 'nf'
> > > >     gets no chance of being freed.
> > > >
> > > > nfsd_file_put() can also race with nfsd_file_cond_queue():
> > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > nfsd_file_lru_add().
> > > >   * nfsd_file_lru_add() sets REFERENCED bit and returns true.
> > > >   * Some userland application runs 'exportfs -f' or something
> > > > like
> > > > that, which triggers
> > > >     __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> > > >   * In nfsd_file_cond_queue(), it runs [if
> > > > (!nfsd_file_unhash(nf))],
> > > > unhash is done
> > > >     successfully.
> > > >   * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now
> > > > nf->nf_ref goes to 2.
> > > >   * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))],
> > > > it succeeds.
> > > >   * nfsd_file_cond_queue() runs [if
> > > > (refcount_sub_and_test(decrement,
> > > > &nf->nf_ref))]
> > > >     (with "decrement" being 2), so the nf->nf_ref goes to 0, the
> > > > 'nf'
> > > > is added to the
> > > >     dispose list [list_add(&nf->nf_lru, dispose)]
> > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so
> > > > it
> > > > tries to remove
> > > >     the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))],
> > > > although
> > > > the 'nf' is not
> > > >     in the LRU, but it is linked in the 'dispose' list,
> > > > nfsd_file_lru_remove() simply
> > > >     treats it as part of the LRU and removes it. This leads to
> > > > its removal from
> > > >     the 'dispose' list!
> > > >   * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
> > > > execution and set
> > > >     nf->nf_ref to REFCOUNT_SATURATED.
> > > >
> > > > As shown in the above analysis, using nf_lru for both the LRU
> > > > list and
> > > > dispose list
> > > > can cause the leaks. This patch adds a new list_head nf_gc in
> > > > struct
> > > > nfsd_file, and uses
> > > > it for the dispose list. It's not expected to have a nfsd_file
> > > > unhashed but it's not
> > > > added to the dispose list, so in nfsd_file_cond_queue() and
> > > > nfsd_file_lru_cb() nfsd_file
> > > > is unhashed after being added to the dispose list.
> > > >
> > >
> > > I don't see where we require the object to be either hashed or on
> > > the
> > > dispose list.  I think you probably just want to do a patch that
> > > changes the dispose list to use a dedicated list_head without
> > > reordering when the these things are unhashed.
> > >
> > > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > > ---
> > > >  fs/nfsd/filecache.c | 23 ++++++++++++++---------
> > > >  fs/nfsd/filecache.h |  1 +
> > > >  2 files changed, 15 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index ad9083ca144b..3aef2ddfce94 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode
> > > > *inode, unsigned char need,
> > > >                 return NULL;
> > > >
> > > >         INIT_LIST_HEAD(&nf->nf_lru);
> > > > +       INIT_LIST_HEAD(&nf->nf_gc);
> > > >         nf->nf_birthtime =3D ktime_get();
> > > >         nf->nf_file =3D NULL;
> > > >         nf->nf_cred =3D get_current_cred();
> > > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head
> > > > *dispose)
> > > >         struct nfsd_file *nf;
> > > >
> > > >         while (!list_empty(dispose)) {
> > > > -               nf =3D list_first_entry(dispose, struct nfsd_file,
> > > > nf_lru);
> > > > -               list_del_init(&nf->nf_lru);
> > > > +               nf =3D list_first_entry(dispose, struct nfsd_file,
> > > > nf_gc);
> > > > +               list_del_init(&nf->nf_gc);
> > > >                 nfsd_file_free(nf);
> > > >         }
> > > >  }
> > > > @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct
> > > > list_head *dispose)
> > > >  {
> > > >         while(!list_empty(dispose)) {
> > > >                 struct nfsd_file *nf =3D list_first_entry(dispose,
> > > > -                                               struct nfsd_file,
> > > > nf_lru);
> > > > +                                               struct nfsd_file,
> > > > nf_gc);
> > > >                 struct nfsd_net *nn =3D net_generic(nf->nf_net,
> > > > nfsd_net_id);
> > > >                 struct nfsd_fcache_disposal *l =3D nn-
> > > > >fcache_disposal;
> > > >
> > > >                 spin_lock(&l->lock);
> > > > -               list_move_tail(&nf->nf_lru, &l->freeme);
> > > > +               list_move_tail(&nf->nf_gc, &l->freeme);
> > > >                 spin_unlock(&l->lock);
> > > >                 svc_wake_up(nn->nfsd_serv);
> > > >         }
> > > > @@ -502,8 +503,10 @@ nfsd_file_lru_cb(struct list_head *item,
> > > > struct
> > > > list_lru_one *lru,
> > > >         }
> > > >
> > > >         /* Refcount went to zero. Unhash it and queue it to the
> > > > dispose list */
> > > > +       list_lru_isolate(lru, &nf->nf_lru);
> > > > +       list_add(&nf->nf_gc, head);
> > > > +       /* Unhash after removing from LRU and adding to dispose
> > > > list */
> > > >         nfsd_file_unhash(nf);
> > > > -       list_lru_isolate_move(lru, &nf->nf_lru, head);
> > >
> > > I don't see the point in reordering these operations. Hashing is
> > > all
> > > about making the thing findable by nfsd operations. The _last_
> > > thing we
> > > want to do is put it on the dispose list while the thing can still
> > > be
> > > found by nfsd threads doing operations.
> > >
> > > >         this_cpu_inc(nfsd_file_evictions);
> > > >         trace_nfsd_file_gc_disposed(nf);
> > > >         return LRU_REMOVED;
> > > > @@ -565,7 +568,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf,
> > > > struct
> > > > list_head *dispose)
> > > >         int decrement =3D 1;
> > > >
> > > >         /* If we raced with someone else unhashing, ignore it */
> > > > -       if (!nfsd_file_unhash(nf))
> > > > +       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > >
> > > The above change looks wrong. I don't think we need to change this.
> > >
> > > >                 return;
> > > >
> > > >         /* If we can't get a reference, ignore it */
> > > > @@ -578,7 +581,9 @@ nfsd_file_cond_queue(struct nfsd_file *nf,
> > > > struct
> > > > list_head *dispose)
> > > >
> > > >         /* If refcount goes to 0, then put on the dispose list */
> > > >         if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > > -               list_add(&nf->nf_lru, dispose);
> > > > +               list_add(&nf->nf_gc, dispose);
> > > > +               /* Unhash after adding to dispose list */
> > > > +               nfsd_file_unhash(nf);
> > >
> > > This too looks wrong? Maybe I'm unclear on the race you're trying
> > > to
> > > fix with this? What's the harm in unhashing it early?
> > >
> > > >                 trace_nfsd_file_closing(nf);
> > > >         }
> > > >  }
> > > > @@ -654,8 +659,8 @@ nfsd_file_close_inode_sync(struct inode
> > > > *inode)
> > > >
> > > >         nfsd_file_queue_for_close(inode, &dispose);
> > > >         while (!list_empty(&dispose)) {
> > > > -               nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > > nf_lru);
> > > > -               list_del_init(&nf->nf_lru);
> > > > +               nf =3D list_first_entry(&dispose, struct nfsd_file,
> > > > nf_gc);
> > > > +               list_del_init(&nf->nf_gc);
> > > >                 nfsd_file_free(nf);
> > > >         }
> > > >  }
> > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > index c61884def906..3fbec24eea6c 100644
> > > > --- a/fs/nfsd/filecache.h
> > > > +++ b/fs/nfsd/filecache.h
> > > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > > >
> > > >         struct nfsd_file_mark   *nf_mark;
> > > >         struct list_head        nf_lru;
> > > > +       struct list_head        nf_gc;
> > > >         struct rcu_head         nf_rcu;
> > > >         ktime_t                 nf_birthtime;
> > > >  };
> > > > --
> > > > 2.34.1
> > > >
> > > > On Thu, Jul 4, 2024 at 7:14=E2=80=AFAM Jeff Layton
> > > > <jlayton@poochiereds.net> wrote:
> > > > >
> > > > > On Wed, 2024-07-03 at 16:46 -0400, Youzhong Yang wrote:
> > > > > > Thank you Chuck. Here are my quick answers to your comments:
> > > > > >
> > > > > > - I don't have a quick reproducer. I reproduced it by using
> > > > > > hundreds
> > > > > > of nfs clients generating +600K ops under our workload in the
> > > > > > testing
> > > > > > environment. Theoretically it should be possible to simplify
> > > > > > the
> > > > > > reproduction but I am still working on it.
> > > > > >
> > > > > > -  I understand zfs is an out-of-tree file system. That's
> > > > > > fine. But
> > > > > > this leaking can happen to any file system, and leaking is
> > > > > > not a good
> > > > > > thing no matter what file system it is.
> > > > > >
> > > > > > -  I will try to come up with a reproducer using xfs or btrfs
> > > > > > if possible.
> > > > > >
> > > > > > Now back to the problem itself, here are my findings:
> > > > > >
> > > > > > - nfsd_file_put() in one thread can race with another thread
> > > > > > doing
> > > > > > garbage collection (running nfsd_file_gc() -> list_lru_walk()
> > > > > > ->
> > > > > > nfsd_file_lru_cb()):
> > > > > >
> > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > > nfsd_file_lru_add().
> > > > > >   * nfsd_file_lru_add() returns true (thus
> > > > > > NFSD_FILE_REFERENCED bit
> > > > > > set for nf->nf_flags)
> > > > > >   * garbage collector kicks in, nfsd_file_lru_cb() clears
> > > > > > REFERENCED
> > > > > > bit and returns LRU_ROTATE.
> > > > > >   * garbage collector kicks in again, nfsd_file_lru_cb() now
> > > > > > decrements nf->nf_ref to 0, runs nfsd_file_unhash(), removes
> > > > > > it from
> > > > > > the LRU and adds to the dispose list
> > > > > > [list_lru_isolate_move(lru,
> > > > > > &nf->nf_lru, head);]
> > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > > so it
> > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > (!nfsd_file_lru_remove(nf))]
> > > > > >   * The 'nf' has been added to the 'dispose' list by
> > > > > > nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply treats
> > > > > > it as
> > > > > > part of the LRU and removes it, which leads it to be removed
> > > > > > from the
> > > > > > 'dispose' list.
> > > > > >   * At this moment, nf->nf_ref is 0, it's unhashed, and not
> > > > > > on the
> > > > > > LRU. nfsd_file_put() continues its execution [if
> > > > > > (refcount_dec_and_test(&nf->nf_ref))], as nf->nf_ref is
> > > > > > already 0, now
> > > > > > bad thing happens: nf->nf_ref is set to REFCOUNT_SATURATED,
> > > > > > and the
> > > > > > 'nf' is leaked.
> > > > > >
> > > > > > To make this happen, the right timing is crucial. It can be
> > > > > > reproduced
> > > > > > by adding artifical delays in filecache.c, or hammering the
> > > > > > nfsd with
> > > > > > tons of ops.
> > > > > >
> > > > > > - Let's see how nfsd_file_put() can race with
> > > > > > nfsd_file_cond_queue():
> > > > > >   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do
> > > > > > nfsd_file_lru_add().
> > > > > >   * nfsd_file_lru_add() sets REFERENCED bit and returns true.
> > > > > >   * 'exportfs -f' or something like that triggers
> > > > > > __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
> > > > > >   * In nfsd_file_cond_queue(), it runs [if
> > > > > > (!nfsd_file_unhash(nf))],
> > > > > > unhash is done successfully.
> > > > > >   * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))],
> > > > > > now
> > > > > > nf->nf_ref goes to 2.
> > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > (nfsd_file_lru_remove(nf))], it succeeds.
> > > > > >   * nfsd_file_cond_queue() runs [if
> > > > > > (refcount_sub_and_test(decrement,
> > > > > > &nf->nf_ref))] (with "decrement" being 2), so the nf->nf_ref
> > > > > > goes to
> > > > > > 0, the 'nf' is added to the dispost list [list_add(&nf-
> > > > > > >nf_lru,
> > > > > > dispose)]
> > > > > >   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared,
> > > > > > so it
> > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > (!nfsd_file_lru_remove(nf))], although the 'nf' is not in the
> > > > > > LRU, but
> > > > > > it is linked in the 'dispose' list, nfsd_file_lru_remove()
> > > > > > simply
> > > > > > treats it as part of the LRU and removes it. This leads to
> > > > > > its removal
> > > > > > from the 'dispose' list!
> > > > > >   * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
> > > > > > execution and sets nf->nf_ref to REFCOUNT_SATURATED.
> > > > > >
> > > > > > The purpose of nf->nf_lru is problematic. As you can see, it
> > > > > > is used
> > > > > > for the LRU list, and also the 'dispose' list. Adding another
> > > > > > 'struct
> > > > > > list_head' specifically for the 'dispose' list seems to be a
> > > > > > better
> > > > > > way of fixing this race condition. Either way works for me.
> > > > > >
> > > > > > Would you agree my above analysis makes sense? Thanks.
> > > > > >
> > > > >
> > > > > I think so. It's been a while since I've done much work in this
> > > > > code,
> > > > > but it does sound like there is a race in the LRU handling.
> > > > >
> > > > >
> > > > > Like Chuck said, the nf->nf_lru list should be safe to use for
> > > > > multiple
> > > > > purposes, but that's only the case if we're not using that list
> > > > > as an
> > > > > indicator.
> > > > >
> > > > > The list_lru code does check this:
> > > > >
> > > > >     if (!list_empty(item)) {
> > > > >
> > > > > ...so if we ever check this while it's sitting on the dispose
> > > > > list, it
> > > > > will handle it incorrectly. It sounds like that's the root
> > > > > cause of the
> > > > > problem you're seeing?
> > > > >
> > > > > If so, then maybe a separate list_head for disposal would be
> > > > > better.
> > > > >
> > > > > > Here is my patch with signed-off-by:
> > > > > >
> > > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > > Date: Mon, 1 Jul 2024 06:45:22 -0400
> > > > > > Subject: [PATCH] nfsd: fix nfsd_file leaking due to race
> > > > > > condition and early
> > > > > >  unhash
> > > > > >
> > > > > > Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> > > > > > ---
> > > > > >  fs/nfsd/filecache.c | 14 +++++++++++++-
> > > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > --- a/fs/nfsd/filecache.c
> > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > >                         if (!nfsd_file_lru_remove(nf))
> > > > > >                                 return;
> > > > > >                 }
> > > > > > +               /*
> > > > > > +                * Racing with nfsd_file_cond_queue() or
> > > > > > nfsd_file_lru_cb(),
> > > > > > +                * it's unhashed but then removed from the
> > > > > > dispose list,
> > > > > > +                * so we need to free it.
> > > > > > +                */
> > > > > > +               if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > > >
> > > > > A refcount_read in this path is a red flag to me. Anytime
> > > > > you're just
> > > > > looking at the refcount without changing anything just screams
> > > > > out
> > > > > "race condition".
> > > > >
> > > > > In this case, what guarantee is there that this won't run afoul
> > > > > of the
> > > > > timing? We could check this and find out it's 1 just before it
> > > > > goes to
> > > > > 0 and you check the other conditions.
> > > > >
> > > > > Does anything prevent that?
> > > > >
> > > > > > +                   !test_bit(NFSD_FILE_HASHED, &nf-
> > > > > > >nf_flags) &&
> > > > > > +                   list_empty(&nf->nf_lru)) {
> > > > > > +                       nfsd_file_free(nf);
> > > > > > +                       return;
> > > > > > +               }
> > > > > >         }
> > > > > >         if (refcount_dec_and_test(&nf->nf_ref))
> > > > > >                 nfsd_file_free(nf);
> > > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > *nf, struct
> > > > > > list_head *dispose)
> > > > > >         int decrement =3D 1;
> > > > > >
> > > > > >         /* If we raced with someone else unhashing, ignore it
> > > > > > */
> > > > > > -       if (!nfsd_file_unhash(nf))
> > > > > > +       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > >                 return;
> > > > >
> > > > > Same here: you're just testing for the HASHED bit, but could
> > > > > this also
> > > > > race with someone who is setting it just after you get here.
> > > > > Why is
> > > > > that not a problem?
> > > > >
> > > > > >
> > > > > >         /* If we can't get a reference, ignore it */
> > > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > *nf, struct
> > > > > > list_head *dispose)
> > > > > >         /* If refcount goes to 0, then put on the dispose
> > > > > > list */
> > > > > >         if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > > > >                 list_add(&nf->nf_lru, dispose);
> > > > > > +               nfsd_file_unhash(nf);
> > > > > >                 trace_nfsd_file_closing(nf);
> > > > > >         }
> > > > > >  }
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > > > On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck Lever
> > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang
> > > > > > > wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I'd like to report a nfsd_file leaking issue and propose
> > > > > > > > a fix for it.
> > > > > > > >
> > > > > > > > When I tested Linux kernel 6.8 and 6.6, I noticed
> > > > > > > > nfsd_file leaks
> > > > > > > > which led to undestroyable file systems (zfs),
> > > > > > >
> > > > > > > Thanks for the report. Some initial comments:
> > > > > > >
> > > > > > > - Do you have a specific reproducer? In other words, what
> > > > > > > is the
> > > > > > >   simplest program that can run on an NFS client that will
> > > > > > > trigger
> > > > > > >   this leak, and can you post it?
> > > > > > >
> > > > > > > - "zfs" is an out-of-tree file system, so it's not directly
> > > > > > >   supported for NFSD.
> > > > > > >
> > > > > > > - The guidelines for patch submission require us to fix
> > > > > > > issues in
> > > > > > >   upstream Linux first (currently that's v6.10-rc6). Then
> > > > > > > that fix
> > > > > > >   can be backported to older stable kernels like 6.6.
> > > > > > >
> > > > > > > Can you reproduce the leak with one of the in-kernel
> > > > > > > filesystems
> > > > > > > (either xfs or btrfs would be great) and with NFSD in 6.10-
> > > > > > > rc6?
> > > > > > >
> > > > > > > One more comment below.
> > > > > > >
> > > > > > >
> > > > > > > > here are some examples:
> > > > > > > >
> > > > > > > > crash> struct nfsd_file -x ffff88e160db0460
> > > > > > > > struct nfsd_file {
> > > > > > > >   nf_rlist =3D {
> > > > > > > >     rhead =3D {
> > > > > > > >       next =3D 0xffff8921fa2392f1
> > > > > > > >     },
> > > > > > > >     next =3D 0x0
> > > > > > > >   },
> > > > > > > >   nf_inode =3D 0xffff8882bc312ef8,
> > > > > > > >   nf_file =3D 0xffff88e2015b1500,
> > > > > > > >   nf_cred =3D 0xffff88e3ab0e7800,
> > > > > > > >   nf_net =3D 0xffffffff83d41600 <init_net>,
> > > > > > > >   nf_flags =3D 0x8,
> > > > > > > >   nf_ref =3D {
> > > > > > > >     refs =3D {
> > > > > > > >       counter =3D 0xc0000000
> > > > > > > >     }
> > > > > > > >   },
> > > > > > > >   nf_may =3D 0x4,
> > > > > > > >   nf_mark =3D 0xffff88e1bddfb320,
> > > > > > > >   nf_lru =3D {
> > > > > > > >     next =3D 0xffff88e160db04a8,
> > > > > > > >     prev =3D 0xffff88e160db04a8
> > > > > > > >   },
> > > > > > > >   nf_rcu =3D {
> > > > > > > >     next =3D 0x10000000000,
> > > > > > > >     func =3D 0x0
> > > > > > > >   },
> > > > > > > >   nf_birthtime =3D 0x73d22fc1728
> > > > > > > > }
> > > > > > > >
> > > > > > > > crash> struct
> > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > > ffff88839a53d850
> > > > > > > >   nf_flags =3D 0x8,
> > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > >   nf_lru =3D {
> > > > > > > >     next =3D 0xffff88839a53d898,
> > > > > > > >     prev =3D 0xffff88839a53d898
> > > > > > > >   },
> > > > > > > >   nf_file =3D 0xffff88810ede8700,
> > > > > > > >
> > > > > > > > crash> struct
> > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > > ffff88c32b11e850
> > > > > > > >   nf_flags =3D 0x8,
> > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > >   nf_lru =3D {
> > > > > > > >     next =3D 0xffff88c32b11e898,
> > > > > > > >     prev =3D 0xffff88c32b11e898
> > > > > > > >   },
> > > > > > > >   nf_file =3D 0xffff88c20a701c00,
> > > > > > > >
> > > > > > > > crash> struct
> > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > > ffff88e372709700
> > > > > > > >   nf_flags =3D 0xc,
> > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > >   nf_lru =3D {
> > > > > > > >     next =3D 0xffff88e372709748,
> > > > > > > >     prev =3D 0xffff88e372709748
> > > > > > > >   },
> > > > > > > >   nf_file =3D 0xffff88e0725e6400,
> > > > > > > >
> > > > > > > > crash> struct
> > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > > > > > > > ffff8982864944d0
> > > > > > > >   nf_flags =3D 0xc,
> > > > > > > >   nf_ref.refs.counter =3D 0x0
> > > > > > > >   nf_lru =3D {
> > > > > > > >     next =3D 0xffff898286494518,
> > > > > > > >     prev =3D 0xffff898286494518
> > > > > > > >   },
> > > > > > > >   nf_file =3D 0xffff89803c0ff700,
> > > > > > > >
> > > > > > > > The leak occurs when nfsd_file_put() races with
> > > > > > > > nfsd_file_cond_queue()
> > > > > > > > or nfsd_file_lru_cb(). With the following patch, I
> > > > > > > > haven't observed
> > > > > > > > any leak after a few days heavy nfs load:
> > > > > > >
> > > > > > > Our patch submission guidelines require a Signed-off-by:
> > > > > > > line at the end of the patch description. See the "Sign
> > > > > > > your work -
> > > > > > > the Developer's Certificate of Origin" section of
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6
> > > > > > >
> > > > > > > (Needed here in case your fix is acceptable).
> > > > > > >
> > > > > > >
> > > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > > > >   if (!nfsd_file_lru_remove(nf))
> > > > > > > >   return;
> > > > > > > >   }
> > > > > > > > + /*
> > > > > > > > + * Racing with nfsd_file_cond_queue() or
> > > > > > > > nfsd_file_lru_cb(),
> > > > > > > > + * it's unhashed but then removed from the dispose list,
> > > > > > > > + * so we need to free it.
> > > > > > > > + */
> > > > > > > > + if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > > > > > > +     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> > > > > > > > +     list_empty(&nf->nf_lru)) {
> > > > > > > > + nfsd_file_free(nf);
> > > > > > > > + return;
> > > > > > > > + }
> > > > > > > >   }
> > > > > > > >   if (refcount_dec_and_test(&nf->nf_ref))
> > > > > > > >   nfsd_file_free(nf);
> > > > > > > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > > *nf, struct
> > > > > > > > list_head *dispose)
> > > > > > > >   int decrement =3D 1;
> > > > > > > >
> > > > > > > >   /* If we raced with someone else unhashing, ignore it
> > > > > > > > */
> > > > > > > > - if (!nfsd_file_unhash(nf))
> > > > > > > > + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > > > > > > >   return;
> > > > > > > >
> > > > > > > >   /* If we can't get a reference, ignore it */
> > > > > > > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > > > > *nf, struct
> > > > > > > > list_head *dispose)
> > > > > > > >   /* If refcount goes to 0, then put on the dispose list
> > > > > > > > */
> > > > > > > >   if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > > > > > > >   list_add(&nf->nf_lru, dispose);
> > > > > > > > + nfsd_file_unhash(nf);
> > > > > > > >   trace_nfsd_file_closing(nf);
> > > > > > > >   }
> > > > > > > >  }
> > > > > > > >
> > > > > > > > Please kindly review the patch and let me know if it
> > > > > > > > makes sense.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > -Youzhong
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Chuck Lever
> > > > > >
> > > > >
> > > > > --
> > > > > Jeff Layton <jlayton@poochiereds.net>
> > >
> > > --
> > > Jeff Layton <jlayton@poochiereds.net>
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>
> --
> Jeff Layton <jlayton@kernel.org>

