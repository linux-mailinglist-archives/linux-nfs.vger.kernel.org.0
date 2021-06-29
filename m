Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155253B7000
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhF2JUJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 05:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232568AbhF2JUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 05:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624958261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeaEkC80+sDqgiyI3aBepHF61whJhsx3ssDXpUOLfYA=;
        b=TPRdccQQgx+ivwc7povyqvpx0DEFY2PvdwkSn6ulAtGLLhR2r+rVcoP4V9xDSsvJpAeGlF
        VDzqBNN9cCZP5hFv0DchXuIIG9bblUnBhNfgJw0OtzUwXVMU3uFjO8bZcHS5jaRpitBWFR
        +NkQI/TIYenvJL3fs/QaNWJmez3yCdI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-f1Bj74_2PgObK1Gcg2pG7w-1; Tue, 29 Jun 2021 05:17:39 -0400
X-MC-Unique: f1Bj74_2PgObK1Gcg2pG7w-1
Received: by mail-ej1-f71.google.com with SMTP id d21-20020a1709063455b02904c609ed19f1so1309889ejb.11
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 02:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeaEkC80+sDqgiyI3aBepHF61whJhsx3ssDXpUOLfYA=;
        b=jP0e2FvZG1wJ7t3AKj/OPbG1+ZV/B2/VZgJ7W1YtqXllOqkDr/sqoxememDHIneWIk
         WmudNCquLnPZnLbRoN10SUDgVShN+XFxSm/TFOrTZn3Zi2VKAf5oaGw/FnxkWb05aZkw
         KLgwo95rR531Bic4eifhJaLPPHbUDTHvd+/99NjTdN9aeQ7SuUP2Cyiza5bMCMOkshFW
         hIxeh4QjGJ0Ncgb7sjpQjhjhbtd53FB30TZri8YvNEWUT6TxMujHurFi7vGfic7R7PLL
         33efuusNlxtkK3y+dv1f8Cs+2We/4Yy0K4723wh8vYmGMtV01bFYO9ITBoB4aSY+LAsi
         L6rw==
X-Gm-Message-State: AOAM530c3XicgV/7c6RvglKSU4tCkK/4t2iJftVMBx2wWFc1ViGtMVKj
        Vm8YeoTI7NSqVpMqYcKoP7FqMeTaLIq3PragJ/kCZGg08vEupi/gGqY5OYIK9EIO9T8gBzGJjwi
        KlvSy+WnWRIyXO28I9UZLU+JYiZW2RhIBR0ly
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr14351895edb.363.1624958258295;
        Tue, 29 Jun 2021 02:17:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0TC6VH9s/smJ06F5oHd2Mx4xVfAFFOLmYTq3zYNKr0C+z7dAfLITjxvQM5r/CxjkJ1GaD+oYUUeZLAKbPh2E=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr14351876edb.363.1624958258080;
 Tue, 29 Jun 2021 02:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-5-git-send-email-dwysocha@redhat.com> <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
 <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
 <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
 <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com> <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
In-Reply-To: <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 29 Jun 2021 05:17:01 -0400
Message-ID: <CALF+zOn=p6wuZ_pdifwWtLOUsiArkxBHHVDEnYcxsBdQy1LtVw@mail.gmail.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 8:39 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-06-28 at 19:46 -0400, David Wysochanski wrote:
> > On Mon, Jun 28, 2021 at 5:59 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2021-06-28 at 17:12 -0400, David Wysochanski wrote:
> > > > On Mon, Jun 28, 2021 at 3:09 PM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski wrote:
> > > > > > Earlier commits refactored some NFS read code and removed
> > > > > > nfs_readpage_async(), but neglected to properly fixup
> > > > > > nfs_readpage_from_fscache_complete().  The code path is
> > > > > > only hit when something unusual occurs with the cachefiles
> > > > > > backing filesystem, such as an IO error or while a cookie
> > > > > > is being invalidated.
> > > > > >
> > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > ---
> > > > > >  fs/nfs/fscache.c | 14 ++++++++++++--
> > > > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > > > > > index c4c021c6ebbd..d308cb7e1dd4 100644
> > > > > > --- a/fs/nfs/fscache.c
> > > > > > +++ b/fs/nfs/fscache.c
> > > > > > @@ -381,15 +381,25 @@ static void
> > > > > > nfs_readpage_from_fscache_complete(struct page *page,
> > > > > >                                                void *context,
> > > > > >                                                int error)
> > > > > >  {
> > > > > > +       struct nfs_readdesc desc;
> > > > > > +       struct inode *inode = page->mapping->host;
> > > > > > +
> > > > > >         dfprintk(FSCACHE,
> > > > > >                  "NFS: readpage_from_fscache_complete
> > > > > > (0x%p/0x%p/%d)\n",
> > > > > >                  page, context, error);
> > > > > >
> > > > > > -       /* if the read completes with an error, we just
> > > > > > unlock
> > > > > > the
> > > > > > page and let
> > > > > > -        * the VM reissue the readpage */
> > > > > >         if (!error) {
> > > > > >                 SetPageUptodate(page);
> > > > > >                 unlock_page(page);
> > > > > > +       } else {
> > > > > > +               desc.ctx = context;
> > > > > > +               nfs_pageio_init_read(&desc.pgio, inode,
> > > > > > false,
> > > > > > +
> > > > > > &nfs_async_read_completion_ops);
> > > > > > +               error = readpage_async_filler(&desc, page);
> > > > > > +               if (error)
> > > > > > +                       return;
> > > > >
> > > > > This code path can clearly fail too. Why can we not fix this
> > > > > code
> > > > > to
> > > > > allow it to return that reported error so that we can handle
> > > > > the
> > > > > failure case in nfs_readpage() instead of dead-ending here?
> > > > >
> > > >
> > > > Maybe the below patch is what you had in mind?  That way if
> > > > fscache
> > > > is enabled, nfs_readpage() should behave the same way as if it's
> > > > not,
> > > > for the case where an IO error occurs in the NFS read completion
> > > > path.
> > > >
> > > > If we call into fscache and we get back that the IO has been
> > > > submitted,
> > > > wait until it is completed, so we'll catch any IO errors in the
> > > > read
> > > > completion
> > > > path.  This does not solve the "catch the internal errors", IOW,
> > > > the
> > > > ones that show up as pg_error, that will probably require copying
> > > > pg_error into nfs_open_context.error field.
> > > >
> > > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > > index 78b9181e94ba..28e3318080e0 100644
> > > > --- a/fs/nfs/read.c
> > > > +++ b/fs/nfs/read.c
> > > > @@ -357,13 +357,13 @@ int nfs_readpage(struct file *file, struct
> > > > page
> > > > *page)
> > > >         } else
> > > >                 desc.ctx =
> > > > get_nfs_open_context(nfs_file_open_context(file));
> > > >
> > > > +       xchg(&desc.ctx->error, 0);
> > > >         if (!IS_SYNC(inode)) {
> > > >                 ret = nfs_readpage_from_fscache(desc.ctx, inode,
> > > > page);
> > > >                 if (ret == 0)
> > > > -                       goto out;
> > > > +                       goto out_wait;
> > > >         }
> > > >
> > > > -       xchg(&desc.ctx->error, 0);
> > > >         nfs_pageio_init_read(&desc.pgio, inode, false,
> > > >                              &nfs_async_read_completion_ops);
> > > >
> > > > @@ -373,6 +373,7 @@ int nfs_readpage(struct file *file, struct
> > > > page
> > > > *page)
> > > >
> > > >         nfs_pageio_complete_read(&desc.pgio);
> > > >         ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
> > > > +out_wait:
> > > >         if (!ret) {
> > > >                 ret = wait_on_page_locked_killable(page);
> > > >                 if (!PageUptodate(page) && !ret)
> > > >
> > > >
> > > >
> > > >
> > > > > > +
> > > > > > +               nfs_pageio_complete_read(&desc.pgio);
> > > > > >         }
> > > > > >  }
> > > > > >
> > > > >
> > > > > --
> > > > > Trond Myklebust
> > > > > Linux NFS client maintainer, Hammerspace
> > > > > trond.myklebust@hammerspace.com
> > > > >
> > > > >
> > > >
> > >
> > > Yes, please. This avoids that duplication of NFS read code in the
> > > fscache layer.
> > >
> >
> > If you mean patch 4 we still need that - I don't see anyway to
> > avoid it.  The above just will make the fscache enabled
> > path waits for the IO to complete, same as the non-fscache case.
> >
>
> With the above, you can simplify patch 4/4 to just make the page unlock
> unconditional on the error, no?
>
> i.e.
>         if (!error)
>                 SetPageUptodate(page);
>         unlock_page(page);
>
> End result: the client just does the same check as before and let's the
> vfs/mm decide based on the status of the PG_uptodate flag what to do
> next. I'm assuming that a retry won't cause fscache to do another bio
> attempt?
>

Yes I think you're right and I'm following - let me test it and I'll send a v2.
Then we can drop patch #3 right?

