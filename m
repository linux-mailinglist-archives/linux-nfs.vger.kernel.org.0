Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9B40213A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhIFWO2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIFWO1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 18:14:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07FC061575
        for <linux-nfs@vger.kernel.org>; Mon,  6 Sep 2021 15:13:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CD59B1C25; Mon,  6 Sep 2021 18:13:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CD59B1C25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630966400;
        bh=7qQ1YEVuELfcLLU6rsSG8Nh0MZtTiMr8wJzVl4dRIAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOBrzpDls2e2ejFaU6ueSxh7P6fih8qiwmDCJvV1xKw2D95fFJ+5/tz7cw9Bisba9
         ihPH+khC4YtqAquYl+rDbCbppfG3dQRC3ttf74sN18SK7JGwG15Rd8TnqnUPEqkylf
         NxRmWaJ0m0IQLi23GtmM3D3Yt6vn7P+Hvj0XdOio=
Date:   Mon, 6 Sep 2021 18:13:20 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@suse.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Message-ID: <20210906221320.GA21567@fieldses.org>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 06, 2021 at 09:20:35PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 06, 2021 at 03:46:34PM +0000, Chuck Lever III wrote:
> > Hi Neil-
> > 
> > > On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > 
> > > Many places that need to wait before retrying a memory allocation use
> > > congestion_wait().  xfs_buf_alloc_pages() is a good example which
> > > follows a similar pattern to that in svc_alloc_args().
> > > 
> > > It make sense to do the same thing in svc_alloc_args(); This will allow
> > > the allocation to be retried sooner if some backing device becomes
> > > non-congested before the timeout.
> 
> It's adorable that you believe this is still true.
> 
> https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/

So, what's the advice for now?  Do we add the congestion_wait() call
anyway and assume it'll be fixed to do something less broken in the
future, or just skip it completely?

--b.
