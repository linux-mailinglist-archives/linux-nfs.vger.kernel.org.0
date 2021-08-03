Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE563DF667
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhHCUbE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhHCUbE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 16:31:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE8C061757
        for <linux-nfs@vger.kernel.org>; Tue,  3 Aug 2021 13:30:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 93F615BAF; Tue,  3 Aug 2021 16:30:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 93F615BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628022651;
        bh=RgkCMao4c6UW4no6ckSwEUhFGOWNAVmOSt1/MT2U9wA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=lMjR+F0OA1wdVnkuHBv6w281t0iUQ2+11tty6yfn9pUl7RWU7EdRhON2V+KxtBQsL
         FOl5eOWk7nVG5zvRSAlHleoVzZrFphEmx38D71jWCDyFGzi1u33lL90IVCeUBktCgh
         dCHrTQ3OywyAGpslqjNzhG6MEZEasrbB/sv4UtfY=
Date:   Tue, 3 Aug 2021 16:30:51 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "plambri@redhat.com" <plambri@redhat.com>
Subject: Re: cto changes for v4 atomic open
Message-ID: <20210803203051.GA3043@fieldses.org>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust wrote:
> On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington wrote:
> > I have some folks unhappy about behavior changes after: 479219218fbe
> > NFS:
> > Optimise away the close-to-open GETATTR when we have NFSv4 OPEN
> > 
> > Before this change, a client holding a RO open would invalidate the
> > pagecache when doing a second RW open.
> > 
> > Now the client doesn't invalidate the pagecache, though technically
> > it could
> > because we see a changeattr update on the RW OPEN response.
> > 
> > I feel this is a grey area in CTO if we're already holding an open. 
> > Do we
> > know how the client ought to behave in this case?  Should the
> > client's open
> > upgrade to RW invalidate the pagecache?
> > 
> 
> It's not a "grey area in close-to-open" at all. It is very cut and
> dried.
> 
> If you need to invalidate your page cache while the file is open, then
> by definition you are in a situation where there is a write by another
> client going on while you are reading. You're clearly not doing close-
> to-open.

Documentation is really unclear about this case.  Every definition of
close-to-open that I've seen says that it requires a cache consistency
check on every application open.  I've never seen one that says "on
every open that doesn't overlap with an already-existing open on that
client".

They *usually* also preface that by saying that this is motivated by the
use case where opens don't overlap.  But it's never made clear that
that's part of the definition.

--b.
