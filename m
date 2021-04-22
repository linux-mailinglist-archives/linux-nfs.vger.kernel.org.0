Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B309D3677A0
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 04:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhDVC7M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 22:59:12 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:49332 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDVC7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 22:59:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 22:59:11 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id D805B80106;
        Thu, 22 Apr 2021 10:51:54 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] fs/nfs: Use fatal_signal_pending instead of signal_pending.
Date:   Wed, 21 Apr 2021 19:51:44 -0700
Message-Id: <1619059904-56371-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx9NHlZNHh8YQ0tPQ0hMQ09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6ASo5GT8WDg8zME46FA4x
        KEsKCg1VSlVKTUpCS05CQkpOSEtJVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPTk03Bg++
X-HM-Tid: 0a78f77db8e3b037kuuud805b80106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We set the state of the current process to TASK_KILLABLE via
prepare_to_wait(). Should we use fatal_signal_pending() to detect
the signal here?

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 fs/nfs/nfs4proc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c65c4b4..127be294 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1681,13 +1681,13 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!signal_pending(current)) {
+		if (!fatal_signal_pending(current)) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
 				status = 0;
 		} else
-			status = -EINTR;
+			status = -ERESTARTSYS;
 		finish_wait(&state->waitq, &wait);
 		rcu_read_lock();
 		spin_lock(&state->owner->so_lock);
@@ -3457,8 +3457,8 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (signal_pending(current))
-			status = -EINTR;
+		if (fatal_signal_pending(current))
+			status = -ERESTARTSYS;
 		else
 			if (schedule_timeout(5*HZ) != 0)
 				status = 0;
@@ -3467,7 +3467,7 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 
 		if (!status)
 			continue;
-		if (status == -EINTR)
+		if (status == -ERESTARTSYS)
 			break;
 
 		/* we slept the whole 5 seconds, we must have lost a seqid */
-- 
2.7.4

