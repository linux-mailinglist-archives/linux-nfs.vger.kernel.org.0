Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226AF125EE4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLSK1f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 05:27:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfLSK1f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 05:27:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 281BFA74C48690F21961;
        Thu, 19 Dec 2019 18:27:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 18:27:26 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] NFS4: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 18:34:47 +0800
Message-ID: <1576751687-74876-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes coccicheck warning:

fs/nfs/nfs4state.c:1138:2-3: Unneeded semicolon
fs/nfs/nfs4proc.c:6862:2-3: Unneeded semicolon
fs/nfs/nfs4proc.c:8629:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/nfs/nfs4proc.c  | 4 ++--
 fs/nfs/nfs4state.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..63269d3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6859,7 +6859,7 @@ static void nfs4_handle_setlk_error(struct nfs_server *server, struct nfs4_lock_
 	case -NFS4ERR_STALE_STATEID:
 		lsp->ls_seqid.flags &= ~NFS_SEQID_CONFIRMED;
 		nfs4_schedule_lease_recovery(server->nfs_client);
-	};
+	}
 }

 static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *fl, int recovery_type)
@@ -8626,7 +8626,7 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 	case -EACCES:
 	case -EAGAIN:
 		goto out;
-	};
+	}

 	clp->cl_seqid++;
 	if (!status) {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3455232..fe1b908 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1135,7 +1135,7 @@ static void nfs_increment_seqid(int status, struct nfs_seqid *seqid)
 		case -NFS4ERR_MOVED:
 			/* Non-seqid mutating errors */
 			return;
-	};
+	}
 	/*
 	 * Note: no locking needed as we are guaranteed to be first
 	 * on the sequence list
--
2.7.4

