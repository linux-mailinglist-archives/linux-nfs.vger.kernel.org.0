Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296CC48BD76
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 03:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348962AbiALCzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 21:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiALCzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 21:55:10 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35280C06173F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 18:55:10 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id z22so2006040ybi.11
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 18:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjG0MxzMFp+mXx/fhnGFPP77MfipZrWjEmzToKHDYMs=;
        b=6ayrnxbcnFPPUmYvOduF6Pq8fL2AVcsSL/nubUFKSkA7/WgCyNwQdZQdDzMwsZ4Iu0
         OXroeHV85F09Q6q2lr0/5r/gpbOga2pzMo6oV1EFUARsGfTa7BYSHl4xZ5wzJL6CIduH
         iT6L6X2WXlOe27ZoL3BpfdmLF0LpMmSfe49ksQFPud2lkCL/06AcTkpTmknzS5a+8rbI
         kPfm6lvx1fQEUzj3n84koZ6w71PtBk2WY7ahFYrFnZaAJulE3yCNpyVKFLjDhM6Mj1TJ
         QsbPEC7V7dg1O7Y+iEtXb9UGx4ExjcJRz9aecVvHlJMyUxUym4J32jZsUqWkt9dpnHPY
         FKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjG0MxzMFp+mXx/fhnGFPP77MfipZrWjEmzToKHDYMs=;
        b=8LmauktM6c4ZKomTwCLT6A2cc7dzq3Hwu7BCwST3xZ1Kt4PvzPcXjqVPZ8gKsD3QDK
         l+CENANy2AbrWz7ykBIO/r97qY3FDSP5ttvRdqaQGLNTNisU8tCqDx1/5S9MDxP4nwMV
         R9MhNPGFa8kbFM508ZGt6Q2pGpdMiTw4E81qANjZ68HBF80LrMiTNkagsDyyyCQhoxY3
         heg6tye6nap9iQEqjayssWWSjO/DzTJ3VzkVoR3jrlFS8xgyuThdMYMD62rkUacsshvf
         l5FnrvJAW0srESWIjNLktIosfCHU5BP5BMtfNrgmcPbBWNr522CcGGg3OCu6FUkIizle
         IsJg==
X-Gm-Message-State: AOAM533nIO8Ee+jZZ8hFP21ti7ZTYzqv0kwwNNt495h3tz7+y/8f9FwR
        BDyZYjzh0JQGvlxqIBuKukN/E23tY5EI7PIp+7EgfQ==
X-Google-Smtp-Source: ABdhPJwHIWCaocHbRKCDyMX3VTIF7z/62FPkM6VJ/tLncpXUrm6uc9D4GQFcLEa7fX824hQsBn3XLLVsBaDv2Ms1ps4=
X-Received: by 2002:a25:abcb:: with SMTP id v69mr10514951ybi.317.1641956109479;
 Tue, 11 Jan 2022 18:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-4-songmuchun@bytedance.com> <Yd3SoypOW0EBZj6K@carbon.dhcp.thefacebook.com>
In-Reply-To: <Yd3SoypOW0EBZj6K@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 12 Jan 2022 10:54:32 +0800
Message-ID: <CAMZfGtU7qw4C3SaF=D5NYpn5oyo4mc5o=Y8TCOkG5a58W5DYRA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] fs: introduce alloc_inode_sb() to allocate
 filesystems specific inode
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

On Wed, Jan 12, 2022 at 2:55 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Dec 20, 2021 at 04:56:36PM +0800, Muchun Song wrote:
> > The allocated inode cache is supposed to be added to its memcg list_lru
> > which should be allocated as well in advance. That can be done by
> > kmem_cache_alloc_lru() which allocates object and list_lru. The file
> > systems is main user of it. So introduce alloc_inode_sb() to allocate
> > file system specific inodes and set up the inode reclaim context
> > properly. The file system is supposed to use alloc_inode_sb() to
> > allocate inodes. In the later patches, we will convert all users to the
> > new API.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/filesystems/porting.rst |  5 +++++
> >  fs/inode.c                            |  2 +-
> >  include/linux/fs.h                    | 11 +++++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> > index bf19fd6b86e7..c9c157d7b7bb 100644
> > --- a/Documentation/filesystems/porting.rst
> > +++ b/Documentation/filesystems/porting.rst
> > @@ -45,6 +45,11 @@ typically between calling iget_locked() and unlocking the inode.
> >
> >  At some point that will become mandatory.
> >
> > +**mandatory**
> > +
> > +The foo_inode_info should always be allocated through alloc_inode_sb() rather
> > +than kmem_cache_alloc() or kmalloc() related.
>
> I'd add a couple of words on why it has to be allocated this way.

Will do.

> > +
> >  ---
>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks.
