Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA759DAF8
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 03:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH0BNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 21:13:55 -0400
Received: from fieldses.org ([173.255.197.46]:47128 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfH0BNy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 21:13:54 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8957F20AE; Mon, 26 Aug 2019 21:13:54 -0400 (EDT)
Date:   Mon, 26 Aug 2019 21:13:54 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190827011354.GB30827@fieldses.org>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <20190827004811.GA30827@fieldses.org>
 <a2045dcd33d7f53fadd50212160c531c2e0c236f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2045dcd33d7f53fadd50212160c531c2e0c236f.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 27, 2019 at 12:56:07AM +0000, Trond Myklebust wrote:
> On Mon, 2019-08-26 at 20:48 -0400, bfields@fieldses.org wrote:
> > On Mon, Aug 26, 2019 at 09:02:31PM +0000, Trond Myklebust wrote:
> > > On Mon, 2019-08-26 at 16:51 -0400, J. Bruce Fields wrote:
> > > > On Mon, Aug 26, 2019 at 12:50:18PM -0400, Trond Myklebust wrote:
> > > > > Note that if multiple clients were writing to the same file,
> > > > > then we probably want to bump the boot verifier anyway, since
> > > > > only one COMMIT will see the error report (because the cached
> > > > > file is also shared).
> > > > 
> > > > I'm confused by the "probably should".  So that's future work?
> > > > I guess it'd mean some additional work to identify that case.
> > > > You can't really even distinguish clients in the NFSv3 case, but
> > > > I suppose you could use IP address or TCP connection as an
> > > > approximation.
> > > 
> > > I'm suggesting we should do this too, but I haven't done so yet in
> > > these patches. I'd like to hear other opinions (particularly from
> > > you, Chuck and Jeff).
> > 
> > Does this process actually converge, or do we end up with all the
> > clients retrying the writes and, again, only one of them getting the
> > error?
> 
> The client that gets the error should stop retrying if the error is
> fatal.

Have clients historically been good about that?  I just wonder whether
it's a concern that boot-verifier-bumping could magnify the impact of
clients that are overly persistent about retrying IO errors.

> > I wonder what the typical errors are, anyway.
> 
> I would expect ENOSPC, and EIO to be the most common. The former if
> delayed allocation and/or snapshots result in writes failing after
> writing to the page cache. The latter if we hit a disk outage or other
> such problem.

Makes sense.

--b.
