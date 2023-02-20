Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACCE69CCE2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Feb 2023 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjBTNoL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Feb 2023 08:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBTNoH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Feb 2023 08:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551E868D
        for <linux-nfs@vger.kernel.org>; Mon, 20 Feb 2023 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676900593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G9jBEacaBVlZAs6ncI+7oeFM0+M4J6km3feMGyJvNAU=;
        b=Jw/6cJghoR4FWOabk1wocVDu9KLAL0fsF5wfBAg1c1JSJP61IiG+zu+ffzXqzGf1LxHuSP
        kArySIqk7AdGz3faiSvNuK1qkQ0FUSMcbg+HjBQbid33p7bHG8GDJbBKH7oQjgQSzijkUN
        P7x7xQvbPNpuT3iNPxJyWa9Yd5WtC+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-M5-7tauNNj-T8YQtzB5DHA-1; Mon, 20 Feb 2023 08:43:10 -0500
X-MC-Unique: M5-7tauNNj-T8YQtzB5DHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE7BB800B23;
        Mon, 20 Feb 2023 13:43:09 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F56A404CD84;
        Mon, 20 Feb 2023 13:43:09 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v11 0/5] Convert NFS with fscache to the netfs API
Date:   Mon, 20 Feb 2023 08:43:03 -0500
Message-Id: <20230220134308.1193219-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, this v11 patchset addresses your latest feedback on patch #2,
and I did a little bit of cleanup to patch 3 (see Changes notes below).
I'm not sure of further changes to patch #3 without a more in-depth
review with specifics, if you feel the current approach is unacceptable [1].

Ben and Daire, if you could test this set and provide you feedback
and a Tested-By: that would be appreciated.  This set addresses
the existing NFS + fscache performance concerns seen by a few
users [5], which is due to utilization use of the deprecated
single-page function, fscache_fallback_read_page().  However,
until "known issue #1" below is also resolved, even with these
patches, performance of NFS+fscache will still be a problem
in some scenarios.

This patchset converts NFS with fscache buffered read IO paths to
use the netfs API with a non-invasive approach.  The existing NFS pgio
layer does not need extensive changes, and is the best way so far I've
found to address Trond's previous concerns about modifying the IO
path [2] as well as only enabling netfs when fscache is configured
and enabled [3].  I have not attempted performance comparisions to
address Chuck Lever's concern [4] because we are not converting the
non-fscache enabled NFS IO paths to netfs. 

The patchset is based on Trond's latest 'testing' branch which includes
his folio patchset, and is based on 6.2-rc5.  It has been pushed to
github at:
https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b7552eff26eb5da1f2282d35616

Changes since v10 [6]
=====================
PATCH6: Dropped
PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode (Trond) [7]
PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlock()

Testing
=======
I did a full round of testing on this because it was rebased on top of
Trond's testing branch which included his folio series.
All of my unit tests pass except the one with the known issue #1 below.
Multiple runs of xfstests generic tests (applicable to NFS) were run with
with various servers, both with and without fscache enabled, and
compared to baseline (Trond's testing branch).  No new failures were
observed with these patches, and in some xfstest instances, this
patchset improves the results (some tests that were failing now pass).
- hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
- NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
- RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3

Known issues
============
1. Unit test setting rsize < readahead does not properly read from
fscache but re-reads data from the NFS server
* This will be fixed with another dhowells patch [8]:
  "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache"
* Daire Byrne verified the patch fixes his issue as well

2. "Cache volume key already in use" after xfstest runs involving multiple mounts
* Simple reproducer requires just two mounts as follows:
 mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp1 /mnt1
 mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp2 /mnt2
* This should be fixed with dhowells patch [9]:
  "[PATCH v5] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing"


References
==========
[1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org/
[2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
[3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
[4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com/
[5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f7XxRj+xS3NVxcJ+b8AAKQg@mail.gmail.com/
[6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwysocha@redhat.com/
[7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5f2414c18e1f.camel@kernel.org/
[8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
[9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyon.org.uk/

Dave Wysochanski (5):
  NFS: Rename readpage_async_filler to nfs_read_add_folio
  NFS: Configure support for netfs when NFS fscache is configured
  NFS: Convert buffered read paths to use netfs when fscache is enabled
  NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
  NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit

 fs/nfs/Kconfig             |   1 +
 fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
 fs/nfs/fscache.h           | 131 ++++++++++++++------
 fs/nfs/inode.c             |   2 +
 fs/nfs/internal.h          |   9 ++
 fs/nfs/iostat.h            |  17 ---
 fs/nfs/nfstrace.h          |  91 --------------
 fs/nfs/pagelist.c          |   4 +
 fs/nfs/read.c              | 105 ++++++++--------
 fs/nfs/super.c             |  11 --
 include/linux/nfs_fs.h     |  25 ++--
 include/linux/nfs_iostat.h |  12 --
 include/linux/nfs_page.h   |   3 +
 include/linux/nfs_xdr.h    |   3 +
 14 files changed, 317 insertions(+), 339 deletions(-)

-- 
2.31.1

