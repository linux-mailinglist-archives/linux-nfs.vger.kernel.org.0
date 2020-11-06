Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458912A9703
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKFNbc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 08:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727214AbgKFNbb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 08:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604669488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6eSX+4KBZhp1TaWfCGjj2f9CX5uzJCTLnz3d803aIs=;
        b=BIY2slOowSc/Sr/jrZg0YkmzOEtgGqfhoC00cgrv4iyrPWlzCkvpFConFMhc3J+88kcR/q
        QFbzo2wcC/3sBW1ahnpak6Tica4+nDDywT/DekZs+K+Rnz/9YGJSbt6RXX8/r/tx7tMO32
        NB57p6z5kunFCZ4d6bJLIdJVZ4oDKsQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-asf_e8w5NN6qAuYiBWHpkg-1; Fri, 06 Nov 2020 08:31:26 -0500
X-MC-Unique: asf_e8w5NN6qAuYiBWHpkg-1
Received: by mail-ed1-f72.google.com with SMTP id c24so529620edx.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 05:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6eSX+4KBZhp1TaWfCGjj2f9CX5uzJCTLnz3d803aIs=;
        b=TwFA5ScnHm9Jmd/MOlHTj2vJFpXKFpGFzntXyLqxsN66IX2jRIHDtIk6xaA8fco3UN
         1ilUPImASY+OoTOfp4LGeNpk8/IF0pf6Yh2aS2VutGhbGXqEi1bwn/qfWczeJstArGUx
         3EHOmTi4QZ2TomDFtSvz0cFLQIEr737XSW+wz+XdAQeXa9tUVst18+7t/71ZiPrQjXrH
         Qwc4x9N69RBlLxdPMj0SuJtk0DAlMgb8YuqTxQ4CaUHyShIJYjTwYuRTH/KezpIArliK
         QCYRYZDFXN2bJ6snqSrKSkikVc6ELawVdX1Pg70cd8bXP9Nq84808buZy8towoH9XdGQ
         dnxA==
X-Gm-Message-State: AOAM5312AyQzn3Q3G9ht1FQ7Zm9q/3l7udFDrSKOh4pEKkV1VXv0x8X1
        TS4X9xe+04YlvcBbbzJpEuhEkodxWuts0nMZmMUVJ9/w+gwDQiJP2tkuNwU4Wwi3to/216X+cSz
        ZgPHiPelcczV6bQdyWRdaTHKcmxD5d3KGVhsf
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr1901948eje.229.1604669485542;
        Fri, 06 Nov 2020 05:31:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXESpo24zdjKFj5ZLjdYlOr2+tHN8CbbbEyox81tQZtX/zlmDrQuOhIadmSLUpjgXnw6mJLvST+7QDjGk3DdM=
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr1901932eje.229.1604669485278;
 Fri, 06 Nov 2020 05:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com> <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com> <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
In-Reply-To: <20201104161638.300324-6-trond.myklebust@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 6 Nov 2020 08:30:49 -0500
Message-ID: <CALF+zOnirS++y=pW8HRtzwdric15ixuAiqTL9YiYh2-NdDd=0Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] NFS: Don't discard readdir results
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 4, 2020 at 11:27 AM <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If a readdir call returns more data than we can fit into one page
> cache page, then allocate a new one for that data rather than
> discarding the data.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 842f69120a01..f7248145c333 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -320,6 +320,26 @@ static void nfs_readdir_page_set_eof(struct page *page)
>         kunmap_atomic(array);
>  }
>
> +static void nfs_readdir_page_unlock_and_put(struct page *page)
> +{
> +       unlock_page(page);
> +       put_page(page);
> +}
> +
> +static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
> +                                             pgoff_t index, u64 cookie)
> +{
> +       struct page *page;
> +
> +       page = nfs_readdir_page_get_locked(mapping, index, cookie);
> +       if (page) {
> +               if (nfs_readdir_page_last_cookie(page) == cookie)
> +                       return page;
> +               nfs_readdir_page_unlock_and_put(page);
> +       }
> +       return NULL;
> +}
> +
>  static inline
>  int is_32bit_api(void)
>  {
> @@ -637,13 +657,15 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
>  }
>
>  /* Perform conversion from xdr to cache array */
> -static
> -int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *entry,
> -                               struct page **xdr_pages, struct page *page, unsigned int buflen)
> +static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
> +                                  struct nfs_entry *entry,
> +                                  struct page **xdr_pages,
> +                                  struct page *fillme, unsigned int buflen)
>  {
> +       struct address_space *mapping = desc->file->f_mapping;
>         struct xdr_stream stream;
>         struct xdr_buf buf;
> -       struct page *scratch;
> +       struct page *scratch, *new, *page = fillme;
>         int status;
>
>         scratch = alloc_page(GFP_KERNEL);
> @@ -666,6 +688,19 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
>                                         desc->dir_verifier);
>
>                 status = nfs_readdir_add_to_array(entry, page);
> +               if (status != -ENOSPC)
> +                       continue;
> +
> +               if (page->mapping != mapping)
> +                       break;
> +               new = nfs_readdir_page_get_next(mapping, page->index + 1,
> +                                               entry->prev_cookie);
> +               if (!new)
> +                       break;
> +               if (page != fillme)
> +                       nfs_readdir_page_unlock_and_put(page);
> +               page = new;
> +               status = nfs_readdir_add_to_array(entry, page);
>         } while (!status && !entry->eof);
>
>         switch (status) {
> @@ -681,6 +716,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
>                 break;
>         }
>
> +       if (page != fillme)
> +               nfs_readdir_page_unlock_and_put(page);
> +
>         put_page(scratch);
>         return status;
>  }
> --
> 2.28.0
>

It doesn't look like this handles uncached_readdir.  Were you planning
on addressing that somehow, or should we think about something like
this to move dtsize up as a parameter to nfs_readdir_xdr_to_array(),
and force uncached_readdir() to 1 page:
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b6c3501e8f61..ca30e2dbb9c3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -791,13 +791,12 @@ static struct page
**nfs_readdir_alloc_pages(size_t npages)

 static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
                                    struct page *page, __be32 *verf_arg,
-                                   __be32 *verf_res)
+                                   __be32 *verf_res, size_t dtsize)
 {
        struct page **pages;
        struct nfs_entry *entry;
        size_t array_size;
        struct inode *inode = file_inode(desc->file);
-       size_t dtsize = NFS_SERVER(inode)->dtsize;
        int status = -ENOMEM;

        entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -879,13 +878,15 @@ static int find_and_lock_cache_page(struct
nfs_readdir_descriptor *desc)
        struct nfs_inode *nfsi = NFS_I(inode);
        __be32 verf[NFS_DIR_VERIFIER_SIZE];
        int res;
+       size_t dtsize = NFS_SERVER(inode)->dtsize;

        desc->page = nfs_readdir_page_get_cached(desc);
        if (!desc->page)
                return -ENOMEM;
        if (nfs_readdir_page_needs_filling(desc->page)) {
                res = nfs_readdir_xdr_to_array(desc, desc->page,
-                                              nfsi->cookieverf, verf);
+                                              nfsi->cookieverf, verf,
+                                              dtsize);
                if (res < 0) {
                        nfs_readdir_page_unlock_and_put_cached(desc);
                        if (res == -EBADCOOKIE || res == -ENOTSYNC) {
@@ -995,7 +996,8 @@ static int uncached_readdir(struct
nfs_readdir_descriptor *desc)
        desc->duped = 0;

        nfs_readdir_page_init_array(page, desc->dir_cookie);
-       status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf);
+       status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf,
+                                         PAGE_SIZE);
        if (status < 0)
                goto out_release;

