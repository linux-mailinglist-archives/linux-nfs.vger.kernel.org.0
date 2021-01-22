Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F502FFDC7
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhAVH7g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 02:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAVH7Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 02:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30CAC061788;
        Thu, 21 Jan 2021 23:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ghnadlxX//ZiQook2l1GlNaZyWjx/ql4SAS5tLoGvvE=; b=BtoJYPRT87oYLm2KD5ZYGV2reA
        qhK5qjwuvb3KER8N0eJtnCyEMYwGH7wLo25MnIv9PVWV9SQFv2EHiKRHAJf/EOJ9rviDu9qm9nRL+
        dZOTkVv/+iNOtY1AfE+QZAvwdZBg4cUrxQJ3yhbvEpxVNfc/Z0I/w6k4psPzONHS1eV73ll0ENosi
        mWKphIB1YmqV9htMS+UUolxI1eihsyZJTcXkPnBfWKAYtv/YR8Y5en41PLTFLVl7WgCIyVBBCP9Ki
        4UXiQgCiyfRJAK5URh6c6XhlMk+0FRyx2BuDky2OaimCDETK5cSUcDueQufnMHFNoQx4yohZFwo1L
        HknIBy/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2rKS-000U7J-B9; Fri, 22 Jan 2021 07:58:04 +0000
Date:   Fri, 22 Jan 2021 07:58:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 2/2] svcrdma: DMA-sync the receive buffer in
 svc_rdma_recvfrom()
Message-ID: <20210122075800.GA113908@infradead.org>
References: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
 <161126239239.8979.7995314438640511469.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161126239239.8979.7995314438640511469.stgit@klimt.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 03:53:12PM -0500, Chuck Lever wrote:
> The Receive completion handler doesn't look at the contents of the
> Receive buffer. The DMA sync isn't terribly expensive but it's one
> less thing that needs to be done by the Receive completion handler,
> which is single-threaded (per svc_xprt). This helps scalability.

On dma-noncoherent systems that have speculative execution (e.g. a lot
of ARM systems) it can be fairly expensive, so for those this a very
good thing.

Reviewed-by: Christoph Hellwig <hch@lst.de>
