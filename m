Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46232442D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhBXS5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 13:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhBXS4h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 13:56:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BFDC06174A;
        Wed, 24 Feb 2021 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aSmBycH0uJ6bas2Xybb1KrzwdkDReh73b+85qbDRdQ4=; b=wDrxERWdH7aSgsyr5QwIDqAZ9y
        oImtMcG8bftvnoTIalKWfhjsmoeEQiczbkbMnhBawibN5m3IZe+Ezn0jI0b3N7tECV/3HeXJAnUYd
        W8o5Q+tHmoAEZcP7sSK80cahp6xqAHvfIjb4bN8Ah047kgyT5ZhaNeG0/jPTWlSqKyBU7etOCLtYN
        UuRrWoJkFf/F6dQlZwdj9eyXoEsDUO4A6dKqDRIppjs9lgVMTw9xvCOlkTv9PjwkBjqGkds7hfBnX
        k9uCfpbd5dSsERxkH6+KjD/pI/UT/wx5E8492nwTdjwfaMfUvAVVXreaqY7SB/05ZO8+FYmcicczo
        a0ns1/qg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEzJh-009lGy-25; Wed, 24 Feb 2021 18:55:26 +0000
Date:   Wed, 24 Feb 2021 18:55:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        fujita.tomonori@lab.ntt.co.jp, tim@cyberelk.net, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, davem@davemloft.net,
        bp@alien8.de, agk@redhat.com, snitzer@redhat.com,
        ulf.hansson@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dgilbert@interlog.com,
        Kai.Makisara@kolumbus.fi, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bfields@fieldses.org, chuck.lever@oracle.com,
        baolin.wang@linaro.org, vbadigan@codeaurora.org, zliua@micron.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        asutoshd@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
Message-ID: <20210224185521.GA2326119@infradead.org>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
 <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
 <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 24, 2021 at 09:48:21AM -0700, Jens Axboe wrote:
> Would make sense to rename blk_get_request() to blk_mq_alloc_request()
> and then we have API symmetry. The get/put don't make sense when there
> are no references involved.
> 
> But it's a lot of churn for very little reward, which is always kind
> of annoying. Especially for the person that has to carry the patches.

Let's do the following:

 - move the initialize_rq_fn call from blk_get_request into
   blk_mq_alloc_request and make the former a trivial alias for the
   latter
 - migrate to the blk_mq_* versions on a per-driver/subsystem basis.
   The scsi migration depends on the first item above, so it will have
   to go with that or wait for the next merge window
 - don't migrate the legacy ide driver, as it is about to be removed and
   has a huge number of blk_get_request calls
