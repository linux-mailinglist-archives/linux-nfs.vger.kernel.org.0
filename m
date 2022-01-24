Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B910497AD0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbiAXI4p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiAXI4o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:56:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7FC06173B;
        Mon, 24 Jan 2022 00:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=egI+y7AO8wKr4Y2T/LgBNkccAOtCyUbyUckfPi3yE8o=; b=trRSnqkVoDGjPRY1W18iMn49qk
        mg1UC8X4zJbTpmEVmtNAbiBsOKnUIIY/pOk769eL0IGGxbssBjv4T/Rkg3a/aEh9s38XzscNkxFbX
        j2c2Ii/S3ifNhKDup9bsQhDRTqhF20cAxo3YbY3VnwBEbOk1FB1qARRpoMZq8BN5CKsIY+JRw+BoO
        5XsWPOMayez0ojqr58rVp+a7qeQ0m+fq/z52HH31t6gLMLwPoiTza9TEr9lA5TtbNk40rqeC+I/h+
        rtDre+QH2UK3W7G/9vg0OkQUTjuhBw1nRiOJjjZ6ccIU+QcFFF+Cb5mncKdT+d7RdO/n01weV2uTH
        zgx/3Vfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv9T-002hBP-HM; Mon, 24 Jan 2022 08:56:39 +0000
Date:   Mon, 24 Jan 2022 00:56:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/23] NFS: remove IS_SWAPFILE hack
Message-ID: <Ye5px/4o9AZvA+C6@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611280.26253.6924680050876339981.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611280.26253.6924680050876339981.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> This code is pointless as IS_SWAPFILE is always defined.
> So remove it.
> 
> Suggested-by: Mark Hemment <markhemm@googlemail.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
