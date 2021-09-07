Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6106402C08
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhIGPkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbhIGPkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Sep 2021 11:40:52 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA912C061575
        for <linux-nfs@vger.kernel.org>; Tue,  7 Sep 2021 08:39:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A21E41C25; Tue,  7 Sep 2021 11:39:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A21E41C25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1631029184;
        bh=Yy3QiJ+Wm8mNfpY+zv7WrsYIFygYyJ5xoCrJBQYX/Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPLQlCPrgtg7V959ovDSKLDE4hoaPNHkPKJRj5FVfn9hG4mqZgdQ7GVxujcYL8IYD
         d8C4DEZLkXaS+0867RF68iKyhmPJPA8N3RsYVus1aqwUrPsk0lY0Irvo7tw/q28Sfb
         kn1fgcZKolDDhcje7o4QQsVigm4mbzo815wUrTws=
Date:   Tue, 7 Sep 2021 11:39:44 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@suse.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Message-ID: <20210907153944.GA1364@fieldses.org>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
 <163097529362.2518.16697605173806213577@noble.neil.brown.name>
 <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ED6E493-21A6-46BC-810A-D9DA42996979@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 07, 2021 at 02:53:48PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 6, 2021, at 8:41 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > When does a single-page GFP_KERNEL allocation fail?  Ever?
> > 
> > I know that if I add __GFP_NOFAIL then it won't fail and that is
> > preferred to looping.
> > I know that if I add __GFP_RETRY_MAILFAIL (or others) then it might
> > fail.
> > But that is the semantics for a plain GFP_KERNEL ??
> > 
> > I recall a suggestion one that it would only fail if the process was
> > being killed by the oom killer.  That seems reasonable and would suggest
> > that retrying is really bad.  Is that true?
> > 
> > For svc_alloc_args(), it might be better to fail and have the calling
> > server thread exit.  This would need to be combined with dynamic
> > thread-count management so that when a request arrived, a new thread
> > might be started.
> 
> I don't immediately see a benefit to killing server threads
> during periods of memory exhaustion, but sometimes I lack
> imagination.

Give up parallelism in return for at least hope of forward progress?
(Which should be possible as long as there's at least one server
thread.)

--b.
