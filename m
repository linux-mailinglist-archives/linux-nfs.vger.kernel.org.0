Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2351220A578
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405941AbgFYTML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 15:12:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43767 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405829AbgFYTMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 15:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593112330; x=1624648330;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Wg0hGgU+SjmEI8boFUFucf7vgvKil9fXRXc7fir9KaU=;
  b=UayIOlqdIFjM3oIGFMxWJEir+35WMdR9dI8JiHAkJ0j4zrVK6cRjenWi
   NXInvZGVWnUaERFK3sdoNDqsi4Fw1Kn9ly0MbZPdQAXFhNMVB981+NQiV
   lPoMhbg0zfm+kGz5s4cWzBq/e6qUgKMZsxGMurzOUAPXnqCYo9ScxR7sz
   4=;
IronPort-SDR: qIpeljOhdyTnMEHBU/iyTQcmpABxhReAUO6i2taBV4GYh9RTYdTjLLgdBndo7FQkhjeSyDprJ/
 /mtky6VsDtxQ==
X-IronPort-AV: E=Sophos;i="5.75,280,1589241600"; 
   d="scan'208";a="38497826"
Subject: Re: nfsd filecache issues with v4
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Jun 2020 19:12:08 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 43E092889DC;
        Thu, 25 Jun 2020 19:12:05 +0000 (UTC)
Received: from EX13D04UWB002.ant.amazon.com (10.43.161.133) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 19:12:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04UWB002.ant.amazon.com (10.43.161.133) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 19:12:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Jun 2020 19:12:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 3E2AFC3318; Thu, 25 Jun 2020 19:12:05 +0000 (UTC)
Date:   Thu, 25 Jun 2020 19:12:05 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
Message-ID: <20200625191205.GC29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200625171021.GC30655@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625171021.GC30655@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 01:10:21PM -0400, Bruce Fields wrote:
> 
> On Mon, Jun 08, 2020 at 07:21:22PM +0000, Frank van der Linden wrote:
> > So here's what happens: for NFSv4, files that are associated with an
> > open stateid can stick around for a long time, as long as there's no
> > CLOSE done on them. That's what's happening here. Also, since those files
> > have a refcount of >= 2 (one for the hash table, one for being pointed to
> > by the state), they are never eligible for removal from the file cache.
> > Worse, since the code call nfs_file_gc inline if the upper bound is crossed
> > (8192), every single operation that calls nfsd_file_acquire will end up
> > walking the entire LRU, trying to free files, and failing every time.
> > Walking a list with millions of files every single time isn't great.
> 
> Thanks for tracking this down.
> 
> >
> > There are some ways to fix this behavior like:
> >
> > * Always allow v4 cached file structured to be purged from the cache.
> >   They will stick around, since they still have a reference, but
> >   at least they won't slow down cache handling to a crawl.
> 
> If they have to stick around anyway it seems too bad not to be able to
> use them.
> 
> I mean, just because a file's opened first by a v4 user doesn't mean it
> might not also have other users, right?
> 
> Would it be that hard to make nfsd_file_gc() a little smarter?
> 
> I don't know, maybe it's not worth it.
> 
> --b.

Basically, opening, and keeping open, a very large number of v4 files on
a client blows up these data structures:

* nfs4state.c:file_hashtbl (FH -> nfs4_file)

..and with the addition of filecache:

* filecache.c:nfsd_file_hashtbl (ino -> nfsd_file)
* filecache.c:nfsd_file_lru

nfsd_file_lru causes the most pain, see my description. But the other ones
aren't without pain either. I tried an experiment where v4 files don't
get added to the filecache, and file_hashtbl started showing up in perf
output in a serious way. Not surprising, really, if you hash millions
of items in a hash table with 256 buckets.

I guess there is an argument to be made that it's such an extreme use case
that it's not worth it.

On the other hand, clients running the server out of resources and slowing
down everything by a lot for all clients isn't great either.

Generally, the only way to enforce an upper bound on resource usage without
returning permanent errors (to which the client might react badly) seems
to be to start invaliding v4 state under pressure. Clients should be prepared
for this, as they should be able to recover from a server reboot. On the
other hand, it's something you probably only should be doing as a last resort.
I'm not sure if consistent behavior for e.g. locks could be guaranteed, I
am not very familiar with the locking code.

Some ideas to alleviate the pain short of doing the above:

* Count v4 references to nfsd_file (filecache) structures. If there
  is a v4 reference, don't have the file on the LRU, as it's pointless.
  Do include it in the hash table so that v2/v3 users can find it. This
  avoids the worst offender (nfsd_file_lru), but does still blow up
  nfsd_file_hashtbl.

* Use rhashtable for the hashtables, as it can automatically grow/shrink
  the number of buckets. I don't know if the rhashtable code could handle
  the load, but it might be worth a shot.

- Frank
