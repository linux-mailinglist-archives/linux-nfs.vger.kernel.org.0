Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E561402C0A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbhIGPmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 11:42:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhIGPmh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 11:42:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05FC9220F4;
        Tue,  7 Sep 2021 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631029290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqHb/tASQGnJarzZC0qa6X3H0t7+vPi6wKd0G7SrSQk=;
        b=Sgzrx7k46UnY0HskaR3CVgatBNQwnReCXRE8RlzRkCILhZcfFFeQgTImrKYORhuP72rFYG
        G36IgDIAsabbaJAEr2xwkTqubboU0PFmjOBJgbX49+N1BM5nTTWZnIovqVSOb8GYkTUrnB
        F85XgALWR9DlGUz/LX79/qpt8Ke1zlE=
Received: from suse.com (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4F98A3B81;
        Tue,  7 Sep 2021 15:41:29 +0000 (UTC)
Date:   Tue, 7 Sep 2021 16:41:25 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Message-ID: <20210907153116.GJ3828@suse.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
 <163097529362.2518.16697605173806213577@noble.neil.brown.name>
 <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 07, 2021 at 02:53:48PM +0000, Chuck Lever III wrote:
> > So maybe we really don't want reclaim_progress_wait(), and all current
> > callers of congestion_wait() which are just waiting for allocation to
> > succeed should be either change to use __GFP_NOFAIL, or to handle
> > failure.
> 
> I had completely forgotten about GFP_NOFAIL. That seems like the
> preferred answer, as it avoids an arbitrary time-based wait for
> a memory resource. (And maybe svc_rqst_alloc() should also get
> the NOFAIL treatment?).
> 

Don't use NOFAIL. It's intended for allocation requests that if they fail,
there is no sane way for the kernel to recover. Amoung other things,
it can access emergency memory reserves and if not returned quickly may
cause premature OOM or even a livelock.

> The question in my mind is how the new alloc_pages_bulk() will
> behave when passed NOFAIL. I would expect that NOFAIL would simply
> guarantee that at least one page is allocated on every call.
> 

alloc_pages_bulk ignores GFP_NOFAIL. If called repeatedly, it might pass
the GFP_NOFAIL flag to allocate at least one page but you'll be depleting
reserves to do it from a call site that has other options for recovery.

The docs say it better

 * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures. The allocation could block
 * indefinitely but will never return with failure. Testing for
 * failure is pointless.
 * New users should be evaluated carefully (and the flag should be
 * used only when there is no reasonable failure policy) but it is
 * definitely preferable to use the flag rather than opencode endless
 * loop around allocator.
 * Using this flag for costly allocations is _highly_ discouraged

-- 
Mel Gorman
SUSE Labs
