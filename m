Return-Path: <linux-nfs+bounces-5143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB8893F831
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256851C20DC2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33C155337;
	Mon, 29 Jul 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmOCPXFI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90715533F;
	Mon, 29 Jul 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263200; cv=none; b=iW+vdDALnmf2Zs6EAb0BlpztPu9xllNkHzKPCvyj0ush9SVC6jYDEqQn4JicDFK7TOXWhldWZ70YXC48TQKiRUj84szfPedYtetgj3z8lKXSpMLkWwGXefG2hWNh0gvGMADrF779CJF3quuMNxLLQLXPYtpYeQOqxLl+EQHUY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263200; c=relaxed/simple;
	bh=NRPlar6h5MBvy+ngqC7qkbPAT+0xNeeCF1e0SEZgSsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipq+EsCx8pbBz0Ae0ALlvGa6w7lSsHkjxkMy1er8cAlpDq0YpBVvlhIZukzLV8HIMmS2P1f1M+N3kHPFkL0gvd4XuANQRKq4FqPJMKBCcKEvx95D6TcKjZEo1JLyUkoqW9tuRRlNKCgjzK6/Ock7gyw9c1dkiOZ4v0EcnYDBOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmOCPXFI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b29539d86so20648287b3.2;
        Mon, 29 Jul 2024 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722263197; x=1722867997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMyyMmYZaiANm5hsUx6iI5UmbZxJBNhJEEbJQucNA4Q=;
        b=FmOCPXFIz03BdU/PbEr0j5BjzF4UMLeoO9Q6Jm5h4RMJuKy64CpsoHGKCigenk0re0
         8SC4K3FYSQ883gcNoWXpwEanyDdzU4sHEVzEiSYn9+YLC4WZQk/jpvot7StP6iIPjvrf
         UIDGmG5Xyqm5xj7QmjqByP9dWiypWdQO2MVMsv+YUo5Jahc70vH4CyPpuQ5e3nb07+b6
         i6oaHvgwPd/rXnDklD+2NGPIaN4lPXuMYC7w0FciGMD9x9G46sOLRFM9veSxHzyZ21xX
         EMVVrSiPe7zhK9ZfbZB3oJ+gsIem6E3Smfp+qCoWMM9YZakx+L+9PbL/1FWm8sEfrmVC
         xGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263198; x=1722867998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMyyMmYZaiANm5hsUx6iI5UmbZxJBNhJEEbJQucNA4Q=;
        b=iVrRmwgA+d7f2XWQlPQzrkZIiRFjhNQbEktdNfq1JOsQwQU0u2eMeAjegbd7fnn4f9
         eC6PSyG7D+TTUBXhLg6xxeNKab5ZcuQjEyCWki9lEdIJL0L7B8qbxwdBfnqXSLKevYyU
         7+nT7PdP7IArdVNl78RoXnHA93Q7sJqorolDM2EmSJcLB98Mr6riHsRFMwLa4qM/EuvG
         DkiTzxiUi+BhEusp0djoY2T3qy2pARzVg5A8e2XAWIfTxWjBoqSr/BXThJUVbjgSuBp2
         bKUYkH0L4LW/BDknh3nV0U/YEHSKlmxxzKceIULUfpTyBKZlDx2xAPikpqb73DGZpreg
         pOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO3aMtWlDIMeMAVmr1pMG3Q/uwMLFD9wFRRb1d/SX3+TYLmGwvnD3ZnB+yWEIkyUUiNsEQMqi5+hHuYQ59/Y4YFyEpVO4CWi50Gcw5qBsBVDGsPhzFrJAB+8kXYyiBS/LCcANNtoXD
X-Gm-Message-State: AOJu0YyPgNjkTmUuU+cfC9d3JHwxr7OZYMxlP7IBDGQxoUdLk8PutXrE
	TXWOKyBd34boeYDX6reqOU+INtegmBSjZraqzL+DJjRReucp5cdDOOwaWWIT7lU+ACamNzx7H8+
	6Crm29++tPaHl06tHifKLpS0MxLI=
X-Google-Smtp-Source: AGHT+IFGXgEszlpaN3xBDlTwX2+LReL1b758AHqjOWaKdHKei8iYIfW9zFlHyAYD3wK2nyPeS9mqdK7tAjyZzjLuAZM=
X-Received: by 2002:a0d:da87:0:b0:63b:d055:6a7f with SMTP id
 00721157ae682-67a0a7fd7ddmr99727287b3.38.1722263197579; Mon, 29 Jul 2024
 07:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
 <172100324023.15471.746980048334211968@noble.neil.brown.name>
 <85dcb63bd31b962039269bef6e3791c82cef9ecb.camel@kernel.org> <ZpUsz61KzRosNNtm@tissot.1015granger.net>
In-Reply-To: <ZpUsz61KzRosNNtm@tissot.1015granger.net>
From: Youzhong Yang <youzhong@gmail.com>
Date: Mon, 29 Jul 2024 10:26:26 -0400
Message-ID: <CADpNCvYpeJ-2sRCpeAC=320SL5KrBvCRMHa+BQdN5XeWATv8BA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How is this going? any chance to move forward and deal with the EEXIST
case in a future patch? I see no harm in keeping the EEXIST check.

On Mon, Jul 15, 2024 at 10:06=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Mon, Jul 15, 2024 at 08:25:53AM -0400, Jeff Layton wrote:
> > On Mon, 2024-07-15 at 10:27 +1000, NeilBrown wrote:
> > > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > > Given that we do the search and insertion while holding the i_lock,=
 I
> > > > don't think it's possible for us to get EEXIST here. Remove this ca=
se.
> > >
> > > I was going to comment that as rhltable_insert() cannot return -EEXIS=
T
> > > that is an extra reason to discard the check.  But then I looked at t=
he
> > > code an I cannot convince myself that it cannot.
> > > If __rhashtable_insert_fast() finds that tbl->future_tbl is not NULL =
it
> > > calls rhashtable_insert_slow(), and that seems to fail if the key
> > > already exists.  But it shouldn't for an rhltable, it should just add
> > > the new item to the linked list for that key.
> > >
> > > It looks like this has always been broken: adding to an rhltable duri=
ng
> > > a resize event can cause EEXIST....
> > >
> > > Would anyone like to check my work?  I'm surprise that hasn't been
> > > noticed if it is really the case.
> > >
> > >
> >
> > I don't know this code well at all, but it looks correct to me:
> >
> > static void *rhashtable_try_insert(struct rhashtable *ht, const void *k=
ey,
> >                                    struct rhash_head *obj)
> > {
> >         struct bucket_table *new_tbl;
> >         struct bucket_table *tbl;
> >         struct rhash_lock_head __rcu **bkt;
> >         unsigned long flags;
> >         unsigned int hash;
> >         void *data;
> >
> >         new_tbl =3D rcu_dereference(ht->tbl);
> >
> >         do {
> >                 tbl =3D new_tbl;
> >                 hash =3D rht_head_hashfn(ht, tbl, obj, ht->p);
> >                 if (rcu_access_pointer(tbl->future_tbl))
> >                         /* Failure is OK */
> >                         bkt =3D rht_bucket_var(tbl, hash);
> >                 else
> >                         bkt =3D rht_bucket_insert(ht, tbl, hash);
> >                 if (bkt =3D=3D NULL) {
> >                         new_tbl =3D rht_dereference_rcu(tbl->future_tbl=
, ht);
> >                         data =3D ERR_PTR(-EAGAIN);
> >                 } else {
> >                         flags =3D rht_lock(tbl, bkt);
> >                         data =3D rhashtable_lookup_one(ht, bkt, tbl,
> >                                                      hash, key, obj);
> >                         new_tbl =3D rhashtable_insert_one(ht, bkt, tbl,
> >                                                         hash, obj, data=
);
> >                         if (PTR_ERR(new_tbl) !=3D -EEXIST)
> >                                 data =3D ERR_CAST(new_tbl);
> >
> >                         rht_unlock(tbl, bkt, flags);
> >                 }
> >         } while (!IS_ERR_OR_NULL(new_tbl));
> >
> >         if (PTR_ERR(data) =3D=3D -EAGAIN)
> >                 data =3D ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
> >                                -EAGAIN);
> >
> >         return data;
> > }
> >
> > I'm assuming the part we need to worry about is where
> > rhashtable_insert_one returns -EEXIST.
> >
> > It holds the rht_lock across the lookup and insert though. So if
> > rhashtable_insert_one returns -EEXIST, then "data" must be something
> > valid. In that case, "data" won't be overwritten and it will fall
> > through and return the pointer to the entry already there.
> >
> > That said, this logic is really convoluted, so I may have missed
> > something too.
>
> This is the issue I was concerned about after my review: it's
> obvious that the rhtable API can return -EEXIST, but it's just
> really hard to tell whether the rh/l/table API will ever return
> -EEXIST.
>
> As Neil says, the rhtable "hash table full" case should not happen
> with rhltable. But can we prove that?
>
> If we are not yet confident, then maybe PATCH 1/3 should replace
> the "if (ret =3D=3D -EEXIST)" with "WARN_ON(ret =3D=3D -EEXIST)"...? It's
> also possible to ask the human(s) who constructed the rhltable
> code. :-)
>
>
> > > > Cc: Youzhong Yang <youzhong@gmail.com>
> > > > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease =
break error")
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > This is replacement for PATCH 1/3 in the series I sent yesterday. I
> > > > think it makes sense to just eliminate this case.
> > > > ---
> > > >  fs/nfsd/filecache.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index f84913691b78..b9dc7c22242c 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > >   if (likely(ret =3D=3D 0))
> > > >           goto open_file;
> > > >
> > > > - if (ret =3D=3D -EEXIST)
> > > > -         goto retry;
> > > >   trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> > > >   status =3D nfserr_jukebox;
> > > >   goto construction_err;
> > > >
> > > > ---
> > > > base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> > > > change-id: 20240711-nfsd-next-c9d17f66e2bd
> > > >
> > > > Best regards,
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > > >
> > > >
> > >
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
>
> --
> Chuck Lever

