Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528DF47586B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Dec 2021 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhLOMJr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Dec 2021 07:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhLOMJr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Dec 2021 07:09:47 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05480C06173F
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 04:09:46 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so54567414ybi.5
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=medD3Xi3kZKH5q7bagszydyhriMt4qJw4H1Wjw4BIeA=;
        b=hFy0KgQxd2bJci/Xd+n8sv+Gu5RmYMvEDhUBuj2Yrq8ctOAyB8hlUNmxpM2IiWLKGy
         GE3vvn8E0z4jskkFd9srdqyZ83G3qGSVOcrD2grWx5AMKa7YPQ48/Vv0KqUhJi54LfOy
         dD7WRE2C4pHHS/JIsZt35udpFpfLB/bfGhx9yBgUoW8bTi5myNlDaZXqEKI6Kx46FisJ
         68kZKS3svXvUdYbK5/j6C34dFY+I1Rbbh4hEBrVj5Z8GkSaIoGT6INxX0WmFow5netem
         tEe/Dm5Fek5uzcugw8IodwEebZjX23z7LIjzHm5KAIPoJ2dg3exHdgGp4uP3a5We1NHj
         TTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=medD3Xi3kZKH5q7bagszydyhriMt4qJw4H1Wjw4BIeA=;
        b=6OGx+4E4PN0HU8/fgg9w+tq8Q2Ags2QNXXC1cZU5HcBclf39SZXP7jymkHQfB5l6vr
         O/iyIWgohZpWtiaF1nHLYFiPfnJYvFDIycDUNScmOX/C7IkIuGnp5dcXFiPNUdqxaRPE
         L41TnO74tOW5abCI4HZG+h7e8XZfVefVXjqkFH6Y7GVsClcsL6v8oeff/INOsGdHntc3
         CX0KuPEGo73hn1aUri4RTxuc7mpPKnA9QvWJidFV7M81PpiHmrgK0Tg7z4g3ArhmfEzW
         Yhh9a7atpugPPTC8wRD4XCkaLCyq9W4INsHg6CP12uJQDE4z6E4DquWwjC+6Bd6rYKpE
         tU4A==
X-Gm-Message-State: AOAM530P+k84tuOTXLGKghTOW/ZX+T3x1hxUI/rJ8tXC6rNHPuSxU6g5
        lnJhk/3Vj85luzQlOlwcWKjBb0aSouw6Ig0j5htpdQ==
X-Google-Smtp-Source: ABdhPJwQ0At3Bjn2QQCan5WHYT82Z/7G6PUgdH5xVAc30+lYih6V821vw+gn8W1jOKI1DU2w2zfhyVDYOnqoiKKOUGU=
X-Received: by 2002:a05:6902:52b:: with SMTP id y11mr5529088ybs.199.1639570186129;
 Wed, 15 Dec 2021 04:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-2-songmuchun@bytedance.com> <YbieX3WCUt7hdZlW@cmpxchg.org>
In-Reply-To: <YbieX3WCUt7hdZlW@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Dec 2021 20:09:10 +0800
Message-ID: <CAMZfGtWPt2wk91Js6NRnw-wpMVQHc+ZRZo8OUyrkNAJBB3f8yQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
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
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 14, 2021 at 9:38 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Dec 14, 2021 at 12:53:26AM +0800, Muchun Song wrote:
> > The list_lru uses an array (list_lru_memcg->lru) to store pointers
> > which point to the list_lru_one. And the array is per memcg per node.
> > Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> > a pointer size on 64 bits system) when we run 10k containers in the
> > system. The memory consumption of the arrays becomes significant. The
> > more numa node, the more memory it consumes.
>
> The complexity for the lists themselves is still nrmemcgs * nrnodes
> right? But the rcu_head goes from that to nrmemcgs.

Right.

>
> > I have done a simple test, which creates 10K memcg and mount point
> > each in a two-node system. The memory consumption of the list_lru
> > will be 24464MB. After converting the array from per memcg per node
> > to per memcg, the memory consumption is going to be 21957MB. It is
> > reduces by 2.5GB. In our AMD servers, there are 8 numa nodes in
> > those system, the memory consumption could be more significant.
>
> The code looks good to me, but it would be useful to include a
> high-level overview of the new scheme, explain that the savings come
> from the rcu heads, that it simplifies the alloc/dealloc path etc.

Will do in the next version.

>
> With that,
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
