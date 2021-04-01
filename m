Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E8351ADD
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhDASDZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbhDAR5b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 13:57:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B819C00F7F2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Apr 2021 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12WYSnn0W09slxpXb2C2FEV1qgEU3cY44OdksaN4OnU=; b=d8PQmNEsNTzawK2fK3tEH7lLxf
        ts7iJ/t5euG6ac64QlBk4QLKCjmwmupI/4N/CYNVG4s0RQxjmys1ZRpkPt4md8Ty4DKudzCikcGSa
        Hbqnw4cZToCbdYPwafq1icjvN/2V/1dSLwMW+/jV2Dp2esgK2D/8fKcF5R6ylMMDJX4QYOJGMJlqE
        5NBC5qmwZcgoaSrRJ336IREJXeICK16dX8u13N4QW71J4Sg16Zi5xSYq0za9rmfhp3PtLdqrOV9pc
        E6LSBt/IEq1zK0o+hurvivsh1S08jPs5nPNUnW4Ua4LF2X1XJJaKcSyWtj1B98rTFVLcn7QoTW7m5
        jGxyC9Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRz0t-006HD0-4x; Thu, 01 Apr 2021 15:13:40 +0000
Date:   Thu, 1 Apr 2021 16:13:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        jlayton@kernel.org, Steve French <sfrench@samba.org>
Subject: Re: RFC: Approaches to resolve netfs API interface to NFS multiple
 completions problem
Message-ID: <20210401151339.GE351017@casper.infradead.org>
References: <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
 <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
 <3727198.1617285066@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3727198.1617285066@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 01, 2021 at 02:51:06PM +0100, David Howells wrote:
>  (1) The way cachefiles reads data from the cache is very hacky (calling
>      readpage on the backing filesystem and then installing an interceptor on
>      the waitqueue for the PG_locked page flag on that page, then memcpying
>      the page in a worker thread) - but it was the only way to do it at the
>      time.  Unfortunately, it's fragile and it seems just occasionally the
>      wake event is missed.
> 
>      Since then, kiocb has come along.  I really want to switch to using this
>      to read/write the cache.  It's a lot more robust and also allows async
>      DIO to be performed, also cutting out the memcpy.
> 
>      Changing the fscache IO part of API would make this easier.

I agree with this.  The current way that fscache works is grotesque.
It knows far too much about the inner workings of, well, everything.

>  (3) VM changes are coming that affect the filesystem address space
>      operations.  THP is already here, though not rolled out into all
>      filesystems yet.  Folios are (probably) on their way.  These manage with
>      page aggregation.  There's a new readahead interface function too.
> 
>      This means, however, that you might get an aggregate page that is
>      partially cached.  In addition, the current fscache IO API cannot deal
>      with these.  I think only 9p, afs, ceph, cifs, nfs plus orangefs don't
>      support THPs yet.  The first five Willy has held off on because fscache
>      is a complication and there's an opportunity to make a single solution
>      that fits all five.

This isn't quite uptodate:

 - The new readahead interface went into Linux in June 2020.
   All filesystems were converted from readpages to readahead except
   for the five above that use fscache.  It would be nice to remove the
   readpages operation, but I'm trying not to get in anyone's way here,
   and the fscache->netfs transition was already underway.
 - THPs in Linux today are available to precisely one filesystem --
   shmem/tmpfs.  There are problems all over the place with using THPs
   for non-in-memory filesystems.
 - My THP work achieved POC status.  I got some of the prerequistite
   bits in, but have now stopped working on it (see next point).  It works
   pretty darned well on XFS only.  I did do some work towards enabling
   it on NFS, but never tested it.  There's a per-filesystem enable bit,
   so in theory NFS never needs to be converted.  In practice, you're
   going to want to for the performance boost.
 - I'm taking the lessons learned as part of the THP work (it's confusing
   when a struct page may refer to part of a large memory allocation or
   all of a large memory allocation) and introducing a new data type
   (the struct folio) to refer to chunks of memory in the page cache.
   All filesystems are going to have to be converted to the new API,
   so the fewer places that filesystems actually deal with struct page,
   the easier this makes the transition.
 - I don't understand how a folio gets to be partially cached.  Cached
   should be tracked on a per-folio basis (like dirty or uptodate), not
   on a per-page basis.  The point of the folio work is that managing
   memory in page-sized chunks is now too small for good performance.

> So with the above, there is an opportunity to abstract handling of the VM I/O
> ops for network filesystems - 9p, afs, ceph, cifs and nfs - into a common
> library that handles VM I/O ops and translates them to RPC calls, cache reads
> and cache writes.  The thought is that we should be able to push the
> aggregation of pages into RPC calls there, handle rsize/wsize and allow
> requests to be sliced up and so that they can be distributed to multiple
> servers (works for ceph) so that all five filesystems can get the same
> benefits in one go.

If NFS wants to do its own handling of rsize/wsize, could it?  That is,
if the VM passes it a 2MB page and says "read it", and the server has
an rsize of 256kB, could NFS split it up and send its own stream of 8
requests, or does it have to use fscache to do that?

