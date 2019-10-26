Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5924E5FBB
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2019 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfJZVgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Oct 2019 17:36:07 -0400
Received: from fieldses.org ([173.255.197.46]:32910 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfJZVgH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 26 Oct 2019 17:36:07 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 90281BD0; Sat, 26 Oct 2019 17:36:06 -0400 (EDT)
Date:   Sat, 26 Oct 2019 17:36:06 -0400
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: uncollected nfsd open owners
Message-ID: <20191026213606.GA11394@fieldses.org>
References: <87mudpfwkj.fsf@notabene.neil.brown.name>
 <20191025152047.GB16053@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025152047.GB16053@pick.fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 25, 2019 at 11:20:47AM -0400, J. Bruce Fields wrote:
> On Fri, Oct 25, 2019 at 12:22:36PM +1100, NeilBrown wrote:
> >  I have a coredump from a machine that was running as an NFS server.
> >  nfs4_laundromat was trying to expire a client, and in particular was
> >  cleaning up the ->cl_openowners.
> >  As there were 6.5 million of these, it took rather longer than the
> >  softlockup timer thought was acceptable, and hence the core dump.
> > 
> >  Those open owners that I looked at had empty so_stateids lists, so I
> >  would normally expect them to be on the close_lru and to be removed
> >  fairly soon.  But they weren't (only 32 openowners on close_lru).
> > 
> >  The only explanation I can think of for this is that maybe an OPEN
> >  request successfully got through nfs4_process_open1(), thus creating an
> >  open owner, but failed to get to or through nfs4_process_open2(), and
> >  so didn't add a stateid.  I *think* this can leave an openowner that is
> >  unused but will never be cleaned up (until the client is expired, which
> >  might be too late).
> > 
> >  Is this possible?  If so, how should we handle those openowners which
> >  never had a stateid?
> >  In 3.0 (which it the kernel were I saw this) I could probably just put
> >  the openowner on the close_lru when it is created.
> >  In more recent kernels, it seems to be assumed that openowners are only
> >  on close_lru if they have a oo_last_closed_stid.  Would we need a
> >  separate "never used lru", or should they just be destroyed as soon as
> >  the open fails?
> 
> Hopefully we can just throw the new openowner away when the open fails.
> 
> But it looks like the new openowner is visible on global data structures
> by then, so we need to be sure somebody else isn't about to use it.

But, also, if this has only been seen on 3.0, it may have been fixed
already.  It sounds like kind of a familiar problem, but I didn't spot a
relevant commit on a quick look through the logs.

--b.
