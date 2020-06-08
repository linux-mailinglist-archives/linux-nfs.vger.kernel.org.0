Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EED1F1FA8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgFHTVb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 15:21:31 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50141 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHTVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 15:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591644090; x=1623180090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Na/w/Yu3QOOXMPe8D2Ie4lQOC+d41IK2aCsczO3jx8=;
  b=VyizJQh5z5X31RWkC/MQecPQJqn+X7ZDzmf7KMKID3KcQB/2WRI9zX6Z
   9dYHQyLpB5sG/TtBCGuCC+pDknQPNPpsmYjOIjJgQCVbLUlC4oXbQ/SiQ
   psUQwjRTfCpVwbjagPxz+11oGyHo6DwPDjfGosusQAXRKLFDMei5estSe
   k=;
IronPort-SDR: /yllG0IE6cWcFChKedG6XTHhMYvZT862obBZJxo9TBNKu2QvibqkbSYIu9XkCqHrYQDDVclr7e
 qY3qJN6oAM7g==
X-IronPort-AV: E=Sophos;i="5.73,487,1583193600"; 
   d="scan'208";a="42470798"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 08 Jun 2020 19:21:25 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id C79271416F6;
        Mon,  8 Jun 2020 19:21:23 +0000 (UTC)
Received: from EX13D43UWC002.ant.amazon.com (10.43.162.172) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 19:21:22 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D43UWC002.ant.amazon.com (10.43.162.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 19:21:22 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 8 Jun 2020 19:21:22 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id EE426C13E5; Mon,  8 Jun 2020 19:21:22 +0000 (UTC)
Date:   Mon, 8 Jun 2020 19:21:22 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>
Subject: nfsd filecache issues with v4
Message-ID: <20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We recently noticed that, with 5.4+ kernels, the generic/531 test takes
a very long time to finish for v4, especially when run on larger systems.

Case in point: a 72 VCPU, 144G EC2 instance as a client will make the test
last about 20 hours.

So, I had a look to see what was going on. First of all, the test generates
a lot of files - what it does is generate 50000 files per process, where
it starts 2 * NCPU processes. So that's 144 processes in this case, 50000
files each. Also, it does it by setting the file ulimit to 50000, and then
just opening files, keeping them open, until it hits the limit.

So that's 7 million new/open files - that's a lot, but the problem can
be triggered with far fewer than that as well.

Looking at what the server was doing, I noticed a lot of lock contention
for nfsd_file_lru. Then I noticed that that nfsd_filecache_count kept
going up, reflecting the number of open files by the client processes,
eventually reaching, for example, that 7 million number.

So here's what happens: for NFSv4, files that are associated with an
open stateid can stick around for a long time, as long as there's no
CLOSE done on them. That's what's happening here. Also, since those files
have a refcount of >= 2 (one for the hash table, one for being pointed to
by the state), they are never eligible for removal from the file cache.
Worse, since the code call nfs_file_gc inline if the upper bound is crossed
(8192), every single operation that calls nfsd_file_acquire will end up
walking the entire LRU, trying to free files, and failing every time.
Walking a list with millions of files every single time isn't great.

There are some ways to fix this behavior like:

* Always allow v4 cached file structured to be purged from the cache.
  They will stick around, since they still have a reference, but
  at least they won't slow down cache handling to a crawl.

* Don't add v4 files to the cache to begin with.

* Since the only advantage of the file cache for v4 is the caching
  of files linked to special stateids (as far as I can tell), only
  cache files associated with special state ids.

* Don't bother with v4 files at all, and revert the changes that
  made v4 use the file cache.

In general, the resource control for files OPENed by the client is
probably an issue. Even if you fix the cache, what if there are
N clients that open millions of files and keep them open? Maybe
there should be a fallback to start using temporary open files
if a client goes beyond a reasonable limit and threatens to eat
all resources.

Thoughts?

- Frank
