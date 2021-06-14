Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1E3A6942
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhFNOuZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhFNOuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 10:50:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3040C061787
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 07:48:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 435563723; Mon, 14 Jun 2021 10:48:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 435563723
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/3] reexport lock fixes
Date:   Mon, 14 Jun 2021 10:48:15 -0400
Message-Id: <1623682098-13236-1-git-send-email-bfields@redhat.com>
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

--b.

J. Bruce Fields (3):
  nfs: don't atempt blocking locks on nfs reexports
  lockd: lockd server-side shouldn't set fl_ops
  nfs: don't allow reexport reclaims

 fs/lockd/svclock.c       | 30 ++++++++++++------------------
 fs/nfs/export.c          |  2 +-
 fs/nfs/file.c            |  3 +++
 fs/nfsd/nfs4state.c      | 11 +++++++++--
 fs/nfsd/nfsproc.c        |  1 +
 include/linux/exportfs.h |  2 ++
 include/linux/fs.h       |  1 +
 7 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.31.1

