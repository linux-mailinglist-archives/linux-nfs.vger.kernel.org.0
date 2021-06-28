Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E03B6B94
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhF1X4j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 19:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhF1X4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 19:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624924451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/zEkYOMPYIlTK754hTONEsqYnD9PSlePB9HxTGxyxg=;
        b=KWWJpj6gyYXk5OvItIWCB5JJuYIuTtjeHE9xuxR/XF8ctPvg/aTCxa0G4EbuZzwMJaLiJj
        pF7oFI5XB28gaNqX5QMghCQh64jeqZvfZMYv+iP3SfMbepwVyWJ6QJA2vv3anVwl2TQm5I
        dHC9dsZYSTSzReaaCg/vceCs/3N+O9Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-oe_UizH3M7GC_JuTlCknrA-1; Mon, 28 Jun 2021 19:54:10 -0400
X-MC-Unique: oe_UizH3M7GC_JuTlCknrA-1
Received: by mail-lf1-f69.google.com with SMTP id j27-20020ac2551b0000b02903185ffe0984so4482144lfk.20
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 16:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/zEkYOMPYIlTK754hTONEsqYnD9PSlePB9HxTGxyxg=;
        b=RC6xL5herQUd7cRvPBklMg2wIlhCXWa65l3gJd0AeK4Rq5qeDozDD04blmHOTFPLow
         HlaXKiTMOPj9ojeAK4JWPGv4GourVPNq6qNOFfkFg7nUg59tqroNyhuyvJvk94ztwakd
         try36Nwfsrgib2p0NV0fBRnal7C9L/42KgXT8uaHu08oo8ZJ31/6EvWwBC8kM2HixDty
         FwLsINdBgqFMi6+1yZVUHAL/PupPKYA5Z1eVWMAD9AVX1M2F9tGONvOtQsA3FQBK9Eix
         Uhcu5EtDQfA50kdxnHRvwnWRSQBT2MDo9vl3Uq8bDmvBahNHMRQtjbo51dKFSYcMBzdb
         eVFA==
X-Gm-Message-State: AOAM5302Cm13HL/Qj/YG8Ws1xQ3tvtiaacsVSOUzaQ518GloP4wG8cwH
        u/N/9LCf7eoD3/hvW5deXf+CPIB++EBLlMfKMQQv2VM34sJxZzDc49ukKGHFaM/bAFP/1Yfr6u+
        A84HhP81UTJV5qIKpfKj91dnADZyLEYeo5FqB
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr26809848ejw.46.1624924009746;
        Mon, 28 Jun 2021 16:46:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoPZNrHCev2xtRF05TMRVlh3ioen35eDBLEcgS6qx06T8ZOL6+6iAX4mECHukwJr9zoDkxVt7TR6Wa2fCEDAw=
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr26809836ejw.46.1624924009564;
 Mon, 28 Jun 2021 16:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-5-git-send-email-dwysocha@redhat.com> <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
 <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com> <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
In-Reply-To: <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 28 Jun 2021 19:46:12 -0400
Message-ID: <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 5:59 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-06-28 at 17:12 -0400, David Wysochanski wrote:
> > On Mon, Jun 28, 2021 at 3:09 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski wrote:
> > > > Earlier commits refactored some NFS read code and removed
> > > > nfs_readpage_async(), but neglected to properly fixup
> > > > nfs_readpage_from_fscache_complete().  The code path is
> > > > only hit when something unusual occurs with the cachefiles
> > > > backing filesystem, such as an IO error or while a cookie
> > > > is being invalidated.
> > > >
> > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > ---
> > > >  fs/nfs/fscache.c | 14 ++++++++++++--
> > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > > > index c4c021c6ebbd..d308cb7e1dd4 100644
> > > > --- a/fs/nfs/fscache.c
> > > > +++ b/fs/nfs/fscache.c
> > > > @@ -381,15 +381,25 @@ static void
> > > > nfs_readpage_from_fscache_complete(struct page *page,
> > > >                                                void *context,
> > > >                                                int error)
> > > >  {
> > > > +       struct nfs_readdesc desc;
> > > > +       struct inode *inode = page->mapping->host;
> > > > +
> > > >         dfprintk(FSCACHE,
> > > >                  "NFS: readpage_from_fscache_complete
> > > > (0x%p/0x%p/%d)\n",
> > > >                  page, context, error);
> > > >
> > > > -       /* if the read completes with an error, we just unlock
> > > > the
> > > > page and let
> > > > -        * the VM reissue the readpage */
> > > >         if (!error) {
> > > >                 SetPageUptodate(page);
> > > >                 unlock_page(page);
> > > > +       } else {
> > > > +               desc.ctx = context;
> > > > +               nfs_pageio_init_read(&desc.pgio, inode, false,
> > > > +
> > > > &nfs_async_read_completion_ops);
> > > > +               error = readpage_async_filler(&desc, page);
> > > > +               if (error)
> > > > +                       return;
> > >
> > > This code path can clearly fail too. Why can we not fix this code
> > > to
> > > allow it to return that reported error so that we can handle the
> > > failure case in nfs_readpage() instead of dead-ending here?
> > >
> >
> > Maybe the below patch is what you had in mind?  That way if fscache
> > is enabled, nfs_readpage() should behave the same way as if it's not,
> > for the case where an IO error occurs in the NFS read completion
> > path.
> >
> > If we call into fscache and we get back that the IO has been
> > submitted,
> > wait until it is completed, so we'll catch any IO errors in the read
> > completion
> > path.  This does not solve the "catch the internal errors", IOW, the
> > ones that show up as pg_error, that will probably require copying
> > pg_error into nfs_open_context.error field.
> >
> > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > index 78b9181e94ba..28e3318080e0 100644
> > --- a/fs/nfs/read.c
> > +++ b/fs/nfs/read.c
> > @@ -357,13 +357,13 @@ int nfs_readpage(struct file *file, struct page
> > *page)
> >         } else
> >                 desc.ctx =
> > get_nfs_open_context(nfs_file_open_context(file));
> >
> > +       xchg(&desc.ctx->error, 0);
> >         if (!IS_SYNC(inode)) {
> >                 ret = nfs_readpage_from_fscache(desc.ctx, inode,
> > page);
> >                 if (ret == 0)
> > -                       goto out;
> > +                       goto out_wait;
> >         }
> >
> > -       xchg(&desc.ctx->error, 0);
> >         nfs_pageio_init_read(&desc.pgio, inode, false,
> >                              &nfs_async_read_completion_ops);
> >
> > @@ -373,6 +373,7 @@ int nfs_readpage(struct file *file, struct page
> > *page)
> >
> >         nfs_pageio_complete_read(&desc.pgio);
> >         ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
> > +out_wait:
> >         if (!ret) {
> >                 ret = wait_on_page_locked_killable(page);
> >                 if (!PageUptodate(page) && !ret)
> >
> >
> >
> >
> > > > +
> > > > +               nfs_pageio_complete_read(&desc.pgio);
> > > >         }
> > > >  }
> > > >
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> >
>
> Yes, please. This avoids that duplication of NFS read code in the
> fscache layer.
>

If you mean patch 4 we still need that - I don't see anyway to
avoid it.  The above just will make the fscache enabled
path waits for the IO to complete, same as the non-fscache case.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

