Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1037EF33B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 14:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbjKQNAr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 08:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjKQNAg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 08:00:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB4D6A
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=92EM5xD3/y6vRocEo33waLmBWQM6YZ2esZ+B1IvkENU=; b=YNcY8DFEV0N5PiQHr3IWOIyPPI
        DWQu8jrwhxiH/gvX5PoSkb3Ufc1bfTjLOS6UdRP/rXhNE0lXIujsGZaG4kQpwJhYYXcFwxza68NZ9
        fYJ57JMVT4L2ThoRIKiRH/hEE4/KMEvJIGH3g0frSgwyVrikZQ7UnIKu0zngmK1qj3vdIAAc5l0U/
        VNbF9yvU8Biuz9rtqFqbVncYFsjYuAH6Pe/3ycJhIIRKKV4ycBwkQ92SHk/ucOBeYV5btwfIx6rEL
        5RC5+0bDZes4moSQGA1jGZqdqOxsAB4MTQ5KrUNtDAMjDhqW1Q9vLD22a+w0DL3p0nF0lwf6lTmDt
        YGXGTg8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r3yS9-006b5Z-2f;
        Fri, 17 Nov 2023 13:00:09 +0000
Date:   Fri, 17 Nov 2023 05:00:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Blocklayoutdriver deadlock with knfsd
Message-ID: <ZVdj2U+kJ7DlI22g@infradead.org>
References: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
 <787DAC8F-5294-4876-9725-096D639B3D9C@oracle.com>
 <465037c9585f910c2192bf896139e7bf01d587d4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465037c9585f910c2192bf896139e7bf01d587d4.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 16, 2023 at 03:32:34PM -0500, Jeff Layton wrote:
> One thing that might help would be make the nfsd threadpool more
> dynamic. If it could just spin up another thread, we'd be OK.
> 
> Maybe the server could keep an emergency thread around that is just for
> processing LAYOUTRETURN/DELEGRETURN (maybe also CLOSE, etc.) calls?
> Sometimes these ops are mixed into compounds with other sorts of calls
> though, so we'd need to deal with that somehow.

I think having an extra thread just for LAYOUTRETURN/DELEGRETURN is
fundamentally the right thing to do, as they need to be processed
to allow everyone else to progress.

> > If nfsd threads are waiting indefinitely, that's a potential DoS
> > vector. Ideally the thread should preserve the waiting request
> > somehow (or return NFS4ERR_DELAY, maybe?). At some later point
> > when the lease conflict is resolved, the requests can be reprocessed.
> > 
> > That's my naive 800,000 ft view.
> > 

That is probably a good idea on top of the above.

> So you can always get stuck in that inner break_layout call. We could
> try to use IOCB_NOWAIT for I/Os coming from nfsd, which would prevent
> that, but that seems like it could change the I/O behavior in other ways
> we don't want. It's not clear to me how that would work alongside
> IOCB_SYNC anyway.

So I definitively think using IOCB_NOWAIT from nfsd and not block
the thread for trivial I/O is a good thing.  This might even enable
not offloading I/O to threads until the IOCB_NOWAIT failed.  But any
IOCB_NOWAIT that returned -EAGAIN needs to eventually fall back to
doing blocking I/O as there is no progress guarantee for IOCB_NOWAIT,
and some I/O simply is entirely impossible with IOCB_NOWAIT.

> It's not immediately clear to me how we'd do this with the existing
> IOCB_* flags, so we might need a new one (IOCB_NFSD?). Then, we could
> just make sure that break_layout call is always nonblocking if that flag
> is set.

I'd name it about the behavior that it controls and not the callers,
but otherwise this too seems like a good idea.
