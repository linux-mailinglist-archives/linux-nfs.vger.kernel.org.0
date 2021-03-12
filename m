Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98D3391A5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhCLPoG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 10:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhCLPn7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 10:43:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1DC061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 07:43:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k16so672235ejx.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1kUnnL0O4N2cXdE1HqPvJg6HjXrUtNq/T/BfMnv3aA=;
        b=K0nf8gQ2nre0A6/R/UJbQCXVTZRS7vnxZFkf6fdlQvK4uFSPa7j3Hjiv4mRJ1iYH4f
         A+nV7ui31Ujw8fXpqfNpoBP6312nwpmV4PbNR/Ah4fqrDwZff5tN0f64b7i2Y1TO9W8l
         fXuloNzF2mEP1i/sMOWdjbVpapt8JS4z6aI81QEOLsU9GkGqoCwGGqN2s0VsUUgGIcQo
         h3Mk9fa+nEmkZX8hdeVss55hPdya29LlNFZq1RUCkpYzk73+afFf3/Ql1djOSUB2XdDq
         PWkD/LsUUiiIdOhthEowiF9RGIrvuaVGQlTGO8maIYHPb4LhXsdlsdGHrR25zrq0pU4l
         x0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1kUnnL0O4N2cXdE1HqPvJg6HjXrUtNq/T/BfMnv3aA=;
        b=C7ldjbbDxZpIkAYjQBNOgVTfX+OXYPSemeUjCNJe+Mw+vDzhvKrZ5HeT7d1lJ1hCOH
         VAuXHTLT/vZQITjxXMX5oycQ6ljE9bpxs1DixS8cQ5KzH/VdtB3tZrmdLO7/q0PmMZGB
         t5qTq95qDlO7GOkJsHIZEQr6LbmtrBkt9QKoYYw5Ur5UpWzVa/3iNDSP2H4wTtSTeyqm
         Pag1xvxjwZ2QY+v3cT3bNeQ9NLsrdaKYpVfZG3+1cAwN42LwRx3+xiu/3iavX8Bvv2Za
         +Rw9rlHUpZxq5dwPY4hKQLmQE18JPVA0MOYqNE48ZLljHol/GNpT9cgWYIs142UgYarp
         Bz+Q==
X-Gm-Message-State: AOAM533G8sDIdAMKXwHzrsvOTcHewnoaoRBAG0Vnn332EZnjVEIvQdMD
        7rAi1O2ADO+B3v8x+Q47wYAGRbXUzyPEvDkI+pE=
X-Google-Smtp-Source: ABdhPJyFVwr9UPFmJgCxzZ0FSTgABoIxlyVRSXfOiI2+qHdWtWFGXb0Y4jUj8d9JlLOox0N+UpKjGD157NBKw4za+84=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr9308725eju.439.1615563837727;
 Fri, 12 Mar 2021 07:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20210128223638.GE29887@fieldses.org> <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
 <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
 <20210129023527.GA11864@fieldses.org> <20210129025041.GA12151@fieldses.org>
 <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
 <20210131215843.GA9273@fieldses.org> <20210203200756.GA30996@fieldses.org>
 <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
 <20210208220855.GA15116@fieldses.org> <20210211185444.GA6048@fieldses.org> <CADJHv_vH5Ocf8D4hXNSKc4PcdwJWCeXe+nvwiOqRWVQ7HOoNfg@mail.gmail.com>
In-Reply-To: <CADJHv_vH5Ocf8D4hXNSKc4PcdwJWCeXe+nvwiOqRWVQ7HOoNfg@mail.gmail.com>
From:   Anna Schumaker <schumakeranna@gmail.com>
Date:   Fri, 12 Mar 2021 10:43:41 -0500
Message-ID: <CAFX2JfnH1JWBWS5zm03mnvHDAfMAqmNKCH9fsjWu2u8sGvGO1g@mail.gmail.com>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "guy@vastdata.com" <guy@vastdata.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Murphy,

On Wed, Mar 3, 2021 at 9:30 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Hi,
>
> On Fri, Feb 12, 2021 at 2:58 AM bfields@fieldses.org
> <bfields@fieldses.org> wrote:
> >
> > From: "J. Bruce Fields" <bfields@redhat.com>
> >
> > The contents of the system.nfs4_acl xattr are literally just the
> > xdr-encoded ACL attribute.  That attribute starts with a 4-byte integer
> > representing the number of ACEs in the ACL.  So even a zero-ACE ACL will
> > be at least 4 bytes.
> >
> > We've never actually bothered to sanity-check the ACL encoding that
> > userspace gives us.  The only problem that causes is that we return an
> > error that's probably wrong.  (The server will return BADXDR, which
> > we'll translate to EIO, when EINVAL would make more sense.)
> >
> > It's not much a problem in practice since the standard utilities give us
> > well-formed XDR.  The one case we're likely to see from userspace in
> > practice is a set of a zero-length xattr since that's how
> >
> >         removexattr(path, "system.nfs4_acl")
> >
> > is implemented.  It's worth trying to give a better error for that case.
> >
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfs/nfs4proc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > On Mon, Feb 08, 2021 at 05:08:55PM -0500, bfields@fieldses.org wrote:
> > > On Mon, Feb 08, 2021 at 07:31:38PM +0000, Trond Myklebust wrote:
> > > > OK. So you're not really saying that the SETATTR has a zero length
> > > > body, but that the ACL attribute in this case has a zero length body,
> > > > whereas in the 'empty acl' case, it is supposed to have a body
> > > > containing a zero-length nfsace4<> array. Fair enough.
> > >
> > > Yep!  I'll see if I can think of a helpful concise comment, and resend.
> >
> > Oops, forgot about this, here you go.--b.
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 2f4679a62712..86e87f7d7686 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -5895,6 +5895,12 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
> >         unsigned int npages = DIV_ROUND_UP(buflen, PAGE_SIZE);
> >         int ret, i;
> >
> > +       /*
> > +        * We don't support removing system.nfs4_acl, and even a
> > +        * 0-length ACL needs at least 4 bytes for the number of ACEs:
> > +        */
> > +       if (buflen < 4)
> > +               return -EINVAL;
> >         if (!nfs4_server_supports_acls(server))
> >                 return -EOPNOTSUPP;
> >         if (npages > ARRAY_SIZE(pages))
> > --
> > 2.29.2
> >
>
> Has this queued up for the next RC ?

Yeah, I have this queued up for the next bugfixes pull request.

Anna
>
>
> Thanks,
