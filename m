Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE42FF1D0
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbhAUR0e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbhAURZ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:25:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C1C061756
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 09:25:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g1so3440515edu.4
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKalawYX95m4ofe8uwpqqcz6HZok0WnI9oBi/8m/nGo=;
        b=hu2o88JfM3B1cK0yBrJ+sluj7biLA+0dxSYa8i3ZQxAcGGg69Ys6h+EgpauSb2o0kL
         H9t4QzoyjiFp0i82UDF8Swdbuq+gvY9UzdODOonK4UXqLTzyq3qpiiy/76kZUy+SS7jj
         V5RZUIcITDBvH8Cz0Nbm5SmKaphBaZIXZzcbt0nv4Yc+8NSRbNjhklRB6iKqRDmawtDN
         avXfYsIezr9C8Q+6kUZNc+gcZ/Xc8DxQ/cybCEtT8CZB/YQpnCHrx5Yc/ybYsSYuBA2N
         /Wuc/Ff9bBvBkQUYQLJdCi0A7FJWjACXhBxKHMN2+SDM1nFZoDB7aqK0Y3DoZTRUbmnK
         s4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKalawYX95m4ofe8uwpqqcz6HZok0WnI9oBi/8m/nGo=;
        b=cNcPJWO9cOINnraYBvhvwuvg2AAoUPIJMBIiSJTW6n8QJcahMflzZWBXCu11UfRaEo
         Uulgn0effc2nuvMrdSoLzG7S9+HxmsIhiYc7pY4Xit6FyDN2f+YJBJ1jpc4EmyPSLVlo
         AT3PAdufa+T4ASP+O2Xd5EUN+fY26DWunc+vyWEL8HsKzoRNatNGmF3WPv+F+ajwuvl8
         sM3pwnEwvWfviNCEXTj3rZYHNBuO7tPqTl5G3bXEg1DRdRjS5o+s2VMIJWxyYLlaArsk
         I0OaTbkXbrUXv3LNxE0/7ozaRuRMdWhMMl0GqY1fkHu7pvx/ILdHjsK+0lGQRG39+pwq
         x7Rg==
X-Gm-Message-State: AOAM5327ZjYOCX/NCfN64JHs88sEyIDvTh8rkUSPW1D0BHKsxuiuhpJC
        D1eSrEs5B/5uhUJi6O9fkMhkTK5WP/PE5/qvl98=
X-Google-Smtp-Source: ABdhPJwDsPbIipEPlJXHufREaeh2kA848JVVGkGME2hcuAAKarveavCNL4x7r+g/i8W0rPTQtwnwjmwuWNXzIRpmmqs=
X-Received: by 2002:a05:6402:c9c:: with SMTP id cm28mr136548edb.281.1611249914293;
 Thu, 21 Jan 2021 09:25:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611160120.git.bcodding@redhat.com> <7394b4d348d0c92b64cd0fb4fbf74bfa6e676d24.1611160121.git.bcodding@redhat.com>
In-Reply-To: <7394b4d348d0c92b64cd0fb4fbf74bfa6e676d24.1611160121.git.bcodding@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 21 Jan 2021 12:24:58 -0500
Message-ID: <CAFX2Jf=Kg+fbxSfgJ_Kzxe6LerQ8RcZu_8AYp2JFF4THDfy8fQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] NFS: Support headless readdir pagecache pages
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

On Wed, Jan 20, 2021 at 12:04 PM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> It is now possible that a reader will resume a directory listing after an
> invalidation and fill the rest of the pages with the offset left over from
> the last partially-filled page.  These pages will then be recycled and
> refilled by the next reader since their alignment is incorrect.
>
> Add an index to the nfs_cache_array that will indicate where the next entry
> should be filled.  This allows partially-filled pages to have the best
> alignment possible.  They are more likely to be useful to readers that
> follow.
>
> This optimization targets the case when there are multiple processes
> listing the directory simultaneously.  Often the processes will collect and
> block on the same page waiting for a READDIR call to fill the pagecache.
> If the pagecache is invalidated, a partially-filled page will usually
> result.  This partially-filled page can immediately be used by all
> processes to emit entries rather than having to discard and refill it for
> every process.
>
> The addition of another integer to struct nfs_cache_array increases its
> size to 24 bytes. We do not lose the original capacity of 127 entries per
> page.

This patch causes cthon basic test #6 to start failing with unexpected
dir entries across all NFS versions:

  ./test6: readdir
  basic tests failed
      ./test6: (/mnt/test/anna/Connectathon/cthon04) unexpected dir entry 'h'

Luckily, the next patch seems to resolve this issue. Could they maybe
be squashed together?

Thanks,
Anna


Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/dir.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 4e21b21c75d0..d6101e45fd66 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -143,6 +143,7 @@ struct nfs_cache_array_entry {
>
>  struct nfs_cache_array {
>         u64 last_cookie;
> +       unsigned int index;
>         unsigned int size;
>         unsigned char page_full : 1,
>                       page_is_eof : 1,
> @@ -179,13 +180,15 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
>         memset(array, 0, sizeof(struct nfs_cache_array));
>  }
>
> -static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
> +static void
> +nfs_readdir_page_init_array(struct page *page, struct nfs_dir_page_cursor *pgc)
>  {
>         struct nfs_cache_array *array;
>
>         array = kmap_atomic(page);
>         nfs_readdir_array_init(array);
> -       array->last_cookie = last_cookie;
> +       array->last_cookie = pgc->index_cookie;
> +       array->index = pgc->entry_index;
>         array->cookies_are_ordered = 1;
>         kunmap_atomic(array);
>         if (page->mapping)
> @@ -224,7 +227,7 @@ void nfs_readdir_clear_array(struct page *page)
>         int i;
>
>         array = kmap_atomic(page);
> -       for (i = 0; i < array->size; i++)
> +       for (i = array->index - array->size; i < array->size; i++)
>                 kfree(array->array[i].name);
>         nfs_readdir_array_init(array);
>         kunmap_atomic(array);
> @@ -232,19 +235,20 @@ void nfs_readdir_clear_array(struct page *page)
>  }
>
>  static void
> -nfs_readdir_recycle_page(struct page *page, u64 last_cookie)
> +nfs_readdir_recycle_page(struct page *page, struct nfs_dir_page_cursor *pgc)
>  {
>         nfs_readdir_clear_array(page);
>         nfs_readdir_invalidatepage(page, 0, 0);
> -       nfs_readdir_page_init_array(page, last_cookie);
> +       nfs_readdir_page_init_array(page, pgc);
>  }
>
>  static struct page *
>  nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
>  {
>         struct page *page = alloc_page(gfp_flags);
> +       struct nfs_dir_page_cursor pgc = { .index_cookie = last_cookie };
>         if (page)
> -               nfs_readdir_page_init_array(page, last_cookie);
> +               nfs_readdir_page_init_array(page, &pgc);
>         return page;
>  }
>
> @@ -309,7 +313,7 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
>
>         if (array->page_full)
>                 return -ENOSPC;
> -       cache_entry = &array->array[array->size + 1];
> +       cache_entry = &array->array[array->index + 1];
>         if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
>                 array->page_full = 1;
>                 return -ENOSPC;
> @@ -336,7 +340,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
>                 goto out;
>         }
>
> -       cache_entry = &array->array[array->size];
> +       cache_entry = &array->array[array->index];
>         cache_entry->cookie = entry->prev_cookie;
>         cache_entry->ino = entry->ino;
>         cache_entry->d_type = entry->d_type;
> @@ -345,6 +349,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
>         array->last_cookie = entry->cookie;
>         if (array->last_cookie <= cache_entry->cookie)
>                 array->cookies_are_ordered = 0;
> +       array->index++;
>         array->size++;
>         if (entry->eof != 0)
>                 nfs_readdir_array_set_eof(array);
> @@ -365,13 +370,15 @@ nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_co
>         ret = true;
>         array = kmap_atomic(page);
>
> -       if ((array->size == 0 || array->size == entry_index)
> -               && array->last_cookie == index_cookie)
> -               goto out_unmap;
> +       if (entry_index >= array->index - array->size) {
> +               if ((array->size == 0 || array->size == entry_index)
> +                       && array->last_cookie == index_cookie)
> +                       goto out_unmap;
>
> -       if (array->size > entry_index &&
> -               array->array[entry_index].cookie == index_cookie)
> -               goto out_unmap;
> +               if (array->size > entry_index &&
> +                       array->array[entry_index].cookie == index_cookie)
> +                       goto out_unmap;
> +       }
>
>         ret = false;
>  out_unmap:
> @@ -391,10 +398,10 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
>                 return page;
>
>         if (!PageUptodate(page))
> -               nfs_readdir_page_init_array(page, pgc->index_cookie);
> +               nfs_readdir_page_init_array(page, pgc);
>
>         if (!nfs_readdir_page_valid(page, pgc->entry_index, pgc->index_cookie))
> -               nfs_readdir_recycle_page(page, pgc->index_cookie);
> +               nfs_readdir_recycle_page(page, pgc);
>
>         return page;
>  }
> @@ -513,7 +520,7 @@ static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
>         /* Optimisation for monotonically increasing cookies */
>         if (cookie >= array->last_cookie)
>                 return false;
> -       if (array->size && cookie < array->array[0].cookie)
> +       if (array->size && cookie < array->array[array->index - array->size].cookie)
>                 return false;
>         return true;
>  }
> @@ -528,7 +535,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
>         if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
>                 goto check_eof;
>
> -       for (i = 0; i < array->size; i++) {
> +       for (i = array->index - array->size; i < array->index; i++) {
>                 if (array->array[i].cookie == desc->dir_cookie) {
>                         struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
>
> @@ -1072,7 +1079,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
>         unsigned int i = 0;
>
>         array = kmap(desc->page);
> -       for (i = desc->pgc.entry_index; i < array->size; i++) {
> +       for (i = desc->pgc.entry_index; i < array->index; i++) {
>                 struct nfs_cache_array_entry *ent;
>
>                 ent = &array->array[i];
> --
> 2.25.4
>
