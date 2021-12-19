Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044B947A0B1
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhLSNiv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 08:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhLSNiv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 08:38:51 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACFC061574;
        Sun, 19 Dec 2021 05:38:51 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p2so13010183uad.11;
        Sun, 19 Dec 2021 05:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bI280telFaJwUWnCTGOVucNdMzF/wNLC2jH94KdWJvI=;
        b=JpNScKqHuNhoreNPYO3wb82lyjROJo4t2vTiX77Jix5VbXKk0rOpa7GTo9alx/+85T
         WA1IgEQA3CQKXvwAasmtRDiLJeygPacKT8cCXg5gjcyl1k5SxWBARyUFHKTi3boJTYz/
         c7lliYvdxYtqn9jpPRLp/av4cMGOy3uxVtcF9uwwHMAYSu9wAmysBXiA3DjowJ4EkacG
         4r3Zeiil9KnLoRtiKkaC850p9Ho14wq6V+n4pTmyBs9SMzh/df/NrgQCxSEeHFm3St7W
         ANpiQQXQBck31bgUfHTQjdIbP0ZGCNUKi6kRUfidBGCH54gyLpOpWousev/gx3I18Hfj
         +ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bI280telFaJwUWnCTGOVucNdMzF/wNLC2jH94KdWJvI=;
        b=TAO48BqEBd3+1DTnHO8YFVC6QGrsOaYHJDaE11ok6HXsrq48pSK1//qPdVEQHPXXQD
         WEKerrNlI1+B5Lpnj0Vbd0BLu7EX5McY0N8ltYaK9vn1wuYBHIhjPBoweTuzVg4R98dE
         cFhoqa/EcpAs6t3wLJVPpIp2obwfgsZDUTBVGy0+25BJm3KEKM6RjrRRyoJCB0ldGFh9
         ftfgSwl11rTATqTw0o8GCORkafCa57ivq47ApFWI4aS7wXyPzevEpfQBC+fN5h34r8PK
         DqZ3aRNH4UptL9hgY2NRi10PywfIx9MxGmyo66m1yFvQTjzFzEGsSuPrqefYlZ/FLgKh
         HmQQ==
X-Gm-Message-State: AOAM533ge+wg2uzuCvQB55+HS0UZjDOyNEuPQ32SautiymSair7Vp5iE
        dSNYDipS7c1tqcvsAUD8bIhsukzb3PIPi6EiZkQ=
X-Google-Smtp-Source: ABdhPJy9Ga6BKjziaeH527tlGnmVQhnHJH5VjPeSXHOyfvXjirVq8zXYRKZ1l3kq7oXqglnplsiwqyIMYNfuA9h9eSI=
X-Received: by 2002:a05:6102:1613:: with SMTP id cu19mr3426842vsb.25.1639921130249;
 Sun, 19 Dec 2021 05:38:50 -0800 (PST)
MIME-Version: 1.0
References: <163969801519.20885.3977673503103544412.stgit@noble.brown> <163969850302.20885.17124747377211907111.stgit@noble.brown>
In-Reply-To: <163969850302.20885.17124747377211907111.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Sun, 19 Dec 2021 13:38:39 +0000
Message-ID: <CANe_+Uj0ooR2QzNQLXihuoaWMCJMpo3yJNhP_9DyPaCzeO7v7w@mail.gmail.com>
Subject: Re: [PATCH 08/18] MM: Add AS_CAN_DIO mapping flag
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 16 Dec 2021 at 23:57, NeilBrown <neilb@suse.de> wrote:
>
> Currently various places test if direct IO is possible on a file by
> checking for the existence of the direct_IO address space operation.
> This is a poor choice, as the direct_IO operation may not be used - it is
> only used if the generic_file_*_iter functions are called for direct IO
> and some filesystems - particularly NFS - don't do this.
>
> Instead, introduce a new mapping flag: AS_CAN_DIO and change the various
> places to check this (avoiding a pointer dereference).
> unlock_new_inode() will set this flag if ->direct_IO is present, so
> filesystems do not need to be changed.
...
> diff --git a/fs/inode.c b/fs/inode.c
> index 6b80a51129d5..bae65ccecdb1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1008,6 +1008,9 @@ EXPORT_SYMBOL(lockdep_annotate_inode_mutex_key);
>  void unlock_new_inode(struct inode *inode)
>  {
>         lockdep_annotate_inode_mutex_key(inode);
> +       if (inode->i_mapping->a_ops &&
> +           inode->i_mapping->a_ops->direct_IO)
> +               set_bit(AS_CAN_DIO, &inode->i_mapping->flags);
>         spin_lock(&inode->i_lock);
>         WARN_ON(!(inode->i_state & I_NEW));
>         inode->i_state &= ~I_NEW & ~I_CREATING;

Does d_instantiate_new() also need to set AS_CAN_DIO?

Mark
