Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C624D652597
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiLTRcd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiLTRcb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 12:32:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AC31F1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 09:32:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so12850653pjo.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8R2Un6W7DOVCXkGS0VT8n5+oRZ0GUYeJ8zH8/294qk=;
        b=LJpa6bXOpjACHeshqKaGF03M6VDpja59ATvzeHdQjmeXWMOinpIv6nJwMk5mgRoy0m
         qo+dusijbuvBhparfbw1t5ZYfs0wJebtXEsuERW4JT0equWwu/n+58m+5P1eqbKH8SmH
         3iWRDl03tYAv3iewMKfEjBfv9wGLY8uSz8HEaBTElR/dl/w0BrIbTcltlOO2Isvr1wFG
         UT/lpWE7uRRhfl/i+KhoCxojrJlHfS6cHUxHrwQYVub01NHbBY+1C3xkuw3CQRxNdq3J
         wknNWobszU2H90oI5/bis2+mxG9iwrBc4rNQ5wwZ5XOKnJD/DkVo/LxwZF4BRd+X+igL
         gWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8R2Un6W7DOVCXkGS0VT8n5+oRZ0GUYeJ8zH8/294qk=;
        b=t+aZAwwiRvylaB1dsAra9xapTWg8IzK0TVsUP1y5sdkjsGYv4qdb7ZvwR1669BV0o9
         c7KOX2eJHkXFBDavY5rohnYmvm781dOz8eKBFqAUxdNjUqG2bbVC8mNh8cLURCMLZAi6
         Fl0+n0CUDaxz5/pTVAia73tqJbXiUWwsBtA76Ort71AAdkCw9xaDU8PPonZLXpH6yOLY
         3YT9KPt0zq9bEkdk701/p9rff4974lL2Fjo8Fxs655pacbQ5fXTEYj6Jd+OXXNlj6uCz
         7IcNSTgdgioDkYDM4YJCbQ3YouQVaYEN23B6knzFcA7vrOo6hSKvNVh7L9b3FM6YBoAv
         MWHQ==
X-Gm-Message-State: ANoB5pk0VI+KoC6K3eZ7mwOb4HkEYWcwN37lGB04sGgBJH7cKOjX6NaD
        c1SZPLyX8kd2o9uudhsPkbXOITAAwzDexSkTdpE=
X-Google-Smtp-Source: AA0mqf47m9kf1xaY8VLtEla6owYF4fZvGvYPwWTGqYKBo1btAA6ICkzMhN+WW6zvKTAbMPvf22/FoIGYmSR2yVFzdVA=
X-Received: by 2002:a17:902:f391:b0:189:7f09:13ca with SMTP id
 f17-20020a170902f39100b001897f0913camr59142433ple.113.1671557549767; Tue, 20
 Dec 2022 09:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20221220162912.95886-1-olga.kornievskaia@gmail.com> <F9BC16CC-E33F-4C1C-8A41-BD451CAE795E@hammerspace.com>
In-Reply-To: <F9BC16CC-E33F-4C1C-8A41-BD451CAE795E@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 20 Dec 2022 12:32:18 -0500
Message-ID: <CAN-5tyHWyJi+r6+Ks1qB1EzuacwgBRMSt21SZL1N5r38KoBhdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pNFS/filelayout: Fix coalescing test for single DS
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 20, 2022 at 11:37 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
>
>
> > On Dec 20, 2022, at 11:29, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
> >
> > When there is a single DS no striping constraints need to be placed on
> > the IO. When such constraint is applied then buffered reads don't
> > coalesce to the DS's rsize.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/filelayout/filelayout.c    | 2 ++
> > fs/nfs/filelayout/filelayout.h    | 1 +
> > fs/nfs/filelayout/filelayoutdev.c | 4 +++-
> > 3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelay=
out.c
> > index ad34a33b0737..cd819b795935 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -803,6 +803,8 @@ filelayout_pg_test(struct nfs_pageio_descriptor *pg=
io, struct nfs_page *prev,
> > size =3D pnfs_generic_pg_test(pgio, prev, req);
> > if (!size)
> > return 0;
> > + else if (FILELAYOUT_LSEG(pgio->pg_lseg)->single_ds)
> > + return size;
>
> Hmm=E2=80=A6 Instead of adding the boolean, perhaps just add a helper fun=
ction
>
> static bool filelayout_lseg_is_striped(const struct nfs4_filelayout_segme=
nt *flseg)
> {
>         return flseg->num_fh > 1;
> }
>
> that can be called here?

Thank you. v2 is on the way.

>
> >
> > /* see if req and prev are in the same stripe */
> > if (prev) {
> > diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelay=
out.h
> > index aed0748fd6ec..524920c2cbf8 100644
> > --- a/fs/nfs/filelayout/filelayout.h
> > +++ b/fs/nfs/filelayout/filelayout.h
> > @@ -65,6 +65,7 @@ struct nfs4_filelayout_segment {
> > struct nfs4_file_layout_dsaddr *dsaddr; /* Point to GETDEVINFO data */
> > unsigned int num_fh;
> > struct nfs_fh **fh_array;
> > + bool single_ds;
> > };
> >
> > struct nfs4_filelayout {
> > diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/file=
layoutdev.c
> > index acf4b88889dc..95ebbe9e7ed4 100644
> > --- a/fs/nfs/filelayout/filelayoutdev.c
> > +++ b/fs/nfs/filelayout/filelayoutdev.c
> > @@ -243,8 +243,10 @@ nfs4_fl_select_ds_fh(struct pnfs_layout_segment *l=
seg, u32 j)
> > u32 i;
> >
> > if (flseg->stripe_type =3D=3D STRIPE_SPARSE) {
> > - if (flseg->num_fh =3D=3D 1)
> > + if (flseg->num_fh =3D=3D 1) {
> > + flseg->single_ds =3D true;
> > i =3D 0;
> > + }
> > else if (flseg->num_fh =3D=3D 0)
> > /* Use the MDS OPEN fh set in nfs_read_rpcsetup */
> > return NULL;
> > --
> > 2.31.1
> >
>
>
>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
