Return-Path: <linux-nfs+bounces-13969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA8B3F23A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 04:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61331A85FB4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC8212F89;
	Tue,  2 Sep 2025 02:23:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583C4414;
	Tue,  2 Sep 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779802; cv=none; b=B+1TXiD40zyv1lMhBRS52tJkcry2GEK9CZYThdrD/6Rza3fhaVOlhUNyp9AKvkouBAXiFdwivjBJ0FooZmX+15zTOewiA18VVX8oMgju+zZDAmXOIjflV5hq2/r/fYssGafUkTrd1F+p5Y3bUYRkFJJp45F+wNcBD1WrSg79GPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779802; c=relaxed/simple;
	bh=EgJvsXcYBC3/9lVL/8kjHt6FlO2LajSjRCpOYUOIh+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n5IuQDClC6ljxYCTUTGT2Bio2s8Q2E7ZPPYPCR9UQ/qDHgV/p2z023GR/T7nsW/PyKdJcNHJ5TqSbBznr1UgHox2kJmJHZEBgzo/Zz4DWMIsayIHWv8ciCfB0couAhOsAVftibsjUAeN2Vk/JEs2fguvVmScytG4p0hfiSXZB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cG8bH6zrZz2VRKQ;
	Tue,  2 Sep 2025 10:20:11 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 454C81A0188;
	Tue,  2 Sep 2025 10:23:17 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemj200013.china.huawei.com
 (7.202.194.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Sep
 2025 10:23:16 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neil@brown.name>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>, <zhangjian496@huawei.com>
Subject: [PATCH] nfsd: remove long-standing revoked delegations by force
Date: Tue, 2 Sep 2025 10:22:37 +0800
Message-ID: <20250902022237.1488709-1-lilingfeng3@huawei.com>
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

However, if the client fails to return the delegation due to a timeout
after receiving the recall or a server bug, the delegation remains in the
server's cl_revoked list. The client marks it revoked and won't find it
upon detecting SEQ4_STATUS_RECALLABLE_STATE_REVOKED. This leads to a loop:
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
 fs/nfsd/nfs4state.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5..aa65a685dbb9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4326,6 +4326,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int buflen;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct list_head *pos, *next;
+	struct nfs4_delegation *dp;
 
 	if (resp->opcnt != 1)
 		return nfserr_sequence_pos;
@@ -4470,6 +4472,15 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	default:
 		seq->status_flags = 0;
 	}
+	if (!list_empty(&clp->cl_revoked)) {
+		list_for_each_safe(pos, next, &clp->cl_revoked) {
+			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
+			if (dp->dl_time < (ktime_get_boottime_seconds() - 2 * nn->nfsd4_lease)) {
+				list_del_init(&dp->dl_recall_lru);
+				nfs4_put_stid(&dp->dl_stid);
+			}
+		}
+	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
 	if (atomic_read(&clp->cl_admin_revoked))
-- 
2.46.1


