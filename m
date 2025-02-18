Return-Path: <linux-nfs+bounces-10185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A93A3AADA
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7047F16E199
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431C1D5142;
	Tue, 18 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPpuyp+b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA601D0F5A;
	Tue, 18 Feb 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914151; cv=none; b=E+w8w+ub7dv8a+tCMOv4HqjGjh4rodUqo4pchsrYHZiR2DVCCtsosfsVNurMGJb1Ps3FtNDRvct7P3QT3djQ8kKRIHph9maxGqU0Pn40tA26gnSrAL+TQ8Lph//JiTLXHgcRBles430MgyMiIvkFgK4bPniQeD7c8ZC388o09ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914151; c=relaxed/simple;
	bh=E5Md+Ptzgm9++CsnUMh6sg46w21bnm1bBG33zFKPK7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufp1j9FFCV/ZA9398eXET3upxmRMCjwWKVxsn7g5ECP0EhJs5Wcs2D63Ugg0mUVHI8SLrLnM/Vv/Mb4q8m0Pzn0UfnQrqgyk01IbC2VaH5Gjo4safi86SDzm0odwaw2Bz1ZlN0wRDr5G0NeXeEaktkhVob+A2l6228YD7pysaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPpuyp+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10945C4CEEB;
	Tue, 18 Feb 2025 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914150;
	bh=E5Md+Ptzgm9++CsnUMh6sg46w21bnm1bBG33zFKPK7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MPpuyp+bjAxqqHLqze7OSoXzvI0PEcWbbXbwKGeHVllleuKHoJNO0EbiNZPCpnnOa
	 wjO/iZhinypZJ5xStJjaqlHjc5hJocXbQ1xNJt2Q5RZyFnzYV2YTWRGFtoDkwkF3H2
	 emg7JvkVxyvAxiD/WsucqiUX+gp4CF6s2dxvcw7SAgBhvU5Nsm2humBZGyPUicGTTw
	 oemXETNOK6BPCjSfkSZ5/X/Nct6zMcG6wbKXy0bV6714tRMqgeezw+59s+vNazGRBI
	 +pDfp1uv2wallrVyK8K2iK0CHMd1NJOItqeYVuLTgBOcpdmeJgINWwV1haFoZ2JMmM
	 PTYkld2JUeOoQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 18 Feb 2025 16:28:58 -0500
Subject: [PATCH 2/3] nfsd: eliminate cl_ra_cblist and
 NFSD4_CLIENT_CB_RECALL_ANY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-nfsd-callback-v1-2-14f966967dd8@kernel.org>
References: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
In-Reply-To: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E5Md+Ptzgm9++CsnUMh6sg46w21bnm1bBG33zFKPK7I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBntPujXzzuChWe87P68/HF2oM2zFM/dfxV2PtWK
 zmh13WhuOCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7T7owAKCRAADmhBGVaC
 FaGbD/oCW05h/vSew8ETTsGjr2mSEI0frQA+n6nYNQrZvmLhiARdVFlQhsLROU9+KkQjIJAN/lt
 U1rChYZrI615lI4plvcvE9I9svskxTaca5Sa0QbNKunUvB0LtWQaXkN4yIU1aM78Jg9VOE1r+73
 DJVGSXtSyp2ZoMeiaEFQSV6qyttkfyQ1S8trehnlC1Iyo8KqC3MNTkr6McAzZEt7+gMbRcApIAi
 jYKc/BgQkVanXy1y0CCmmq7QEybYHBOxFGz21SpFyh6TwNIuP5ly3c2+UUyBR+jvQ0u/BexNCWS
 E6ZCpETYISq1VnMZvJoTU+19OtTN/maM9SnhIUC74AmD0nOggJ3FOFeO60X8IEwYmEqrvm1hkW4
 zEQvAuqeWurIZYK8jR1mf4GtO1ibJiyMVtRY53QYi7GM14cWU/wUC/OpQQhkTaPBXih7CQyjSxb
 OzPRSgkXBQPKSa6KjS14oEtPHMWS0+xuY4acLOjcHnrhpPG+795REmAx9QLRKbeQ7cJZxIe4EZ4
 IKEpWVRRscWFoqfGfiHQedqQXR0SxAhi9tz8d7tyVXf0W8V37I5POVw8/Pu14g6YOh1aRbV9n+o
 sOMTlmVMFgLKCiVkJB8+8CPD5xetkbZ1c+20E5Va5UTs9eaP9krC8vgQYKWv/nlQOHl/f8W4jAW
 wftpEJDbFDdPIDA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

deleg_reaper() will walk the client_lru list and put any suitable
entries onto "cblist" using the cl_ra_cblist pointer. It then walks the
objects outside the spinlock and queues callbacks for them.

None of the operations that deleg_reaper() does outside the
nn->client_lock are blocking operations. Just queue their workqueue jobs
under the nn->client_lock instead.

Also, the NFSD4_CLIENT_CB_RECALL_ANY and NFSD4_CALLBACK_RUNNING flags
serve an identical purpose now. Drop the NFSD4_CLIENT_CB_RECALL_ANY flag
and just use the one in the callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 +++-------------
 fs/nfsd/state.h     |  2 --
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fabcd979c40695ebcc795cfd2d8a035b7d589a37..422439a46ffd03926524b8463cfdabfb866281b3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3175,7 +3175,6 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 
-	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 	drop_client(clp);
 }
 
@@ -6881,7 +6880,6 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
-	LIST_HEAD(cblist);
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -6893,31 +6891,23 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
-		if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags))
+		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
 			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
-		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
-		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
-	}
-	spin_unlock(&nn->client_lock);
-
-	while (!list_empty(&cblist)) {
-		clp = list_first_entry(&cblist, struct nfs4_client,
-					cl_ra_cblist);
-		list_del_init(&clp->cl_ra_cblist);
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_try_run_cb(&clp->cl_ra->ra_cb);
+		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
+	spin_unlock(&nn->client_lock);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index dc7105e685b8057ca4e2fcc5ceb85754e96981a2..d1a8f074885aa6576843baf46de3a55de530d8d9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -454,7 +454,6 @@ struct nfs4_client {
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
-#define NFSD4_CLIENT_CB_RECALL_ANY	(6)
 	unsigned long		cl_flags;
 
 	struct workqueue_struct *cl_callback_wq;
@@ -500,7 +499,6 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
-	struct list_head	cl_ra_cblist;
 };
 
 /* struct nfs4_client_reset

-- 
2.48.1


