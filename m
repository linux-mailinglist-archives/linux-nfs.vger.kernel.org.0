Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5397B47AFF7
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhLTPXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 10:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhLTPWc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 10:22:32 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB8C08EA6B;
        Mon, 20 Dec 2021 07:02:45 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y22so18222388uap.2;
        Mon, 20 Dec 2021 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5dsjn45w/r98lY9eOdxUUnyPxII4scBtnfEACcCO3I=;
        b=jECDHrGyp8EcXQWOuodyJm8wNMsr+QhOLFHPqoSrLvKczC+V0Btd4Kmn92Mfcvpg7i
         y9cDgEoxxxbiLVgwKDz0tEXyng9UNi98eFKAduJz4zwLi/QLi9DbjRnIWOX0xIc5Emwo
         8CnWUBv6/u/HdFwTanL0lPRWBOqY9TR75+Sq/qZlG9uEWTS8qmiNxyfVu3/X56AcWd9n
         +wlShoeZf2E1hqCN49fq0Ocabn/UvnMmVKOmDPs8HI/2qHLzP/tcvGO0T50CGqV82dRR
         5a1pmNSWlrW5aAGMzXn08KVJ2rIlryjagDozCv0YYeNKiTN30o9YevNEhn60QJ+3gNQt
         +MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5dsjn45w/r98lY9eOdxUUnyPxII4scBtnfEACcCO3I=;
        b=ZQbzztM0TyCX3Z1OIPM0v4qn9RZCQKsRK52OrR2bgwLHGzfnGFWT8aLEtbgPhzhuKE
         RzfRQZVXPy1Hm9lMS7XP+1INNhr7eWaKspBcfXxyIlDriJ/FevHQ4VwXutxVOPM4NzkP
         ZO9YM/EYr5lh7TCumDF5dT4cs5JEJqfy0NE5qD03oG0GltgToMRUzwbipmBGF01mLjjp
         sSHiW7abS5GvEVIiHpS1WKBbw9zreK1PB4tIKsqDya1gmQrkDDz9HIBSxkMVlPFWd6Y4
         C4RYAwJ7bBpD4RE73bIZ9+7FDNiyHj0ya54Pt9QxpGjlvz+4oAcx2X42c8W7M6YXbEnC
         0qqA==
X-Gm-Message-State: AOAM530fwVDe+DwGbsEyzJxN/wLXp6WCwiTNwQhYB6vbF8ZP6HWQEHv5
        w0P1h5u0HHYkP7F6EbgfU+wgmoZCeCbpQ7G0yd35COSjMVE=
X-Google-Smtp-Source: ABdhPJw4yGR5YShQXGrvI3EY9qxOpbI14WmP9yRcJCevDole2egJsXglkfKn1fdLgU3CAZ+nSQoriiflUSjIa/a7EAU=
X-Received: by 2002:a9f:35ad:: with SMTP id t42mr5302353uad.105.1640012562772;
 Mon, 20 Dec 2021 07:02:42 -0800 (PST)
MIME-Version: 1.0
References: <163969801519.20885.3977673503103544412.stgit@noble.brown> <163969850314.20885.13214679186436457787.stgit@noble.brown>
In-Reply-To: <163969850314.20885.13214679186436457787.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 20 Dec 2021 15:02:31 +0000
Message-ID: <CANe_+Ujg_NXFkPq1FOzM-+TZEQ8Rm9qc1Q=bwL_zt3eV65yY-g@mail.gmail.com>
Subject: Re: [PATCH 10/18] NFS: swap IO handling is slightly different for
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

On Thu, 16 Dec 2021 at 23:58, NeilBrown <neilb@suse.de> wrote:
>
> 1/ Taking the i_rwsem for swap IO triggers lockdep warnings regarding
>    possible deadlocks with "fs_reclaim".  These deadlocks could, I believe,
>    eventuate if a buffered read on the swapfile was attempted.
>
>    We don't need coherence with the page cache for a swap file, and
>    buffered writes are forbidden anyway.  There is no other need for
>    i_rwsem during direct IO.  So never take it for swap_rw()

Agreed.  I cannot see an issue with not taking the sem.

> 2/ generic_write_checks() explicitly forbids writes to swap, and
>    performs checks that are not needed for swap.  So bypass it
>    for swap_rw().
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
...
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> @@ -625,7 +625,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
>                 return result;
>
>         if (iocb->ki_flags & IOCB_DIRECT)
> -               return nfs_file_direct_write(iocb, from);
> +               return nfs_file_direct_write(iocb, from, false);
>
>         dprintk("NFS: write(%pD2, %zu@%Ld)\n",
>                 file, iov_iter_count(from), (long long) iocb->ki_pos);

This code at the top of nfs/file.c should be removed;
    /* Hack for future NFS swap support */
    #ifndef IS_SWAPFILE
    # define IS_SWAPFILE(inode)     (0)
    #endif
As IS_SWAPFILE() is used just below this diff (to prevent buffered
writes), better be using a non-hacked version.

Mark
