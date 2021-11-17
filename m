Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC78545406D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 06:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhKQFx1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 00:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhKQFx0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 00:53:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C2C061570;
        Tue, 16 Nov 2021 21:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgX1lKFHbGYlVIxMybKAUHxepjKR3IBDm4U5W4UN3zo=; b=nzDoS8FSD4/qhGPCItt5A1bJgG
        3QyU05unbBwcOHdGh7W+8lfiKBqIHXjHH2RL1LGLKQxIxc8uJRdvrZTN+dkp0ZpQcyRkvSz+++cLk
        wl5PsTufUAAH6Tp+hw65/tgQJ9EsNaWehtD5UuwsOos/u24vrvy8d0kf2JoRqNjJuRtC93WLBzhtk
        1fFSGfiOTi3+Ao+zQFBuwjyxUUtmiwM9CsBtFIPcrplZO8PFnljTWRm6+TySoMGvrW3g6qkiBXnNQ
        12aeo7acoLwc1+9NkX69xkq14/xGVz5f4+rIu0QyWeP9GVMiAKtjjicawakNOtlm3x08j9kRnN2b6
        R+CWF1lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnDpx-003Nw2-KE; Wed, 17 Nov 2021 05:50:25 +0000
Date:   Tue, 16 Nov 2021 21:50:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] MM: reclaim mustn't enter FS for swap-over-NFS
Message-ID: <YZSYIWtVnhqv0Noh@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
 <163703064452.25805.16932817889703270242.stgit@noble.brown>
 <YZNss/ujX3yovr/k@infradead.org>
 <163709852340.13692.16362531894844686350@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163709852340.13692.16362531894844686350@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 17, 2021 at 08:35:23AM +1100, NeilBrown wrote:
> +	/* We can "enter_fs" for swap-cache with only __GFP_IO

normal kernel style would be the

	/*

on a line of it's own.  But except for this nitpick this looks good.
