Return-Path: <linux-nfs+bounces-14061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04442B44BDA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCB5A1693
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80ED225761;
	Fri,  5 Sep 2025 02:49:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C93156C6A;
	Fri,  5 Sep 2025 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040559; cv=none; b=EXWXIkhuX88r+4tkhSy2yIkMNVgK/bAqKxHUvznZu/k8gzf7S7XDOB1eFFrHtOMJvcu6pn5EJq9ODmX8+ZxiINZzoRbuhbKTUDegacq/R5lYuQhGO+I56Mm0K0NInT3RC++7Hhkuqz8UGS69dvwsrmvPHoXRX32Czq1wGUUUdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040559; c=relaxed/simple;
	bh=EnQY57ZddTsQf+MPN8Pnv9AZ+cNzvl1957Tk/4TJJ54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzoVPiZuU2XCc4uvrxOKF3CFWV9uIIIv7gK/QoBvQtGam2CE6NotRLL9yuG2clcqdc4UWF5rSIfDmT1rDmOd2THmRKVVw0PVPMcBJlpmLJiI0zZgWTr6OJwUSTjUyeDc8sS/fNWgMqxGTVAzhn7UP1fyPVg5sKwIx5DJiBM5+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cJ11x4Z0qz1R96s;
	Fri,  5 Sep 2025 10:46:13 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id BCD08140279;
	Fri,  5 Sep 2025 10:49:13 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemj200013.china.huawei.com
 (7.202.194.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 10:49:12 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neil@brown.name>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>, <zhangjian496@huawei.com>, <bcodding@redhat.com>
Subject: [PATCH v3] nfsd: remove long-standing revoked delegations by force
Date: Fri, 5 Sep 2025 10:48:23 +0800
Message-ID: <20250905024823.3626685-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200013.china.huawei.com (7.202.194.25)

When file access conflicts occur between clients, the server recalls
delegations. If the client holding delegation fails to return it after
a recall, nfs4_laundromat adds the delegation to cl_revoked list.
This causes subsequent SEQUENCE operations to set the
SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
validate all delegations and return the revoked one.

However, if the client fails to return the delegation like this:
nfs4_laundromat                       nfsd4_delegreturn
 unhash_delegation_locked
 list_add // add dp to reaplist
          // by dl_recall_lru
 list_del_init // delete dp from
               // reaplist
                                       destroy_delegation
                                        unhash_delegation_locked
                                         // do nothing but return false
 revoke_delegation
 list_add // add dp to cl_revoked
          // by dl_recall_lru

The delegation will remain in the server's cl_revoked list while the
client marks it revoked and won't find it upon detecting
SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
This leads to a loop:
the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
client repeatedly tests all delegations, severely impacting performance
when numerous delegations exist.

Since abnormal delegations are removed from flc_lease via nfs4_laundromat
--> revoke_delegation --> destroy_unhashed_deleg -->
nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
requests indefinitely, retaining such a delegation on the server is
unnecessary.

Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Reported-by: Zhang Jian <zhangjian496@huawei.com>
Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
  Changes in v2:
  1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
  2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
     rather than by timeout;
  3) Modify the commit message.

  Changes in v3:
  1) Move variables used for traversal inside the if statement;
  2) Add a comment to explain why we have to do this;
  3) Move the second check of cl_revoked inside the if statement of
     the first check.
 fs/nfsd/nfs4state.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5..20fae3449af6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1336,6 +1336,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 
 	spin_lock(&state_lock);
 	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
+	/*
+	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
+	 * delegation is hashed, to mark the current delegation as invalid.
+	 */
+	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -4470,8 +4475,34 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	default:
 		seq->status_flags = 0;
 	}
-	if (!list_empty(&clp->cl_revoked))
-		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (!list_empty(&clp->cl_revoked)) {
+		struct list_head *pos, *next;
+		struct nfs4_delegation *dp;
+
+		/*
+		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
+		 * may add a delegation to cl_revoked even after the
+		 * client has returned it, causing persistent
+		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
+		 * operations.
+		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
+		 * to resolve.
+		 */
+		spin_lock(&clp->cl_lock);
+		list_for_each_safe(pos, next, &clp->cl_revoked) {
+			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
+			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
+				list_del_init(&dp->dl_recall_lru);
+				spin_unlock(&clp->cl_lock);
+				nfs4_put_stid(&dp->dl_stid);
+				spin_lock(&clp->cl_lock);
+			}
+		}
+		spin_unlock(&clp->cl_lock);
+
+		if (!list_empty(&clp->cl_revoked))
+			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	}
 	if (atomic_read(&clp->cl_admin_revoked))
 		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 	trace_nfsd_seq4_status(rqstp, seq);
-- 
2.46.1


