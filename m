Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A0C0C61
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2019 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfI0UIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Sep 2019 16:08:39 -0400
Received: from fieldses.org ([173.255.197.46]:35766 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0UIj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Sep 2019 16:08:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6356C1BE4; Fri, 27 Sep 2019 16:08:38 -0400 (EDT)
Date:   Fri, 27 Sep 2019 16:08:38 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd changes for 5.4
Message-ID: <20190927200838.GA2618@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull nfsd changes from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4

--b.

----------------------------------------------------------------
Highlights:

	- add a new knfsd file cache, so that we don't have to open and
	  close on each (NFSv2/v3) READ or WRITE.  This can speed up
	  read and write in some cases.  It also replaces our readahead
	  cache.
	- Prevent silent data loss on write errors, by treating write
	  errors like server reboots for the purposes of write caching,
	  thus forcing clients to resend their writes.
	- Tweak the code that allocates sessions to be more forgiving,
	  so that NFSv4.1 mounts are less likely to hang when a server
	  already has a lot of clients.
	- Eliminate an arbitrary limit on NFSv4 ACL sizes; they should
	  now be limited only by the backend filesystem and the
	  maximum RPC size.
	- Allow the server to enforce use of the correct kerberos
	  credentials when a client reclaims state after a reboot.

And some miscellaneous smaller bugfixes and cleanup.

----------------------------------------------------------------
Dave Wysochanski (1):
      SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist

 include/linux/sunrpc/cache.h |  6 +++---
 net/sunrpc/cache.c           | 12 ++++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)
