Return-Path: <linux-nfs+bounces-4625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533A9274B4
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 13:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83D61C21976
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46681AC227;
	Thu,  4 Jul 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b="f52Cswte"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9181AB8F8
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091665; cv=none; b=Ut6tZmSdjkadwDeyWAtXQ0CyyB11lkoo129EHZnNRbigddBtzgSKTwFuJXKCi+GaVVVQ1TXBBKMg0Pr01tBfYJNokR7GNPReX8l3idHl2hKL14QWkpzZYp5O6uZ3i25LEA1TOxLF+jYDIy9lZMwoiu+m6qsDTE7Qei+xqqxFlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091665; c=relaxed/simple;
	bh=TcBZlG1PSGsY/8FLei5xOO4pVL2rojsrUZZV3YoHlrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cq4yTpfKHVnA4CX6P5VYBuK3ULEOdrm9AooWNyyU8R6X/rqE82svJdHgrzjVxJScWvFtRirkP6p69oUzmECXB4Vs+t2ya2s/8WIPU53MoGOrTStEDVnvnlLnaOVfgOODYte5rbfBFGJX96cP1EzJJQymax4O0/eg7z8FjbBfB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=pass smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b=f52Cswte; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poochiereds.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44633a67e52so3401021cf.2
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jul 2024 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1720091661; x=1720696461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRAu+HxedB5t4bbUnuCtwDTP4pSy6UOFqGrQ8rwovTE=;
        b=f52CswtewNPAiCtgJkLEOCMZwVEdIdPOcB5lduABLYnYq+OxdgFzRhh4EIgVhAdhal
         okYmdC/7i0xvS1WAuDrvG6TK45qEhWASHpm/fPA44lRcbnwivpO4P+AM/qWdramu69S7
         rKK6jWUhixaJDvfdoI7XPc5SURwXY7fZEV43JMHzR7XdwdRvXEP7ofaFxJ6WC3sDJqh5
         J8DZ5j1TixU8cFftxjXBYJriCQPR2vH+QQz2Z0/DuDDLPVJ7N3Mf5DxgrDcK07lHlHo0
         Lf8WoQKC8ku3nCOFY6WNfGhtx8tL1nhhj7w4Us9Li10Dsp3iYTaZbdYh6UfdgjCL+HXE
         K+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091661; x=1720696461;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRAu+HxedB5t4bbUnuCtwDTP4pSy6UOFqGrQ8rwovTE=;
        b=ZWTjwGb8v+prWUM+YiEMnYRoUKCUbfy6TVymIG7n0mxkY6Vgimuswbj3ueh5ccw5sP
         YNFRxRYcru1Tu/1UOZZgdIKNvY5g3ngzqjLq1rTo4NS3I5iNp5Yqs1Jx5btWTHiwAQzk
         /aQr8ANt52NjwpD3EdMIzrnUDPbGW6Vc2H23ycDVWEZYxk3hi0RbEQfUgYxtAZNNL9Y0
         atf43B5SOsnyAK4Fkrp45tUvvNmUUI82Jhfr7OICEE5fmMcD86lb+jStldP/4IngUGxP
         6kkeEXDl4UhVXUgpaPbxHZTriizyFRxzosJLcATk94XS3RyAFOJXdVI25zI359Anq/nu
         tePw==
X-Gm-Message-State: AOJu0Ywq/B8824XnaJ+Q4/P0lvI0RRdGj2ymLZFalFPRTFdvYmvg954z
	r2FwolGSLs1MN9+bqx7EV+FA/d5X7/VyGq5cYQRbeNQMYdrmBHiG+yz3vwqNWrHJggn10i6y32b
	Y
X-Google-Smtp-Source: AGHT+IEGH/W2PCBFJNcA+s0zk9ILDdyGJ28f1r4kSJ2XfugqJ1wqj2Vs4YSdRhgYuB5O+znnk9JcXg==
X-Received: by 2002:ad4:5f4b:0:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6b5ed19c404mr13913176d6.47.1720091661322;
        Thu, 04 Jul 2024 04:14:21 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5eefa7060sm2963256d6.55.2024.07.04.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:14:20 -0700 (PDT)
Message-ID: <0445d64ebcc7185bf48cc05f72ca29b859f45c26.camel@poochiereds.net>
Subject: Re: Leaked nfsd_file due to race condition and early unhash
 (fs/nfsd/filecache.c)
From: Jeff Layton <jlayton@poochiereds.net>
To: Youzhong Yang <youzhong@gmail.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 04 Jul 2024 07:14:20 -0400
In-Reply-To: <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
References: 
	<CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
	 <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
	 <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
Autocrypt: addr=jlayton@poochiereds.net; prefer-encrypt=mutual;
 keydata=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
 q/2QWqNFB6xOBr5rQ5xwl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 16:46 -0400, Youzhong Yang wrote:
> Thank you Chuck. Here are my quick answers to your comments:
>=20
> - I don't have a quick reproducer. I reproduced it by using hundreds
> of nfs clients generating +600K ops under our workload in the testing
> environment. Theoretically it should be possible to simplify the
> reproduction but I am still working on it.
>=20
> -  I understand zfs is an out-of-tree file system. That's fine. But
> this leaking can happen to any file system, and leaking is not a good
> thing no matter what file system it is.
>=20
> -  I will try to come up with a reproducer using xfs or btrfs if possible=
.
>=20
> Now back to the problem itself, here are my findings:
>=20
> - nfsd_file_put() in one thread can race with another thread doing
> garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
> nfsd_file_lru_cb()):
>=20
>   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_=
add().
>   * nfsd_file_lru_add() returns true (thus NFSD_FILE_REFERENCED bit
> set for nf->nf_flags)
>   * garbage collector kicks in, nfsd_file_lru_cb() clears REFERENCED
> bit and returns LRU_ROTATE.
>   * garbage collector kicks in again, nfsd_file_lru_cb() now
> decrements nf->nf_ref to 0, runs nfsd_file_unhash(), removes it from
> the LRU and adds to the dispose list [list_lru_isolate_move(lru,
> &nf->nf_lru, head);]
>   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it
> tries to remove the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]
>   * The 'nf' has been added to the 'dispose' list by
> nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply treats it as
> part of the LRU and removes it, which leads it to be removed from the
> 'dispose' list.
>   * At this moment, nf->nf_ref is 0, it's unhashed, and not on the
> LRU. nfsd_file_put() continues its execution [if
> (refcount_dec_and_test(&nf->nf_ref))], as nf->nf_ref is already 0, now
> bad thing happens: nf->nf_ref is set to REFCOUNT_SATURATED, and the
> 'nf' is leaked.
>=20
> To make this happen, the right timing is crucial. It can be reproduced
> by adding artifical delays in filecache.c, or hammering the nfsd with
> tons of ops.
>=20
> - Let's see how nfsd_file_put() can race with nfsd_file_cond_queue():
>   * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_=
add().
>   * nfsd_file_lru_add() sets REFERENCED bit and returns true.
>   * 'exportfs -f' or something like that triggers
> __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
>   * In nfsd_file_cond_queue(), it runs [if (!nfsd_file_unhash(nf))],
> unhash is done successfully.
>   * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now
> nf->nf_ref goes to 2.
>   * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))], it succe=
eds.
>   * nfsd_file_cond_queue() runs [if (refcount_sub_and_test(decrement,
> &nf->nf_ref))] (with "decrement" being 2), so the nf->nf_ref goes to
> 0, the 'nf' is added to the dispost list [list_add(&nf->nf_lru,
> dispose)]
>   * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it
> tries to remove the 'nf' from the LRU [if
> (!nfsd_file_lru_remove(nf))], although the 'nf' is not in the LRU, but
> it is linked in the 'dispose' list, nfsd_file_lru_remove() simply
> treats it as part of the LRU and removes it. This leads to its removal
> from the 'dispose' list!
>   * Now nf->ref is 0, unhashed. nfsd_file_put() continues its
> execution and sets nf->nf_ref to REFCOUNT_SATURATED.
>=20
> The purpose of nf->nf_lru is problematic. As you can see, it is used
> for the LRU list, and also the 'dispose' list. Adding another 'struct
> list_head' specifically for the 'dispose' list seems to be a better
> way of fixing this race condition. Either way works for me.
>=20
> Would you agree my above analysis makes sense? Thanks.
>=20

I think so. It's been a while since I've done much work in this code,
but it does sound like there is a race in the LRU handling.


Like Chuck said, the nf->nf_lru list should be safe to use for multiple
purposes, but that's only the case if we're not using that list as an
indicator.

The list_lru code does check this:

    if (!list_empty(item)) {

...so if we ever check this while it's sitting on the dispose list, it
will handle it incorrectly. It sounds like that's the root cause of the
problem you're seeing?

If so, then maybe a separate list_head for disposal would be better.

> Here is my patch with signed-off-by:
>=20
> From: Youzhong Yang <youzhong@gmail.com>
> Date: Mon, 1 Jul 2024 06:45:22 -0400
> Subject: [PATCH] nfsd: fix nfsd_file leaking due to race condition and ea=
rly
>  unhash
>=20
> Signed-off-by: Youzhong Yang <youzhong@gmail.com>
> ---
>  fs/nfsd/filecache.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 1a6d5d000b85..2323829f7208 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
>                         if (!nfsd_file_lru_remove(nf))
>                                 return;
>                 }
> +               /*
> +                * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb=
(),
> +                * it's unhashed but then removed from the dispose list,
> +                * so we need to free it.
> +                */
> +               if (refcount_read(&nf->nf_ref) =3D=3D 0 &&

A refcount_read in this path is a red flag to me. Anytime you're just
looking at the refcount without changing anything just screams out
"race condition".

In this case, what guarantee is there that this won't run afoul of the
timing? We could check this and find out it's 1 just before it goes to
0 and you check the other conditions.

Does anything prevent that?

> +                   !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> +                   list_empty(&nf->nf_lru)) {
> +                       nfsd_file_free(nf);
> +                       return;
> +               }
>         }
>         if (refcount_dec_and_test(&nf->nf_ref))
>                 nfsd_file_free(nf);
> @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> list_head *dispose)
>         int decrement =3D 1;
>=20
>         /* If we raced with someone else unhashing, ignore it */
> -       if (!nfsd_file_unhash(nf))
> +       if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
>                 return;

Same here: you're just testing for the HASHED bit, but could this also
race with someone who is setting it just after you get here. Why is
that not a problem?

>=20
>         /* If we can't get a reference, ignore it */
> @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> list_head *dispose)
>         /* If refcount goes to 0, then put on the dispose list */
>         if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
>                 list_add(&nf->nf_lru, dispose);
> +               nfsd_file_unhash(nf);
>                 trace_nfsd_file_closing(nf);
>         }
>  }
> --
> 2.43.0
>=20
> On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
> >=20
> > On Wed, Jul 03, 2024 at 10:12:33AM -0400, Youzhong Yang wrote:
> > > Hello,
> > >=20
> > > I'd like to report a nfsd_file leaking issue and propose a fix for it=
.
> > >=20
> > > When I tested Linux kernel 6.8 and 6.6, I noticed nfsd_file leaks
> > > which led to undestroyable file systems (zfs),
> >=20
> > Thanks for the report. Some initial comments:
> >=20
> > - Do you have a specific reproducer? In other words, what is the
> >   simplest program that can run on an NFS client that will trigger
> >   this leak, and can you post it?
> >=20
> > - "zfs" is an out-of-tree file system, so it's not directly
> >   supported for NFSD.
> >=20
> > - The guidelines for patch submission require us to fix issues in
> >   upstream Linux first (currently that's v6.10-rc6). Then that fix
> >   can be backported to older stable kernels like 6.6.
> >=20
> > Can you reproduce the leak with one of the in-kernel filesystems
> > (either xfs or btrfs would be great) and with NFSD in 6.10-rc6?
> >=20
> > One more comment below.
> >=20
> >=20
> > > here are some examples:
> > >=20
> > > crash> struct nfsd_file -x ffff88e160db0460
> > > struct nfsd_file {
> > >   nf_rlist =3D {
> > >     rhead =3D {
> > >       next =3D 0xffff8921fa2392f1
> > >     },
> > >     next =3D 0x0
> > >   },
> > >   nf_inode =3D 0xffff8882bc312ef8,
> > >   nf_file =3D 0xffff88e2015b1500,
> > >   nf_cred =3D 0xffff88e3ab0e7800,
> > >   nf_net =3D 0xffffffff83d41600 <init_net>,
> > >   nf_flags =3D 0x8,
> > >   nf_ref =3D {
> > >     refs =3D {
> > >       counter =3D 0xc0000000
> > >     }
> > >   },
> > >   nf_may =3D 0x4,
> > >   nf_mark =3D 0xffff88e1bddfb320,
> > >   nf_lru =3D {
> > >     next =3D 0xffff88e160db04a8,
> > >     prev =3D 0xffff88e160db04a8
> > >   },
> > >   nf_rcu =3D {
> > >     next =3D 0x10000000000,
> > >     func =3D 0x0
> > >   },
> > >   nf_birthtime =3D 0x73d22fc1728
> > > }
> > >=20
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -=
x
> > > ffff88839a53d850
> > >   nf_flags =3D 0x8,
> > >   nf_ref.refs.counter =3D 0x0
> > >   nf_lru =3D {
> > >     next =3D 0xffff88839a53d898,
> > >     prev =3D 0xffff88839a53d898
> > >   },
> > >   nf_file =3D 0xffff88810ede8700,
> > >=20
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -=
x
> > > ffff88c32b11e850
> > >   nf_flags =3D 0x8,
> > >   nf_ref.refs.counter =3D 0x0
> > >   nf_lru =3D {
> > >     next =3D 0xffff88c32b11e898,
> > >     prev =3D 0xffff88c32b11e898
> > >   },
> > >   nf_file =3D 0xffff88c20a701c00,
> > >=20
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -=
x
> > > ffff88e372709700
> > >   nf_flags =3D 0xc,
> > >   nf_ref.refs.counter =3D 0x0
> > >   nf_lru =3D {
> > >     next =3D 0xffff88e372709748,
> > >     prev =3D 0xffff88e372709748
> > >   },
> > >   nf_file =3D 0xffff88e0725e6400,
> > >=20
> > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -=
x
> > > ffff8982864944d0
> > >   nf_flags =3D 0xc,
> > >   nf_ref.refs.counter =3D 0x0
> > >   nf_lru =3D {
> > >     next =3D 0xffff898286494518,
> > >     prev =3D 0xffff898286494518
> > >   },
> > >   nf_file =3D 0xffff89803c0ff700,
> > >=20
> > > The leak occurs when nfsd_file_put() races with nfsd_file_cond_queue(=
)
> > > or nfsd_file_lru_cb(). With the following patch, I haven't observed
> > > any leak after a few days heavy nfs load:
> >=20
> > Our patch submission guidelines require a Signed-off-by:
> > line at the end of the patch description. See the "Sign your work -
> > the Developer's Certificate of Origin" section of
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6
> >=20
> > (Needed here in case your fix is acceptable).
> >=20
> >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 1a6d5d000b85..2323829f7208 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
> > >   if (!nfsd_file_lru_remove(nf))
> > >   return;
> > >   }
> > > + /*
> > > + * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb(),
> > > + * it's unhashed but then removed from the dispose list,
> > > + * so we need to free it.
> > > + */
> > > + if (refcount_read(&nf->nf_ref) =3D=3D 0 &&
> > > +     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
> > > +     list_empty(&nf->nf_lru)) {
> > > + nfsd_file_free(nf);
> > > + return;
> > > + }
> > >   }
> > >   if (refcount_dec_and_test(&nf->nf_ref))
> > >   nfsd_file_free(nf);
> > > @@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> > > list_head *dispose)
> > >   int decrement =3D 1;
> > >=20
> > >   /* If we raced with someone else unhashing, ignore it */
> > > - if (!nfsd_file_unhash(nf))
> > > + if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> > >   return;
> > >=20
> > >   /* If we can't get a reference, ignore it */
> > > @@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
> > > list_head *dispose)
> > >   /* If refcount goes to 0, then put on the dispose list */
> > >   if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
> > >   list_add(&nf->nf_lru, dispose);
> > > + nfsd_file_unhash(nf);
> > >   trace_nfsd_file_closing(nf);
> > >   }
> > >  }
> > >=20
> > > Please kindly review the patch and let me know if it makes sense.
> > >=20
> > > Thanks,
> > >=20
> > > -Youzhong
> > >=20
> >=20
> > --
> > Chuck Lever
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>

