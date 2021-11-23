Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE99F45A277
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 13:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhKWMZe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 07:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhKWMZc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Nov 2021 07:25:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C3261002;
        Tue, 23 Nov 2021 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637670144;
        bh=1jxFLUnE7hAw9XO4ad7+VcW/xFs46+nC6nnZhu74Jr0=;
        h=From:To:Cc:Subject:Date:From;
        b=UYdti6bM78RKalRsnRQZ/aK6zG/E+gjddIK6PzhPJQGl8xdge+BCF1AZAVJ+hPrVe
         ZK9SZEfOYLQfCRMoR+xGTzEOZ/bbXewdTPtnvr9InCWQo4IGu2mcd8KTBQ0qTuV7P1
         OAFGJ/I3jmJ5ZATUa2tcfnKacVlMA4/k41rAiCb2Fx/bvzK9tDh8B8eYrcZIthf7K2
         P4FYvfvUJdb4qFI6vCwPsrK9rnEImzrV3tDxi3q+gd5W8XishgA49TEGyIUGeM0uYN
         /7gDCnQW+SMOmVDd/hNlmvBQk+sS6xUSnGGrLFJTZXg/UCf+ne5MGjS6OoHjxTa0JS
         2P3IYxzlimicg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     chuck.lever@oracle.com, bfields@fieldses.org,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfsd: don't put blocked locks on LRU until after vfs_lock_file returns
Date:   Tue, 23 Nov 2021 07:22:23 -0500
Message-Id: <20211123122223.69236-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Vasily reported a case where vfs_lock_file took a very long time to
return (longer than a lease period). The laundromat eventually ran and
reaped the thing and when the vfs_lock_file returned, it ended up
accessing freed memory.

Don't put entries onto the LRU until vfs_lock_file returns.

Reported-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bfad94c70b84..8cfef84b9355 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = ktime_get_boottime_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
-		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
@@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			nn->somebody_reclaimed = true;
 		break;
 	case FILE_LOCK_DEFERRED:
+		nbl->nbl_time = ktime_get_boottime_seconds();
+		spin_lock(&nn->blocked_locks_lock);
+		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
+		spin_unlock(&nn->blocked_locks_lock);
 		nbl = NULL;
 		fallthrough;
 	case -EAGAIN:		/* conflock holds conflicting lock */
-- 
2.33.1

