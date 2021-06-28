Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D543B6994
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhF1USx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 16:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhF1USw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 16:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624911386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FzNPn1yDkvPNpLTOZPogxsjVfxTLnSMlfo+dd/rkFM=;
        b=YUHoeyQON2xWrHssFZqvfoMwBoCU81vP+GduCl78mIkOLZ7Ut6w2TpxtjTyXGrx438KXbO
        ztk1Ejrrh7MgRbjcuGVdvBEd5W3IjeV8i/jfOD/6qjrd+We/0pATKCLK0iKSAQPwvEqvQB
        MhgNLORUUXh+KThasiEcTjJA4QHX8oM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-vjYAGgSVOAO8aC8A-KUfbQ-1; Mon, 28 Jun 2021 16:16:24 -0400
X-MC-Unique: vjYAGgSVOAO8aC8A-KUfbQ-1
Received: by mail-ej1-f72.google.com with SMTP id l6-20020a1709062a86b029046ec0ceaf5cso4871088eje.8
        for <linux-nfs@vger.kernel.org>; Mon, 28 Jun 2021 13:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FzNPn1yDkvPNpLTOZPogxsjVfxTLnSMlfo+dd/rkFM=;
        b=StAQ48Nfr/wqV36j+AsCCITgLVnlLjDM3D7m4Ag4aV68HQp9vNL8Z4Uqt7L6pFEWGx
         fSd9ygLPzvlqDsJ+dPvYEtGTe9k9YuGYdbMeNckaUzm1uOy5VNCmjgQCryfjK/3FlvHN
         aski2zIheQBY9t+VTwZhO4L5tsBRsnu048f/l8Sh35D6fbf/wq9475NjiXXmTnAD4nTY
         5YRYLxHdOKdSmfX1cQJVqUYBKomEiCx348TfWpP6d2NfDV9LJ4q3aVhd564BYh2YR41Y
         zdPPCnJstBr41ku5UZgQ9l56f5s7fQLLjOFgFi2WqmN9ig552dgo2emkENiC72x1zYY6
         6tzQ==
X-Gm-Message-State: AOAM5319bL5GemjU8np24v0uQpF5EugVMTJUBpF4moMRCuBBagU8Dx82
        Jc7l5UfgTdoGs3QmzGgt5DOc44b9lhA1B9rfV3iW3y1Si17jCgRQK3m7LpMsqXlJNgmZq/3trtH
        0d2QTgsDzjetdTyY3aF+2dschFdSJKpdWPRbI
X-Received: by 2002:a17:906:3794:: with SMTP id n20mr25015198ejc.276.1624911382485;
        Mon, 28 Jun 2021 13:16:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNafsrLJGISk1LnDWdCha4QnMr6WGCDUPz3k49afQsV3fHQO5pfOjzrf8JK5DgIbsLXOcgXwbH26c5pkerXJQ=
X-Received: by 2002:a17:906:3794:: with SMTP id n20mr25015187ejc.276.1624911382296;
 Mon, 28 Jun 2021 13:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
 <1624901943-20027-5-git-send-email-dwysocha@redhat.com> <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
In-Reply-To: <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 28 Jun 2021 16:15:46 -0400
Message-ID: <CALF+zOn4QUG=5QVXNmqn=0quBBp+F2eG4NaKLO+L2DYVMPHz-g@mail.gmail.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 3:09 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-06-28 at 13:39 -0400, Dave Wysochanski wrote:
> > Earlier commits refactored some NFS read code and removed
> > nfs_readpage_async(), but neglected to properly fixup
> > nfs_readpage_from_fscache_complete().  The code path is
> > only hit when something unusual occurs with the cachefiles
> > backing filesystem, such as an IO error or while a cookie
> > is being invalidated.
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/fscache.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > index c4c021c6ebbd..d308cb7e1dd4 100644
> > --- a/fs/nfs/fscache.c
> > +++ b/fs/nfs/fscache.c
> > @@ -381,15 +381,25 @@ static void
> > nfs_readpage_from_fscache_complete(struct page *page,
> >                                                void *context,
> >                                                int error)
> >  {
> > +       struct nfs_readdesc desc;
> > +       struct inode *inode = page->mapping->host;
> > +
> >         dfprintk(FSCACHE,
> >                  "NFS: readpage_from_fscache_complete
> > (0x%p/0x%p/%d)\n",
> >                  page, context, error);
> >
> > -       /* if the read completes with an error, we just unlock the
> > page and let
> > -        * the VM reissue the readpage */
> >         if (!error) {
> >                 SetPageUptodate(page);
> >                 unlock_page(page);
> > +       } else {
> > +               desc.ctx = context;
> > +               nfs_pageio_init_read(&desc.pgio, inode, false,
> > +                                    &nfs_async_read_completion_ops);
> > +               error = readpage_async_filler(&desc, page);
> > +               if (error)
> > +                       return;
>
> This code path can clearly fail too. Why can we not fix this code to
> allow it to return that reported error so that we can handle the
> failure case in nfs_readpage() instead of dead-ending here?
>

Because the context of the process calling nfs_readpage() is already
gone - this is called from keventd context coming up from fscache.
So if fscache fails, and then we retry here, and that fails, what is left
to be done?  This _is_ the retry code.  I guess I'm not following.  Do you
want the process to wait inside nfs_readpage() until fscache calls
nfs_readpage_from_fscache_complete?  If so, that would be new as
we have not done this before - this patch was just putting back the hunk I
mistakenly removed in commit 1e83b173b266


nfs_readpage() -> nfs_readpage_from_fscache -> fscache_read_or_alloc_page
* nfs_readpage_from_fscache_complete() will be called by fscache when
IO completes or there's an error
* fscache_read_or_alloc_page() returns 0 saying we've submitted the BIO

nfs_readpage()
...
    if (!IS_SYNC(inode)) {
        ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
        if (ret == 0)
            goto out;
    }


int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
                struct inode *inode, struct page *page)
{
...
    ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
                     page,
                     nfs_readpage_from_fscache_complete,
                     ctx,
                     GFP_KERNEL);

   switch (ret) {
    case 0: /* read BIO submitted (page in fscache) */
        dfprintk(FSCACHE,
             "NFS:    readpage_from_fscache: BIO submitted\n");
        nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
        return ret;




> > +
> > +               nfs_pageio_complete_read(&desc.pgio);
> >         }
> >  }
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

