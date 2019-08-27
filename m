Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B579DACF
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 02:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfH0AsM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 20:48:12 -0400
Received: from fieldses.org ([173.255.197.46]:47088 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfH0AsM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 20:48:12 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A2A551E3B; Mon, 26 Aug 2019 20:48:11 -0400 (EDT)
Date:   Mon, 26 Aug 2019 20:48:11 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190827004811.GA30827@fieldses.org>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 26, 2019 at 09:02:31PM +0000, Trond Myklebust wrote:
> On Mon, 2019-08-26 at 16:51 -0400, J. Bruce Fields wrote:
> > On Mon, Aug 26, 2019 at 12:50:18PM -0400, Trond Myklebust wrote:
> > > Recently, a number of changes went into the kernel to try to
> > > ensure that I/O errors (specifically write errors) are reported to
> > > the application once and only once. The vehicle for ensuring the
> > > errors are reported is the struct file, which uses the 'f_wb_err'
> > > field to track which errors have been reported.
> > > 
> > > The problem is that errors are mainly intended to be reported
> > > through fsync(). If the client is doing synchronous writes, then
> > > all is well, but if it is doing unstable writes, then the errors
> > > may not be reported until the client calls COMMIT. If the file
> > > cache has thrown out the struct file, due to memory pressure, or
> > > just because the client took a long while between the last WRITE
> > > and the COMMIT, then the error report may be lost, and the client
> > > may just think its data is safely stored.
> > 
> > These were lost before the file caching patches as well, right?  Or
> > is there some regression? 
> 
> Correct. This is not a regression, but an attempt to fix a problem
> that has existed for some time now.
> 
> > 
> > > Note that the problem is compounded by the fact that NFSv3 is
> > > stateless, so the server never knows that the client may have
> > > rebooted, so there can be no guarantee that a COMMIT will ever be
> > > sent.
> > > 
> > > The following patch set attempts to remedy the situation using 2
> > > strategies:
> > > 
> > > 1) If the inode is dirty, then avoid garbage collecting the file
> > > from the file cache.  2) If the file is closed, and we see that it
> > > would have reported an error to COMMIT, then we bump the boot
> > > verifier in order to ensure the client retransmits all its writes.
> > 
> > Sounds sensible to me.
> > 
> > > Note that if multiple clients were writing to the same file, then
> > > we probably want to bump the boot verifier anyway, since only one
> > > COMMIT will see the error report (because the cached file is also
> > > shared).
> > 
> > I'm confused by the "probably should".  So that's future work?  I
> > guess it'd mean some additional work to identify that case.  You
> > can't really even distinguish clients in the NFSv3 case, but I
> > suppose you could use IP address or TCP connection as an
> > approximation.
> 
> I'm suggesting we should do this too, but I haven't done so yet in
> these patches. I'd like to hear other opinions (particularly from you,
> Chuck and Jeff).

Does this process actually converge, or do we end up with all the
clients retrying the writes and, again, only one of them getting the
error?

I wonder what the typical errors are, anyway.

--b.
