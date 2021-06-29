Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFA3B731F
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhF2NXv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233956AbhF2NXu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624972883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkJFMLNudsTQN94ZMtiCYHy7SZgh33zSW1B8SrfpZwM=;
        b=Js6caYFmDs0WWhlGrehHQdm/Fq1y2PMCQ3s8AwKnOcOZs+xIyg+0vkzaJWDB5O2jMTFaF6
        KITOjdUkIM0CNX0ac0h3tWyeSsLsK/tA6qpRQJF/stptP2JMOwyDL9pDAHRm5Jf5pSkD9F
        nV84HoLQeBaQRtQOBXgVCqlyRQslTOU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-pdXHy4ZsNOG4L2pBZmF0CA-1; Tue, 29 Jun 2021 09:21:21 -0400
X-MC-Unique: pdXHy4ZsNOG4L2pBZmF0CA-1
Received: by mail-ej1-f70.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso5721222ejp.3
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 06:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkJFMLNudsTQN94ZMtiCYHy7SZgh33zSW1B8SrfpZwM=;
        b=Rmp6uPI0RmHExgzeVGYGRIJpz+2kZUpMLsZLLyWFHCuqDV/jSni2VXHdiGWfhmX3jQ
         4vcUzvN2ucm51SVcRosf9ip80+RjlTsmVRRW2p/PWvukX69nVBUyRAX/hqsMEHhoXYpM
         S3PNkBtxEr4aenIJCFntnX6IuUQlfyRD37DRm7cHpJBnBp9mUvbeFYuBB17opIMOL8sX
         jFL6J/IGypYtHVA9SPOAbYyZTvA4SuONyhYsybuPdKBm3NavHNz2A97+ske1mlRQ6KMX
         ePXia55ojezk/EvusdOV4IWc47UzZKNIY3g5M02uvRDPlsko28Z3lGnbGMfcqYOD3OTV
         BRWw==
X-Gm-Message-State: AOAM5300eZrOjPyFQe+et6THfmilwBQ90c/V0eFH53yf1VwzNUCVIgus
        aJxIOGti1QY5hx8bZdrRY8QezYqlM2OYn5rfgYsDZernuEsxSCEOzAji/Cm6rPgRe11r2+g8ihD
        i1S3OO+qRBBQjQ4p1twehuAbqz7tcyUDD61hu
X-Received: by 2002:a50:d64a:: with SMTP id c10mr41346523edj.199.1624972880463;
        Tue, 29 Jun 2021 06:21:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrQ4V2IVqMB57SO5ftS5xV5brb6C+f+GkOiRkEdQ/ybBGF2R0tFpsNTXy857e0duxk6fcjCz5LrmMKpnmPZAk=
X-Received: by 2002:a50:d64a:: with SMTP id c10mr41346490edj.199.1624972880206;
 Tue, 29 Jun 2021 06:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-5-git-send-email-dwysocha@redhat.com> <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
 <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
 <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
 <CALF+zOma0-M7Nhsz1=XZR0ihFGe4d4v7ofr4Emjg2VJWeUj9uw@mail.gmail.com>
 <ac3deecf386901f688b0c682237326f468a625ef.camel@hammerspace.com>
 <CALF+zOn=p6wuZ_pdifwWtLOUsiArkxBHHVDEnYcxsBdQy1LtVw@mail.gmail.com> <321b6e11718979668b5ab129a7048a511a9886a9.camel@hammerspace.com>
In-Reply-To: <321b6e11718979668b5ab129a7048a511a9886a9.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 29 Jun 2021 09:20:43 -0400
Message-ID: <CALF+zOn5QiKTpngHB0Lv-pBNPa4R8t5+snbo49hKDAP3gcOx0w@mail.gmail.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 8:46 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-29 at 05:17 -0400, David Wysochanski wrote:
> > On Mon, Jun 28, 2021 at 8:39 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2021-06-28 at 19:46 -0400, David Wysochanski wrote:
> > > > On Mon, Jun 28, 2021 at 5:59 PM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Mon, 2021-06-28 at 17:12 -0400, David Wysochanski wrote:
> > > > > > On Mon, Jun 28, 2021 at 3:09 PM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >
> > > > > > > On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski wrote:
> > > > > > > > Earlier commits refactored some NFS read code and removed
> > > > > > > > nfs_readpage_async(), but neglected to properly fixup
> > > > > > > > nfs_readpage_from_fscache_complete().  The code path is
> > > > > > > > only hit when something unusual occurs with the
> > > > > > > > cachefiles
> > > > > > > > backing filesystem, such as an IO error or while a cookie
> > > > > > > > is being invalidated.
> > > > > > > >
> > > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > > ---
> > > > > > > >  fs/nfs/fscache.c | 14 ++++++++++++--
> > > > > > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > > > > > > > index c4c021c6ebbd..d308cb7e1dd4 100644
> > > > > > > > --- a/fs/nfs/fscache.c
> > > > > > > > +++ b/fs/nfs/fscache.c
> > > > > > > > @@ -381,15 +381,25 @@ static void
> > > > > > > > nfs_readpage_from_fscache_complete(struct page *page,
> > > > > > > >                                                void
> > > > > > > > *context,
> > > > > > > >                                                int error)
> > > > > > > >  {
> > > > > > > > +       struct nfs_readdesc desc;
> > > > > > > > +       struct inode *inode = page->mapping->host;
> > > > > > > > +
> > > > > > > >         dfprintk(FSCACHE,
> > > > > > > >                  "NFS: readpage_from_fscache_complete
> > > > > > > > (0x%p/0x%p/%d)\n",
> > > > > > > >                  page, context, error);
> > > > > > > >
> > > > > > > > -       /* if the read completes with an error, we just
> > > > > > > > unlock
> > > > > > > > the
> > > > > > > > page and let
> > > > > > > > -        * the VM reissue the readpage */
> > > > > > > >         if (!error) {
> > > > > > > >                 SetPageUptodate(page);
> > > > > > > >                 unlock_page(page);
> > > > > > > > +       } else {
> > > > > > > > +               desc.ctx = context;
> > > > > > > > +               nfs_pageio_init_read(&desc.pgio, inode,
> > > > > > > > false,
> > > > > > > > +
> > > > > > > > &nfs_async_read_completion_ops);
> > > > > > > > +               error = readpage_async_filler(&desc,
> > > > > > > > page);
> > > > > > > > +               if (error)
> > > > > > > > +                       return;
> > > > > > >
> > > > > > > This code path can clearly fail too. Why can we not fix
> > > > > > > this
> > > > > > > code
> > > > > > > to
> > > > > > > allow it to return that reported error so that we can
> > > > > > > handle
> > > > > > > the
> > > > > > > failure case in nfs_readpage() instead of dead-ending here?
> > > > > > >
> > > > > >
> > > > > > Maybe the below patch is what you had in mind?  That way if
> > > > > > fscache
> > > > > > is enabled, nfs_readpage() should behave the same way as if
> > > > > > it's
> > > > > > not,
> > > > > > for the case where an IO error occurs in the NFS read
> > > > > > completion
> > > > > > path.
> > > > > >
> > > > > > If we call into fscache and we get back that the IO has been
> > > > > > submitted,
> > > > > > wait until it is completed, so we'll catch any IO errors in
> > > > > > the
> > > > > > read
> > > > > > completion
> > > > > > path.  This does not solve the "catch the internal errors",
> > > > > > IOW,
> > > > > > the
> > > > > > ones that show up as pg_error, that will probably require
> > > > > > copying
> > > > > > pg_error into nfs_open_context.error field.
> > > > > >
> > > > > > diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> > > > > > index 78b9181e94ba..28e3318080e0 100644
> > > > > > --- a/fs/nfs/read.c
> > > > > > +++ b/fs/nfs/read.c
> > > > > > @@ -357,13 +357,13 @@ int nfs_readpage(struct file *file,
> > > > > > struct
> > > > > > page
> > > > > > *page)
> > > > > >         } else
> > > > > >                 desc.ctx =
> > > > > > get_nfs_open_context(nfs_file_open_context(file));
> > > > > >
> > > > > > +       xchg(&desc.ctx->error, 0);
> > > > > >         if (!IS_SYNC(inode)) {
> > > > > >                 ret = nfs_readpage_from_fscache(desc.ctx,
> > > > > > inode,
> > > > > > page);
> > > > > >                 if (ret == 0)
> > > > > > -                       goto out;
> > > > > > +                       goto out_wait;
> > > > > >         }
> > > > > >
> > > > > > -       xchg(&desc.ctx->error, 0);
> > > > > >         nfs_pageio_init_read(&desc.pgio, inode, false,
> > > > > >                              &nfs_async_read_completion_ops);
> > > > > >
> > > > > > @@ -373,6 +373,7 @@ int nfs_readpage(struct file *file,
> > > > > > struct
> > > > > > page
> > > > > > *page)
> > > > > >
> > > > > >         nfs_pageio_complete_read(&desc.pgio);
> > > > > >         ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error :
> > > > > > 0;
> > > > > > +out_wait:
> > > > > >         if (!ret) {
> > > > > >                 ret = wait_on_page_locked_killable(page);
> > > > > >                 if (!PageUptodate(page) && !ret)
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > > +
> > > > > > > > +               nfs_pageio_complete_read(&desc.pgio);
> > > > > > > >         }
> > > > > > > >  }
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Trond Myklebust
> > > > > > > Linux NFS client maintainer, Hammerspace
> > > > > > > trond.myklebust@hammerspace.com
> > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > > > Yes, please. This avoids that duplication of NFS read code in
> > > > > the
> > > > > fscache layer.
> > > > >
> > > >
> > > > If you mean patch 4 we still need that - I don't see anyway to
> > > > avoid it.  The above just will make the fscache enabled
> > > > path waits for the IO to complete, same as the non-fscache case.
> > > >
> > >
> > > With the above, you can simplify patch 4/4 to just make the page
> > > unlock
> > > unconditional on the error, no?
> > >
> > > i.e.
> > >         if (!error)
> > >                 SetPageUptodate(page);
> > >         unlock_page(page);
> > >
> > > End result: the client just does the same check as before and let's
> > > the
> > > vfs/mm decide based on the status of the PG_uptodate flag what to
> > > do
> > > next. I'm assuming that a retry won't cause fscache to do another
> > > bio
> > > attempt?
> > >
> >
> > Yes I think you're right and I'm following - let me test it and I'll
> > send a v2.
> > Then we can drop patch #3 right?
> >
> Sounds good. Thanks Dave!
>

This approach works but it differs from the original when an fscache
error occurs.
The original (see below) would call back into NFS to read from the server, but
now we just let the VM handle it.  The VM will re-issue the read, but
will go back into
fscache again (because it's enabled), which may fail again.

If you're ok with that limitation, I'll send the patch.  I tried an
alternative patch on
top to disable fscache on the inode if an error occurs - that way the
reissue from
the VM should go to the NFS server like the original.  But so far I
got a deadlock
in fscache when I try that so it didn't work.  If you want I can try
to work on disable
for another patch but it may take longer.

Original (before commit 1e83b173b266)
static void nfs_readpage_from_fscache_complete(struct page *page,
...
        if (!error) {
                SetPageUptodate(page);
                unlock_page(page);
        } else {
                error = nfs_readpage_async(context, page->mapping->host, page);
                if (error)
                        unlock_page(page);
        }


Patched with above idea

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index c4c021c6ebbd..dca7ce676b1d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -385,12 +385,11 @@ static void
nfs_readpage_from_fscache_complete(struct page *page,
                 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
                 page, context, error);

-       /* if the read completes with an error, we just unlock the page and let
+       /* if the read completes with an error, unlock the page and let
         * the VM reissue the readpage */
-       if (!error) {
+       if (!error)
                SetPageUptodate(page);
-               unlock_page(page);
-       }
+       unlock_page(page);
 }

 /*
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb390eb618b3..9f39e0a1a38b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -362,13 +362,13 @@ int nfs_readpage(struct file *file, struct page *page)
        } else
                desc.ctx = get_nfs_open_context(nfs_file_open_context(file));

+       xchg(&desc.ctx->error, 0);
        if (!IS_SYNC(inode)) {
                ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
                if (ret == 0)
-                       goto out;
+                       goto out_wait;
        }

-       xchg(&desc.ctx->error, 0);
        nfs_pageio_init_read(&desc.pgio, inode, false,
                             &nfs_async_read_completion_ops);

@@ -378,6 +378,7 @@ int nfs_readpage(struct file *file, struct page *page)

        nfs_pageio_complete_read(&desc.pgio);
        ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
+out_wait:
        if (!ret) {
                ret = wait_on_page_locked_killable(page);
                if (!PageUptodate(page) && !ret)



Patched with above plus an attempt at disabling fscache on error
(hangs in fscache disabling)

commit cf88e94e941e718156e68e11dbff10ca0a90bbad
Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Tue Jun 29 08:39:44 2021 -0400

    NFS: Disable fscache on an inode if we get an error when reading a
page from fscache

    If fscache is enabled, and a read from fscache completes with an error,
    disable fscache and unlock the page.  The VM will then re-issue the
    readpage and it should then be sent to the NFS server as a fallback.

    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cfa6e8c1b5a4..ef02bdd2b775 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -415,10 +415,12 @@ static void
nfs_readpage_from_fscache_complete(struct page *page,
                 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
                 page, context, error);

-       /* if the read completes with an error, unlock the page and let
-        * the VM reissue the readpage */
+       /* if the read completes with an error, disable caching on the inode,
+        * unlock the page, and let the VM reissue the readpage to the server */
        if (!error)
                SetPageUptodate(page);
+       else
+               nfs_fscache_enable_inode(page->mapping->host, 0);
        unlock_page(page);
 }


@@ -286,6 +286,29 @@ static bool nfs_fscache_can_enable(void *data)
        return !inode_is_open_for_write(inode);
 }

+
+void nfs_fscache_enable_inode(struct inode *inode, int enable)
+{
+       struct nfs_fscache_inode_auxdata auxdata;
+       struct nfs_inode *nfsi = NFS_I(inode);
+       struct fscache_cookie *cookie = nfs_i_fscache(inode);
+
+       dfprintk(FSCACHE, "NFS: nfsi 0x%p %s cache\n", nfsi,
+                enable ? "enabling" : "disabling");
+
+       nfs_fscache_update_auxdata(&auxdata, nfsi);
+       if (enable) {
+               fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
+                                     nfs_fscache_can_enable, inode);
+               if (fscache_cookie_enabled(cookie))
+                       set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
+       } else {
+               clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
+               fscache_disable_cookie(cookie, &auxdata, true);
+               fscache_uncache_all_inode_pages(cookie, inode);
+       }
+}
+

