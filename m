Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45563DF6EF
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhHCVgy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 17:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhHCVgy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Aug 2021 17:36:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14647C06175F
        for <linux-nfs@vger.kernel.org>; Tue,  3 Aug 2021 14:36:43 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 211346855; Tue,  3 Aug 2021 17:36:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 211346855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628026602;
        bh=op7dCBzASNDo4MndkQvHjqCe321G3fxN+Jg7+e9laQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fggxa4oqMvwO0xMRqogIesxYOuinco7gZaSLwLfVR7HJAfwnsmPfEMmq1DXkZiU2+
         ia2kuA2rSvaXuO4IC4t3jwzX178oAx77NJjiULBNYRVhLsl4F/6g1RKzCw6oaUagKm
         +mzlJmY8om6uJtAA/XyV58NcbJilFTPWzduaI5Q0=
Date:   Tue, 3 Aug 2021 17:36:42 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Message-ID: <20210803213642.GA4042@fieldses.org>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
> On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
> > On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust wrote:
> > > On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington wrote:
> > > > I have some folks unhappy about behavior changes after:
> > > > 479219218fbe
> > > > NFS:
> > > > Optimise away the close-to-open GETATTR when we have NFSv4 OPEN
> > > > 
> > > > Before this change, a client holding a RO open would invalidate
> > > > the
> > > > pagecache when doing a second RW open.
> > > > 
> > > > Now the client doesn't invalidate the pagecache, though
> > > > technically
> > > > it could
> > > > because we see a changeattr update on the RW OPEN response.
> > > > 
> > > > I feel this is a grey area in CTO if we're already holding an
> > > > open. 
> > > > Do we
> > > > know how the client ought to behave in this case?  Should the
> > > > client's open
> > > > upgrade to RW invalidate the pagecache?
> > > > 
> > > 
> > > It's not a "grey area in close-to-open" at all. It is very cut and
> > > dried.
> > > 
> > > If you need to invalidate your page cache while the file is open,
> > > then
> > > by definition you are in a situation where there is a write by
> > > another
> > > client going on while you are reading. You're clearly not doing
> > > close-
> > > to-open.
> > 
> > Documentation is really unclear about this case.  Every definition of
> > close-to-open that I've seen says that it requires a cache
> > consistency
> > check on every application open.  I've never seen one that says "on
> > every open that doesn't overlap with an already-existing open on that
> > client".
> > 
> > They *usually* also preface that by saying that this is motivated by
> > the
> > use case where opens don't overlap.  But it's never made clear that
> > that's part of the definition.
> > 
> 
> I'm not following your logic.

It's just a question of what every source I can find says close-to-open
means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
provides a guarantee of cache consistency at the level of file opens and
closes.  When a file is closed by an application, the client flushes any
cached changs to the server.  When a file is opened, the client ignores
any cache time remaining (if the file data are cached) and makes an
explicit GETATTR call to the server to check the file modification
time."

> The close-to-open model assumes that the file is only being modified by
> one client at a time and it assumes that file contents may be cached
> while an application is holding it open.
> The point checks exist in order to detect if the file is being changed
> when the file is not open.
> 
> Linux does not have a per-application cache. It has a page cache that
> is shared among all applications. It is impossible for two applications
> to open the same file using buffered I/O, and yet see different
> contents.

Right, so based on the descriptions like the one above, I would have
expected both applications to see new data at that point.

Maybe that's not practical to implement.  It'd be nice at least if that
was explicit in the documentation.

--b.
