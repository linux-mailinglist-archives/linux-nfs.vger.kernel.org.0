Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796F3F35CD
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 23:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhHTVCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbhHTVCr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Aug 2021 17:02:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4295C061575
        for <linux-nfs@vger.kernel.org>; Fri, 20 Aug 2021 14:02:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B016640E2; Fri, 20 Aug 2021 17:02:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B016640E2
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/8] reexport lock fixes v3
Date:   Fri, 20 Aug 2021 17:01:58 -0400
Message-Id: <1629493326-28336-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The following fix up some problems that can cause crashes or silently
broken lock guarantees in the reexport case.

Note:
	- patches 1-5 are server side
	- patches 6-7 are client side
	- patch 8 affects both

Simplest might be for Trond or Anna to ACK 6-8, if they look OK, and
then submit them all through the server.  But those three sets of
patches are all independent if you'd rather split them up.

Not fixed:
        - Attempts to reclaim locks after a reboot of the reexport
          server will fail.  This at least seems like an improvement
          over the current situation, which is that they'll succeed even
          in cases where they shouldn't.  Complete support for reboot
          recovery is a bigger job.

        - NFSv4.1+ lock nofications don't work.  So, clients have to
          poll as they do with NFSv4.0, which is suboptimal, but correct
          (and an improvement over the current situation, which is a
          kernel oops).

So what we have at this point is a suboptimal lock implementation that
doesn't support lock recovery.

Another alternative might be to turn off file locking entirely in the
re-export case.  I'd rather take the incremental improvement and fix the
oopses.

Change since v2:
	- keep nlmsvc_file_inode a static inline to address build
	  failure identified by the kernel test robot
Changes since v1:
	- Use ENOGRACE instead of returning NFS-specific error from vfs lock
	  method.
	- Take write opens for write locks in the NLM case (as we always
	  have in the NFSv4 case).
	- Don't block NLM threads waiting for blocking locks.

With those changes I'm passing connecthon tests for NFSv3-4.2 reexports
of an NFSv4.0 filesystem.

--b.

J. Bruce Fields (8):
  lockd: lockd server-side shouldn't set fl_ops
  nlm: minor nlm_lookup_file argument change
  nlm: minor refactoring
  lockd: update nlm_lookup_file reexport comment
  Keep read and write fds with each nlm_file
  nfs: don't atempt blocking locks on nfs reexports
  lockd: don't attempt blocking locks on nfs reexports
  nfs: don't allow reexport reclaims

 fs/lockd/svc4proc.c         |   6 +-
 fs/lockd/svclock.c          |  80 ++++++++++++++----------
 fs/lockd/svcproc.c          |   6 +-
 fs/lockd/svcsubs.c          | 117 +++++++++++++++++++++++++-----------
 fs/nfs/export.c             |   2 +-
 fs/nfs/file.c               |   3 +
 fs/nfsd/lockd.c             |   8 ++-
 fs/nfsd/nfs4state.c         |  11 +++-
 fs/nfsd/nfsproc.c           |   1 +
 include/linux/errno.h       |   1 +
 include/linux/exportfs.h    |   2 +
 include/linux/fs.h          |   1 +
 include/linux/lockd/bind.h  |   3 +-
 include/linux/lockd/lockd.h |  11 +++-
 14 files changed, 170 insertions(+), 82 deletions(-)

-- 
2.31.1

