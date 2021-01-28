Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5873078DB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhA1O5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 09:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231924AbhA1O4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 09:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611845714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5UD1LmNPOaLThJ2vu85J65ZRZzuy/JwWHof7H9XBSO0=;
        b=Fj36OhZWJVOQW7gviMPzBl/3hOXoqSWoFDB32pOT2/xYtZi+Cntv0fjWPrvVpjKJ4KDDvr
        lqSvdTxKvSBsdKmMuP5MZpsxzqtGYulzZTb+Z1u3w58VVIxMZUsHhrfL7+or5vu5bHSLhS
        NAMBgvP6WN+uaTRHszqBLFmIcMnoq1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-kICLWFZ6PN2DW4XXu767Rg-1; Thu, 28 Jan 2021 09:55:11 -0500
X-MC-Unique: kICLWFZ6PN2DW4XXu767Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7D61800D41;
        Thu, 28 Jan 2021 14:55:10 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD4F63B8C;
        Thu, 28 Jan 2021 14:55:09 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] Convert NFS fscache read paths to netfs API
Date:   Thu, 28 Jan 2021 09:54:58 -0500
Message-Id: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This minimal set of patches update the NFS client to use the new
readahead method, and convert the NFS fscache to use the new netfs
IO API, and are at:
https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-lib-nfs-20210128
https://github.com/DaveWysochanskiRH/kernel/commit/74357eb291c9c292f3ab3bc9ed1227cb76f52c51

The patches are based on David Howells fscache-netfs-lib tree at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

The first 6 patches refactor some of the NFS read code to facilitate
re-use, the next 4 patches do the conversion to the new API.  Note
patch 8 converts nfs_readpages to nfs_readahead.

Changes since my last posting on Jan 27, 2021
- Fix oops with fscache enabled on parallel read unit test
- Add patches to handle invalidate and releasepage
- Use #define FSCACHE_USE_NEW_IO_API to select the new API
- Minor cleanup in nfs_readahead_from_fscache

Still TODO
1. Fix known bugs
a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
   with GFP_KERNEL which may sleep (dhowells noted this in a review)
b) nfs_refresh_inode() takes inode->i_lock but may call
   __fscache_invalidate() which may sleep (found with lockdep)
c) WARN with xfstest fscache/netapp/pnfs/nfs41
2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
* Compare with netfs stats and determine if still needed
3. Cleanup dfprintks and/or convert to tracepoints
4. Further tests (see "Not tested yet")

Tests run
1. Custom NFS+fscache unit tests for basic operation: PASS
* vers=3,4.0,4.1,4.2,sec=sys,server=localhost (same kernel)
2. cthon04: PASS
* test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys
* No failures, oopses or hangs
3. iozone tests: PASS
* nofsc,fsc,vers=3,4.0,4.1,4.2,sec=sys,server=rhel7,rhel8
* No failures, oopses, or hangs
4. xfstests/generic: PASS*
* no hangs or crashes (one WARN); failures unrelated to these patches
* Ran following configurations
  * vers=4.1,fsc,sec=sys,rhel7-server: PASS
  * vers=4.0,fsc,sec=sys,rhel7-server: PASS
  * vers=3,fsc,sec=sys,rhel7-server: PASS
  * vers=4.1,nofsc,sec=sys,netapp-server(pnfs/files): PASS
  * vers=4.1,fsc,sec=sys,netapp-server(pnfs/files): INCOMPLETE
    * WARN_ON fs/netfs/read_helper.c:616
    * ran with kernel.panic_on_oops=1
  * vers=4.2,fsc,sec=sys,rhel7-server: running at generic/438
  * vers=4.2,fsc,sec=sys,rhel8-server: running at generic/127
5. kernel build: PASS
  * vers=4.2,fsc,sec=sys,rhel8-server: PASS

Not tested yet:
* error injections (for example, connection disruptions, server errors during IO, etc)
* many process mixed read/write on same file
* performance

Dave Wysochanski (10):
  NFS: Clean up nfs_readpage() and nfs_readpages()
  NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
    succeeds
  NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
    nfs_readdesc
  NFS: Call readpage_async_filler() from nfs_readpage_async()
  NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
  NFS: Allow internal use of read structs and functions
  NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
  NFS: Convert readpages to readahead and use netfs_readahead for
    fscache
  NFS: Update releasepage to handle new fscache kiocb IO API
  NFS: update various invalidation code paths for new IO API

 fs/nfs/file.c              |  22 +++--
 fs/nfs/fscache.c           | 230 +++++++++++++++++++------------------------
 fs/nfs/fscache.h           | 105 +++-----------------
 fs/nfs/internal.h          |   8 ++
 fs/nfs/pagelist.c          |   2 +
 fs/nfs/read.c              | 240 ++++++++++++++++++++-------------------------
 fs/nfs/write.c             |  10 +-
 include/linux/nfs_fs.h     |   5 +-
 include/linux/nfs_iostat.h |   2 +-
 include/linux/nfs_page.h   |   1 +
 include/linux/nfs_xdr.h    |   1 +
 11 files changed, 257 insertions(+), 369 deletions(-)

-- 
1.8.3.1

