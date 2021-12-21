Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1947BBF3
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhLUIgd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhLUIgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:36:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B008C061574;
        Tue, 21 Dec 2021 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bev5UwUDySNtcXZ7IbUg3yOmocPFGSISGcvag7Sq58Q=; b=HAPbiOL2hqJaqg/4Wb6uKUEuOb
        Htg78H8fB44s1S4lq7nQQbrNItf7oqgP7CnnX8VCmQ7nmATKnAY4mfiYeshBLINj8dUY+gGOKksg8
        y7/eeXHqTE/fywSrKbKvxH/tN61lfWCznBMkbvDAvjio/Y5xToFGn0Y3UaoHTstQ2tE9WHzVW3f4B
        RdfSm8zmmybWDTcniynbcCziNP2Gs15CLRnkF/heHehNo97n9wnxEVl4wxbBKwMmdWG5XcunEtQ+V
        zx2bk5wp8zWlG8IMpYRO3l69PsX74PB9iPcriFgZ6YsIqxAE9cSpHCih17A3cigW6xBT1gCq5U28H
        TuVITm9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzadH-005xM6-Uk; Tue, 21 Dec 2021 08:36:27 +0000
Date:   Tue, 21 Dec 2021 00:36:27 -0800
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
Subject: Re: [PATCH 02/18] MM: create new mm/swap.h header file.
Message-ID: <YcGSC9QITsBUbuDr@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850279.20885.7172996032577523902.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850279.20885.7172996032577523902.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:22AM +1100, NeilBrown wrote:
> Many functions declared in include/linux/swap.h are only used within mm/
> 
> Create a new "mm/swap.h" and move some of these declarations there.
> Remove the redundant 'extern' from the function declarations.

Good idea!  Looks good modulo the extra includes that the buildbot asks
for:

Reviewed-by: Christoph Hellwig <hch@lst.de>
