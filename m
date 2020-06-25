Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E889120A616
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406863AbgFYTsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406635AbgFYTsW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 15:48:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB2FC08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 12:48:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7B462BD0; Thu, 25 Jun 2020 15:48:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7B462BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593114501;
        bh=YT+MtTRbYc0k8vzZO1JhHrVetD8I8o0+r7+sOwe2C8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BX36dtgqBsbmmGnIKRJp58TUyrl4+3zuboNEXASdhnJjG/SMaE20nP98lHpGMHBFh
         0w2atoCfvvu3SrI2+HAYjWyuS+auzwgRVFS7DmYc8Nn3DKG+iTnUsR8TE1pQjicLJ9
         uDqeaiO2W9NTDmwYG5Kg45oqH4Kzwj0f2RDLip6Q=
Date:   Thu, 25 Jun 2020 15:48:21 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: nfsd filecache issues with v4
Message-ID: <20200625194821.GA6605@fieldses.org>
References: <20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200625171021.GC30655@fieldses.org>
 <20200625191205.GC29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625191205.GC29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 07:12:05PM +0000, Frank van der Linden wrote:
> On Thu, Jun 25, 2020 at 01:10:21PM -0400, Bruce Fields wrote:
> > 
> > On Mon, Jun 08, 2020 at 07:21:22PM +0000, Frank van der Linden wrote:
> > > So here's what happens: for NFSv4, files that are associated with an
> > > open stateid can stick around for a long time, as long as there's no
> > > CLOSE done on them. That's what's happening here. Also, since those files
> > > have a refcount of >= 2 (one for the hash table, one for being pointed to
> > > by the state), they are never eligible for removal from the file cache.
> > > Worse, since the code call nfs_file_gc inline if the upper bound is crossed
> > > (8192), every single operation that calls nfsd_file_acquire will end up
> > > walking the entire LRU, trying to free files, and failing every time.
> > > Walking a list with millions of files every single time isn't great.
> > 
> > Thanks for tracking this down.
> > 
> > >
> > > There are some ways to fix this behavior like:
> > >
> > > * Always allow v4 cached file structured to be purged from the cache.
> > >   They will stick around, since they still have a reference, but
> > >   at least they won't slow down cache handling to a crawl.
> > 
> > If they have to stick around anyway it seems too bad not to be able to
> > use them.
> > 
> > I mean, just because a file's opened first by a v4 user doesn't mean it
> > might not also have other users, right?
> > 
> > Would it be that hard to make nfsd_file_gc() a little smarter?
> > 
> > I don't know, maybe it's not worth it.
> > 
> > --b.
> 
> Basically, opening, and keeping open, a very large number of v4 files on
> a client blows up these data structures:
> 
> * nfs4state.c:file_hashtbl (FH -> nfs4_file)
> 
> ..and with the addition of filecache:
> 
> * filecache.c:nfsd_file_hashtbl (ino -> nfsd_file)
> * filecache.c:nfsd_file_lru
> 
> nfsd_file_lru causes the most pain, see my description. But the other ones
> aren't without pain either. I tried an experiment where v4 files don't
> get added to the filecache, and file_hashtbl started showing up in perf
> output in a serious way. Not surprising, really, if you hash millions
> of items in a hash table with 256 buckets.
> 
> I guess there is an argument to be made that it's such an extreme use case
> that it's not worth it.
> 
> On the other hand, clients running the server out of resources and slowing
> down everything by a lot for all clients isn't great either.
> 
> Generally, the only way to enforce an upper bound on resource usage without
> returning permanent errors (to which the client might react badly) seems
> to be to start invaliding v4 state under pressure. Clients should be prepared
> for this, as they should be able to recover from a server reboot. On the
> other hand, it's something you probably only should be doing as a last resort.
> I'm not sure if consistent behavior for e.g. locks could be guaranteed, I
> am not very familiar with the locking code.

I don't think that would work, for a bunch of reasons.

Off hand I don't think I've actually seen reports in the wild of hitting
resource limits due to number of opens.  Though I admit it bothers me
that we're not prepared for it.

--b.

> Some ideas to alleviate the pain short of doing the above:
> 
> * Count v4 references to nfsd_file (filecache) structures. If there
>   is a v4 reference, don't have the file on the LRU, as it's pointless.
>   Do include it in the hash table so that v2/v3 users can find it. This
>   avoids the worst offender (nfsd_file_lru), but does still blow up
>   nfsd_file_hashtbl.
> 
> * Use rhashtable for the hashtables, as it can automatically grow/shrink
>   the number of buckets. I don't know if the rhashtable code could handle
>   the load, but it might be worth a shot.
> 
> - Frank
