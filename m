Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06F52EB63
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiETMAv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348879AbiETMAo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 08:00:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA84240A38;
        Fri, 20 May 2022 05:00:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a3so13815767ybg.5;
        Fri, 20 May 2022 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsuQwYfm5G6xrNGiS/dHpJ/FwoJ31MhACc8+V8rTgs4=;
        b=QNjKLehntMGX87wICh6YufpfX4yIxbslpam/PjvE0Xqsw4x/7SguqhkrUfBzEP1n4V
         ilJureFeTvKEVR9uUcEw39VUnCUlNIjkgBYYXqcnQ9k3ZNmwiEWk2DKRg8flJc7/X3BA
         ftK3v+kWAg8AUIL5dT+olwc39P/fHaXiMLSKPD6yIYG1qE2IJugelGfjj9pfZ8Y8BxGS
         bpsYdLHIm0VRROCIRwSjkl2d0CI4xsPYwdFTcyvFw0TRx1YKZjO1H0q3jyH55CIa4Q9c
         gYbSYOf5HfR8q7KGz8AieiBQvWUkjZpGEfRwB9NX0APmg68uXrQY70xnb1tBe4PFggJu
         E8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsuQwYfm5G6xrNGiS/dHpJ/FwoJ31MhACc8+V8rTgs4=;
        b=qPMlhcxmZyYupxUiseBRQgH7p3eiEdfFJlcd77udUHDMoClYnFwze5TbJXSWtGPb6Z
         2nvwPLIOtWrfnn8reVhjQzri4/Q7bfgbwQnQSr/syNhOPxLvoFTbrQf7Z+3PWAdVIxTH
         6B+DC+cmQYHUeZUhSJLJSUHTa59BLFdqgUbZg2Ouh3bllyLp6ZyMuRE9FL0RAPvoqJmJ
         6jIAtXj1bNjIBgtwpooGDm867Ki0+fcDfbIR5f58DN3a4yEg2Vn2PWS3Wz3ZDAQntJKm
         CV29eYigOCzjB3Ce6VxZRMp95ieCKN8oBH08IhxpDrpat2FfWaYmIUDZAB9GiwT8Nt+U
         OGhQ==
X-Gm-Message-State: AOAM531QpCnEQVK1eq3vKik5vRFLBLvbn9jGjvH8jwaacus6OF9mlOse
        ijVKiwkgxyEwOj/oGnlpWdFsuPVxhXXqywBhKZ4=
X-Google-Smtp-Source: ABdhPJwujyCk/43sRIvp26J8wkO6JVNTSR+PioHs1VjDwLcTBQGwCdzMjlSPwT7BjDW2IjsCeP9z3sYt2L4qkTFGzX8=
X-Received: by 2002:a25:a222:0:b0:64a:edb4:cf02 with SMTP id
 b31-20020a25a222000000b0064aedb4cf02mr8875692ybi.615.1653048038443; Fri, 20
 May 2022 05:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220520115714.47321-1-javier.abrego.lorente@gmail.com>
In-Reply-To: <20220520115714.47321-1-javier.abrego.lorente@gmail.com>
From:   Javier Abrego Lorente <javier.abrego.lorente@gmail.com>
Date:   Fri, 20 May 2022 14:00:02 +0200
Message-ID: <CAPsi6X+M11NttnV80dYhA=0t=ZGH1YR1ZGssEZvz+kN8RYTcbw@mail.gmail.com>
Subject: Re: [PATCH] FS: nfs: removed goto statement
To:     Javier Abrego <javier.abrego.lorente@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

final version, I promise.

On Fri, 20 May 2022 at 13:57, Javier Abrego
<javier.abrego.lorente@gmail.com> wrote:
>
> In this function goto can be replaced. Avoiding goto will improve the
> readability
>
> Signed-off-by: Javier Abrego<javier.abrego.lorente@gmail.com>
> ---
>  fs/nfs/nfs42xattr.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index e7b34f7e0..78130462c 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -747,20 +747,18 @@ void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
>                 return;
>
>         entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
> -       if (entry == NULL)
> -               goto out;
> -
> -       /*
> -        * This is just there to be able to get to bucket->cache,
> -        * which is obviously the same for all buckets, so just
> -        * use bucket 0.
> -        */
> -       entry->bucket = &cache->buckets[0];
> -
> -       if (!nfs4_xattr_set_listcache(cache, entry))
> -               kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> +       if (entry != NULL) {
> +              /*
> +               * This is just there to be able to get to bucket->cache,
> +               * which is obviously the same for all buckets, so just
> +               * use bucket 0.
> +               */
> +               entry->bucket = &cache->buckets[0];
> +
> +               if (!nfs4_xattr_set_listcache(cache, entry))
> +                       kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> +       }
>
> -out:
>         kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
>  }
>
> --
> 2.25.1
>
