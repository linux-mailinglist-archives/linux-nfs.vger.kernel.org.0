Return-Path: <linux-nfs+bounces-15116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF5BCB939
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 05:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76CD34E0F8D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7B26A1CF;
	Fri, 10 Oct 2025 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PUNz2wP8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C943D76;
	Fri, 10 Oct 2025 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067878; cv=none; b=tzb801JfE//swyAUhmWBRi2dsoOoCoKX3wB6B7/1ekyY9OvPp4ENuUvUmDWyJA3hvmSoBwjAQp3bnpE/98fEXHyyD0AnsWF0ztAxi3+2nrqKzHoA+BWT4r/wawndpXUacrM2GwnVt9pLPP8RM9fGfgSZr78JhQ81MQTkQ26xUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067878; c=relaxed/simple;
	bh=KXVk+qxTTK5dmUBUc1AAzLAw8BFrjpHoLyZVhe0cHQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkACRbYscgUIDlx4ENIm0tDXeW844GnLd3+4XJK2jeUlyN83zpa68t5Dxgm2MBqi7bUk24o1HIT+8o97NXypul54oLGvOBxwxoZnfm0ddlqoHNL4KmchDUe06j+I4oyPBmsjeqlgRxn2gZ2knAtc53PSNp0TCKnuR/mJf6U7PoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PUNz2wP8; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UO2i6K049bN9LynJuKtSWLZ6WnrlQgkXQr1f5NmB5MM=;
	b=PUNz2wP88wk2a4WneMNmtP1V5FAGCflUTa66xZ7KEPgiRamxKbkIRqLmo0Wg20+33pO0FlCnt
	qdlYSXRfyIE0/hLF478av45hSSP4+l2nu0Lx+4y1txpByYnYulQXeAazkUsGT+WQauXKRIdhoNO
	W/z53RveWuzGNqSp1+kWhNE=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cjXff3D7KzKm6c;
	Fri, 10 Oct 2025 11:44:10 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A5A01A016C;
	Fri, 10 Oct 2025 11:44:27 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemj200013.china.huawei.com
 (7.202.194.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 11:44:26 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neil@brown.name>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>, <zhangjian496@huawei.com>, <bcodding@redhat.com>
Subject: [PATCH v4] nfsd: remove long-standing revoked delegations by force
Date: Fri, 10 Oct 2025 11:43:33 +0800
Message-ID: <20251010034333.670068-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Reported-by: Zhang Jian <zhangjian496@huawei.com>
Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
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

  Changes in v4:
  Stuff dp onto a local list under the protect of cl_lock and put all
  the items later.
 fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 81fa7cc6c77b..30fed3845fa1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1373,6 +1373,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 
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
@@ -4507,8 +4512,40 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	default:
 		seq->status_flags = 0;
 	}
-	if (!list_empty(&clp->cl_revoked))
-		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (!list_empty(&clp->cl_revoked)) {
+		struct list_head *pos, *next, reaplist;
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
+		INIT_LIST_HEAD(&reaplist);
+		spin_lock(&clp->cl_lock);
+		list_for_each_safe(pos, next, &clp->cl_revoked) {
+			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
+			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
+				list_del_init(&dp->dl_recall_lru);
+				list_add(&dp->dl_recall_lru, &reaplist);
+			}
+		}
+		spin_unlock(&clp->cl_lock);
+
+		while (!list_empty(&reaplist)) {
+			dp = list_first_entry(&reaplist, struct nfs4_delegation,
+						dl_recall_lru);
+			list_del_init(&dp->dl_recall_lru);
+			nfs4_put_stid(&dp->dl_stid);
+		}
+
+		if (!list_empty(&clp->cl_revoked))
+			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	}
 	if (atomic_read(&clp->cl_admin_revoked))
 		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 	trace_nfsd_seq4_status(rqstp, seq);
-- 
2.46.1


