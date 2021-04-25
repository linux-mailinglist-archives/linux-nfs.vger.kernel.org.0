Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242C36A7C4
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhDYOUA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhDYOT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Apr 2021 10:19:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552ACC061756
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 07:19:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g9so37101607wrx.0
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DImb7OsrRdC9PGbz0r03XzcJAu+MGbGVsXBucc53vH8=;
        b=pcBrJbPxuhhXDB/mncZPMeAxIL1D/Kgg4hfMLgnExFnvafEqmfy6ivAsLaRonJcpq6
         GJwzxG5rMNZtS+19oMx0/5kp278eCeTCTL73GGdDIz3e7PeFjWLtzkJQpx/ZQOrCOkzW
         qpDyxDcUc2tSJfg5ej/a5zuyG/LfHVjUGwDFnGS6fs9qkz2+RFTShrQVK6KCssk8txcv
         HmOnEZQ1iE2v5aeIQoip6h1ocU2nQofR7Nmw542MNjsh+mq97ABduZKyeTzIrxRiPsYS
         p6oI2yqyI9VZYwh1tbV5yv6aPY9+yMnwFT5b3H2375neK6xic1/+nrej0VyxbMyj4S8Y
         VRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DImb7OsrRdC9PGbz0r03XzcJAu+MGbGVsXBucc53vH8=;
        b=lE9tol9imSZyLPwj3bxVWs5CFvFxEXVBDA/r1WFGAZl5f0AdvkPawqrMRtJ/9px2Pj
         sH5XKaNxaXlOTjZNo5ysk01Hk0+ngpkKslWblnKIq+VOa5NCGgA5Co8v7O4mTV76CdS8
         nZI/kr4H3/Pce4peX7kQfvnJprccT888CfamPGmJQb2VYghOJHadj2T78ZZMoInXby9C
         zI6DdQUe+SYyg0YBBHHKwrzzicXlbxPk/iuFoz1RhVZ75+X4KZQ5TbQjp78q7mXfL4IE
         2Os2yLmd+9u7zjHroXxXf0VfMLvLU50EEhRyd5owwmsT/ZqKQnQZC1/4u3RVGApjGDUK
         hOdQ==
X-Gm-Message-State: AOAM533V+lP8wy1+pGjpj73p2dGneqia3VFVYIk3A4bHkClL9Z258IgC
        P05/4KkjQQCwYm3j4CAWTR5Byw==
X-Google-Smtp-Source: ABdhPJxvFg4T3QPVigG1XdAImPU0Xm/WEUgnJFIP99og0sKI4BvN/W0iEXfKpx8YDC+NaY4UVgbkvw==
X-Received: by 2002:adf:fe91:: with SMTP id l17mr8105020wrr.149.1619360357868;
        Sun, 25 Apr 2021 07:19:17 -0700 (PDT)
Received: from gmail.com ([77.126.186.5])
        by smtp.gmail.com with ESMTPSA id n124sm672363wmn.40.2021.04.25.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:19:17 -0700 (PDT)
Date:   Sun, 25 Apr 2021 17:19:14 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     trondmy@hammerspace.com, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 15/26] xprtrdma: Do not recycle MR after
 FastReg/LocalInv flushes
Message-ID: <20210425141914.6govk2lm2hfosdie@gmail.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
 <161885539285.38598.13978652738422395833.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161885539285.38598.13978652738422395833.stgit@manet.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 19, 2021 at 02:03:12PM -0400, Chuck Lever wrote:
> Better not to touch MRs involved in a flush or post error until the
> Send and Receive Queues are drained and the transport is fully
> quiescent. Simply don't insert such MRs back onto the free list.
> They remain on mr_all and will be released when the connection is
> torn down.
> 
> I had thought that recycling would prevent hardware resources from
> being tied up for a long time. However, since v5.7, a transport
> disconnect destroys the QP and other hardware-owned resources. The
> MRs get cleaned up nicely at that point.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Is this a fix for the crash below?  I just wonder if it appeared for
others in the wild, and the fix is not just theoretical.

    WARNING: CPU: 5 PID: 20312 at lib/list_debug.c:53 __list_del_entry+0x63/0xd0
    list_del corruption, ffff9df150b06768->next is LIST_POISON1 (dead000000000100)

    Call Trace:
     [<ffffffff99764147>] dump_stack+0x19/0x1b
     [<ffffffff99098848>] __warn+0xd8/0x100
     [<ffffffff990988cf>] warn_slowpath_fmt+0x5f/0x80
     [<ffffffff9921d5f6>] ? kfree+0x106/0x140
     [<ffffffff99396953>] __list_del_entry+0x63/0xd0
     [<ffffffff993969cd>] list_del+0xd/0x30
     [<ffffffffc0bb307f>] frwr_mr_recycle+0xaf/0x150 [rpcrdma]
     [<ffffffffc0bb3264>] frwr_wc_localinv+0x94/0xa0 [rpcrdma]
     [<ffffffffc067d20e>] __ib_process_cq+0x8e/0x100 [ib_core]
     [<ffffffffc067d2f9>] ib_cq_poll_work+0x29/0x70 [ib_core]
     [<ffffffff990baf9f>] process_one_work+0x17f/0x440
     [<ffffffff990bc036>] worker_thread+0x126/0x3c0
     [<ffffffff990bbf10>] ? manage_workers.isra.25+0x2a0/0x2a0
     [<ffffffff990c2e81>] kthread+0xd1/0xe0
     [<ffffffff990c2db0>] ? insert_kthread_work+0x40/0x40
     [<ffffffff99776c37>] ret_from_fork_nospec_begin+0x21/0x21
     [<ffffffff990c2db0>] ? insert_kthread_work+0x40/0x40

-- 
Dan Aloni
