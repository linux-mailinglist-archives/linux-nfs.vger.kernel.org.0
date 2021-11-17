Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5445406B
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 06:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhKQFwk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 00:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhKQFwk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 00:52:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F1CC061570;
        Tue, 16 Nov 2021 21:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iEufQItznMuE7/EKoKGX4vRELYAFxyh15c7XENTRZno=; b=UNWr528FoOJiy9z0OkAsmpZ32m
        UMul8BbbAOiHrOPKiGq/ZolB25Q2p++XnqWkNtSlnenIhYoHZSH4Vaqyw/KYq+YsExfGZPlNpw7Xd
        nHaXX4vuuM63Ti8WnysHMH07GBRiRJOaM7QHuvozj4tL5LwFj+L1e78reMBXL2GSPAl3TMNRe/roo
        bjafKgX0MJCGBqGZbIdpibzTFEHlnbcp38V1+uEjR5zUAf9aMw+Wo5uxkifmmbVPivEqY4t/Rlg9a
        h/rfAWRf0TOZJayqDFUornH7xL5BMokfQI/bdx7YNk5DIgGT58C9cYAHMxHkSkNnu62qvlNA083kw
        LCrn2g1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnDpA-003NnN-9J; Wed, 17 Nov 2021 05:49:36 +0000
Date:   Tue, 16 Nov 2021 21:49:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/13] NFS: do not take i_rwsem for swap IO
Message-ID: <YZSX8C+2mxQ0NaSq@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
 <163703064452.25805.5738767545414940042.stgit@noble.brown>
 <YZNjLtYKnQ/RFpxR@infradead.org>
 <163709941227.13692.8504638930849686895@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163709941227.13692.8504638930849686895@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 17, 2021 at 08:50:12AM +1100, NeilBrown wrote:
> This would be David Howells' "mm: Use DIO for swap and fix NFS
> swapfiles" series?

Yes.

> I'd be very happy to work with that once it lands.
> I might try it out and see how two work together.

Dave: is it ok if Neil takes over the swap vs NFS work given that he's
working on a customer requirement?
