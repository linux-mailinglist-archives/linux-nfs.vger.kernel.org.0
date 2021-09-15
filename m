Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420F40C089
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhIOHcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhIOHcI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 03:32:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C205C061575
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 00:30:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 17so1845447pgp.4
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ansDI2ALwiWUvo/BHMzSUNbG1zi7g1Z2RW2yT9Z/nQU=;
        b=ORu8quCr4ulyj8peI8bv8LIWYdxUyRLHamjFT4YgcAyCXXSJdSEDIA5RUxfAmRN09J
         tY/7T5bYctY95S7e+fwttxX+NNE5jGnbTpmByrsUudiTX9yWUMLlenKQBt/TixdSRPsZ
         LrlLHUqNy1XM3U3BySYeH/YSkyih1AlxBf3CpwC7vZvdDR4Blb2RYh6a1Bq9HCVhkR1+
         E0XG1SnRFmOSibxEc1rd4fVF8VCvFA6y+XiaAfVwVYGGx/EljBv00XVcINk3zbgbFI37
         Na9ZrjmuFHRhntxtlqxBJbwI9WZHCcDwJ5mTZqO8dkI54BjWnhGuTajMW1ZdHWDAO0jc
         U2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ansDI2ALwiWUvo/BHMzSUNbG1zi7g1Z2RW2yT9Z/nQU=;
        b=BI/t3bWEIKH5R5noqhW/eyxr9mPRVnx/YzL6DTDctXVkr7/KN77eebTNaLYwMhg6Qy
         cOKvXnMpzPg9c1C254dejJT4dAYSqkDUBSfxOn/MxUnzOC7vv6Ig9LqGKwRUjrxRimyw
         LPaQZfr6MrwjWerwZwxBjVRgbTz8o5W3UeHJswoqYRz0e2tYvHEOJZISdN1mt1KGGlEr
         2UAH+KsRbg71lShtWZXhdGmqEEumCmnVYn4TZsJP5t0YilfGJv/isX2jVGXIyP7rl/Et
         Ebu3UK372gaxcD0XEKyZRjczFiuXA2SNqFPQt9EJyDRSmSLaJ9ASWRIZ4Ac9NIkyPD+f
         9TeA==
X-Gm-Message-State: AOAM532p/i4Hn2bnTJMgNbATovthFPyYKZ3Qtw6yfcBV998618WQ4e9S
        EBq1/yx7HI9v/ZSG90D/nUg9HX3nsiUp4wYSj/YUuw==
X-Google-Smtp-Source: ABdhPJyPhEr+fuMcqTX6W8kA2CYRATLI7X4XWaSCGHZXRVAs1Jug54iwzt8yUmfw+4OuE3ywJoZ1ZLM++dY2ReITCo4=
X-Received: by 2002:aa7:9e8d:0:b0:406:be8:2413 with SMTP id
 p13-20020aa79e8d000000b004060be82413mr9157759pfq.66.1631691049890; Wed, 15
 Sep 2021 00:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914072938.6440-1-songmuchun@bytedance.com> <YUEEoAUBaN7J0ch3@mit.edu>
In-Reply-To: <YUEEoAUBaN7J0ch3@mit.edu>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Sep 2021 15:30:12 +0800
Message-ID: <CAMZfGtXQ4pvbzQQOCAfZmc0xtt3Yr=szE4ZuTuSJyt9FvWfaZw@mail.gmail.com>
Subject: Re: [PATCH v3 00/76] Optimize list lru memory consumption
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 15, 2021 at 4:23 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Sep 14, 2021 at 03:28:22PM +0800, Muchun Song wrote:
> > So we have to convert to new API for all filesystems, which is done in
> > one patch. Some filesystems are easy to convert (just replace
> > kmem_cache_alloc() to alloc_inode_sb()), while other filesystems need to
> > do more work.
>
> From what I can tell, three are 54 file systems for which it was a
> trivial one-line change, and two (f2fs and nfs42) that were a tad bit
> more complex.

Definitely right. Thanks for your clarification.

>
> > In order to make it easy for maintainers of different
> > filesystems to review their own maintained part, I split the patch into
> > patches which are per-filesystem in this version. I am not sure if this
> > is a good idea, because there is going to be more commits.
>
> What I'd actually suggest is that you combine all of the trivial file
> system changes into a single commit, and keep the two more complex
> changes for f2fs and nfs42 in separate commits.

Got it. Will do in the next version.

>
> Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks.

>
> ... for the ext4 related change.
>
>                                                 - Ted
>
