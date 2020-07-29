Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33F7231FFC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2OMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgG2OMr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=HL+6FqlvEcgCaIqZDwXrTYJS6X5Crt1+Xo08Pm8/Rbo=;
        b=f/CdX1UpBBjnThOy2zsfPE8pDD2cIWvqqhynLuQgU0IkOcCsHWvMC4FUszK2GVrcKlOkOY
        URc1fPiGXtPSIEIR7R0f0lCKEM+cTksPKhwhpHts2fDynee3WLc0v3UFUwnSEIkwtB2+R+
        MZvJSIg7xV5FZEH8281z+LUnH13moGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-nJvcavXrMXe_8-yqMF8Ynw-1; Wed, 29 Jul 2020 10:12:42 -0400
X-MC-Unique: nJvcavXrMXe_8-yqMF8Ynw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F7210CE782;
        Wed, 29 Jul 2020 14:12:41 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D47E371923;
        Wed, 29 Jul 2020 14:12:35 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 0/14] Convert NFS to new FS-Cache iter API
Date:   Wed, 29 Jul 2020 10:12:15 -0400
Message-Id: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches update the nfs client to use the new FS-Cache API and are at:
https://github.com/DaveWysochanskiRH/kernel/tree/fscache-iter-nfs
https://github.com/DaveWysochanskiRH/kernel/commit/467796a0c75d64401c8963e9266f27d87863ed3e

They are based on David Howells fscache-iter tree at 757ac8b16a0edd3befa15c9bdcb2ab3811be945d
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-iter&id=757ac8b16a0edd3befa15c9bdcb2ab3811be945d

The first 5 patches refactor some of the NFS read code to facilitate
re-use, while the last 9 patches do the conversion to the new FS-Cache
API.

Changes since v1
* Refactor and general cleanup of read code paths
* Fixes a few build errors when NFS_FSCACHE is not configured
* Fixes directIO data corruption (needed fscache_invalidate() on directIO write)

Summary
* Takes a "least invasive to existing code" approach
  * most fscache bits stay fs/nfs/fscache.[ch]
  * only enable fscache for files open for READ (disable for WRITE)
  * may not be the best approach (see future patcheset items below)
* Basically works and passes a series of tests (see below)
  * No kernel oopses or hangs seen with tests run

Future patchset items
* Call fscache_read_helper_* directly rather than isolation into
  fs/nfs/fscache.c, similar to the AFS conversion
* Add write-through support
  * Eliminate on/off switching of fscache based on whether a
  file is open for read or write
  * TODO: Work out any limitations of NFS versions
* Rework dfprintks and/or add ftrace points
  * fscache/cachefiles has 'debug' logging similar to rpcdebug
  * convert IO path to ftrace, leave non-IO path as dfprintk?

Tests run
* A few individual NFS/fscache unit tests: PASS
* cthon04 (fsc/non-fsc, vers=3,4.0,4.1,4.2, sec=sys): PASS
* iozone tests (fsc, vers=3,4.0,4.1,4.2, sec=sys): PASS
* xfstests/generic (fsc,vers=4.2): 17/151 (Failed/Ran) 595/444 (Total/NotRan)
Failures: generic/029 generic/030 generic/240 generic/294 generic/306 generic/356 generic/357 generic/452 generic/472 generic/493 generic/494 generic/495 generic/496 generic/497 generic/554 generic/568 generic/569
Failed 17 of 595 tests
* kernel build: FAIL (linking module fails; truncate / invalidate related?)

Test not run
* error injections (for example, connection disruptions, server errors during IO, etc)
* pNFS
* many process mixed read/write on same file
* sec=krb5

Dave Wysochanski (14):
  NFS: Clean up nfs_readpage() and nfs_readpages()
  NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
    succeeds
  NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
    nfs_readdesc
  NFS: Call readpage_async_filler() from nfs_readpage_async()
  NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
  NFS: Allow internal use of read structs and functions
  NFS: Convert nfs_readpage() and readpages() to new fscache API
  NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
  NFS: Only use and unuse an fscache cookie a single time based on
    NFS_INO_FSCACHE
  NFS: Convert fscache invalidation and update aux_data and i_size
  NFS: Call nfs_fscache_invalidate() when write extends the size of the
    file
  NFS: Invalidate fscache for direct writes
  NFS: Call fscache_resize_cookie() when inode size changes due to
    setattr
  NFS: Allow NFS use of new fscache API in build

 fs/nfs/Kconfig           |   2 +-
 fs/nfs/direct.c          |   2 +
 fs/nfs/file.c            |  20 +--
 fs/nfs/fscache-index.c   |  94 --------------
 fs/nfs/fscache.c         | 309 +++++++++++++++++++++++------------------------
 fs/nfs/fscache.h         |  99 ++++++---------
 fs/nfs/inode.c           |   4 +-
 fs/nfs/internal.h        |   9 ++
 fs/nfs/nfs4proc.c        |   2 +-
 fs/nfs/pagelist.c        |   1 +
 fs/nfs/read.c            | 217 +++++++++++++++------------------
 fs/nfs/write.c           |   3 +-
 include/linux/nfs_fs.h   |   2 -
 include/linux/nfs_page.h |   1 +
 include/linux/nfs_xdr.h  |   1 +
 15 files changed, 316 insertions(+), 450 deletions(-)

-- 
1.8.3.1

