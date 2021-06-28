Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F063B67C6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhF1Rlh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhF1Rlg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yrDUznq+Z8fx7WO9gYtWyra8a1Joazfh4tpmOmex5R4=;
        b=MlbpxNgtcyZaU/ypWkLNMd6LjT3pcbOtwvaPguxK2QEUFFNol7F7CIBkwHKdoYg3qVbsaj
        QnP4A1hxmVJlwmKnY/Q4tpMcLJmgq9IL+8Hu9xXDORd8MzrQe+e2CDmX3ffR4HShk46COu
        5ZYirgHkN5D2rjgvZr8RdipsB4uoCiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-VIspQRvGOGaw6a9TVwR9Wg-1; Mon, 28 Jun 2021 13:39:08 -0400
X-MC-Unique: VIspQRvGOGaw6a9TVwR9Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 031CF800D55;
        Mon, 28 Jun 2021 17:39:07 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ECE65DD68;
        Mon, 28 Jun 2021 17:39:06 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Fix a few error paths in nfs_readpage and fscache
Date:   Mon, 28 Jun 2021 13:38:59 -0400
Message-Id: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A prior patchset refactored some nfs read code paths but introduced a
few problems in some error paths.  This patcheset cleans up these
error paths specifically the following commit:
1e83b173b266 ("NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()")

The last patch fixes a bug introduced in the above commit, and when
fscache is enabled and an unlikely error occurs.  The first 3 patches
are refactorings / cleanups and while they do not fix any actual bug
to my knowledge, they are required for the 4th patch.

NOTE: The first patch was submitted prior as a solo patch[1], it is
included here unchanged from that submission.
[1] https://marc.info/?l=linux-nfs&m=162454885107812&w=2

Testing
=======
I applied this series on top of Trond's testing tree based on 5.13-rc6
and at:
159dd33001be Merge branch 'sysfs-devel'

scripts/checkpatch.pl was run on all patches and no warnings or errors.

For unit tests of these specific code paths I created custom error injection
to induce failures.

For regression, I ran iterations of xfstests with different servers and all NFS
versions (4.2, 4.1, 4.0, 3), including pNFS (flexfiles,filelayout), and
didn't see any new failures.


Dave Wysochanski (4):
  NFS: Remove unnecessary inode parameter from
    nfs_pageio_complete_read()
  NFS: Ensure nfs_readpage does not wait an internal error occurs
  NFS: Allow internal use of read structs and functions
  NFS: Fix fscache read from NFS after cache error

 fs/nfs/fscache.c  | 14 ++++++++++++--
 fs/nfs/internal.h |  7 +++++++
 fs/nfs/read.c     | 39 ++++++++++++++++++---------------------
 3 files changed, 37 insertions(+), 23 deletions(-)

-- 
1.8.3.1

