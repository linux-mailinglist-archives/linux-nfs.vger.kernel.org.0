Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA84C325D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiBXQ4h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiBXQ4f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:56:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABAF3B297
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:56:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so207438wme.0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2u0tTWzB+C7m5LfM7iEbPI+TTHyVsULewsmOsGCCQ50=;
        b=c4hc/QY5AsPyJomMGtHByxU70WaAVKHp9IrehpZko8Nf5zdYUsQMegmneroPsJdkdE
         dv34aWkO34CC9kXL7fK9jHluUxgh/1ZpCDm6Nk8GVyZjhihcDG9bIzkrnEgKTXehsSlq
         paLp+fJhuttH9a+HM9vEnCs/ItJfn0m4Swcs9PyWaF6r/2vp757B2dZlDv1TRfSWcKJw
         yy/mAel8SyQ1S9Betb0OLnHr2dexklfFwcsWbEReSj3J61GeOslS3JE+O2drDFndL3hO
         k8nfQkmq9w9dkq04sZIkoiCdQCLInQd9/4Fh1MEel08smumMCqaWLslUmeyg51jvKdsX
         rLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2u0tTWzB+C7m5LfM7iEbPI+TTHyVsULewsmOsGCCQ50=;
        b=gkA3msI6lhvjL52hmKIXfBvQmbJNmKZw56qtJbw8AtFaVPiTKmsPknh3BLBKxAZNJC
         64qATzkSenpaHDiW6+jn48IiL/09cIwyIxEoKInqxlS96gVgsjdn4MHbfdsZSt+xvCPa
         CY1OePUkEL4FQ6Ioj9PHKwd8XgwJkDFqRvVievJlVXRyf2zD9WXgonaciEBbCKuFGlbR
         5LDv+AneMKAKL7mF38rzCMX6Pod38sLMiMf58sztRUrQ0y4XPNOXURAds9qeINn0kE0i
         rOYy9a4RoBDnnRiLa0IblBJK1QT7Oh3l6vboYyG62If/5v+GfBIc3u6LUl4LI1wQv64X
         uGCQ==
X-Gm-Message-State: AOAM5322L3c96N3QasOD60c9RGeQtNaARXYPHB280TcVkVv0E+eE/M9/
        KfdNtFv89vTHM+FfkUWAYJeWKSN3PMRJJ0l+0aU=
X-Google-Smtp-Source: ABdhPJyMgZLhl4nmgqVsoDChIM/jOxi/AMMkkTdxWsuiBb8jCOg4R8Z46AJ+wj2lYr49eKCG6XyclzBEOHXD0DO3eM4=
X-Received: by 2002:a05:600c:284a:b0:37e:9244:abea with SMTP id
 r10-20020a05600c284a00b0037e9244abeamr3119883wmb.2.1645721761517; Thu, 24 Feb
 2022 08:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20220223211305.296816-1-trondmy@kernel.org> <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org> <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org> <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org> <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org> <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
In-Reply-To: <20220223211305.296816-11-trondmy@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 24 Feb 2022 11:55:45 -0500
Message-ID: <CAFX2JfmLvuh2KROa_tP=_RBXbUg68E--JHutgh1xKPV9en5sfg@mail.gmail.com>
Subject: Re: [PATCH v7 10/21] NFS: Reduce use of uncached readdir
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

On Wed, Feb 23, 2022 at 8:25 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When reading a very large directory, we want to try to keep the page
> cache up to date if doing so is inexpensive. With the change to allow
> readdir to continue reading even when the cache is incomplete, we no
> longer need to fall back to uncached readdir in order to scale to large
> directories.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

As of this patch, cthon tests are passing again.

Anna


Anna

> ---
>  fs/nfs/dir.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 9b0f13b52dbf..982b5dbe30d7 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -986,28 +986,11 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
>         return res;
>  }
>
> -static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
> -{
> -       struct address_space *mapping = desc->file->f_mapping;
> -       struct inode *dir = file_inode(desc->file);
> -       unsigned int dtsize = NFS_SERVER(dir)->dtsize;
> -       loff_t size = i_size_read(dir);
> -
> -       /*
> -        * Default to uncached readdir if the page cache is empty, and
> -        * we're looking for a non-zero cookie in a large directory.
> -        */
> -       return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
> -}
> -
>  /* Search for desc->dir_cookie from the beginning of the page cache */
>  static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
>  {
>         int res;
>
> -       if (nfs_readdir_dont_search_cache(desc))
> -               return -EBADCOOKIE;
> -
>         do {
>                 if (desc->page_index == 0) {
>                         desc->current_index = 0;
> @@ -1262,10 +1245,10 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
>         }
>         if (offset != filp->f_pos) {
>                 filp->f_pos = offset;
> -               if (!nfs_readdir_use_cookie(filp)) {
> +               dir_ctx->page_index = 0;
> +               if (!nfs_readdir_use_cookie(filp))
>                         dir_ctx->dir_cookie = 0;
> -                       dir_ctx->page_index = 0;
> -               } else
> +               else
>                         dir_ctx->dir_cookie = offset;
>                 if (offset == 0)
>                         memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
> --
> 2.35.1
>
