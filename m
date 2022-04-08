Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E74F9945
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiDHPXs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDHPXs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 11:23:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77998107088
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 08:21:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g9so15660097ybj.9
        for <linux-nfs@vger.kernel.org>; Fri, 08 Apr 2022 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rARwp4JxtbGtTKS2McwI+fd9OeZSQmaskuxhRCfKtcg=;
        b=oNcOEGJeEM6+C/nhpF6J8+VP4jutRRk8+sSDAxBNhh8a6EXN9CvJqj/DoZ31GjFY8b
         E8fWg/fMP9c0xnpkkmQUB2zybOURwhFqnChsD1OpmDKfQ7SEXjCCD7JWCvhjt5seHZQf
         7cFNgk4FKt7LG4SRpC9N3KBp1QWWZPllT3eMNYTmAT34FJPntVkpo6+s/t5o25atpLMO
         5CnZvFAhZgMSJm3aCbYnt0m5SVkiyE1Ro8HamvZuTyNuutmj9CS+MG5XpsuPMiENc6IL
         Tsfr8/fDQPgVXDb6qJBO0pz9zA2XvkilOHhsocoXiVQ8PE57zd6KP19DRuVy+hebGyAm
         025w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rARwp4JxtbGtTKS2McwI+fd9OeZSQmaskuxhRCfKtcg=;
        b=4E/m1IPQZleR38SIUKy7xYnC1ww+JLL7Sqil4+dumDGfO7nF3r/P5cabHfnYVq6InR
         NEAOoqOGlvEmqqcjOfApSPeRtNqq0/Bfh3Gs1uIlucOJ6xzJu1bmLHEu5pT3ecG7NRMr
         PFpy8CXXNEt3BUEGvE1eoRW7cOSs7VFwn/yh6qShlVKLiEWL2B9XKEhjpWmoeiipuQxr
         vv+bBbB2DZkZysQjREwOArg16dq6JzAA2U4NZFcxEhsOCCGzWi0p4Hrz4XlA07PSU0u1
         fcs+4SnGPcsSFBT8qZg9IieETEYtY6oFzf9OPoaVpOmqDAvenRgXzZohrE5NDKXBC19X
         Jqtw==
X-Gm-Message-State: AOAM53254xAH965znDwKSj+GFeeUQtngXPJTKZAK5Ciy4E2TCrPEG/Tr
        m9gyM3f5/NL1yWxq0YCDPgf0AM/1JIpPqktb4YNuKQxV68Y=
X-Google-Smtp-Source: ABdhPJx68hCF4vUhuIp51kdWz+tAGehjCiR66J/VDn3Ou3yAhliWQJiG4Tjsa0u6rXA88y+JQI2a0P77hcEoIlCDDk0=
X-Received: by 2002:a25:e905:0:b0:641:cf9:9522 with SMTP id
 n5-20020a25e905000000b006410cf99522mr1688463ybd.132.1649431303689; Fri, 08
 Apr 2022 08:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220401025905.49771-1-songmuchun@bytedance.com>
In-Reply-To: <20220401025905.49771-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Apr 2022 23:21:07 +0800
Message-ID: <CAMZfGtV7Uf3Z1G-0WQNe_DukPz4t5HuxPRrNMVLJ1GVST9jQpA@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on
 kmem_cache allocation
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>, NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ping

Could someone be willing to help merge this?

On Fri, Apr 1, 2022 at 10:59 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The commit 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory
> allocation flags") has stripped GFP_KERNEL_ACCOUNT down to GFP_KERNEL,
> however, it forgot to remove SLAB_ACCOUNT from kmem_cache allocation.
> It means that memory is still limited by kmemcg.  This patch also fix a
> NULL pointer reference issue [1] reported by NeilBrown.
>
> Link: https://lore.kernel.org/all/164870069595.25542.17292003658915487357@noble.neil.brown.name/ [1]
> Fixes: 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory allocation flags")
> Fixes: 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")
> Reported-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/nfs/nfs42xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index ad3405c64b9e..e7b34f7e0614 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -997,7 +997,7 @@ int __init nfs4_xattr_cache_init(void)
>
>         nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
>             sizeof(struct nfs4_xattr_cache), 0,
> -           (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +           (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
>             nfs4_xattr_cache_init_once);
>         if (nfs4_xattr_cache_cachep == NULL)
>                 return -ENOMEM;
> --
> 2.11.0
>
