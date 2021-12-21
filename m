Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7147BC05
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhLUIok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhLUIoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:44:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EEC061574;
        Tue, 21 Dec 2021 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nPiQf/MI+bwqfpcWS154xJ3aaU/G74L5bGAeKIKv96Q=; b=Qdnk4yIhbeEGJ9r6rR1zk/TxJh
        SOlUOwTdLYDRrQJpF+5v2r6ImMjcS8OZGR3NA3dFaIakL0CoaflRO97iBuN2T2j0ROo3rMh8VTvq/
        f2t5onLlGMdGYTTIAT8xBTplYP+mmnRTiKsiB6inFWmkc9Ujm40e8oALDZhcO/LdgvOlk1qT+McBB
        oP0NXKUoULs7vAFNQ2UDupLhKqPI8MkBo32rHivR/ncCZwQ446qQtwV0GsaSunkHAy79rO2UvrgtO
        3AQJuz5pIcBNqOy2MPEv78nVzoc1qcEhhfYCr0yRG0U6WNeoUrw5uANYBuGg3nCGtSdhlBQrhhTXm
        ej5Iu/fw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzal9-005xx1-IT; Tue, 21 Dec 2021 08:44:35 +0000
Date:   Tue, 21 Dec 2021 00:44:35 -0800
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
Subject: Re: [PATCH 06/18] MM: submit multipage reads for SWP_FS_OPS
 swap-space
Message-ID: <YcGT80RFm2oJdC4b@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850296.20885.16043920355602134308.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850296.20885.16043920355602134308.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:22AM +1100, NeilBrown wrote:
> Some caller currently call blk_finish_plug() *before* the final call to
> swap_readpage(), so the last page cannot be included.  This patch moves
> blk_finish_plug() to after the last call, and calls swap_read_unplug()
> there too.

Can you move this fix into a separate prep patch, preferably with a
Fixes tag so that it gets picked up for backports?

Otherwise this looks sensible to me.
