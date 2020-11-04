Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AF2A6F53
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 22:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKDVCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 16:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbgKDVCQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 16:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604523733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YKGm9jP7feuBQzU6CeoElg2XCtotMjtBWrNn06l0pw=;
        b=SP470/eQK/6ALp0KfFm0A//AcHs4WkqgCPW5PTNwNycB+6DU2VTuFo1DFfOU3DI9YXdcVQ
        rQXCTH1YyfGUny/Tu1vVj/y+wxFhq6Ef+gk0L5lPDot5gFV2OR9tjVH62YFabubBImsMWB
        XSUjex22PpKwc0vfVwpEP5lMrZvCTMI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-oDSsqsv3O8Kqx84zIVWOmw-1; Wed, 04 Nov 2020 16:02:12 -0500
X-MC-Unique: oDSsqsv3O8Kqx84zIVWOmw-1
Received: by mail-ed1-f70.google.com with SMTP id c24so2319636edx.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 13:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YKGm9jP7feuBQzU6CeoElg2XCtotMjtBWrNn06l0pw=;
        b=AuEOrd4KRz4t8kg9qmiCtHJZYUL6OGn5MMBuOR7E5at0oM82FlOtBB0wiDHiWiqm+e
         G8nvAH7oGo/vEdiU0BWsLsMV3E24yXRrelmooP+51Q2+H0QWnE1eXe3BbqHcYC3WvLwU
         fcoPcE4WTagwGWXtiWCqnyeDBdCW0NnhHwoB3Te8i7n0O0Z2MGR9Q5TygidX5fFSGFRm
         f8dTSOvbxU3ynKRjw0+4V3FaYAPBK63/5Ud+YfC9JNc4xpafu7ftVA17Egg8zJMBJCBO
         rvF4YiUSfJmYaRj/542duMfjX+4UOgsi4nElstvXtsPquX3xXUUeIGGcFF/XsEIq66GK
         Uq7w==
X-Gm-Message-State: AOAM5312QNbrGZzR1ysP7KmGU/VQCavPrjLhmXlpraPrxVlFzOGXfAKj
        C2m/vBoDABElbpxjQiZFad748Fw9PT32TxMBd1ekM63wwXldpt6Mo5DS5nM5LCUqhl4mgucs5WT
        knS2SulR5vxhoEPmzhApkwIWKiu0FntYqv87n
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr8398083eje.229.1604523730557;
        Wed, 04 Nov 2020 13:02:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaJGncc01EPqUUQMKacKwkIFHfEmMZMB+aYk0C47VJjjPePYMs+xj5lYRlgMeqdcd8BuXDdCLrcCrfbma+tBQ=
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr8398047eje.229.1604523730225;
 Wed, 04 Nov 2020 13:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com> <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com> <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com> <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com> <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
 <20201104161638.300324-15-trond.myklebust@hammerspace.com>
 <20201104161638.300324-16-trond.myklebust@hammerspace.com> <20201104161638.300324-17-trond.myklebust@hammerspace.com>
In-Reply-To: <20201104161638.300324-17-trond.myklebust@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 4 Nov 2020 16:01:34 -0500
Message-ID: <CALF+zOnbaR3x0FqLFY85_5y4e640h7kcm+ibwHsxPc0zocdrJA@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] NFS: Improve handling of directory verifiers
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 4, 2020 at 11:28 AM <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the server insists on using the readdir verifiers in order to allow
> cookies to expire, then we should ensure that we cache the verifier
> with the cookie, so that we can return an error if the application
> tries to use the expired cookie.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c           | 35 +++++++++++++++++++++++------------
>  fs/nfs/inode.c         |  7 -------
>  include/linux/nfs_fs.h |  8 +++++++-
>  3 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 3b44bef3a1b4..454377228167 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -155,6 +155,7 @@ struct nfs_readdir_descriptor {
>         loff_t          current_index;
>         loff_t          prev_index;
>
> +       __be32          verf[NFS_DIR_VERIFIER_SIZE];
>         unsigned long   dir_verifier;
>         unsigned long   timestamp;
>         unsigned long   gencount;
> @@ -466,15 +467,15 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
>
>  /* Fill a page with xdr information before transferring to the cache page */
>  static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
> -                                 u64 cookie, struct page **pages,
> -                                 size_t bufsize)
> +                                 __be32 *verf, u64 cookie,
> +                                 struct page **pages, size_t bufsize,
> +                                 __be32 *verf_res)
>  {
>         struct inode *inode = file_inode(desc->file);
> -       __be32 verf_res[2];
>         struct nfs_readdir_arg arg = {
>                 .dentry = file_dentry(desc->file),
>                 .cred = desc->file->f_cred,
> -               .verf = NFS_I(inode)->cookieverf,
> +               .verf = verf,
>                 .cookie = cookie,
>                 .pages = pages,
>                 .page_len = bufsize,
> @@ -503,8 +504,6 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
>         }
>         desc->timestamp = timestamp;
>         desc->gencount = gencount;
> -       memcpy(NFS_I(inode)->cookieverf, res.verf,
> -              sizeof(NFS_I(inode)->cookieverf));
>  error:
>         return error;
>  }
> @@ -770,11 +769,13 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
>  }
>
>  static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
> -                                   struct page *page, struct inode *inode)
> +                                   struct page *page, __be32 *verf_arg,
> +                                   __be32 *verf_res)
>  {
>         struct page **pages;
>         struct nfs_entry *entry;
>         size_t array_size;
> +       struct inode *inode = file_inode(desc->file);
>         size_t dtsize = NFS_SERVER(inode)->dtsize;
>         int status = -ENOMEM;
>
> @@ -801,8 +802,9 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
>
>         do {
>                 unsigned int pglen;
> -               status = nfs_readdir_xdr_filler(desc, entry->cookie,
> -                                               pages, dtsize);
> +               status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
> +                                               pages, dtsize,
> +                                               verf_res);
>                 if (status < 0)
>                         break;
>
> @@ -854,13 +856,15 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
>  {
>         struct inode *inode = file_inode(desc->file);
>         struct nfs_inode *nfsi = NFS_I(inode);
> +       __be32 verf[NFS_DIR_VERIFIER_SIZE];
>         int res;
>
>         desc->page = nfs_readdir_page_get_cached(desc);
>         if (!desc->page)
>                 return -ENOMEM;
>         if (nfs_readdir_page_needs_filling(desc->page)) {
> -               res = nfs_readdir_xdr_to_array(desc, desc->page, inode);
> +               res = nfs_readdir_xdr_to_array(desc, desc->page,
> +                                              nfsi->cookieverf, verf);
>                 if (res < 0) {
>                         nfs_readdir_page_unlock_and_put_cached(desc);
>                         if (res == -EBADCOOKIE || res == -ENOTSYNC) {
> @@ -870,6 +874,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
>                         }
>                         return res;
>                 }
> +               memcpy(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf));
>         }
>         res = nfs_readdir_search_array(desc);
>         if (res == 0) {
> @@ -902,6 +907,7 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
>  static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
>  {
>         struct file     *file = desc->file;
> +       struct nfs_inode *nfsi = NFS_I(file_inode(file));
>         struct nfs_cache_array *array;
>         unsigned int i = 0;
>
> @@ -915,6 +921,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
>                         desc->eof = true;
>                         break;
>                 }
> +               memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf));
>                 if (i < (array->size-1))
>                         desc->dir_cookie = array->array[i+1].cookie;
>                 else
> @@ -949,8 +956,8 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
>  static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>  {
>         struct page     *page = NULL;
> +       __be32          verf[NFS_DIR_VERIFIER_SIZE];
>         int             status;
> -       struct inode *inode = file_inode(desc->file);
>
>         dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
>                         (unsigned long long)desc->dir_cookie);
> @@ -967,7 +974,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>         desc->duped = 0;
>
>         nfs_readdir_page_init_array(page, desc->dir_cookie);
> -       status = nfs_readdir_xdr_to_array(desc, page, inode);
> +       status = nfs_readdir_xdr_to_array(desc, page, desc->verf, verf);
>         if (status < 0)
>                 goto out_release;
>
> @@ -1023,6 +1030,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>         desc->dup_cookie = dir_ctx->dup_cookie;
>         desc->duped = dir_ctx->duped;
>         desc->attr_gencount = dir_ctx->attr_gencount;
> +       memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
>         spin_unlock(&file->f_lock);
>
>         do {
> @@ -1061,6 +1069,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>         dir_ctx->dup_cookie = desc->dup_cookie;
>         dir_ctx->duped = desc->duped;
>         dir_ctx->attr_gencount = desc->attr_gencount;
> +       memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
>         spin_unlock(&file->f_lock);
>
>         kfree(desc);
> @@ -1101,6 +1110,8 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
>                         dir_ctx->dir_cookie = offset;
>                 else
>                         dir_ctx->dir_cookie = 0;
> +               if (offset == 0)
> +                       memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
>                 dir_ctx->duped = 0;
>         }
>         spin_unlock(&filp->f_lock);

Thanks for doing these patches!

For some reason this patch does not apply but I get a problem at this hunk.
Is there a fixup or hunk or two missing from 01/17 ?
I'm starting at 3cea11cd5e3b (Linux 5.10-rc2).

Problem looks like it's at the spin_unlock - here's what the hunk
looks like for me:
fs/nfs/dir.c
1092         inode_lock(inode);
1093         offset += filp->f_pos;
1094         if (offset < 0) {
1095             inode_unlock(inode);
1096             return -EINVAL;
1097         }
1098     }
1099     if (offset != filp->f_pos) {
1100         filp->f_pos = offset;
1101         if (nfs_readdir_use_cookie(filp))
1102             dir_ctx->dir_cookie = offset;
1103         else
1104             dir_ctx->dir_cookie = 0;
1105         dir_ctx->duped = 0;
1106     }
1107     inode_unlock(inode);
1108     return offset;
1109 }



$ git reset --hard 3cea11cd5e3b
HEAD is now at 3cea11cd5e3b Linux 5.10-rc2
$ for f in
~/Downloads/trond-nfs-readdir/v3/*; do echo applying $(basename "$f");
git am "$f"; done
applying [PATCH v3 01_17] NFS_ Ensure contents of struct
nfs_open_dir_context are consistent.eml
Applying: NFS: Ensure contents of struct nfs_open_dir_context are consistent
applying [PATCH v3 02_17] NFS_ Clean up readdir struct nfs_cache_array.eml
Applying: NFS: Clean up readdir struct nfs_cache_array
applying [PATCH v3 03_17] NFS_ Clean up nfs_readdir_page_filler().eml
Applying: NFS: Clean up nfs_readdir_page_filler()
applying [PATCH v3 04_17] NFS_ Clean up directory array handling.eml
Applying: NFS: Clean up directory array handling
applying [PATCH v3 05_17] NFS_ Don't discard readdir results.eml
Applying: NFS: Don't discard readdir results
applying [PATCH v3 06_17] NFS_ Remove unnecessary kmap in
nfs_readdir_xdr_to_array().eml
Applying: NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
applying [PATCH v3 07_17] NFS_ Replace kmap() with kmap_atomic() in
nfs_readdir_search_array().eml
Applying: NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
applying [PATCH v3 08_17] NFS_ Simplify struct nfs_cache_array_entry.eml
Applying: NFS: Simplify struct nfs_cache_array_entry
applying [PATCH v3 09_17] NFS_ Support larger readdir buffers.eml
Applying: NFS: Support larger readdir buffers
applying [PATCH v3 10_17] NFS_ More readdir cleanups.eml
Applying: NFS: More readdir cleanups
applying [PATCH v3 11_17] NFS_ nfs_do_filldir() does not return a value.eml
Applying: NFS: nfs_do_filldir() does not return a value
applying [PATCH v3 12_17] NFS_ Reduce readdir stack usage.eml
Applying: NFS: Reduce readdir stack usage
applying [PATCH v3 13_17] NFS_ Cleanup to remove
nfs_readdir_descriptor_t typedef.eml
Applying: NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
applying [PATCH v3 14_17] NFS_ Allow the NFS generic code to pass in a
verifier to readdir.eml
Applying: NFS: Allow the NFS generic code to pass in a verifier to readdir
applying [PATCH v3 15_17] NFS_ Handle NFS4ERR_NOT_SAME and
NFSERR_BADCOOKIE from readdir calls.eml
Applying: NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
applying [PATCH v3 16_17] NFS_ Improve handling of directory verifiers.eml
Applying: NFS: Improve handling of directory verifiers
error: patch failed: fs/nfs/dir.c:1101
error: fs/nfs/dir.c: patch does not apply
Patch failed at 0001 NFS: Improve handling of directory verifiers
The copy of the patch that failed is found in:
   /home/dwysocha/git/kernel/.git/rebase-apply/patch
When you have resolved this problem, run "git am --resolved".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
applying [PATCH v3 17_17] NFS_ Optimisations for monotonically
increasing readdir cookies.eml
previous rebase directory /home/dwysocha/git/kernel/.git/rebase-apply
still exists but mbox given.

