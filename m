Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1422AD935
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJOtM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 09:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730760AbgKJOtL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 09:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605019749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkAS42uANfABRC2N5GWOoF5jng/cBwZWFyJ7UocoJw8=;
        b=XEz5JROsZaZz3KMSjk5FbTd/w+C4SiPH9AXw1nf6B/+6bnTKkwjEDltNLTLWdECDAr0CAK
        CiMogV9vwsGuJPrc8N4D+PL+HSP/j85k2gF+IKlgaSDtrzEnNJk/1LCGOu3gi7KEWhEVGi
        adStgJ3V3qKl4qwVOgQmmZ/lDNJYZDo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-_G7hg4_aOJWM77gVhQA-Zw-1; Tue, 10 Nov 2020 09:49:06 -0500
X-MC-Unique: _G7hg4_aOJWM77gVhQA-Zw-1
Received: by mail-ej1-f72.google.com with SMTP id z9so4778187ejg.10
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 06:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkAS42uANfABRC2N5GWOoF5jng/cBwZWFyJ7UocoJw8=;
        b=ALUbSNQqh+FZnWaXU/kHeVRMBQtSXt+/Bq6n80NKzxVUydFoCMIEv3+SDzh8ovrFC0
         ERx68izz2VbFxL/FvrHaV1rgo1Zrs9jaQVXEHbqqJzAkp4WeNMeYlVRJAelXxTDESneg
         zYZu0OPqTqnPL7S5p6jfM5072GFKeW7n3ygw6AqpY/wg+U3tGiinyMc9bCgOGLQSdwnU
         tU/iRy3Uise+ynkkDpSvrhlrfzRlI91qxpTAyID1EQx9zdddHUWbakaE3eeuemnXNEpa
         sNrWATEMkEBeTW9e/+dX3/VX7lv23Y/YTXLdu6sQu/2qkiO1PkioFL8gS1erJ/o5TuL8
         7Stw==
X-Gm-Message-State: AOAM531WgwZF+qqHJWY55ZYYKfIuplCsJI18OCsqXwC6TePNgA7ej4wc
        eGevPKJGV04CvFd9uwvUww/pd6wPq0hkrUdncZ35dkeGLRErGkQX1e1FS9KCDEkeF0Q1fccVIgn
        4TPdPvXLN+gTz/8JLvvef9yG9bsUCAT/WBY3b
X-Received: by 2002:a17:906:3547:: with SMTP id s7mr12501771eja.70.1605019744809;
        Tue, 10 Nov 2020 06:49:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi2qzoITNpCNBcN5znYm7xrURxzaCI/l2+9PNxueSzwKdWRrKNx+AGTe7w5erXW/UML3pFTYsvVB+kF909ZIg=
X-Received: by 2002:a17:906:3547:: with SMTP id s7mr12501748eja.70.1605019744538;
 Tue, 10 Nov 2020 06:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20201107140325.281678-1-trondmy@kernel.org> <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org> <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org> <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org> <20201107140325.281678-8-trondmy@kernel.org>
 <20201107140325.281678-9-trondmy@kernel.org> <20201107140325.281678-10-trondmy@kernel.org>
 <20201107140325.281678-11-trondmy@kernel.org> <20201107140325.281678-12-trondmy@kernel.org>
 <20201107140325.281678-13-trondmy@kernel.org> <20201107140325.281678-14-trondmy@kernel.org>
 <20201107140325.281678-15-trondmy@kernel.org> <20201107140325.281678-16-trondmy@kernel.org>
 <20201107140325.281678-17-trondmy@kernel.org> <20201107140325.281678-18-trondmy@kernel.org>
 <20201107140325.281678-19-trondmy@kernel.org> <20201107140325.281678-20-trondmy@kernel.org>
 <20201107140325.281678-21-trondmy@kernel.org> <20201107140325.281678-22-trondmy@kernel.org>
In-Reply-To: <20201107140325.281678-22-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 10 Nov 2020 09:48:28 -0500
Message-ID: <CALF+zOm+2Vng8Fx6124jK9G9bZHGLd1UEMrjot79naUwyLqn7Q@mail.gmail.com>
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 7, 2020 at 9:14 AM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the directory is changing, causing the page cache to get invalidated
> while we are listing the contents, then the NFS client is currently forced
> to read in the entire directory contents from scratch, because it needs
> to perform a linear search for the readdir cookie. While this is not
> an issue for small directories, it does not scale to directories with
> millions of entries.
> In order to be able to deal with large directories that are changing,
> add a heuristic to ensure that if the page cache is empty, and we are
> searching for a cookie that is not the zero cookie, we just default to
> performing uncached readdir.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 238872d116f7..d7a9efd31ecd 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -917,11 +917,28 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
>         return res;
>  }
>
> +static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
> +{
> +       struct address_space *mapping = desc->file->f_mapping;
> +       struct inode *dir = file_inode(desc->file);
> +       unsigned int dtsize = NFS_SERVER(dir)->dtsize;
> +       loff_t size = i_size_read(dir);
> +
> +       /*
> +        * Default to uncached readdir if the page cache is empty, and
> +        * we're looking for a non-zero cookie in a large directory.
> +        */
> +       return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
> +}
> +
>  /* Search for desc->dir_cookie from the beginning of the page cache */
>  static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
>  {
>         int res;
>
> +       if (nfs_readdir_dont_search_cache(desc))
> +               return -EBADCOOKIE;
> +
>         do {
>                 if (desc->page_index == 0) {
>                         desc->current_index = 0;
> --
> 2.28.0
>
I did a lot of testing yesterday and last night and this mostly
behaves as designed.

However, before you sent this I was starting to test the following
patch which adds a NFS_DIR_CONTEXT_UNCACHED
flag inside nfs_open_dir_context.  I was not sure about the logic when
to turn it on, so for now I'd ignore that
(especially nrpages > NFS_READDIR_UNCACHED_THRESHOLD).  However, I'm
curious why:
1. you didn't take the approach of adding a per-process context flag
so once a process hits this condition, the
process would just shift to uncached and be unaffected by any other
process.  I wonder about multiple directory
listing processes defeating this logic if it's not per-process so we
may get an unbounded time still
2. you put the logic inside readdir_search_pagecache rather than
inside the calling do { .. } while loop

commit a56ff638fe696929a1bc633b22e2d9bd05f3c308
Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Fri Nov 6 08:32:41 2020 -0500

    NFS: Use uncached readdir if we drop the pagecache with larger directories

    Larger directories can get into problem where they do not make
    forward progress once the pagecache times out via exceeding
    acdirmax.  Alleviate this problem by shifting to uncached
    readdir if we drop the pagecache on larger directory.

    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ca30e2dbb9c3..7f43f75d5b76 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -78,6 +78,7 @@ static struct nfs_open_dir_context
*alloc_nfs_open_dir_context(struct inode *di
                ctx->attr_gencount = nfsi->attr_gencount;
                ctx->dir_cookie = 0;
                ctx->dup_cookie = 0;
+               ctx->flags = 0;
                spin_lock(&dir->i_lock);
                if (list_empty(&nfsi->open_files) &&
                    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -1023,6 +1024,8 @@ static int nfs_readdir(struct file *file, struct
dir_context *ctx)
        struct nfs_open_dir_context *dir_ctx = file->private_data;
        struct nfs_readdir_descriptor *desc;
        int res;
+       unsigned long nrpages;
+#define NFS_READDIR_UNCACHED_THRESHOLD 1024

        dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
                        file, (long long)ctx->pos);
@@ -1035,9 +1038,25 @@ static int nfs_readdir(struct file *file,
struct dir_context *ctx)
         * revalidate the cookie.
         */
        if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
+               nrpages = inode->i_mapping->nrpages;
                res = nfs_revalidate_mapping(inode, file->f_mapping);
                if (res < 0)
                        goto out;
+               /*
+                * If we just dropped the pagecache, and we're not
+                * at the start of the directory, use uncached.
+                */
+               if (!test_bit(NFS_DIR_CONTEXT_UNCACHED, &dir_ctx->flags) &&
+                   ctx->pos != 0 &&
+                   !inode->i_mapping->nrpages &&
+                   nrpages > NFS_READDIR_UNCACHED_THRESHOLD) {
+                       set_bit(NFS_DIR_CONTEXT_UNCACHED, &dir_ctx->flags);
+                       printk("NFS: DBG setting
NFS_DIR_CONTEXT_UNCACHED ctx->pos = %lld nrpages
+               }
+       }
+       if (test_bit(NFS_DIR_CONTEXT_UNCACHED, &dir_ctx->flags) &&
ctx->pos == 0) {
+               clear_bit(NFS_DIR_CONTEXT_UNCACHED, &dir_ctx->flags);
+               printk("NFS: DBG clearing NFS_DIR_CONTEXT_UNCACHED");
        }

        res = -ENOMEM;
@@ -1057,7 +1076,10 @@ static int nfs_readdir(struct file *file,
struct dir_context *ctx)
        spin_unlock(&file->f_lock);

        do {
-               res = readdir_search_pagecache(desc);
+               if (test_bit(NFS_DIR_CONTEXT_UNCACHED, &dir_ctx->flags))
+                       res = -EBADCOOKIE;
+               else
+                       res = readdir_search_pagecache(desc);

                if (res == -EBADCOOKIE) {
                        res = 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..fedcfec94d95 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -98,6 +98,8 @@ struct nfs_open_dir_context {
        __u64 dir_cookie;
        __u64 dup_cookie;
        signed char duped;
+       unsigned long flags;
+#define NFS_DIR_CONTEXT_UNCACHED       (1)
 };

 /*

