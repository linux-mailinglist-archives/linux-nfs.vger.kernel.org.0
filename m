Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAA3ED86A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhHPOBM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhHPOAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627FC0612E7
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 06:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7768240E2; Mon, 16 Aug 2021 09:59:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7768240E2
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/8] reexport lock fixes v2
Date:   Mon, 16 Aug 2021 09:59:19 -0400
Message-Id: <1629122367-18541-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The following fix up some problems that can cause crashes or silently
broken lock guarantees in the reexport case.

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
 fs/lockd/svclock.c          |  80 +++++++++++++----------
 fs/lockd/svcproc.c          |   6 +-
 fs/lockd/svcsubs.c          | 125 +++++++++++++++++++++++++-----------
 fs/nfs/export.c             |   2 +-
 fs/nfs/file.c               |   3 +
 fs/nfsd/lockd.c             |   8 ++-
 fs/nfsd/nfs4state.c         |  11 +++-
 fs/nfsd/nfsproc.c           |   1 +
 include/linux/errno.h       |   1 +
 include/linux/exportfs.h    |   2 +
 include/linux/fs.h          |   1 +
 include/linux/lockd/bind.h  |   3 +-
 include/linux/lockd/lockd.h |  13 ++--
 14 files changed, 177 insertions(+), 85 deletions(-)

-- 
2.31.1

