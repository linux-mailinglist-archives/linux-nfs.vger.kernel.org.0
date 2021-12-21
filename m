Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40AD47BBFD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhLUIle (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhLUIle (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:41:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE3C061574;
        Tue, 21 Dec 2021 00:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1SfuWtyBT/lCOeUjHpOa8oNjQ7IYPylpMxyFG1nXMrQ=; b=UO/t1vtyfCs/03PyiOpu8/Jt28
        8yISYgBUk47c8mXqrG4qYbjL5hAseZWZypz86F42rcXgxhiIGSKAoUsXnHc2wlMNQnYSlPhXvylG4
        eb1x+8vcDP+1jqnqFCa40Tv/7KpmvLEyW+o0miLF3XhMjt8PbB8vC5gVYHPjghjf6aS8MpFwfArCM
        I1omI8tzS497dL4Oo+VWRXnxYysvRAx/8W2B9lmiC6JJyn9B21TN0hyJGLuV4KDCwqCPRai+06t3B
        tsxNDzngO0OEwEZNXvNddGlo63h5U76bPHODnDJF/rv3d7QF/LHhj3G/zVq4spBK/TicWybqsazm8
        4f3lfJyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzai9-005xhw-Km; Tue, 21 Dec 2021 08:41:29 +0000
Date:   Tue, 21 Dec 2021 00:41:29 -0800
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
Subject: Re: [PATCH 04/18] MM: perform async writes to SWP_FS_OPS swap-space
Message-ID: <YcGTOfZFSFZVuBEv@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850292.20885.16191050558510542930.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850292.20885.16191050558510542930.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:22AM +1100, NeilBrown wrote:
> Writes to SWP_FS_OPS swapspace is currently synchronous.  To make it
> async we need to allocate the kiocb struct which may block, but won't
> block as long as waiting for the write to complete would block.

Against a little helper for the SWP_FS_OPS case of __swap_writepage
would be nice.  But otherwise this looks good to me.
