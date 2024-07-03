Return-Path: <linux-nfs+bounces-4609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6F9269B2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 22:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188EDB2159E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956A13A275;
	Wed,  3 Jul 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlILXFBi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695E17BA9
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039619; cv=none; b=tX/cAZMrZbTnW83TZCxTjxiuo/hRKKR4usiJqOCW2fEowPqwJlmJ9fz8neRYb8uB2zr2VvH9xZmpozJGsqwxntc0wcA2DHystnzcuZ91tWFXZIjQXA6v9Fz1qEKcFhXr7+mJssj5BzEH2TZcM4AvUWw1+1GeFgxNUIiN3G+dTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039619; c=relaxed/simple;
	bh=/FVD0DkBhM5lyqATyaKCpCEmHdy0kqPMgbJSWfGjVc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQFH9DeCbhlYy+me0VXRK/LnSxIjhd32j0Gzyyv8w1QfvGuxZjTnsIE04KdCrDLk5jVDsUkfeS7H6OTQvLzILFnC7hMCLbEyJAKi6rztPx+xSQJFegWCQMtMHuBY+sNrr+3Z1GYYrZcevycNEEqyYafQxCkhc8/GnFUeiAJejko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlILXFBi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfab5f7e749so6357514276.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jul 2024 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720039617; x=1720644417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXkdxWKwpeNQK2RWao5952wy3F4x3tJrBbrdnGhw23I=;
        b=OlILXFBiiohIlzPrE+GeG0rbDw9KrCAZCL6othe17aoTb+OKB+6GEWJ67/GkGiKVWJ
         tFVGZGmnSfpWo3blRir8iuUnEc5iom25FVIuE+r1PN4+tanWzuju2avaxpCKdtdgY879
         Zlemj692DV70j0olWxqL1+MWyrtNLph1ohWptDJ9ul0xCONq7Y7RRTLUBfOYgEbjIvle
         mPtDredKsl7A0zqMkDjJeDWwAtPsyfEx5U/d+5UDSZRN3Pfw4Rzt/pgegPb6TIH+bSb7
         iDeOxsZOXfki9RNA1IqzB1X0+KmU0jFqHABq78K1nOJzik5A8Mi/mst392W/ZrU7Q4+D
         2WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720039617; x=1720644417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXkdxWKwpeNQK2RWao5952wy3F4x3tJrBbrdnGhw23I=;
        b=v7YZ0sLnAYv488IrncfnNpix4M910fLpLM/cvHDs+3/rMcb8UyMlgSSh/FmH3UbRZp
         jXoCUkRroMlUFuINkIfit4dvuVw2M9KrDouBLpvllOMNT79cF1LdomZTcZAw39NFbtLB
         Ljb6iLX5LoV6TtAx//wqLCbJ57ma1D3+ksHjm4W5HaVEw5k3lcNqauSG30mCA2mdGspJ
         23apWpEKoeZ6I7zm948krNr8JnbZ6GD290VhwRzl32oZmV8OVmn5EOZQPG6kg6M7j1xs
         ATCfkN0wBPg8L9ToNdlB5+wXdX8TJrxw7dmlYYCu5kW4dEmrw5yI51ZtdANYr7WpGkQQ
         uY6w==
X-Gm-Message-State: AOJu0Yzh2//4cLQME011DoqouJBuGveoIq1ksnl3X3vk2Jp5U0RvjFiJ
	3PGcYTsR1LrXo1QaUzOvA5chEE2ILr97JjewatEq9f287fLUiSCUcUY46+yuDPxZdS3hSCL9hX4
	jN6h4QfY7H4YUVJ6SZye+JtR83eCIDdHN
X-Google-Smtp-Source: AGHT+IGGvZbms6l5q0XM/9bx3cxM6zr4l7cA+mLdI9q6y9cxINwLHWHrzdX6w6JH+AnSXsqyrotJT2/orI9wCJmn28s=
X-Received: by 2002:a5b:8c1:0:b0:dfb:3bf:f5ce with SMTP id 3f1490d57ef6-e03a2d76870mr6020761276.48.1720039616588;
 Wed, 03 Jul 2024 13:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
 <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
In-Reply-To: <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
From: Youzhong Yang <youzhong@gmail.com>
Date: Wed, 3 Jul 2024 16:46:45 -0400
Message-ID: <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
Subject: Re: Leaked nfsd_file due to race condition and early unhash (fs/nfsd/filecache.c)
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Chuck. Here are my quick answers to your comments:

- I don't have a quick reproducer. I reproduced it by using hundreds
of nfs clients generating +600K ops under our workload in the testing
environment. Theoretically it should be possible to simplify the
reproduction but I am still working on it.

-  I understand zfs is an out-of-tree file system. That's fine. But
this leaking can happen to any file system, and leaking is not a good
thing no matter what file system it is.

-  I will try to come up with a reproducer using xfs or btrfs if possible.

Now back to the problem itself, here are my findings:

- nfsd_file_put() in one thread can race with another thread doing
garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
nfsd_file_lru_cb()):

  * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_ad=
d().
  * nfsd_file_lru_add() returns true (thus NFSD_FILE_REFERENCED bit
set for nf->nf_flags)
  * garbage collector kicks in, nfsd_file_lru_cb() clears REFERENCED
bit and returns LRU_ROTATE.
  * garbage collector kicks in again, nfsd_file_lru_cb() now
decrements nf->nf_ref to 0, runs nfsd_file_unhash(), removes it from
the LRU and adds to the dispose list [list_lru_isolate_move(lru,
&nf->nf_lru, head);]
  * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it
tries to remove the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]
  * The 'nf' has been added to the 'dispose' list by
nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply treats it as
part of the LRU and removes it, which leads it to be removed from the
'dispose' list.
  * At this moment, nf->nf_ref is 0, it's unhashed, and not on the
LRU. nfsd_file_put() continues its execution [if
(refcount_dec_and_test(&nf->nf_ref))], as nf->nf_ref is already 0, now
bad thing happens: nf->nf_ref is set to REFCOUNT_SATURATED, and the
'nf' is leaked.

To make this happen, the right timing is crucial. It can be reproduced
by adding artifical delays in filecache.c, or hammering the nfsd with
tons of ops.

- Let's see how nfsd_file_put() can race with nfsd_file_cond_queue():
  * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_ad=
d().
  * nfsd_file_lru_add() sets REFERENCED bit and returns true.
  * 'exportfs -f' or something like that triggers
__nfsd_file_cache_purge() -> nfsd_file_cond_queue().
  * In nfsd_file_cond_queue(), it runs [if (!nfsd_file_unhash(nf))],
unhash is done successfully.
  * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now
nf->nf_ref goes to 2.
  * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))], it succeed=
s.
  * nfsd_file_cond_queue() runs [if (refcount_sub_and_test(decrement,
&nf->nf_ref))] (with "decrement" being 2), so the nf->nf_ref goes to
0, the 'nf' is added to the dispost list [list_add(&nf->nf_lru,
dispose)]
  * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it
tries to remove the 'nf' from the LRU [if
(!nfsd_file_lru_remove(nf))], although the 'nf' is not in the LRU, but
it is linked in the 'dispose' list, nfsd_file_lru_remove() simply
treats it as part of the LRU and removes it. This leads to its removal
from the 'dispose' list!
  * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
execution and sets nf->nf_ref to REFCOUNT_SATURATED.

The purpose of nf->nf_lru is problematic. As you can see, it is used
for the LRU list, and also the 'dispose' list. Adding another 'struct
list_head' specifically for the 'dispose' list seems to be a better
way of fixing this race condition. Either way works for me.

Would you agree my above analysis makes sense? Thanks.

Here is my patch with signed-off-by:

From: Youzhong Yang <youzhong@gmail.com>
Date: Mon, 1 Jul 2024 06:45:22 -0400
Subject: [PATCH] nfsd: fix nfsd_file leaking due to race condition and earl=
y
 unhash

Signed-off-by: Youzhong Yang <youzhong@gmail.com>
---
 fs/nfsd/filecache.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1a6d5d000b85..2323829f7208 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
                        if (!nfsd_file_lru_remove(nf))
                                return;
                }
+               /*
+                * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb()=
,
+                * it's unhashed but then removed from the dispose list,
+                * so we need to free it.
+                */
+               if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
+                   !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
+                   list_empty(&nf->nf_lru)) {
+                       nfsd_file_free(nf);
+                       return;
+               }
        }
        if (refcount_dec_and_test(&nf->nf_ref))
                nfsd_file_free(nf);
@@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
list_head *dispose)
        int decrement =3D 1;

        /* If we raced with someone else unhashing, ignore it */
-       if (!nfsd_file_unhash(nf))
+       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
                return;

        /* If we can't get a reference, ignore it */
@@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
list_head *dispose)
        /* If refcount goes to 0, then put on the dispose list */
        if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
                list_add(&nf->nf_lru, dispose);
+               nfsd_file_unhash(nf);
                trace_nfsd_file_closing(nf);
        }
 }
--
2.43.0

On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang wrote:
> > Hello,
> >
> > I'd like to report a nfsd_file leaking issue and propose a fix for it.
> >
> > When I tested Linux kernel 6.8 and 6.6, I noticed nfsd_file leaks
> > which led to undestroyable file systems (zfs),
>
> Thanks for the report. Some initial comments:
>
> - Do you have a specific reproducer? In other words, what is the
>   simplest program that can run on an NFS client that will trigger
>   this leak, and can you post it?
>
> - "zfs" is an out-of-tree file system, so it's not directly
>   supported for NFSD.
>
> - The guidelines for patch submission require us to fix issues in
>   upstream Linux first (currently that's v6.10-rc6). Then that fix
>   can be backported to older stable kernels like 6.6.
>
> Can you reproduce the leak with one of the in-kernel filesystems
> (either xfs or btrfs would be great) and with NFSD in 6.10-rc6?
>
> One more comment below.
>
>
> > here are some examples:
> >
> > crash> struct nfsd_file -x ffff88e160db0460
> > struct nfsd_file {
> >   nf_rlist =3D {
> >     rhead =3D {
> >       next =3D 0xffff8921fa2392f1
> >     },
> >     next =3D 0x0
> >   },
> >   nf_inode =3D 0xffff8882bc312ef8,
> >   nf_file =3D 0xffff88e2015b1500,
> >   nf_cred =3D 0xffff88e3ab0e7800,
> >   nf_net =3D 0xffffffff83d41600 <init_net>,
> >   nf_flags =3D 0x8,
> >   nf_ref =3D {
> >     refs =3D {
> >       counter =3D 0xc0000000
> >     }
> >   },
> >   nf_may =3D 0x4,
> >   nf_mark =3D 0xffff88e1bddfb320,
> >   nf_lru =3D {
> >     next =3D 0xffff88e160db04a8,
> >     prev =3D 0xffff88e160db04a8
> >   },
> >   nf_rcu =3D {
> >     next =3D 0x10000000000,
> >     func =3D 0x0
> >   },
> >   nf_birthtime =3D 0x73d22fc1728
> > }
> >
> > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > ffff88839a53d850
> >   nf_flags =3D 0x8,
> >   nf_ref.refs.counter =3D 0x0
> >   nf_lru =3D {
> >     next =3D 0xffff88839a53d898,
> >     prev =3D 0xffff88839a53d898
> >   },
> >   nf_file =3D 0xffff88810ede8700,
> >
> > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > ffff88c32b11e850
> >   nf_flags =3D 0x8,
> >   nf_ref.refs.counter =3D 0x0
> >   nf_lru =3D {
> >     next =3D 0xffff88c32b11e898,
> >     prev =3D 0xffff88c32b11e898
> >   },
> >   nf_file =3D 0xffff88c20a701c00,
> >
> > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > ffff88e372709700
> >   nf_flags =3D 0xc,
> >   nf_ref.refs.counter =3D 0x0
> >   nf_lru =3D {
> >     next =3D 0xffff88e372709748,
> >     prev =3D 0xffff88e372709748
> >   },
> >   nf_file =3D 0xffff88e0725e6400,
> >
> > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
> > ffff8982864944d0
> >   nf_flags =3D 0xc,
> >   nf_ref.refs.counter =3D 0x0
> >   nf_lru =3D {
> >     next =3D 0xffff898286494518,
> >     prev =3D 0xffff898286494518
> >   },
> >   nf_file =3D 0xffff89803c0ff700,
> >
> > The leak occurs when nfsd_file_put() races with nfsd_file_cond_queue()
> > or nfsd_file_lru_cb(). With the following patch, I haven't observed
> > any leak after a few days heavy nfs load:
>
> Our patch submission guidelines require a Signed-off-by:
> line at the end of the patch description. See the "Sign your work -
> the Developer's Certificate of Origin" section of
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.10-rc6
>
> (Needed here in case your fix is acceptable).
>
>
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 1a6d5d000b85..2323829f7208 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> >   if (!nfsd_file_lru_remove(nf))
> >   return;
> >   }
> > + /*
> > + * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb(),
> > + * it's unhashed but then removed from the dispose list,
> > + * so we need to free it.
> > + */
> > + if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > +     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> > +     list_empty(&nf->nf_lru)) {
> > + nfsd_file_free(nf);
> > + return;
> > + }
> >   }
> >   if (refcount_dec_and_test(&nf->nf_ref))
> >   nfsd_file_free(nf);
> > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> > list_head *dispose)
> >   int decrement =3D 1;
> >
> >   /* If we raced with someone else unhashing, ignore it */
> > - if (!nfsd_file_unhash(nf))
> > + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> >   return;
> >
> >   /* If we can't get a reference, ignore it */
> > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> > list_head *dispose)
> >   /* If refcount goes to 0, then put on the dispose list */
> >   if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> >   list_add(&nf->nf_lru, dispose);
> > + nfsd_file_unhash(nf);
> >   trace_nfsd_file_closing(nf);
> >   }
> >  }
> >
> > Please kindly review the patch and let me know if it makes sense.
> >
> > Thanks,
> >
> > -Youzhong
> >
>
> --
> Chuck Lever

