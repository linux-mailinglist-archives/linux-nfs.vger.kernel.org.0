Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00C47A968
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhLTMVx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 07:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLTMVw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 07:21:52 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E790C061574;
        Mon, 20 Dec 2021 04:21:52 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id t13so17245135uad.9;
        Mon, 20 Dec 2021 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQFMqdREYbA6pMmlCdr5tqLXzt6JY03eIdDvlj4irPg=;
        b=lOxIjH2sPXo7lH1pv+9xqI6q77X5toldoYNan7hBf0t4eykMEXCKFBwZHism4a8i9I
         2u/qKd6G1p/iqZJOlJRARn9dpuxJKsL9QfTSbV6vaeKYMmq4ad6pPvdtgv3P7R9xDlMO
         gjJof3eUpIiltLOttwIrFQhicAjUfkWj/eHf16bc9CGrnyFBHCgbQ5mfvVXSGng+GnST
         9e9jFhkvF53lBIOUOklUKUZSbggo+GyQs5crxQ7SZOmcuo0CqRAhtCnz7EZiHg0koJZN
         GY8qx5Y86N1YWaBisYlM4eMY6SEy7KAf76gxgF9QemzyevIua4uibmFuJxsyfGLWYcHW
         IfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQFMqdREYbA6pMmlCdr5tqLXzt6JY03eIdDvlj4irPg=;
        b=C/TKRgXNBF2BEDp7CC0UdPmXKrHvneYjIWxrcbCWboANZCveoNcG+U79xx7LjwfWlj
         YcawXf/sm5z+3OTVpD+mx5dfqlA0FkAP0AuN29zwg7ubDY+KcRCaF6PNl4bDgcAHIrYT
         scRL81pcNohTEyScMQSNQGj7vuI180yTD8FCpLX6uLONbbWMa5yNwdRiI/Gp7RQ7U3sT
         2b+setqxF8SZocftpg9aaiA3iCQd1gfJBEU+iJt8XVzCxNXnhcATgWqbNvHfuncSjmDa
         yMPERQ6Tf0k6TCrxBtAaG3jb31BwUTa6l3lG/DU0TB1wZdkpp0oIGd7pepa4SrJzNr3A
         RCQA==
X-Gm-Message-State: AOAM532xOWfGgHi0n9UxqhJdP2f4hMm/+sjV5h4psee/WdAL+BHke1p9
        8HZxI+0WAIqK8LQ938OPoz5hz8Qvnbelheg8TBfNLmUbiOo=
X-Google-Smtp-Source: ABdhPJy5Yr3VSqOfKSJ2+mLWwF2Sf8WB3Mmlsk+ujRLez8Z6FA6BEhzJG/7MZDhGMxB65PxZq+Q/hqMvFjYAiTYSnm0=
X-Received: by 2002:a05:6102:1613:: with SMTP id cu19mr4463931vsb.25.1640002911522;
 Mon, 20 Dec 2021 04:21:51 -0800 (PST)
MIME-Version: 1.0
References: <163969801519.20885.3977673503103544412.stgit@noble.brown> <163969850299.20885.11549845125423716814.stgit@noble.brown>
In-Reply-To: <163969850299.20885.11549845125423716814.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 20 Dec 2021 12:21:40 +0000
Message-ID: <CANe_+UiH-1uJPRE2CWAiu=h=JG97aGD-QtvaaRvcAYOfCB8CuQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] MM: submit multipage write for SWP_FS_OPS swap-space
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

On Thu, 16 Dec 2021 at 23:56, NeilBrown <neilb@suse.de> wrote:
>
> swap_writepage() is given one page at a time, but may be called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
>
> With this patch we pass a pointer-to-pointer via the wbc.
> swap_writepage can store state between calls - much like the pointer
> passed explicitly to swap_readpage.  After calling swap_writepage() some
> number of times, the state will be passed to swap_write_unplug() which
> can submit the combined request.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/writeback.h |    7 +++
>  mm/page_io.c              |   98 ++++++++++++++++++++++++++++++---------------
>  mm/swap.h                 |    1
>  mm/vmscan.c               |    9 +++-
>  4 files changed, 80 insertions(+), 35 deletions(-)
...
> +void swap_write_unplug(struct swap_iocb *sio)
> +{
> +       struct iov_iter from;
> +       struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
> +       int ret;
> +
> +       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
> +                     PAGE_SIZE * sio->pages);
> +       ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> +       if (ret != -EIOCBQUEUED)
> +               sio_write_complete(&sio->iocb, ret);
> +}
> +

As swap_write_unplug() is called from vmscan.c, need an 'no-op'
version (in "swap.h") for when !CONFIG_SWAP

Mark
