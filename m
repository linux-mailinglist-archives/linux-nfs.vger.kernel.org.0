Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11348666047
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 17:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAKQVZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 11:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbjAKQUg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 11:20:36 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3C1DF2A
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:18:36 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id t7so10948169qvv.3
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QInJOM56A8ZzMOfRkZbdd/idmpwWnTWTT0b+KAP56V0=;
        b=RyySAOCXSPzmfB65iJ052gJyMGP3418APKwg+TVyyKMInXp+wXX/9KPEVMSVRYwx35
         7alGFSo98Mc95O133Pdrzs1mgTpQ/qkXgzE9jYhCkCIrRPT43gsTXGHbDQjf9OrOO+0I
         RarJPGn0ZENeVce+3vWHeMCnwRKXmInYtwfuU+4YCV/qApMyGg1keeZPCoHEysgewMNZ
         /bm05DSZNbk9kbvET47QHexyRMaeIuBdvQ+y0zhE4/Lehc1X9GezGvw0YWmnXtv089oc
         MJGOOj5tyKXnn9V5KlTWBGOp4q0SsXqaO1R3q/mdkoHNpMAQ9ai6zT9RGYQkBAvzUTcy
         bojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QInJOM56A8ZzMOfRkZbdd/idmpwWnTWTT0b+KAP56V0=;
        b=6k084k5yaBBcOC+MFYR9f8UN+fbIXpTeUJZ6Ki2P/806zlTWgviSJ8Ai6YBj+/2sBu
         iqFinAB4zek9i4ZNJXXh6rZsfpPYi45vRJcq3g3sOMQ96dcwF/xPgbO12Y7poNFX17Fs
         JrvSEokDQpHhow/blqt3E3td0VRt7fky7B2ESK7MI+FWFI/kgErWumI4CcGGLKuF+vRU
         MuPOvM63stmyPefP0a0Bs7LEI7SN7o8ufagC34LEIzxuoDOSCwN8h+7MC19Hpsn+ln5i
         q9SXWsY9iLXdCzACUZ7t7nbU0RULRmmmVz/CpFA07F3NWZG9Tc+zaDeHHj2qBtDIxHc4
         lJvA==
X-Gm-Message-State: AFqh2ko2h53EaFnpZNDo7w83SwC6pyErUmc7Fk72A3hpCMQKqN8F7scN
        b4z4iuiT+Pc2MZOeiE2xUjj51NK/+8bCNCFbyd2O95jswns=
X-Google-Smtp-Source: AMrXdXv7kw/sp4WcRVe3AaesaX1fDWJSfzgkRy/kBOx03Eh346bryvd0QHNxe9YK9VYngNIGU7BhCGZw4QA5BFb02+s=
X-Received: by 2002:a0c:f691:0:b0:532:3011:ab07 with SMTP id
 p17-20020a0cf691000000b005323011ab07mr596192qvn.30.1673453915315; Wed, 11 Jan
 2023 08:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20230107173635.2025233-1-trondmy@kernel.org> <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org> <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org> <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org> <20230107173635.2025233-8-trondmy@kernel.org>
 <20230107173635.2025233-9-trondmy@kernel.org> <20230107173635.2025233-10-trondmy@kernel.org>
In-Reply-To: <20230107173635.2025233-10-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 11 Jan 2023 11:18:19 -0500
Message-ID: <CAFX2Jf=HxgJmuE0CjUcFbw1pekcpYqm7aigeb_XY0rG5Gbje_Q@mail.gmail.com>
Subject: Re: [PATCH 09/17] NFS: Convert the function nfs_wb_page() to use folios
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Sat, Jan 7, 2023 at 12:43 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/write.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 0fbb119022d9..14f98c452595 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -2069,13 +2069,18 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
>         return ret;
>  }
>
> -/*
> - * Write back all requests on one page - we do this before reading it.
> +/**
> + * nfs_wb_folio - Write back all requests on one page
> + * @inode: pointer to page
> + * @folio: pointer to folio
> + *
> + * Assumes that the folio has been locked by the caller, and will
> + * not unlock it.
>   */
> -int nfs_wb_page(struct inode *inode, struct page *page)
> +int nfs_wb_folio(struct inode *inode, struct folio *folio)
>  {
> -       loff_t range_start = page_file_offset(page);
> -       loff_t range_end = range_start + (loff_t)(PAGE_SIZE - 1);
> +       loff_t range_start = folio_file_pos(folio);
> +       loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;
>         struct writeback_control wbc = {
>                 .sync_mode = WB_SYNC_ALL,
>                 .nr_to_write = 0,
> @@ -2087,15 +2092,15 @@ int nfs_wb_page(struct inode *inode, struct page *page)
>         trace_nfs_writeback_page_enter(inode);
>
>         for (;;) {
> -               wait_on_page_writeback(page);
> -               if (clear_page_dirty_for_io(page)) {
> -                       ret = nfs_writepage_locked(page, &wbc);
> +               folio_wait_writeback(folio);
> +               if (folio_clear_dirty_for_io(folio)) {
> +                       ret = nfs_writepage_locked(folio, &wbc);

nfs_writepage_locked() still takes a "struct page *" until the next
patch (NFS: Convert buffered writes to use folios), so I'm seeing this
when I try to compile:

fs/nfs/write.c:2097:31: error: incompatible pointer types passing
'struct folio *' to parameter of type 'struct page *'
[-Werror,-Wincompatible-pointer-types]
                        ret = nfs_writepage_locked(folio, &wbc);
                                                   ^~~~~
fs/nfs/write.c:661:46: note: passing argument to parameter 'page' here
static int nfs_writepage_locked(struct page *page,
                                             ^
1 error generated.
make[3]: *** [scripts/Makefile.build:252: fs/nfs/write.o] Error 1
make[2]: *** [scripts/Makefile.build:504: fs/nfs] Error 2
make[1]: *** [scripts/Makefile.build:504: fs] Error 2
make: *** [Makefile:2008: .] Error 2


>                         if (ret < 0)
>                                 goto out_error;
>                         continue;
>                 }
>                 ret = 0;
> -               if (!PagePrivate(page))
> +               if (!folio_test_private(folio))
>                         break;
>                 ret = nfs_commit_inode(inode, FLUSH_SYNC);
>                 if (ret < 0)
> @@ -2106,17 +2111,9 @@ int nfs_wb_page(struct inode *inode, struct page *page)
>         return ret;
>  }
>
> -/**
> - * nfs_wb_folio - Write back all requests on one page
> - * @inode: pointer to page
> - * @folio: pointer to folio
> - *
> - * Assumes that the folio has been locked by the caller, and will
> - * not unlock it.
> - */
> -int nfs_wb_folio(struct inode *inode, struct folio *folio)
> +int nfs_wb_page(struct inode *inode, struct page *page)
>  {
> -       return nfs_wb_page(inode, &folio->page);
> +       return nfs_wb_folio(inode, page_folio(page));
>  }
>
>  #ifdef CONFIG_MIGRATION
> --
> 2.39.0
>
