Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1D1FFC48
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFRUJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jun 2020 16:09:06 -0400
Received: from fieldses.org ([173.255.197.46]:50778 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFRUJG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Jun 2020 16:09:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4AE1214D8; Thu, 18 Jun 2020 16:09:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4AE1214D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592510945;
        bh=rSrnlz9tLWtb7++Fvp4cqffvJINTvx2LaI6JVtjB/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DH57J5BIl/Jrk2w7ISRKDvF6hQ/eBZaJnY3xShLrO3gjIBrx4lYFz1ti3ggDJUveL
         0YqXNWB6emVoM6wXQeHZxAuehy6OVGVP7sZLVNIrFrwHz8XaxdOBjSttfAdCRy87KY
         uAvZ3qIrN2SgX5IJJwG4FxXT0TGNyjmPjRNvIrTQ=
Date:   Thu, 18 Jun 2020 16:09:05 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client caching and locks
Message-ID: <20200618200905.GA10313@fieldses.org>
References: <20200608211945.GB30639@fieldses.org>
 <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
 <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 18, 2020 at 02:29:42PM +0000, Trond Myklebust wrote:
> On Thu, 2020-06-18 at 09:54 +0000, inoguchi.yuki@fujitsu.com wrote:
> > > What does the client do to its cache when it writes to a locked
> > > range?
> > > 
> > > The RFC:
> > > 
> > > 	https://tools.ietf.org/html/rfc7530#section-10.3.2
> > > 
> > > seems to apply that you should get something like local-filesystem
> > > semantics if you write-lock any range that you write to and read-
> > > lock
> > > any range that you read from.
> > > 
> > > But I see a report that when applications write to non-overlapping
> > > ranges (while taking locks over those ranges), they don't see each
> > > other's updates.
> > > 
> > > I think for simultaneous non-overlapping writes to work that way,
> > > the
> > > client would need to invalidate its cache on unlock (except for the
> > > locked range).  But i can't tell what the client's designed to do.
> > 
> > Simultaneous non-overlapping WRITEs is not taken into consideration
> > in RFC7530.
> > I personally think it is not necessary to deal with this case by
> > modifying the kernel because
> > the application on the client can be implemented to avoid it.
> > 
> > Serialization of the simultaneous operations may be one of the ways.
> > Just before the write operation, each client locks and reads the
> > overlapped range of data
> > instead of obtaining a lock in their own non-overlapping range.
> > They can reflect updates from other clients in this case.
> > 
> > Yuki Inoguchi
> > 
> > > --b.
> 
> See the function 'fs/nfs/file.c:do_setlk()'. We flush dirty file data
> both before and after taking the byte range lock. After taking the
> lock, we force a revalidation of the data before returning control to
> the application (unless there is a delegation that allows us to cache
> more aggressively).
> 
> In addition, if you look at fs/nfs/file.c:do_unlk() you'll note that we
> force a flush of all dirty file data before releasing the lock.
> 
> Finally, note that we turn off assumptions of close-to-open caching
> semantics when we detect that the application is using locking, and we
> turn off optimisations such as assuming we can extend writes to page
> boundaries when the page is marked as being up to date.
> 
> IOW: if all the clients are running Linux, then the thread that took
> the lock should see 100% up to date data in the locked range. I believe
> most (if not all) non-Linux clients use similar semantics when
> taking/releasing byte range locks, so they too should be fine.

I probably don't understand the algorithm (in particular, how it
revalidates caches after a write).

How does it avoid a race like this?:

Start with a file whose data is all 0's and change attribute x:

        client 0                        client 1
        --------                        --------
        take write lock on byte 0
                                        take write lock on byte 1
        write 1 to offset 0
          change attribute now x+1
                                        write 1 to offset 1
                                          change attribute now x+2
        getattr returns x+2
                                        getattr returns x+2
        unlock
                                        unlock

        take readlock on byte 1

At this point a getattr will return change attribute x+2, the same as
was returned after client 0's write.  Does that mean client 0 assumes
the file data is unchanged since its last write?

--b.
