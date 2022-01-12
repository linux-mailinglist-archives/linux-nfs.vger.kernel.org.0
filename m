Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8383C48BDF5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 05:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbiALEsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 23:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiALEsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 23:48:38 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF360C061748
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 20:48:37 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id p5so2933016ybd.13
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 20:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLZAC3CMSCIXpnQURW0tWmpIOKmVcmIrl+Z52NxTeuQ=;
        b=LCIkAOvJVwWFouI+xP+uISMFfHNgU9FxU3p7BFxfiPXa+M0vBPwjMymrSUDgziWttR
         p144ZmbB3+yXZm0rpBTHosOYbFVunyGfkCsGwtkDPSkwJwQnfeXAKLxiob6mpjH/1qnr
         ZFIvxkOPQh3H2G2HUVdqapmUPxUsyAJcsLEYGgC1KBGfLGl0gmadY8XUorqu6xa5fihw
         xN5juk8uCbIX47eUEFIAhfe+y9Idl6gNJlzF3gnriES26RuyD3SYMZS281eEmMpgUspK
         l72b5hAJplFcyjP5xYy4kh62C4EQIjBpkW+ileNPV9Ak7yAp3Yp+Bxpawtqe2zIBZYoE
         N3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLZAC3CMSCIXpnQURW0tWmpIOKmVcmIrl+Z52NxTeuQ=;
        b=KQLyXuZLcNPSQwbJbhCYjiXdmUpGLOUHXSj6O/pmJkfjlyk1uPkMOOkynpxaxjn3YE
         ZXGkeoms5kmTWSTMRGBSH9yPtyR2IRsVfAmafqltHJzChXRe21gqrv4z0WPW6wnJ2NVA
         8+g0OHFemhqhUDljOARADfJK2ux8Rdub6M/h1KaOaQZIL5WRuhQ0KkqmXWZCmyHirNMZ
         4gGaZ/Lyh6XCSW8yWubimlGkypOzGAEhhaJNJd5a6B2YY+DxJb1bIAP4BRzePQro9EYT
         WX0wc3OXjZHire3I0L1vC3uVXbAkSGYKkkX5NB5oQx74avc/WZwigqudjJIjen5KsJhi
         qCXQ==
X-Gm-Message-State: AOAM531N84Kt/w5MUxM9PIuL3cuC0LQkf0QEMJN7Uor5DSc08RFS96F9
        cGEmtba/SvSSFsyT8hrAmWwXuCrveajaVYDltIiDS5WTTt+em1x+4+Y=
X-Google-Smtp-Source: ABdhPJzM6r3HV7zixUCi+df2G19UeRviY+iC+6vrvYNbRVy+qhG00MN449rGwCohBbkIGf44mBkrBtf62rcRCnOCTUs=
X-Received: by 2002:a25:abcb:: with SMTP id v69mr10868130ybi.317.1641962916903;
 Tue, 11 Jan 2022 20:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com> <Yd3h2YwGIZs1A+2s@carbon.dhcp.thefacebook.com>
In-Reply-To: <Yd3h2YwGIZs1A+2s@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 12 Jan 2022 12:48:00 +0800
Message-ID: <CAMZfGtVYX=SoHsqRPFeqY4JK=M3cq2VuXJrkns=Q2rQGVZnCnA@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when needed
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 12, 2022 at 4:00 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:43PM +0800, Muchun Song wrote:
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than
> > 2GB memory.
> >
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
> >
> >   crash> p memcg_nr_cache_ids
> >   memcg_nr_cache_ids = $2 = 24574
> >
> > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > can be calculated with the following formula.
> >
> >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> >
> > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> >
> >   crash> list super_blocks | wc -l
> >   952
> >
> > Every mount will register 2 list lrus, one is for inode, another is for
> > dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> > MB (~5.6GB). But the number of memory cgroup is less than 500. So I
> > guess more than 12286 containers have been deployed on this machine (I
> > do not know why there are so many containers, it may be a user's bug or
> > the user really want to do that). And memcg_nr_cache_ids has not been
> > reduced to a suitable value. This can waste a lot of memory.
>
> But on the other side you increase the size of struct list_lru_per_memcg,
> so if number of cgroups is close to memcg_nr_cache_ids, we can actually
> waste more memory.

The saving comes from the fact that we currently allocate scope for every
memcg to be able to be tracked on every superblock instantiated in the system,
regardless of whether that superblock is even accessible to that memcg.

In theory, increasing struct list_lru_per_memcg is not significant, most
savings is from decreasing the number of allocations of struct
list_lru_per_memcg.

> I'm not saying the change is not worth it, but would be
> nice to add some real-world numbers.

OK. I will do a test.

>
> Or it's all irrelevant and is done as a preparation to the conversion to xarray?

Right. It's also a preparation to transfer to xarray.

> If so, please, make it clear.

Will do.

Thanks.
