Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57812107
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2019 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBRcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 May 2019 13:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEBRcN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 May 2019 13:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08FE587621;
        Thu,  2 May 2019 17:32:13 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-85.rdu2.redhat.com [10.10.122.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB47A423D;
        Thu,  2 May 2019 17:32:12 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 80ABE21003; Thu,  2 May 2019 13:32:12 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: update callback done processing
Date:   Thu,  2 May 2019 13:32:12 -0400
Message-Id: <20190502173212.9530-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 02 May 2019 17:32:13 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Instead of having the convention where individual nfsd4_callback_ops->done
operations return -1 to indicate the callback path is down, move the check
to nfsd4_cb_done.  Only mark the callback path down on transport-level
errors, not NFS-level errors.

Additionally, handle NFS4ERR_DELAY in nfsd4_cb_recall_done.  The client
returns NFS4ERR_DELAY if it is already in the process of returning the
delegation.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4callback.c | 9 +++++----
 fs/nfsd/nfs4layouts.c  | 2 +-
 fs/nfsd/nfs4state.c    | 5 ++++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7caa3801ce72..b9cbd7189d74 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1122,10 +1122,11 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 		return;
 	case 1:
-		break;
-	case -1:
-		/* Network partition? */
-		nfsd4_mark_cb_down(clp, task->tk_status);
+		switch (task->tk_status) {
+		case -EIO:
+		case -ETIMEDOUT:
+			nfsd4_mark_cb_down(clp, task->tk_status);
+		}
 		break;
 	default:
 		BUG();
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 44517fb5c0de..a79e24b79095 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -693,7 +693,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 			ops->fence_client(ls);
 		else
 			nfsd4_cb_layout_fail(ls);
-		return -1;
+		return 1;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
 		task->tk_status = 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f056b1d3fecd..4805b83ac5e5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3957,6 +3957,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 	switch (task->tk_status) {
 	case 0:
 		return 1;
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
 	case -EBADHANDLE:
 	case -NFS4ERR_BAD_STATEID:
 		/*
@@ -3969,7 +3972,7 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 		}
 		/*FALLTHRU*/
 	default:
-		return -1;
+		return 1;
 	}
 }
 
-- 
2.17.2

