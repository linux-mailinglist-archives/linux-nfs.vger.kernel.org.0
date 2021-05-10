Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C7377A31
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhEJCl2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 May 2021 22:41:28 -0400
Received: from mail-m17670.qiye.163.com ([59.111.176.70]:23344 "EHLO
        mail-m17670.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEJCl1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 May 2021 22:41:27 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 May 2021 22:41:27 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17670.qiye.163.com (Hmail) with ESMTPA id F0BC33C0137;
        Mon, 10 May 2021 10:34:43 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] fs/nfs: Use fatal_signal_pending instead of signal_pending
Date:   Sun,  9 May 2021 19:34:37 -0700
Message-Id: <1620614077-73633-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk1CGVZDTUsdH0IeTE4aH0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6Vhw6MT8VTj8hIgsjTAs6
        DjoKCSJVSlVKTUlLTUpPS0NPT0hDVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpDQkk3Bg++
X-HM-Tid: 0a79542075f8da5akuwsf0bc33c0137
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We set the state of the current process to TASK_KILLABLE via
prepare_to_wait(). Should we use fatal_signal_pending() to detect
the signal here?

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 87d04f2..0cd9658 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1706,7 +1706,7 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!signal_pending(current)) {
+		if (!fatal_signal_pending(current)) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
@@ -3487,7 +3487,7 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			status = -EINTR;
 		else
 			if (schedule_timeout(5*HZ) != 0)
-- 
2.7.4

