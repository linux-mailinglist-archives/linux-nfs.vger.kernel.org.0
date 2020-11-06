Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51842A9B5F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgKFSBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 13:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFSBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 13:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604685696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5miuYCMkYe1V5REFPfczfBf0SGHvu0st42ZMq0xBofA=;
        b=aiD0CH7h4IvpcC0Z7OsdvmfBKuWXfiJtVJgmv3gTmnEijR+VdHcaw6c2Wy6irGFkUlv1oi
        +tFiXFx4PTkkIN28S9fSWlz+5CLiQDJnAf2QWYHXjWR+mHZxZTvOE17M7rlTls/M5itvqg
        wNil0fdS49zC8VrvyI7gyyvxxTg40PA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-3LToZrwWM6ywDJxHvVsuqg-1; Fri, 06 Nov 2020 13:01:34 -0500
X-MC-Unique: 3LToZrwWM6ywDJxHvVsuqg-1
Received: by mail-ej1-f72.google.com with SMTP id nt22so733920ejb.17
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 10:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5miuYCMkYe1V5REFPfczfBf0SGHvu0st42ZMq0xBofA=;
        b=gSyBv8TwTLRxh+gJj5BIJG6z95zFVvD/s7JeAKQL0nVcL+oNPwaMt3rUzbRd57mJVo
         oujGN5BMArBeQ+InCNDHtVPE90yVrsu/SOkzHlkQ4HzeCGOh13zYR+2yhWri+VDKEUeX
         xXUhfi5oO0LarU9QquYFpMWoKVYwWGZvc3nS/A8s2N+0sgX6n43fsNotdU2MkSfx6Hm9
         Be9WFlW2fVZ7YxvTwLugFQ6BOpv4QKqZkHqBle3pENBJQ2ULhkSLiMgQY5sULQnUNwIC
         rHMvmD5GOoM1LEd7IlcMvQrr37GiVC7fNxbXo7TfMOUeSfjcdCiFrYJydLiS2L6vT+In
         dsZQ==
X-Gm-Message-State: AOAM533hY1+K+aP2wma9QZkcSUNLANSMdfiQ6sr0qnwrVZedDz2QIbGc
        pwL7rNxDgOOf/ZpNECbwJWT8apDs5vuGPdiotrQYgqqB4Ak9wS5NszyYpbsyP3wty5/Fa8GqEHX
        xeqDFlXqOH6LMBMAclRAKZUwXcirTNN5PAyZL
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr3148129eji.320.1604685693198;
        Fri, 06 Nov 2020 10:01:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYlPCv/U+d1FhApMxfBKmE8yVhuY3Wxv4VVxIRkJSDPDL6Bp0WX22tqFRqyPPHJ4w8iblfKrI5BUK4c/22/is=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr3148098eji.320.1604685692905;
 Fri, 06 Nov 2020 10:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com> <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com> <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com> <CALF+zOnirS++y=pW8HRtzwdric15ixuAiqTL9YiYh2-NdDd=0Q@mail.gmail.com>
 <482aa15584d90773068da4af772c7aaf43db183c.camel@hammerspace.com>
In-Reply-To: <482aa15584d90773068da4af772c7aaf43db183c.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 6 Nov 2020 13:00:56 -0500
Message-ID: <CALF+zOmWydsif=Tv4UQvYgLPdF3O1Qy+GvqZ7g-7iVVEUskW8g@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] NFS: Don't discard readdir results
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 6, 2020 at 10:05 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2020-11-06 at 08:30 -0500, David Wysochanski wrote:
> > On Wed, Nov 4, 2020 at 11:27 AM <trondmy@gmail.com> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > If a readdir call returns more data than we can fit into one page
> > > cache page, then allocate a new one for that data rather than
> > > discarding the data.
> > >
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/dir.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index 842f69120a01..f7248145c333 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -320,6 +320,26 @@ static void nfs_readdir_page_set_eof(struct
> > > page *page)
> > >         kunmap_atomic(array);
> > >  }
> > >
> > > +static void nfs_readdir_page_unlock_and_put(struct page *page)
> > > +{
> > > +       unlock_page(page);
> > > +       put_page(page);
> > > +}
> > > +
> > > +static struct page *nfs_readdir_page_get_next(struct address_space
> > > *mapping,
> > > +                                             pgoff_t index, u64
> > > cookie)
> > > +{
> > > +       struct page *page;
> > > +
> > > +       page = nfs_readdir_page_get_locked(mapping, index, cookie);
> > > +       if (page) {
> > > +               if (nfs_readdir_page_last_cookie(page) == cookie)
> > > +                       return page;
> > > +               nfs_readdir_page_unlock_and_put(page);
> > > +       }
> > > +       return NULL;
> > > +}
> > > +
> > >  static inline
> > >  int is_32bit_api(void)
> > >  {
> > > @@ -637,13 +657,15 @@ void nfs_prime_dcache(struct dentry *parent,
> > > struct nfs_entry *entry,
> > >  }
> > >
> > >  /* Perform conversion from xdr to cache array */
> > > -static
> > > -int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct
> > > nfs_entry *entry,
> > > -                               struct page **xdr_pages, struct
> > > page *page, unsigned int buflen)
> > > +static int nfs_readdir_page_filler(struct nfs_readdir_descriptor
> > > *desc,
> > > +                                  struct nfs_entry *entry,
> > > +                                  struct page **xdr_pages,
> > > +                                  struct page *fillme, unsigned
> > > int buflen)
> > >  {
> > > +       struct address_space *mapping = desc->file->f_mapping;
> > >         struct xdr_stream stream;
> > >         struct xdr_buf buf;
> > > -       struct page *scratch;
> > > +       struct page *scratch, *new, *page = fillme;
> > >         int status;
> > >
> > >         scratch = alloc_page(GFP_KERNEL);
> > > @@ -666,6 +688,19 @@ int
> > > nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct
> > > nfs_entry *en
> > >                                         desc->dir_verifier);
> > >
> > >                 status = nfs_readdir_add_to_array(entry, page);
> > > +               if (status != -ENOSPC)
> > > +                       continue;
> > > +
> > > +               if (page->mapping != mapping)
> > > +                       break;
> > > +               new = nfs_readdir_page_get_next(mapping, page-
> > > >index + 1,
> > > +                                               entry-
> > > >prev_cookie);
> > > +               if (!new)
> > > +                       break;
> > > +               if (page != fillme)
> > > +                       nfs_readdir_page_unlock_and_put(page);
> > > +               page = new;
> > > +               status = nfs_readdir_add_to_array(entry, page);
> > >         } while (!status && !entry->eof);
> > >
> > >         switch (status) {
> > > @@ -681,6 +716,9 @@ int
> > > nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct
> > > nfs_entry *en
> > >                 break;
> > >         }
> > >
> > > +       if (page != fillme)
> > > +               nfs_readdir_page_unlock_and_put(page);
> > > +
> > >         put_page(scratch);
> > >         return status;
> > >  }
> > > --
> > > 2.28.0
> > >
> >
> > It doesn't look like this handles uncached_readdir.  Were you
> > planning
> > on addressing that somehow, or should we think about something like
> > this to move dtsize up as a parameter to nfs_readdir_xdr_to_array(),
> > and force uncached_readdir() to 1 page:
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index b6c3501e8f61..ca30e2dbb9c3 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -791,13 +791,12 @@ static struct page
> > **nfs_readdir_alloc_pages(size_t npages)
> >
> >  static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor
> > *desc,
> >                                     struct page *page, __be32
> > *verf_arg,
> > -                                   __be32 *verf_res)
> > +                                   __be32 *verf_res, size_t dtsize)
> >  {
> >         struct page **pages;
> >         struct nfs_entry *entry;
> >         size_t array_size;
> >         struct inode *inode = file_inode(desc->file);
> > -       size_t dtsize = NFS_SERVER(inode)->dtsize;
> >         int status = -ENOMEM;
> >
> >         entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > @@ -879,13 +878,15 @@ static int find_and_lock_cache_page(struct
> > nfs_readdir_descriptor *desc)
> >         struct nfs_inode *nfsi = NFS_I(inode);
> >         __be32 verf[NFS_DIR_VERIFIER_SIZE];
> >         int res;
> > +       size_t dtsize = NFS_SERVER(inode)->dtsize;
> >
> >         desc->page = nfs_readdir_page_get_cached(desc);
> >         if (!desc->page)
> >                 return -ENOMEM;
> >         if (nfs_readdir_page_needs_filling(desc->page)) {
> >                 res = nfs_readdir_xdr_to_array(desc, desc->page,
> > -                                              nfsi->cookieverf,
> > verf);
> > +                                              nfsi->cookieverf,
> > verf,
> > +                                              dtsize);
> >                 if (res < 0) {
> >                         nfs_readdir_page_unlock_and_put_cached(desc);
> >                         if (res == -EBADCOOKIE || res == -ENOTSYNC) {
> > @@ -995,7 +996,8 @@ static int uncached_readdir(struct
> > nfs_readdir_descriptor *desc)
> >         desc->duped = 0;
> >
> >         nfs_readdir_page_init_array(page, desc->dir_cookie);
> > -       status = nfs_readdir_xdr_to_array(desc, page, desc->verf,
> > verf);
> > +       status = nfs_readdir_xdr_to_array(desc, page, desc->verf,
> > verf,
> > +                                         PAGE_SIZE);
> >         if (status < 0)
> >                 goto out_release;
> >
>
> Actually for uncached readdir, I was thinking we might want to convert
> nfs_readdir_xdr_to_array() and nfs_readdir_page_filler() to take an
> array of pages + buffer size.
> IOW: convert uncached_readdir() to allocate an array of pages, and pass
> in a 'struct page **' + a buffer length.
>
Yes I agree and this looks more like the right way to fix it rather than
this single page approach.


> I don't like the idea of passing in a dtsize because that restricts the
> size of the READDIR RPC request buffer instead of restricting the
> number of entries the server returns. For any given buffer size, that
> number of entries fluctuates wildly depending on the filenames in that
> directory and their differing lengths, whereas your page can take a
> fixed number of entries irrespective of the filename lengths (in fact
> it can always take 127 entries on an x86_64).
>
> It is true that the number of entries that nfs_do_filldir() can handle
> also depends on the filename length, but we don't have any information
> in the filesystem about the buffer size that was passed in to the
> getdents() system call of how much space remains in that buffer. All
> that information is hidden in the opaque 'struct dir_context'. So for
> that reason, we can't use that information to set a dtsize either.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

