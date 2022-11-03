Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858906183FC
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCQRn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKCQRj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 12:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8211154
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667492203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iZLYUlTfkNsEFb90/6rRUPnaF4FyWc/ZnESSH4x3jIg=;
        b=B0G3jXEw9ClMF3SAzL2tUClveWHvh20i4s/INKvlfzmewFIda3AA9zKmgsPLcJL1pFxiuv
        pVjzpBGAJmv9HvbKusnri91qlUB4j5YBtIwTiMDsFjgvZUJDcNlBk5WLndPkp3uP/Xm2sf
        mctdVOA4TQtezkC62KsYc9VmI5msmbg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-uriHy2v3OE6wpUP3QrT-nw-1; Thu, 03 Nov 2022 12:16:41 -0400
X-MC-Unique: uriHy2v3OE6wpUP3QrT-nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFBFE3C11EB7;
        Thu,  3 Nov 2022 16:16:39 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.10.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CEA01415139;
        Thu,  3 Nov 2022 16:16:39 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v10 0/6] Convert NFS with fscache to the netfs API 
Date:   Thu,  3 Nov 2022 12:16:31 -0400
Message-Id: <20221103161637.1725471-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This v10 patchset addresses at least some of Trond's latest concerns.
Some of the feedback like the unlock_page() wrapper function in
nfs_read_completion() I don't know how to address without an
ifdef.  Other feedback I'm not quite sure about splitting out
netfs bits or what you would like to see.  Trond I do not want to
in any way ignore or miss any of your feedback so please elaborate
as needed.

This patchset converts NFS with fscache non-direct READ IO paths to
use the netfs API with a non-invasive approach.  The existing NFS pgio
layer does not need extensive changes, and is the best way so far I've
found to address Trond's concerns about modifying the IO path [1] as
well as only enabling netfs when fscache is configured and enabled [2].
I have not attempted performance comparisions to address Chuck
Lever's concern [3] because we are not converting the non-fscache
enabled NFS IO paths to netfs.

The patchset is based on 6.1-rc3 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
https://github.com/DaveWysochanskiRH/kernel/commit/bff09aa979010f38a11a6f92451e85d04d850715

Changes since v9 [7]
====================
PATCH1: Rename nfs_pageio_add_page to nfs_read_add_page (Trond)
PATCH3: Remove a few #ifdef's and replace with wrappers (Trond) [8]
PATCH6: RFC patch to reduce increase in nfs_inode memory footprint
when netfs is configured but not enabled (Trond) [9]

Testing
=======
I did not do much testing on this as the changes to patches 1 and 3
are cosmetic.  Patch #6 is RFC patch and may change, so if that is
added it may need more testing.

Known issues
============
1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another linux-cachefs [4] patch to resolve
"Stop read optimisation when folio removed from pagecache"
* Daire Byrne also verified the patch fixes his issue as well

2. "Cache volume key already in use" after xfstest runs
* xfstests (hammerspace with vers=4.2,fsc) shows the following on the
console after some tests:
"NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
* This may be fixed with another patch [5] that is in progress

3. Daire Byrne reported a NULL pointer oops at cachefiles_prepare_write+0x28/0x90
* harder to reproduce/debug but under investigation [6]
* only reproduced on RHEL7.9 based NFS re-export server using fscache with upstream kernel plus
the previous patches
* Debug in progress, first pass at where the problem is indicates a race
between fscache cookie LRU and use_cookie; looking at cookie state machine [10]

[58710.346376] BUG: kernel NULL pointer dereference, address: 0000000000000008
[58710.371212] CPU: 12 PID: 9134 Comm: kworker/u129:0 Tainted: G E      6.0.0-2.dneg.x86_64 #1
...
[58710.389995] Workqueue: events_unbound netfs_rreq_write_to_cache_work [netfs]
[58710.397188] RIP: 0010:cachefiles_prepare_write+0x28/0x90 [cachefiles]
...
[58710.500316] Call Trace:
[58710.502894]  <TASK>
[58710.505126]  netfs_rreq_write_to_cache_work+0x11c/0x320 [netfs]
[58710.511201]  process_one_work+0x217/0x3e0
[58710.515358]  worker_thread+0x4a/0x3b0
[58710.519152]  ? process_one_work+0x3e0/0x3e0
[58710.523467]  kthread+0xd6/0x100
[58710.526740]  ? kthread_complete_and_exit+0x20/0x20
[58710.531659]  ret_from_fork+0x1f/0x30



References
==========
[1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[2] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
[3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
[4] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
[5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4
[6] https://listman.redhat.com/archives/linux-cachefs/2022-September/007183.html
[7] https://marc.info/?l=linux-nfs&m=166600357429305&w=4
[8] https://marc.info/?l=linux-nfs&m=166697599503342&w=4
[9] https://marc.info/?l=linux-nfs&m=166717208305834&w=4
[10] https://listman.redhat.com/archives/linux-cachefs/2022-October/007259.html

Dave Wysochanski (5):
  NFS: Rename readpage_async_filler to nfs_pageio_add_page
  NFS: Configure support for netfs when NFS fscache is configured
  NFS: Convert buffered read paths to use netfs when fscache is enabled
  NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
  NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit

 fs/nfs/Kconfig             |   1 +
 fs/nfs/delegation.c        |   2 +-
 fs/nfs/dir.c               |   2 +-
 fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
 fs/nfs/fscache.h           | 111 +++++++++++------
 fs/nfs/inode.c             |   8 +-
 fs/nfs/internal.h          |  11 +-
 fs/nfs/iostat.h            |  17 ---
 fs/nfs/nfstrace.h          |  91 --------------
 fs/nfs/pagelist.c          |  12 ++
 fs/nfs/pnfs.c              |  12 +-
 fs/nfs/read.c              | 110 +++++++++--------
 fs/nfs/super.c             |  11 --
 fs/nfs/write.c             |   2 +-
 include/linux/nfs_fs.h     |  35 ++++--
 include/linux/nfs_iostat.h |  12 --
 include/linux/nfs_page.h   |   3 +
 include/linux/nfs_xdr.h    |   3 +
 18 files changed, 335 insertions(+), 350 deletions(-)

-- 
2.31.1

*** BLURB HERE ***

Dave Wysochanski (6):
  NFS: Rename readpage_async_filler to nfs_read_add_page
  NFS: Configure support for netfs when NFS fscache is configured
  NFS: Convert buffered read paths to use netfs when fscache is enabled
  NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
  NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
  netfs: Change netfs_inode_init to allocate memory to allow opt-in

 fs/9p/cache.c              |   2 +-
 fs/9p/vfs_inode.c          |  17 ++-
 fs/afs/dynroot.c           |   7 +-
 fs/afs/inode.c             |  14 +--
 fs/afs/internal.h          |   2 +-
 fs/afs/super.c             |   7 ++
 fs/afs/write.c             |   2 +-
 fs/ceph/inode.c            |   6 +-
 fs/netfs/buffered_read.c   |  16 +--
 fs/netfs/internal.h        |   2 +-
 fs/netfs/objects.c         |   2 +-
 fs/nfs/Kconfig             |   1 +
 fs/nfs/delegation.c        |   2 +-
 fs/nfs/dir.c               |   2 +-
 fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
 fs/nfs/fscache.h           | 136 +++++++++++++++------
 fs/nfs/inode.c             |  15 ++-
 fs/nfs/internal.h          |  11 +-
 fs/nfs/iostat.h            |  17 ---
 fs/nfs/nfstrace.h          |  91 --------------
 fs/nfs/pagelist.c          |   4 +
 fs/nfs/pnfs.c              |  12 +-
 fs/nfs/read.c              | 110 +++++++++--------
 fs/nfs/super.c             |  11 --
 fs/nfs/write.c             |   2 +-
 include/linux/netfs.h      |  41 +++++--
 include/linux/nfs_fs.h     |  35 ++++--
 include/linux/nfs_iostat.h |  12 --
 include/linux/nfs_page.h   |   3 +
 include/linux/nfs_xdr.h    |   3 +
 30 files changed, 428 insertions(+), 399 deletions(-)

-- 
2.31.1

