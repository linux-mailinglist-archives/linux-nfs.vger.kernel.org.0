Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE404743D8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Dec 2021 14:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhLNNu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Dec 2021 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhLNNu4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Dec 2021 08:50:56 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E770C061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 05:50:56 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id s9so17217797qvk.12
        for <linux-nfs@vger.kernel.org>; Tue, 14 Dec 2021 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rx+hqR5BLDytRmc1k+qRylCXkJ+6AQ7elY7tUqHK8RA=;
        b=SAn4jhcDHzoZJgY6lNfz1wDtjhMMGbgWvc0lPp7zZX7SuNOLZF+4qB4Ky040g04jVZ
         xzMHRnnCINKQEcs6YvsOWKPpXyj9FidivDBbfCEzj/PbELvdznhM0sKgL4YmEZJlIo+n
         KUmcaQT76EqQI5jsUrshYIfS28FPn4nvLmbOOjACQ5tLrpXYwpVnsv8tC6M4gJXFrrXj
         4GHfTbdKjqLNERoy9OCH0WdYGV+IrpdndDDYITNl57sFm+XGTuVTi0jOIy2CUNoTjzXu
         Gbs1xM2qzeapIYvRFeiedU155eAv2wfclcaONKwzBjxndW3piEWPi2Mlr/c7IAarZUhC
         nRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rx+hqR5BLDytRmc1k+qRylCXkJ+6AQ7elY7tUqHK8RA=;
        b=xGajjiAwCv4yn/7f+wAbHi2+K5J9uE5mRrQo8++6JxhBUGKKNosn/lzEj3OheQ+RBB
         5og7e4gLiUeCVbKkKQl3knxFk/lIPlW7RlkMBLXZJ/4YJCkb8G0UlrAl6BJh0wwy9VX9
         IK2stoRdP8VqBKJXi/Sce23XwWpO4ICworu2dqTYOhiBXScIO6SOkBrIGCwSH8xAuEZE
         zr6+rvAzkV2mo7dK/b8EoiMOeGC6rrSRdm3tAQIQ6sww7WIDRmKXkfGgdyD/pi8Cytoa
         bH5XhlxgzvsrGEgg2gP1OdBvW7gWMhyaHbmvVPQ5jUwOePtCgAG01Oo+G719mtuNBDtm
         FwbQ==
X-Gm-Message-State: AOAM530OfHXipUrsI/NIYFsAQ7va0fCvHRyhN9S0sZTiNR4RY3CFU9eq
        cDz0vA+/FSCwYXgIcD/Hf5pE/Q==
X-Google-Smtp-Source: ABdhPJyY3iPu7+f980O6CZq77edRBaM323uDa1Fe74X6ayyglYZzYoBacLC4AtJ5fzzQ6Ldvs3bcXQ==
X-Received: by 2002:a05:6214:1631:: with SMTP id e17mr5489515qvw.58.1639489855166;
        Tue, 14 Dec 2021 05:50:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e1e4])
        by smtp.gmail.com with ESMTPSA id y15sm7671961qko.74.2021.12.14.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:50:53 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:50:48 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jaegeuk@kernel.org, chao@kernel.org,
        kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v4 02/17] mm: introduce kmem_cache_alloc_lru
Message-ID: <YbihOFJHqvQ9hsjO@cmpxchg.org>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213165342.74704-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 14, 2021 at 12:53:27AM +0800, Muchun Song wrote:
> +/*
> + * The allocated list lru pointers array is not accounted directly.
> + * Moreover, it should not come from DMA buffer and is not readily
> + * reclaimable. So those GFP bits should be masked off.
> + */
> +#define LRUS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT | __GFP_ZERO)

There is already GFP_RECLAIM_MASK for this purpose, you can use that.

> +int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> +			 gfp_t gfp)
> +{
> +	int i;
> +	unsigned long flags;
> +	struct list_lru_memcg *mlrus;
> +	struct list_lru_memcg_table {
> +		struct list_lru_per_memcg *mlru;
> +		struct mem_cgroup *memcg;
> +	} *table;
> +
> +	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
> +		return 0;
> +
> +	gfp &= ~LRUS_CLEAR_MASK;

	gfp &= GFP_RECLAIM_MASK;
