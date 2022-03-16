Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2984DBAA8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 23:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiCPW0k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 18:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiCPW0j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 18:26:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96025AE5B
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 15:25:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so7114319ejb.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdEbzQFGgUC2obpBVOgXRw+BcVyqauFPV0jnUPzvYFI=;
        b=osTezEdTfcolwrZRRD7Q6ZtCvkkQyAZ/2TJuzfrUxzOTPvvLWiRsHGdSlHqTWWGz+p
         5YcK86r9aKZbr9ptpsXmvhb+3T57cwvpVZdRPvKWnnsjI+t1EFB7qD+arxqeNP6CCf2M
         eDX5YEEWEAbLKJxUPy0nz0ualaSuHdEbV44pNEwMs6j2NPNOwLr9nnbCQBOdF3N7upFF
         pWp/uu5OU8ztJILmtFKjRJFdzMNvoL7iMT/jMPf1DOPzdQOCGlmZsIuwErOkmEupMGtQ
         jkclzld2587nINbonQGV0IhmkrdfaXo016eiIiK/cvlNWrWpPq8sEL0EOA0/JdmE2nJB
         A7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdEbzQFGgUC2obpBVOgXRw+BcVyqauFPV0jnUPzvYFI=;
        b=ljiGDM/577i7WuM65J8Aho+//vxlJwFxk7NlGOPNtf0riu97BognOfPmyeAxGtg6Ab
         7pLEHS4jn7zGm/XFY1qv59FLmpxoQoXqQjPiZmnMfuyD7F2500d/+fomLMRLA61k1aZ8
         Mem59K+4WRKcOHR/66I9lDtbfJufBLr+Ybreaye8i9ZmkNIjEJSWQ35tHK8H22N/rKDu
         qJOgvCi70barVidy+qRqMmziV4Fwdjg3Okm6oqmEhg6r/yLWJ7n+m3Q/vBeXMcDN2ToZ
         3OXZA7fhRaaG+Oq1y6SZZGfzAWbb0ow9IF8x6s6WayDwfWs5LKcAQdN1r8jbSV36v21V
         EAOA==
X-Gm-Message-State: AOAM532tTx5OlyJv5pbWMXnF2KV2ssJZ8c7CJgNoxLOAtxmhDImIyVd0
        b8RVxbB4HmqeVCmMSAhNlwwtpjW07ECogBT3jxg=
X-Google-Smtp-Source: ABdhPJwgmvMr0jJc7gzYawfIQ8EAh4BCvO/rpbOQ0Tqld8pZ5+e11eosOY/VA2cxnl37fFePYDNaQsq5ZyNRBGQXLMI=
X-Received: by 2002:a17:907:1b0e:b0:6da:81ae:a798 with SMTP id
 mp14-20020a1709071b0e00b006da81aea798mr1681460ejc.699.1647469521995; Wed, 16
 Mar 2022 15:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220227231227.9038-1-trondmy@kernel.org> <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org> <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org> <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org> <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org> <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org> <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org> <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org> <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
 <88cb6a4d7a074fd4c4c6b59076df766c7de54105.1646922313.git.bcodding@redhat.com>
In-Reply-To: <88cb6a4d7a074fd4c4c6b59076df766c7de54105.1646922313.git.bcodding@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 16 Mar 2022 18:25:10 -0400
Message-ID: <CAN-5tyFsJy-D9cEfk8zCH8-0KErWteVW8Zb7BMqjL7==2qtT_A@mail.gmail.com>
Subject: Re: [PATCH] NFS: Trigger "ls -l" readdir heuristic sooner
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trondmy@kernel.org, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 11, 2022 at 9:40 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> .. Something like this does the trick in my testing, but yes will have an
> impact on regular workloads:
>
> 8<------------------------------------------------------------------------
>
> Since commit 1a34c8c9a49e ("NFS: Support larger readdir buffers") has
> updated dtsize and recent improvements to the READDIRPLUS helper heuristic,
> the heuristic may not trigger until many dentries are emitted to userspace,
> which may cause many thousands of GETATTR calls for "ls -l" when the
> directory's pagecache has already been populated.  This typically manifests
> as a much slower total runtime for a _second_ invocation of "ls -l" within
> the directory attribute cache timeouts.
>
> Fix this by emitting only 17 entries for any first pass through the NFS
> directory's ->iterate_shared(), which will allow userpace to prime the
> counters for the heuristic.

Here's for what it's worth. An experiment between linux to linux where
the linux server had a "small" directory structure of 57274
directories, 5727390 files in total where each directory had ~100
files each.
With this patch:

date; time tree vol1 > tree.out && date; time tree vol1 > tree.out
Wed Mar 16 12:21:30 EDT 2022

real    11m7.923s
user    0m20.507s
sys     0m39.683s
Wed Mar 16 12:32:38 EDT 2022

real    40m1.751s
user    0m23.477s
sys     0m45.663s

Without the patch:
date; time tree vol1 > tree.out && date; time tree vol1 > tree.out
Wed Mar 16 13:49:12 EDT 2022

real    10m52.909s
user    0m21.342s
sys     0m39.198s
Wed Mar 16 14:00:05 EDT 2022

real    222m56.990s
user    0m30.392s
sys     2m25.202s


>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/dir.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 7e12102b29e7..dc5fc9ba2c49 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1060,6 +1060,8 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
>         return res;
>  }
>
> +#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
> +
>  /*
>   * Once we've found the start of the dirent within a page: fill 'er up...
>   */
> @@ -1069,6 +1071,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
>         struct file     *file = desc->file;
>         struct nfs_cache_array *array;
>         unsigned int i;
> +       bool first_emit = !desc->dir_cookie;
>
>         array = kmap(desc->page);
>         for (i = desc->cache_entry_index; i < array->size; i++) {
> @@ -1092,6 +1095,10 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
>                         desc->ctx->pos = desc->dir_cookie;
>                 else
>                         desc->ctx->pos++;
> +               if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 1) {
> +                       desc->eob = true;
> +                       break;
> +               }
>         }
>         if (array->page_is_eof)
>                 desc->eof = !desc->eob;
> @@ -1173,8 +1180,6 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
>         return status;
>  }
>
> -#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
> -
>  static bool nfs_readdir_handle_cache_misses(struct inode *inode,
>                                             struct nfs_readdir_descriptor *desc,
>                                             unsigned int cache_misses,
> --
> 2.31.1
>
