Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A22FF177
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 18:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbhAURLc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbhAURE5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:04:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDDC0613D6;
        Thu, 21 Jan 2021 09:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QzyNyEp1YsTE5vSV+3cDru2rTzeX2CsFjS3xBz6a990=; b=m/sCpkjOMCVgP4VoWYhFT+pNFA
        XsN5cp/1QMUAEvRGYKVrcCWtT0K0Qc1rUYrY8tnWtvRBGAzYQF1aJcWF3PjXrGGN5DB6crvK52Uhq
        VmNi8hTrqhlV+i2i9NAfj+R5YQr9uVin10+P+GGGvl4s+Wro8U/2/QQy8nAXo/5hPnH9AZL+NWlnM
        toPoiBaqrmygPeFA0pi51swSnxTXmB2rXAaBa2z16O2JBwXvSZdc+MGy9skDIY3SNinDpyuqYtJ3N
        cyelbC61FxOX5f44I6+AYEzvIq/k8mhEfUgaLp9Knoar2TChae7OQQlHwtAFdMat/0mm5SWvcQ2ZF
        9pImn9Kw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2dMH-00HI8V-2u; Thu, 21 Jan 2021 17:03:07 +0000
Date:   Thu, 21 Jan 2021 17:02:57 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
Message-ID: <20210121170257.GA4120717@infradead.org>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 03:29:04PM +0100, Guoqing Jiang wrote:
> The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
> elevator code"), also update the comment of the function.

And more importantly it never really was needed to start with given
that we can triviall derive it from struct request.

> -extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
> +extern void blk_execute_rq_nowait(struct gendisk *,
>  				  struct request *, int, rq_end_io_fn *);
