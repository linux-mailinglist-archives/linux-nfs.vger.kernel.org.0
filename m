Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568E06BA0BA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCNU2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCNU2b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 16:28:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD620565
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 13:28:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r1so4365743ybu.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Mar 2023 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1678825708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mEMC6QS48jaHa/mQ7rCJGL+TiPOvzlcCTCRPKhz2OOU=;
        b=G44Hjgc6MboyDzkdf58ZURZMKA4NcJCahlS7/VUUUcOSrObtRwrU/3Rso8PHQ/mI7f
         tkWgUz6U3yRrJpc7l6wwd/C8s+WQ/RbMdXfdZzD6/33Kz83G1sHgWFTAXKSdPFmG6EHO
         MgWAYLuX63b7KwC7JaGhMWbkt8TtwGBA8qV/VT4MOe2QLZZXqzuJpAj8SdXEIyIq2xga
         Jnla7IydfUgMvwZTWnegAM8tbuPHyMk7H5Btwxl4ePtax/CHWH8PBWEx2UF85vYKt2GF
         qgnulkFaaQ3UXiiYw/VpYEjCFov+jqB5UWhMLCadW49dmEs8/8QDVe+YRXqiLkPu9l0+
         u9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEMC6QS48jaHa/mQ7rCJGL+TiPOvzlcCTCRPKhz2OOU=;
        b=cODm8bPJ7Sb20yzkK5PaRwAxRIczdnIly1lIDcW8mFnKW4ChXtFK/LJWlSnhW0cgXM
         ypTBP+aOhhl69jD1eXQ+W83fW34OCZOTZum02D3OXH0pwNXxmtOrIG6UBvpsrVw7ZOZ8
         6pw3cqgL8jIz9Lp9PAF1xmQwetAi+b894EXDLO32C6P959T40uzh1ctCJgTMBNm6u2W/
         Eyjb/5bkIiN56QVNHL5csy6eAavcP3PpaJq5QMTACRmmnINwF/eLKvYh4XKnK7esht2U
         +p0i61V0ion5YO8odB2rwwKdcEPeZ6DTRO55ZXVwxoh62BAauJtWMAcOxVE8MgrPuWsV
         q7hQ==
X-Gm-Message-State: AO0yUKUbwug2RsRVYHZeq7aqHrenRggpFkV7T+3lEhmWf6YJ9trSwJRn
        FJVY4JE8r8WhNI3dbwIT6VpxQC0Edazsh4pHXYtPOw==
X-Google-Smtp-Source: AK7set/45E7PZ1VgU0S5whJcmzasAC368yVrAHkgUypAYe+NVfFMZM444Z2AX7H+Y7Uz/TIKHzQU5HGVJqzsXpm2poo=
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr24374192ybp.4.1678825708376; Tue, 14
 Mar 2023 13:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230309185852.1151546-1-dwysocha@redhat.com> <20230309185852.1151546-2-dwysocha@redhat.com>
In-Reply-To: <20230309185852.1151546-2-dwysocha@redhat.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 14 Mar 2023 20:27:52 +0000
Message-ID: <CAPt2mGOQ9ic3vTeEZKT=GvmSsq-MxdjxLWEv-GtLMb-5n4MGCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFS: Fix /proc/PID/io read_bytes for buffered reads
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Daire Byrne <daire.byrne@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Dave.

I can confirm that this does indeed fix the reporting of
/proc/PID/read_bytes for us. I actually applied it (cleanly) to our
v5.18 based kernel as we use that in production on our render farm.

We use the read_bytes in our post render statistics to help track per render IO.

Tested-by: Daire Byrne <daire@dneg.com>


On Thu, 9 Mar 2023 at 19:00, Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> Prior to commit 8786fde8421c ("Convert NFS from readpages to
> readahead"), nfs_readpages() used the old mm interface read_cache_pages()
> which called task_io_account_read() for each NFS page read.  After
> this commit, nfs_readpages() is converted to nfs_readahead(), which
> now uses the new mm interface readahead_page().  The new interface
> requires callers to call task_io_account_read() themselves.
> In addition, to nfs_readahead() task_io_account_read() should also
> be called from nfs_read_folio().
>
> Fixes: 8786fde8421c ("Convert NFS from readpages to readahead")
> Link: https://lore.kernel.org/linux-nfs/CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com/
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/read.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index c380cff4108e..e90988591df4 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -15,6 +15,7 @@
>  #include <linux/stat.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/task_io_accounting_ops.h>
>  #include <linux/pagemap.h>
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/nfs_fs.h>
> @@ -337,6 +338,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
>
>         trace_nfs_aop_readpage(inode, folio);
>         nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
> +       task_io_account_read(folio_size(folio));
>
>         /*
>          * Try to flush any pending writes to the file..
> @@ -393,6 +395,7 @@ void nfs_readahead(struct readahead_control *ractl)
>
>         trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
>         nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
> +       task_io_account_read(readahead_length(ractl));
>
>         ret = -ESTALE;
>         if (NFS_STALE(inode))
> --
> 2.31.1
>
