Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64F48BD79
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 03:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbiALC4c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 21:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbiALC4c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 21:56:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91417C061751
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 18:56:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id n68so2499757ybg.6
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 18:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdgI3Zt03Z9yu5gw1AVJ9FZ0coQfTSlXMvH0cNGXvgo=;
        b=obpEDlbTBNVc0ialZgTqwmfTDtdmvE9nkCFctdSCLRHt41Kf7zO8z/PUVdUnyMkRqs
         5MIb1HRW+bE2l/qRgtUHe7YNjxYAIfUEPhngcYd3bDzozP+HiYM8BOH4dS222yZp1SKx
         ikHECaW7xeMH6R3LmlhaGwC2r0uvbPax53uE/cwEm4OKAlH+hLpeamBQiOOeGr9t6bvB
         koskXZ64keEmaP620oo7bzAv3FL8oEFZS+hXNMGhzySlygLOlEA2hxuZ/RenGzwk8v+6
         VMUnFAt4zkp3/KkOA3vXcpJjhNCrNG0eXUfW0WewAVvSQz7pJnxwxf14Tq8Na93pbTuV
         8luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdgI3Zt03Z9yu5gw1AVJ9FZ0coQfTSlXMvH0cNGXvgo=;
        b=m3J0KlrEdbFjVZ5t/sACvWtzJpNk8MngEQvrV2jocXD3RJ6T5cA8JndGG1B1LvRC0g
         RIgYQhUz5bYGGXxVC6asqZkzdluWgA6gost9GZGycNFsEckW22o1wgtQwQTqSV2J16UW
         AV0T4aXWxDDImPTI8rDNVZIA97tJm20/I9RLg5BkaxpVzEz08+ZVrtCNsmiwpVlhCk76
         88tNG2DFYGFtkuIYumtUSac9bv/jJBzGioRlVYyy4Q0L9lAQtfairJR1SkL83yGghy3w
         mEzzjlGSXlDLY9LWFYpPuJPXmIQhL+ZqC7CFxosi3psdIRximjfbiOdBN5iP7h8uXASl
         zCkQ==
X-Gm-Message-State: AOAM532HK/XVj8BCRGV8YVPNioiNXeMfkOgOqbGRK2xPwE7YHZiLiRpA
        HqQ1oEQUmBedb2Hu952O9CMuLmkZrWzDTqrq1aAwfQ==
X-Google-Smtp-Source: ABdhPJxjYC1WaBKd1/OkWaghbsu4OSs2IYGS94HFmYSGQsFxRIfiLwnY3TJvgShBoOtj9pIN381fuSYp6loOYXf2PQA=
X-Received: by 2002:a25:7312:: with SMTP id o18mr3742934ybc.485.1641956190618;
 Tue, 11 Jan 2022 18:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-5-songmuchun@bytedance.com> <Yd3TVKpvsBmZM51k@carbon.dhcp.thefacebook.com>
In-Reply-To: <Yd3TVKpvsBmZM51k@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 12 Jan 2022 10:55:54 +0800
Message-ID: <CAMZfGtXcGv_ZcNZZDGhj=O4pXGOsnftLZpYS2qrNsQqOFuh3ZA@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] fs: allocate inode by using alloc_inode_sb()
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
        Muchun Song <smuchun@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 12, 2022 at 2:58 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:37PM +0800, Muchun Song wrote:
> > The inode allocation is supposed to use alloc_inode_sb(), so convert
> > kmem_cache_alloc() of all filesystems to alloc_inode_sb().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Theodore Ts'o <tytso@mit.edu>               [ext4]
>
> LGTM
>
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks Roman.
