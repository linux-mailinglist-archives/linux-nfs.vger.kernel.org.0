Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B644020AB
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhIFUWi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhIFUWi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 16:22:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40539C061575
        for <linux-nfs@vger.kernel.org>; Mon,  6 Sep 2021 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FReIuqwvQaH3DM8EOJMpifjLgOWirL3DRmnMdZvC3Vg=; b=J1SnPAe5tlmtNOlAYTVayWMoKY
        33JfGi1Oq8qh1U5tcf9Ha9AI0nf9cM+/dEje8frQglY3SEziO02sFjcO4g4W2Y55XkxWXDx2Iuoyx
        e9+f6g80276rX/kmot8OnxVmyw5/g6bePKm53gtWktuD8nTkwNFZGMtvDyQI6fsJGedpIU5fEw1wy
        v9OAHenspIQ5FRJ4QfZEYUO1PHqHvP8tyw+46iLunZbfSB+O+erQoe9VSDDnnff8jn492st+EYqbW
        x8SoS9AnChU5REocCxJqymPFi1ydHcXS8hvq4Dp8xayB7fcfb3hfSmbcR1eRvOJBrY4HKmD8mCEeg
        iHPw2Bcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNL6Z-007H6B-D8; Mon, 06 Sep 2021 20:20:52 +0000
Date:   Mon, 6 Sep 2021 21:20:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@suse.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Message-ID: <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 06, 2021 at 03:46:34PM +0000, Chuck Lever III wrote:
> Hi Neil-
> 
> > On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > Many places that need to wait before retrying a memory allocation use
> > congestion_wait().  xfs_buf_alloc_pages() is a good example which
> > follows a similar pattern to that in svc_alloc_args().
> > 
> > It make sense to do the same thing in svc_alloc_args(); This will allow
> > the allocation to be retried sooner if some backing device becomes
> > non-congested before the timeout.

It's adorable that you believe this is still true.

https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/
