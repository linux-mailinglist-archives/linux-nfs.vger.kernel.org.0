Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E24C3174
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiBXQbo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiBXQbn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:31:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA41A9054
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:31:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so140434wmb.1
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sgx0aDHfQQaatA33vfIbvvWROj3cPyoEUQuG3hbRL6k=;
        b=KzaXk5P1ivqmyEpc/m18Rc0yua9EKTWM9Pd2OjTRkeDaN3oWa24D+IKgvqsPCeDUEl
         xE9IuDszZAnAivSOdOSfENF8XqeCI5u+C/7AaHlzHwwBFRv9E5ZueIv9YVw9k+sj+087
         ZAUpJDOzdQETGEvRMRNZ7SWaIWHHIarDbbwFZMocHM6Vkdqf4D8D82nOq8whjMQMDGqM
         1q8R23DgQK4YoDr1t0UIvjTx91F8OPqAkbrbMevYVBa4lwrgozijBMignqaVAVgspm3B
         98aF+CmMgn1I7aNrzdKxgT0SAGP/0UN6FDAZReYQW1CbizGkE9kEHxRlBbB2T8oLrK3A
         q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sgx0aDHfQQaatA33vfIbvvWROj3cPyoEUQuG3hbRL6k=;
        b=UDFv9EF5pqg4iMoPApTjKQyy+QGfabtN3Fk/qUo36RrqC5skQIaDVPTCkEhK832FtI
         qqUDbevKaG+z0/IX3RbYrbMbDbZFAYuxx3bIrIFMTBDMlndXdpTaFPNFvmQcuOT2oEIP
         lnOo+81Ke5wPOgHNS9tnadqOhWMS4Isc9eXukjSagymVeVqjxchDWknKCehfTXpqiXor
         IOHA5b6vt1jdGIeMIrg1EprcAi6A97fOKKXcQpwmgOc2dvXmwwqCnlkUBmFiOYRwxDJ7
         0dMjnnLLDjW/xjorAlQWJ5bkCUeSBDjtbcjNIfWHCQSBiqMvVlP72QLJz92d4OoZGUad
         O3iw==
X-Gm-Message-State: AOAM533j0p4sWu73hidG/6swQRNJGwvdGCvp0IDqDrvIgZwnGKFAbxSJ
        eVdjm3NdoWPMHY3cATd6AOXKnfWZ1xwpY6leu/8YyX3jhA7Uqg==
X-Google-Smtp-Source: ABdhPJw6haoL5uZt1tNEZxlRDR5ynlKUW76IYby+JdmLqbF9PpXQW64AGuViSOUUGoH32DY3TYDOx7O8G65hrVCLsBY=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr12463378wms.82.1645720262146; Thu, 24
 Feb 2022 08:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20220223211305.296816-1-trondmy@kernel.org> <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org> <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org> <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org> <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
In-Reply-To: <20220223211305.296816-9-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 24 Feb 2022 11:30:45 -0500
Message-ID: <CAFX2Jfm5Dxy8iG71+wd2daB53ViLtUWb0LgnpDqhaiucEEWxRA@mail.gmail.com>
Subject: Re: [PATCH v7 08/21] NFS: Adjust the amount of readahead performed by
 NFS readdir
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Wed, Feb 23, 2022 at 8:11 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The current NFS readdir code will always try to maximise the amount of
> readahead it performs on the assumption that we can cache anything that
> isn't immediately read by the process.
> There are several cases where this assumption breaks down, including
> when the 'ls -l' heuristic kicks in to try to force use of readdirplus
> as a batch replacement for lookup/getattr.
>
> This patch therefore tries to tone down the amount of readahead we
> perform, and adjust it to try to match the amount of data being
> requested by user space.

I'm seeing cthon basic tests fail at this patch, but I'm unsure if it
would have started now or in patches 6 or 7 due to the earlier compile
error. The other cthon tests still pass, however:

Thu Feb 24 11:27:44 EST 2022
./server -b -o tcp,v3,sec=sys -m /mnt/nfsv3tcp -p /srv/test/anna/nfsv3tcp server
./server -b -o proto=tcp,sec=sys,v4.0 -m /mnt/nfsv4tcp -p
/srv/test/anna/nfsv4tcp server
./server -b -o proto=tcp,sec=sys,v4.1 -m /mnt/nfsv41tcp -p
/srv/test/anna/nfsv41tcp server
./server -b -o proto=tcp,sec=sys,v4.2 -m /mnt/nfsv42tcp -p
/srv/test/anna/nfsv42tcp server
Waiting for 'b' to finish...
The '-b' test using '-o tcp,v3,sec=sys' args to server: Failed!!
The '-b' test using '-o proto=tcp,sec=sys,v4.0' args to server: Failed!!
The '-b' test using '-o proto=tcp,sec=sys,v4.2' args to server: Failed!!
The '-b' test using '-o proto=tcp,sec=sys,v4.1' args to server: Failed!!
 Done: 11:27:46

Anna

>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c           | 55 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/nfs_fs.h |  1 +
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 70c0db877815..83933b7018ea 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -69,6 +69,8 @@ const struct address_space_operations nfs_dir_aops = {
>         .freepage = nfs_readdir_clear_array,
>  };
>
> +#define NFS_INIT_DTSIZE PAGE_SIZE
> +
>  static struct nfs_open_dir_context *
>  alloc_nfs_open_dir_context(struct inode *dir)
>  {
> @@ -78,6 +80,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
>         if (ctx != NULL) {
>                 ctx->attr_gencount = nfsi->attr_gencount;
> +               ctx->dtsize = NFS_INIT_DTSIZE;
>                 spin_lock(&dir->i_lock);
>                 if (list_empty(&nfsi->open_files) &&
>                     (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
> @@ -153,6 +156,7 @@ struct nfs_readdir_descriptor {
>         struct page     *page;
>         struct dir_context *ctx;
>         pgoff_t         page_index;
> +       pgoff_t         page_index_max;
>         u64             dir_cookie;
>         u64             last_cookie;
>         u64             dup_cookie;
> @@ -165,12 +169,36 @@ struct nfs_readdir_descriptor {
>         unsigned long   gencount;
>         unsigned long   attr_gencount;
>         unsigned int    cache_entry_index;
> +       unsigned int    buffer_fills;
> +       unsigned int    dtsize;
>         signed char duped;
>         bool plus;
>         bool eob;
>         bool eof;
>  };
>
> +static void nfs_set_dtsize(struct nfs_readdir_descriptor *desc, unsigned int sz)
> +{
> +       struct nfs_server *server = NFS_SERVER(file_inode(desc->file));
> +       unsigned int maxsize = server->dtsize;
> +
> +       if (sz > maxsize)
> +               sz = maxsize;
> +       if (sz < NFS_MIN_FILE_IO_SIZE)
> +               sz = NFS_MIN_FILE_IO_SIZE;
> +       desc->dtsize = sz;
> +}
> +
> +static void nfs_shrink_dtsize(struct nfs_readdir_descriptor *desc)
> +{
> +       nfs_set_dtsize(desc, desc->dtsize >> 1);
> +}
> +
> +static void nfs_grow_dtsize(struct nfs_readdir_descriptor *desc)
> +{
> +       nfs_set_dtsize(desc, desc->dtsize << 1);
> +}
> +
>  static void nfs_readdir_array_init(struct nfs_cache_array *array)
>  {
>         memset(array, 0, sizeof(struct nfs_cache_array));
> @@ -774,6 +802,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
>                                 break;
>                         arrays++;
>                         *arrays = page = new;
> +                       desc->page_index_max++;
>                 } else {
>                         new = nfs_readdir_page_get_next(mapping,
>                                                         page->index + 1,
> @@ -783,6 +812,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
>                         if (page != *arrays)
>                                 nfs_readdir_page_unlock_and_put(page);
>                         page = new;
> +                       desc->page_index_max = new->index;
>                 }
>                 status = nfs_readdir_add_to_array(entry, page);
>         } while (!status && !entry->eof);
> @@ -848,7 +878,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
>         struct nfs_entry *entry;
>         size_t array_size;
>         struct inode *inode = file_inode(desc->file);
> -       size_t dtsize = NFS_SERVER(inode)->dtsize;
> +       unsigned int dtsize = desc->dtsize;
>         int status = -ENOMEM;
>
>         entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> @@ -884,6 +914,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
>
>                 status = nfs_readdir_page_filler(desc, entry, pages, pglen,
>                                                  arrays, narrays);
> +               desc->buffer_fills++;
>         } while (!status && nfs_readdir_page_needs_filling(page) &&
>                 page_mapping(page));
>
> @@ -931,6 +962,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
>         if (!desc->page)
>                 return -ENOMEM;
>         if (nfs_readdir_page_needs_filling(desc->page)) {
> +               desc->page_index_max = desc->page_index;
>                 res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
>                                                &desc->page, 1);
>                 if (res < 0) {
> @@ -1067,6 +1099,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>         desc->cache_entry_index = 0;
>         desc->last_cookie = desc->dir_cookie;
>         desc->duped = 0;
> +       desc->page_index_max = 0;
>
>         status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
>
> @@ -1076,10 +1109,22 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>         }
>         desc->page = NULL;
>
> +       /*
> +        * Grow the dtsize if we have to go back for more pages,
> +        * or shrink it if we're reading too many.
> +        */
> +       if (!desc->eof) {
> +               if (!desc->eob)
> +                       nfs_grow_dtsize(desc);
> +               else if (desc->buffer_fills == 1 &&
> +                        i < (desc->page_index_max >> 1))
> +                       nfs_shrink_dtsize(desc);
> +       }
>
>         for (i = 0; i < sz && arrays[i]; i++)
>                 nfs_readdir_page_array_free(arrays[i]);
>  out:
> +       desc->page_index_max = -1;
>         kfree(arrays);
>         dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
>         return status;
> @@ -1118,6 +1163,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>         desc->file = file;
>         desc->ctx = ctx;
>         desc->plus = nfs_use_readdirplus(inode, ctx);
> +       desc->page_index_max = -1;
>
>         spin_lock(&file->f_lock);
>         desc->dir_cookie = dir_ctx->dir_cookie;
> @@ -1128,6 +1174,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>         desc->last_cookie = dir_ctx->last_cookie;
>         desc->attr_gencount = dir_ctx->attr_gencount;
>         desc->eof = dir_ctx->eof;
> +       nfs_set_dtsize(desc, dir_ctx->dtsize);
>         memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
>         spin_unlock(&file->f_lock);
>
> @@ -1169,6 +1216,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>
>                 nfs_do_filldir(desc, nfsi->cookieverf);
>                 nfs_readdir_page_unlock_and_put_cached(desc);
> +               if (desc->eob || desc->eof)
> +                       break;
> +               /* Grow the dtsize if we have to go back for more pages */
> +               if (desc->page_index == desc->page_index_max)
> +                       nfs_grow_dtsize(desc);
>         } while (!desc->eob && !desc->eof);
>
>         spin_lock(&file->f_lock);
> @@ -1179,6 +1231,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>         dir_ctx->attr_gencount = desc->attr_gencount;
>         dir_ctx->page_index = desc->page_index;
>         dir_ctx->eof = desc->eof;
> +       dir_ctx->dtsize = desc->dtsize;
>         memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
>         spin_unlock(&file->f_lock);
>  out_free:
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 1c533f2c1f36..691a27936849 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -107,6 +107,7 @@ struct nfs_open_dir_context {
>         __u64 dup_cookie;
>         __u64 last_cookie;
>         pgoff_t page_index;
> +       unsigned int dtsize;
>         signed char duped;
>         bool eof;
>  };
> --
> 2.35.1
>
