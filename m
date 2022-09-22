Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3D5E647F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIVN6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiIVN63 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 09:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC438EF087
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663855108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gORBnhZVuyQJdPZiIBZNVwHNCrWccUCJT1OB9qTPNo8=;
        b=idKvx2eS3QTtvVfwOowQLE7X2lP0SqoJW5gmrABfQ1q5VFvyzeRuRqOe/rz7AK0cjGG/mp
        GacQZ60CpvaetBKmC5F9PBS+8BdJolwd/9Vvp6NTqNZJpwqrkwbhDti7+fgtxpOtnZsb/w
        wPqBdvX0P0twIPKt4cIhr3ZNayUAu1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-plsAeilXOeeUPZI8aV_HLA-1; Thu, 22 Sep 2022 09:58:24 -0400
X-MC-Unique: plsAeilXOeeUPZI8aV_HLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E18BB80280D;
        Thu, 22 Sep 2022 13:58:23 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28D7F112131B;
        Thu, 22 Sep 2022 13:58:23 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v8 0/3] Convert NFS with fscache to the netfs API
Date:   Thu, 22 Sep 2022 09:58:16 -0400
Message-Id: <20220922135821.1771966-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset converts NFS with fscache non-direct READ IO paths to
use the netfs API with a non-invasive approach.  The existing NFS pgio
layer does not need extensive changes, and is the best way so far I've
found to address Trond's concerns about modifying the IO path [1] as
well as only enabling netfs when fscache is configured and enabled [2].
I have not attempted performance comparisions to address Chuck
Lever's concern [3] because we are not converting the non-fscache
enabled NFS IO paths to netfs.

The main patch to be reviewed is patch #3 which converts nfs_read_folio
and nfs_readahead.  There are two main compatibility points with the
interface between the NFS READ IO path and netfs.  First, NFS IO
interfaces are page based and netfs is request based (multiple page).
Thus, there's some accounting information collected to turn multiple
NFS READ RPC completions into a single netfs completion, and we have
to pass a pointer to this information through NFS pgio layer.  Second,
the unlocking of pages of an NFS READ is handled inside netfs, which
requires a tiny bit of refactoring of the NFS read code.

Patch #4 removes the NFS fscache counters and also removes the "fsc:"
line from /proc/self/mountstats.  I was not sure if we need to leave
that line in the mountstats file, and just leave the values at 0, or
we can remove it.  For now I've removed it but if needed for ABI or
some other reason I can add back a "dummy" line with zeros.

In patch #5 I've removed the existing trace events because they no
longer have any meaning, and did not add any new ones since netfs
and fscache has many tracepoints.  A future series may want to look
at some of the pgio layer tracepoints along with maybe one or two
related to NFS with fscache but for now it does not seem needed.

The patchset is based on 6.0-rc6 and has been pushed to github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
https://github.com/DaveWysochanskiRH/kernel/commit/b0467a2c39f3e8582660d073f9fa5c45ec2ca7f0


Changes since v7
================
- PATCH3: Free netfs memory if nfs_pageio_add_page() fails inside
  nfs_netfs_issue_read()
- PATCH3: Clean up handling of READs completing with retryable and
  non-retryable errors by removing unneeded nfs_netfs_read_done();
  fixes oops in generic/303 with vers=4.2 and RHEL8 server due to
  use-after-free of netfs structure
- PATCH3: Update patch header
- PATCH4 and PATCH5: new


Testing
=======
The patches are fairly stable as evidenced with xfstests generic with
various servers, both with and without fscache enabled, with no hangs
or crashes seen: 
- hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
- NetApp(pNFS filelayout): NFS3, NFS4.0, NFS4.1
- RHEL8: NFS3,NFS4.0,NFS4.2

The known issues are as follows:

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
* only reproduced on RHEL7.9 based NFS re-export server using fscache with upstream kernel plus
the previous patches
* may be a bug in netfs or cachefiles exposed by NFS patches
* harder to reproduce/debug but under investigation

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

