Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A417A452CD7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 09:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhKPIfx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 03:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhKPIfw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 03:35:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE39C061746;
        Tue, 16 Nov 2021 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4es8FO5SJaQGq2UgE1ci1YHP56WQQ2cHosypX0fQUds=; b=shYGA2EQWsHmDyFu5BR3rthX+m
        fINS2KeKdL7lH1ZuCThcNqv/nOwm2fJRlL9T1/yiFgPOirEIettm4ER3zGz8PChISJW4mo99JhmZn
        4r+wuekG50XBiCggC36fX8KPX70E3L3aqbkBnfuQ8VD0SFV9KDM8w+pyyAXbKVkgFTq1obxYW2Ogc
        B73HKBgKiSwnaWTDTJUZ2FdAwBRWPOzQjWbaillvxKqRzIWMHNZGGPBD18UeHZ/loXpIQtxRk4p/w
        8Dnv5a0szw+Rj/ZtgLfIkT7zREGg5Gnz7Th4TvVxX65QFkudNJd4n5Ac4AhVP9mSujhqbrroDhVo2
        Ch4Cr1HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmttb-000kGz-Tl; Tue, 16 Nov 2021 08:32:51 +0000
Date:   Tue, 16 Nov 2021 00:32:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] MM: reclaim mustn't enter FS for swap-over-NFS
Message-ID: <YZNss/ujX3yovr/k@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
 <163703064452.25805.16932817889703270242.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163703064452.25805.16932817889703270242.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> +		/* ->flags can be updated non-atomicially (scan_swap_map_slots),
> +		 * but that will never affect SWP_FS_OPS, so the data_race
> +		 * is safe.
> +		 */
>  		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
> +			(PageSwapCache(page) &&
> +			 !data_race(page_swap_info(page)->flags & SWP_FS_OPS) &&
> +			 (sc->gfp_mask & __GFP_IO));

You might want to move the comment and SWP_FS_OPS into a little
inline helper.  That makes it a lot more readable and also avoids the
overly long line in the second hunk.
