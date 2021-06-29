Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08383B7551
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhF2PcY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 11:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234991AbhF2PcQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 11:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624980587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxhRbKks03jKTbABcCi09hV86OxPARBYNAJHjk2PBZk=;
        b=NGW88zX2UWqMntEXnsEoMNchTk1YW5v9tEb6CK9mTd01TgpF8Mks9gm12uKCkqo3zus2u1
        jJemOdvQNDUXnq02TC/KVYXCY37uQP7aaXjjTY9VBTNUDQq2qCI1gym4j3R8oABYEHmzWp
        0yy5jmnMqq8gBu3WZk8SQwILADn2xXY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-GVW0fjHdNdGD35DE3TAInw-1; Tue, 29 Jun 2021 11:29:46 -0400
X-MC-Unique: GVW0fjHdNdGD35DE3TAInw-1
Received: by mail-ej1-f69.google.com with SMTP id d21-20020a1709063455b02904c609ed19f1so1725744ejb.11
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 08:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxhRbKks03jKTbABcCi09hV86OxPARBYNAJHjk2PBZk=;
        b=sToFMhNs1MAkjgdsCr9mS9mEX1riesekEewtr4g6cxX0Hz4bkxI6MxU6mu3DfIEm46
         c9xIw1JUmREpFgpfbS4WlxI7hZYnvJw9bcmWUKGbZT3zCs+XpwQhcu9R/yX0jpAIeyqU
         tC/0CxsnuchQ0VXksdFEOpPrqqdGFwV7wu3wr2+rlb7/GcWcHKjaTV67r67llDiQnE/V
         +OSg0y3zxSlechcuIAamk4QeH3cV8TBNi475YKcUVZdGcxfiFoUGu2wiDliaFpdjFnd3
         XBpB/vxknqZQR4S6UV11VIkSWD0bwOiNAVm0fin9zoutwmg2zs+jKuRyBk7Gzczv6j5Y
         B3Tw==
X-Gm-Message-State: AOAM532uiAqx4Uoi2rSbx0BGII7s5pMKBS9tqRFtpmMy17s5b5VtMwZ9
        8tMvN7Q2cF4nghQ174aDXk5GhAyeMLIfr4Z1lFImCg3wLDMB7Pm+KPzZoAsqocvwyhBtXkWlIfK
        n9isBVRyO8ROnQug74myswnTExofA8S6Cu/gt
X-Received: by 2002:a17:906:5d11:: with SMTP id g17mr29722021ejt.537.1624980584899;
        Tue, 29 Jun 2021 08:29:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUUSvhX0P3kyUKyUHv027pzWhxcEnV6Tz9ociED7ucutxSOFNKWbJLNV1y2EvLoODD+V9wB5xSoKa2JfoBJWg=
X-Received: by 2002:a17:906:5d11:: with SMTP id g17mr29722003ejt.537.1624980584663;
 Tue, 29 Jun 2021 08:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-5-git-send-email-dwysocha@redhat.com> <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
 <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
 <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
 <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
 <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
 <CALF+zOn=p6wuZ_pdifwWtLOUsiArkxBHHVDEnYcxsBdQy1LtVw@mail.gmail.com>
 <321b6e11718979668b5ab129a7048a511a9886a9.camel@hammerspace.com>
 <CALF+zOn5QiKTpngHB0Lv-pBNPa4R8t5+snbo49hKDAP3gcOx0w@mail.gmail.com> <267a770477273ba7400973ed162f040eec763e74.camel@hammerspace.com>
In-Reply-To: <267a770477273ba7400973ed162f040eec763e74.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 29 Jun 2021 11:29:08 -0400
Message-ID: <CALF+zOkEQSKbUrmUMn8Bna3WGw1Qm3a0aoz+4XG7=TYsjbfsgg@mail.gmail.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 10:54 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-29 at 09:20 -0400, David Wysochanski wrote:
> > On Tue, Jun 29, 2021 at 8:46 AM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2021-06-29 at 05:17 -0400, David Wysochanski wrote:
> > > > On Mon, Jun 28, 2021 at 8:39 PM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2021-06-28 at 19:46 -0400, David Wysochanski wrote:
> > > > > > On Mon, Jun 28, 2021 at 5:59 PM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >
> > > > > > > On Mon, 2021-06-28 at 17:12 -0400, David Wysochanski wrote:
> > > > > > > > On Mon, Jun 28, 2021 at 3:09 PM Trond Myklebust
> > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski
> > > > > > > > > wrote:
> > > > > > > > > > Earlier commits refactored some NFS read code and
> > > > > > > > > > removed
> > > > > > > > > > nfs_readpage_async(), but neglected to properly fixup
> > > > > > > > > > nfs_readpage_from_fscache_complete().  The code path
> > > > > > > > > > is
> > > > > > > > > > only hit when something unusual occurs with the
> > > > > > > > > > cachefiles
> > > > > > > > > > backing filesystem, such as an IO error or while a
> > > > > > > > > > cookie
> > > > > > > > > > is being invalidated.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  fs/nfs/fscache.c | 14 ++++++++++++--
> > > > > > > > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > > > > > > > > > index c4c021c6ebbd..d308cb7e1dd4 100644
> > > > > > > > > > --- a/fs/nfs/fscache.c
> > > > > > > > > > +++ b/fs/nfs/fscache.c
> > > > > > > > > > @@ -381,15 +381,25 @@ static void
> > > > > > > > > > nfs_readpage_from_fscache_complete(struct page *page,
> > > > > > > > > >                                                void
> > > > > > > > > > *context,
> > > > > > > > > >                                                int
> > > > > > > > > > error)
> > > > > > > > > >  {
> > > > > > > > > > +       struct nfs_readdesc desc;
> > > > > > > > > > +       struct inode *inode = page->mapping->host;
> > > > > > > > > > +
> > > > > > > > > >         dfprintk(FSCACHE,
> > > > > > > > > >                  "NFS: readpage_from_fscache_complete
> > > > > > > > > > (0x%p/0x%p/%d)\n",
> > > > > > > > > >                  page, context, error);
> > > > > > > > > >
> > > > > > > > > > -       /* if the read completes with an error, we
> > > > > > > > > > just
> > > > > > > > > > unlock
> > > > > > > > > > the
> > > > > > > > > > page and let
> > > > > > > > > > -        * the VM reissue the readpage */
> > > > > > > > > >         if (!error) {
> > > > > > > > > >                 SetPageUptodate(page);
> > > > > > > > > >                 unlock_page(page);
> > > > > > > > > > +       } else {
> > > > > > > > > > +               desc.ctx = context;
> > > > > > > > > > +               nfs_pageio_init_read(&desc.pgio,
> > > > > > > > > > inode,
> > > > > > > > > > false,
> > > > > > > > > > +
> > > > > > > > > > &nfs_async_read_completion_ops);
> > > > > > > > > > +               error = readpage_async_filler(&desc,
> > > > > > > > > > page);
> > > > > > > > > > +               if (error)
> > > > > > > > > > +                       return;
> > > > > > > > >
> > > > > > > > > This code path can clearly fail too. Why can we not fix
> > > > > > > > > this
> > > > > > > > > code
> > > > > > > > > to
> > > > > > > > > allow it to return that reported error so that we can
> > > > > > > > > handle
> > > > > > > > > the
> > > > > > > > > failure case in nfs_readpage() instead of dead-ending
> > > > > > > > > here?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Maybe the below patch is what you had in mind?  That way
> > > > > > > > if
> > > > > > > > fscache
> > > > > > > > is enabled, nfs_readpage() should behave the same way as
> > > > > > > > if
> > > > > > > > it's
> > > > > > > > not,
> > > > > > > > for the case where an IO error occurs in the NFS read
> > > > > > > > completion
> > > > > > > > path.
> > > > > > > >
> > > > > > > > If we call into fscache and we get back that the IO has
> > > > > > > > been
> > > > > > > > submitted,
> > > > > > > > wait until it is completed, so we'll catch any IO errors
> > > > > > > > in
> > > > > > > > the
> > > > > > > > read
> > > > > > > > completion
> > > > > > > > path.  This does not solve the "catch the internal
> > > > > > > > errors",
> > > > > > > > IOW,
> > > > > > > > the
> > > > > > > > ones that show up as pg_error, that will probably require
> > > > > > > > copying
> > > > > > > > pg_error into nfs_open_context.error field.
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > > > > > > index 78b9181e94ba..28e3318080e0 100644
> > > > > > > > --- a/fs/nfs/read.c
> > > > > > > > +++ b/fs/nfs/read.c
> > > > > > > > @@ -357,13 +357,13 @@ int nfs_readpage(struct file *file,
> > > > > > > > struct
> > > > > > > > page
> > > > > > > > *page)
> > > > > > > >         } else
> > > > > > > >                 desc.ctx =
> > > > > > > > get_nfs_open_context(nfs_file_open_context(file));
> > > > > > > >
> > > > > > > > +       xchg(&desc.ctx->error, 0);
> > > > > > > >         if (!IS_SYNC(inode)) {
> > > > > > > >                 ret = nfs_readpage_from_fscache(desc.ctx,
> > > > > > > > inode,
> > > > > > > > page);
> > > > > > > >                 if (ret == 0)
> > > > > > > > -                       goto out;
> > > > > > > > +                       goto out_wait;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       xchg(&desc.ctx->error, 0);
> > > > > > > >         nfs_pageio_init_read(&desc.pgio, inode, false,
> > > > > > > >
> > > > > > > > &nfs_async_read_completion_ops);
> > > > > > > >
> > > > > > > > @@ -373,6 +373,7 @@ int nfs_readpage(struct file *file,
> > > > > > > > struct
> > > > > > > > page
> > > > > > > > *page)
> > > > > > > >
> > > > > > > >         nfs_pageio_complete_read(&desc.pgio);
> > > > > > > >         ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error
> > > > > > > > :
> > > > > > > > 0;
> > > > > > > > +out_wait:
> > > > > > > >         if (!ret) {
> > > > > > > >                 ret = wait_on_page_locked_killable(page);
> > > > > > > >                 if (!PageUptodate(page) && !ret)
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +               nfs_pageio_complete_read(&desc.pgio);
> > > > > > > > > >         }
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Trond Myklebust
> > > > > > > > > Linux NFS client maintainer, Hammerspace
> > > > > > > > > trond.myklebust@hammerspace.com
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Yes, please. This avoids that duplication of NFS read code
> > > > > > > in
> > > > > > > the
> > > > > > > fscache layer.
> > > > > > >
> > > > > >
> > > > > > If you mean patch 4 we still need that - I don't see anyway
> > > > > > to
> > > > > > avoid it.  The above just will make the fscache enabled
> > > > > > path waits for the IO to complete, same as the non-fscache
> > > > > > case.
> > > > > >
> > > > >
> > > > > With the above, you can simplify patch 4/4 to just make the
> > > > > page
> > > > > unlock
> > > > > unconditional on the error, no?
> > > > >
> > > > > i.e.
> > > > >         if (!error)
> > > > >                 SetPageUptodate(page);
> > > > >         unlock_page(page);
> > > > >
> > > > > End result: the client just does the same check as before and
> > > > > let's
> > > > > the
> > > > > vfs/mm decide based on the status of the PG_uptodate flag what
> > > > > to
> > > > > do
> > > > > next. I'm assuming that a retry won't cause fscache to do
> > > > > another
> > > > > bio
> > > > > attempt?
> > > > >
> > > >
> > > > Yes I think you're right and I'm following - let me test it and
> > > > I'll
> > > > send a v2.
> > > > Then we can drop patch #3 right?
> > > >
> > > Sounds good. Thanks Dave!
> > >
> >
> > This approach works but it differs from the original when an fscache
> > error occurs.
> > The original (see below) would call back into NFS to read from the
> > server, but
> > now we just let the VM handle it.  The VM will re-issue the read, but
> > will go back into
> > fscache again (because it's enabled), which may fail again.
>
> How about marking the page on failure, then? I don't believe we
> currently use PG_owner_priv_1 (a.k.a. PageOwnerPriv1, PageChecked,
> PagePinned, PageForeign, PageSwapCache, PageXenRemapped) for anything
> and according to legend it is supposed to be usable by the fs for page
> cache pages.
>
> So what say we use SetPageChecked() to mark the page as having failed
> retrieval from fscache?
>

So this?  I confirm this patch on top of the one I just sent works.
Want me to merge them together and send a v3?

Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Tue Jun 29 11:10:15 2021 -0400

    NFS: Mark page with PG_checked if fscache IO completes in error

    If fscache is enabled and we try to read from fscache, but the
    IO fails, mark the page with PG_checked.  Then when the VM
    re-issues the IO, skip over fscache and just read from the server.

    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 0966e147e973..687e98b08994 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -404,10 +404,12 @@ static void
nfs_readpage_from_fscache_complete(struct page *page,
                 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
                 page, context, error);

-       /* if the read completes with an error, unlock the page and let
-        * the VM reissue the readpage */
+       /* if the read completes with an error, mark the page with PG_checked,
+        * unlock the page, and let the VM reissue the readpage */
        if (!error)
                SetPageUptodate(page);
+       else
+               SetPageChecked(page);
        unlock_page(page);
 }

@@ -423,6 +425,11 @@ int __nfs_readpage_from_fscache(struct
nfs_open_context *ctx,
                 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
                 nfs_i_fscache(inode), page, page->index, page->flags, inode);

+       if (PageChecked(page)) {
+               ClearPageChecked(page);
+               return 1;
+       }
+

        ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
                                         page,
                                         nfs_readpage_from_fscache_complete,

