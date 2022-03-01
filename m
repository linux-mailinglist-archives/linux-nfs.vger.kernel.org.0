Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876364C93F5
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCATKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 14:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCATKj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 14:10:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AAE63BED
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 11:09:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m6so4822885wrr.10
        for <linux-nfs@vger.kernel.org>; Tue, 01 Mar 2022 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLSiye/5+ivgxlmsBzxK7LRGfKRzcHn7bItowny/HzQ=;
        b=OvWyjR4GhqaJ2yQ4X3RuhPdF1f05YijaZVPnLLOAuOEGS8GnKcn5ruzSZ80x2kthrj
         XoOVqa00Ic2fdph+XrIvR1PRl9zpxWCMBvmr2Qfro0AiBZPrIvepF3HUu7SoMXymuRk9
         jFNed/MDps0GdQqLsHu+nQK5gTi+/2afpFHexL3JsBz4IOZP+nS3yXjG2vmx1eYujVc9
         bGzUzhGC7CQtwcoaLEsx5fZk7r2RYRYhnrgmBm08nBIvDrbaDzHWVbfF4ipjkPO08QcF
         vzijwD4u0g9Bsk53V/anJxl//fBBQmdtlW4EBIPBhnnKRgq0YYqSnw+TJ4oHTieSeQef
         Okig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLSiye/5+ivgxlmsBzxK7LRGfKRzcHn7bItowny/HzQ=;
        b=xZILqN5zKCqXr6z80/aquFUMbzQADEhMsjBTk9Jes8IOPp/CGYwHOzauXUgL8kR5OS
         zmckHbVev9tC4QrgYyQ5M5rqfVh886rS1YeF24IIQdZT4UemZ0+L6WM6CiHcJ/Y5eKaJ
         z5zdNEN8M2Sw9zdbySvF0SEZtYcjC7z5+whinlgXOl0OCq2+d+dlvqvlYbFMDEvurJYy
         07oojEUowHVRDEe8d2jCWcf7Sgs0pA2lmT+5aHHVv7nnxU4G4xCMmgJlbRK+Cq+unT2r
         PaOZvDVNRL7ySzisGH0nPwqS4QGOrkhzuQNFDRd3qSFN91AgBr/yPn7ONbSgRUbhauNO
         w/TQ==
X-Gm-Message-State: AOAM532ELsYV6DxaVvc36PwLFH/l3tURIXJfQhbdyhYenz8l0RMFxnRu
        CGikIIXLpb8k0YBeeAbIzfarfipAMjXe4eaTNZYaS4RqDgJR6Q==
X-Google-Smtp-Source: ABdhPJxKYEg2ggngMfrGQix0KEzR63dX0FZNqJ+H8rh6rS+h3mXA2cKwbZIzrJU5YgYFwIhTXf1zk7u/TpAE2cswlvI=
X-Received: by 2002:a5d:6ace:0:b0:1ed:89dc:a456 with SMTP id
 u14-20020a5d6ace000000b001ed89dca456mr20413439wrw.114.1646161795840; Tue, 01
 Mar 2022 11:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20220227231227.9038-1-trondmy@kernel.org> <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org> <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org> <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org> <20220227231227.9038-8-trondmy@kernel.org>
In-Reply-To: <20220227231227.9038-8-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 1 Mar 2022 14:09:39 -0500
Message-ID: <CAFX2JfkPjKN81yWjZYtT+0uGquqq2tYy7RRX9bQr2NaSYsvuLw@mail.gmail.com>
Subject: Re: [PATCH v9 07/27] NFS: Store the change attribute in the directory
 page cache
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

On Mon, Feb 28, 2022 at 5:51 AM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Use the change attribute and the first cookie in a directory page cache
> entry to validate that the page is up to date.

Starting with this patch I'm seeing cthon basic tests fail on NFS v3:

Tue Mar  1 14:08:39 EST 2022
./server -b -o tcp,v3,sec=sys -m /mnt/nfsv3tcp -p /srv/test/anna/nfsv3tcp server
./server -b -o proto=tcp,sec=sys,v4.0 -m /mnt/nfsv4tcp -p
/srv/test/anna/nfsv4tcp server
./server -b -o proto=tcp,sec=sys,v4.1 -m /mnt/nfsv41tcp -p
/srv/test/anna/nfsv41tcp server
./server -b -o proto=tcp,sec=sys,v4.2 -m /mnt/nfsv42tcp -p
/srv/test/anna/nfsv42tcp server
Waiting for 'b' to finish...
The '-b' test using '-o tcp,v3,sec=sys' args to server: Failed!!
 Done: 14:08:41

Anna
>
> Suggested-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 68 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 6f0a38db6c37..bfb553c57274 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -140,6 +140,7 @@ struct nfs_cache_array_entry {
>  };
>
>  struct nfs_cache_array {
> +       u64 change_attr;
>         u64 last_cookie;
>         unsigned int size;
>         unsigned char page_full : 1,
> @@ -176,12 +177,14 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
>         memset(array, 0, sizeof(struct nfs_cache_array));
>  }
>
> -static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
> +static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
> +                                       u64 change_attr)
>  {
>         struct nfs_cache_array *array;
>
>         array = kmap_atomic(page);
>         nfs_readdir_array_init(array);
> +       array->change_attr = change_attr;
>         array->last_cookie = last_cookie;
>         array->cookies_are_ordered = 1;
>         kunmap_atomic(array);
> @@ -208,7 +211,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
>  {
>         struct page *page = alloc_page(gfp_flags);
>         if (page)
> -               nfs_readdir_page_init_array(page, last_cookie);
> +               nfs_readdir_page_init_array(page, last_cookie, 0);
>         return page;
>  }
>
> @@ -305,19 +308,43 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
>         return ret;
>  }
>
> +static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
> +                                     u64 change_attr)
> +{
> +       struct nfs_cache_array *array = kmap_atomic(page);
> +       int ret = true;
> +
> +       if (array->change_attr != change_attr)
> +               ret = false;
> +       if (array->size > 0 && array->array[0].cookie != last_cookie)
> +               ret = false;
> +       kunmap_atomic(array);
> +       return ret;
> +}
> +
> +static void nfs_readdir_page_unlock_and_put(struct page *page)
> +{
> +       unlock_page(page);
> +       put_page(page);
> +}
> +
>  static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
>                                                 pgoff_t index, u64 last_cookie)
>  {
>         struct page *page;
> +       u64 change_attr;
>
>         page = grab_cache_page(mapping, index);
> -       if (page && !PageUptodate(page)) {
> -               nfs_readdir_page_init_array(page, last_cookie);
> -               if (invalidate_inode_pages2_range(mapping, index + 1, -1) < 0)
> -                       nfs_zap_mapping(mapping->host, mapping);
> -               SetPageUptodate(page);
> +       if (!page)
> +               return NULL;
> +       change_attr = inode_peek_iversion_raw(mapping->host);
> +       if (PageUptodate(page)) {
> +               if (nfs_readdir_page_validate(page, last_cookie, change_attr))
> +                       return page;
> +               nfs_readdir_clear_array(page);
>         }
> -
> +       nfs_readdir_page_init_array(page, last_cookie, change_attr);
> +       SetPageUptodate(page);
>         return page;
>  }
>
> @@ -357,12 +384,6 @@ static void nfs_readdir_page_set_eof(struct page *page)
>         kunmap_atomic(array);
>  }
>
> -static void nfs_readdir_page_unlock_and_put(struct page *page)
> -{
> -       unlock_page(page);
> -       put_page(page);
> -}
> -
>  static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
>                                               pgoff_t index, u64 cookie)
>  {
> @@ -419,16 +440,6 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
>         return -EBADCOOKIE;
>  }
>
> -static bool
> -nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
> -{
> -       if (nfsi->cache_validity & (NFS_INO_INVALID_CHANGE |
> -                                   NFS_INO_INVALID_DATA))
> -               return false;
> -       smp_rmb();
> -       return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
> -}
> -
>  static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
>                                               u64 cookie)
>  {
> @@ -457,8 +468,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
>                         struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
>
>                         new_pos = nfs_readdir_page_offset(desc->page) + i;
> -                       if (desc->attr_gencount != nfsi->attr_gencount ||
> -                           !nfs_readdir_inode_mapping_valid(nfsi)) {
> +                       if (desc->attr_gencount != nfsi->attr_gencount) {
>                                 desc->duped = 0;
>                                 desc->attr_gencount = nfsi->attr_gencount;
>                         } else if (new_pos < desc->prev_index) {
> @@ -1095,11 +1105,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
>          * to either find the entry with the appropriate number or
>          * revalidate the cookie.
>          */
> -       if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
> -               res = nfs_revalidate_mapping(inode, file->f_mapping);
> -               if (res < 0)
> -                       goto out;
> -       }
> +       nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
>
>         res = -ENOMEM;
>         desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> --
> 2.35.1
>
