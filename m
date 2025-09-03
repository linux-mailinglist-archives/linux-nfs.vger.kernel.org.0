Return-Path: <linux-nfs+bounces-14002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210FB41E1E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EAC1887263
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BE27EC80;
	Wed,  3 Sep 2025 12:00:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F072FD7A7;
	Wed,  3 Sep 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900808; cv=none; b=k2XB12I3KmVpiCe5eEhFoNaB1O3CF6f1ziTh+fJO89jtS1UbIsEpVQABlijkvY9jVO2CuADPOgAuxvGh994lgNIzbSZ2gttKgmsxjwCb+K842zoO4MrtHUhrcBPewuF1rW4iG0UtLyxpacWX7RiOxN7na7ixA4yzRH2R2NYugCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900808; c=relaxed/simple;
	bh=45SFBCX7ymFr1NNsVrJRsAAdN4WtgrdDrn+YDV+in/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S3kxRrq1HBhKEL/Ao4GDJ2weicY88KBdyDzdRAbu0n3ZG/E29xistbzKSgzcHKRsbf6WkMTp8rs43V0/XevRv8cH7DsUNnj6WVHT2HXhCLspCFMOB/WTRqUQLOljpfTJSb6LMFSlVWMPguCGH5EgCRWDom8zdUOJMFHI32oh4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cH1RB5cs9z2wB80;
	Wed,  3 Sep 2025 20:01:10 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id DF8DC140155;
	Wed,  3 Sep 2025 20:00:02 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemj200013.china.huawei.com
 (7.202.194.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 20:00:02 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neil@brown.name>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>, <zhangjian496@huawei.com>, <bcodding@redhat.com>
Subject: [PATCH v2] nfsd: remove long-standing revoked delegations by force
Date: Wed, 3 Sep 2025 19:59:18 +0800
Message-ID: <20250903115918.788159-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
 fs/nfsd/nfs4state.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5..bb9e1df4e41f 100644
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
@@ -4326,6 +4331,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int buflen;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct list_head *pos, *next;
+	struct nfs4_delegation *dp;
 
 	if (resp->opcnt != 1)
 		return nfserr_sequence_pos;
@@ -4470,6 +4477,19 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	default:
 		seq->status_flags = 0;
 	}
+	if (!list_empty(&clp->cl_revoked)) {
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
+	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
 	if (atomic_read(&clp->cl_admin_revoked))
-- 
2.46.1


