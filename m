Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAB4980F3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 14:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiAXNW1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 08:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbiAXNW1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 08:22:27 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB2C06173B;
        Mon, 24 Jan 2022 05:22:27 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id u6so31005871uaq.0;
        Mon, 24 Jan 2022 05:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7bb6IBw6GjkTb//ePU563Q3Mbbnc26r4MUINOM28oo=;
        b=dpV5tuNQ+gABsPSJvZ0kKqvgykw2stLtWbHGY+YevN9mF51/fh50k1/2fUG65mEVAD
         DmDhXMj9MP9u1faUvRK3LO0u4b7erZ6kWfXGWZ4l+VK1iafOKUTgMxZ27gf5HuuYJX1J
         4vi0o6XafqRWdzzuniLIdLvobQvtpQr6Jmkj7sWvqUWZkSjRHVAfRk/+WYO7zFT3IaF/
         0SXSN8sUr3m3fAqGpY5deHJFt6Xb0hGdxGYkRF6mhr+dOqQ3SAaLZH3grw7e3u62khWu
         z6K2O+MAaPPIVwNgJ6YjyvLSgbf5uNcKRRqbP7xlVD6zK7KrA2t1QLFy+if0vi8t8G7J
         xzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7bb6IBw6GjkTb//ePU563Q3Mbbnc26r4MUINOM28oo=;
        b=yVWfg0zJngi2VJiFcEPrGlPHSki5YSN/kcNwy4yGswg64TUP9ezHP3QAFhMkFpv9Ua
         kLxgdlszYsV3H4bVGmyRfJq5gU6ag4yaT3VY97JkFtoQf6B574CiZQwYxojZiOB+ohU9
         PFjAUBa4gZrl2NcT82akLv1/Apdk6KlvNAxQtf8ySssebDuIGZ1BHcxhj8Tcz8A8l/Tz
         BqQUrp2RMiut2yslKuXRhJg/9MMjDvum5a81K0me0fKPNgHYfGPpX/9TSa4yWtcajA5K
         MXE6j/HXE2i5iCHKB8mAMPG9MoFLtVe+efAFs1eW/G0Oh+U2o99KcU5xdfGcUWPYK6rs
         0U1Q==
X-Gm-Message-State: AOAM531+JIfJgrQ/e1ODsbSyT2EHA36FNcaap4YTDzzt6aOHy+U7KmPm
        k1gFB59DWtFeIbKaqFMHs2MR4/lTjRl8t5QyPAk=
X-Google-Smtp-Source: ABdhPJy09eBwzl1gL01WbY7b9cgW9fs2BvPYMYn3qQyppN3DTCjyrA5SvnFB/ghek0xrVWLA6uenUN9sgKLEj+j92pg=
X-Received: by 2002:ab0:3a82:: with SMTP id r2mr5607677uaw.105.1643030546178;
 Mon, 24 Jan 2022 05:22:26 -0800 (PST)
MIME-Version: 1.0
References: <164299573337.26253.7538614611220034049.stgit@noble.brown> <164299611281.26253.15560926531007295753.stgit@noble.brown>
In-Reply-To: <164299611281.26253.15560926531007295753.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 24 Jan 2022 13:22:15 +0000
Message-ID: <CANe_+UgUNS81Jho8gLc956LArQk9SzGETusRpzRW-_uPF-fqbg@mail.gmail.com>
Subject: Re: [PATCH 14/23] NFS: swap IO handling is slightly different for
 O_DIRECT IO
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

On Mon, 24 Jan 2022 at 03:53, NeilBrown <neilb@suse.de> wrote:
>
> 1/ Taking the i_rwsem for swap IO triggers lockdep warnings regarding
>    possible deadlocks with "fs_reclaim".  These deadlocks could, I believe,
>    eventuate if a buffered read on the swapfile was attempted.
>
>    We don't need coherence with the page cache for a swap file, and
>    buffered writes are forbidden anyway.  There is no other need for
>    i_rwsem during direct IO.  So never take it for swap_rw()
>
> 2/ generic_write_checks() explicitly forbids writes to swap, and
>    performs checks that are not needed for swap.  So bypass it
>    for swap_rw().
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/direct.c        |   30 +++++++++++++++++++++---------
>  fs/nfs/file.c          |    4 ++--
>  include/linux/nfs_fs.h |    4 ++--
>  3 files changed, 25 insertions(+), 13 deletions(-)
>
...
> @@ -943,7 +954,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
>                                               pos >> PAGE_SHIFT, end);
>         }
>
> -       nfs_end_io_direct(inode);
> +       if (!swap)
> +               nfs_end_io_direct(inode);

Just above this code diff, there is;
    if (mapping->nrpages) {
        invalidate_inode_pages2_range(mapping,
             pos >> PAGE_SHIFT, end);
    }

This invalidation looks strange/wrong for a NFS swap write.  Should it
be disabled for the swap case?

Cheers,
Mark
