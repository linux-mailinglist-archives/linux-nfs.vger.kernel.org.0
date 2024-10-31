Return-Path: <linux-nfs+bounces-7602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F619B7BE0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C95282188
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC019DFA7;
	Thu, 31 Oct 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDlxBGqX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267519DF8D
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382017; cv=none; b=lJFksLpDuY/pLB8h/BeI93PUjJKgHf063iKLfzA8igwLoBPplgcuKfZms9uPBD/N5ZUvctRzBWl4bCyf7ozv3GQ70/wfkNQMaAh8MnGKncMh6Ie6HdLQZcnd3kB7tpSqfhzeI3cxQmP6HBnHsMLkifFKYz6NzEU51gI419QeTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382017; c=relaxed/simple;
	bh=o5uhiIfV5BQBFN70IdYLLkZwXrWuMtvfZXPk9jgNQ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYq5SHERDJ2vVCEbOPNmQlVRBL82wAQGHorW3TrrGSkth/GSOSxckR3TeXGtYFrpbplwEZKy2LlZ6/PuJnyYGWIz/VKvyRVK6dI0/u/20DCrYZ+bqvl8s/87GOwzdrp6JUHCvZfSPJ2QcTF9filMkX37CzgwGfTE8xR7RxuYwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDlxBGqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC95C4DDF1;
	Thu, 31 Oct 2024 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382017;
	bh=o5uhiIfV5BQBFN70IdYLLkZwXrWuMtvfZXPk9jgNQ70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDlxBGqXRvUjxRpHkDqNfJRHBWFGQ1Fl3y58ggvUJoK2WcJL0DIncfaxqjLqpuvMn
	 6xNrVKJljknZITFEYD6wf6MUgPhQ5jY0PPlBoWLjM9FkT+Qli7qcHojoK2XFremExX
	 SEUOXyjOVGawMbAGJOkXel+25kZZh61b8ozupnDlkoR7xXmMBosLHMNwvJ1Jf3El5O
	 HIepqlY9YI+jjJM7GqjSl8/BqskExxe2A/WnzLu2JgemCILloCjFKpd8JAhrLDGvJ5
	 dWSjAyCba2b5K9feK1WUTOdkphXW9pQbiYYRexswHHb8SbT7tlvQy5uJuVl/NcSHu/
	 P4DV/mxhAQjzg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 7/8] NFSD: Add nfsd4_copy time-to-live
Date: Thu, 31 Oct 2024 09:40:08 -0400
Message-ID: <20241031134000.53396-17-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=chuck.lever@oracle.com; h=from:subject; bh=JaLuYLLN+OiyG7XtTAq4BRlYXuBG1Ryt2UrY/WaXo30=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i3JcYc6ohSmWLs8RgHkcbKPtec7a6zf0GnN KlzkhaAI9KJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItwAKCRAzarMzb2Z/ l2+wD/4y0sevk0dl1g4M3iEs6gjmy2aFmjM2rqbv4x2TY4FHYh6L3RCb4L6kdRZ/EzTL8RZAWIl /sWxdTRCBp5NgENxtJPNqC6ulkgeT43bJLhej7beHqolE5VsxPfPI/QjJq3DYEk/tygXWGcT3/b qk0LscLXc++x3gJ64db1ZfpPsAt9ymPt0R9J2M7xUdk2IXmxaEGje4HJGqe6VvsgcYQpMumL62T JspVXBE9ILdEQP2tThLXfbKgjnC6IYv5k+khU5HEKSFiPxXp9zQSzNt3Pa13qzA/3BCCj8y3JRC ZloySOyBeGQQ23RHCA9Ax2KYUeBNIKUuP4l3Kb+AXyPbPweY0hy5UEUFO4h7TF16eHkCASzGwqk C57UwcP0PMGiVajtryyG6nBK+qf1XOKRBZial3NQD6/Qegen9yNoCAlVBUSRQBa1eJca8uM1LFD QeS0bKYCtCErFheCY+f91WuCMvfL0IUlVpazl6eZ2u9bVgpyof2t1qZJk/OOY394MBWICSop702 aKqRAN4CkFQUjQe0vn26pUBdAn35qo9yfHCGFkuWBBEc34lmq571lyIYWnCjgAtzVjAMTSr4uvL IAXy7CyTGWW96SzkUT9k0LoBabnoYs0w8BsB9737ADSGbOSN2vmePObGndluUVrllO6yrn+halg LOEbE43NvO/BQ4A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Keep async copy state alive for a few lease cycles after the copy
completes so that OFFLOAD_STATUS returns something meaningful.

This means that NFSD's client shutdown processing needs to purge
any of this state that happens to be waiting to die.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  7 +++++--
 fs/nfsd/state.h    | 15 +++++++++++++++
 fs/nfsd/xdr4.h     |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7061db2f33b0..4c964bce6bd7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1326,8 +1326,10 @@ void nfsd4_async_copy_reaper(struct nfsd_net *nn)
 		list_for_each_safe(pos, next, &clp->async_copies) {
 			copy = list_entry(pos, struct nfsd4_copy, copies);
 			if (test_bit(NFSD4_COPY_F_OFFLOAD_DONE, &copy->cp_flags)) {
-				list_del_init(&copy->copies);
-				list_add(&copy->copies, &reaplist);
+				if (--copy->cp_ttl) {
+					list_del_init(&copy->copies);
+					list_add(&copy->copies, &reaplist);
+				}
 			}
 		}
 		spin_unlock(&clp->async_lock);
@@ -1921,6 +1923,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_nn = nn;
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
+		async_copy->cp_ttl = NFSD_COPY_INITIAL_TTL;
 		/* Arbitrary cap on number of pending async copy operations */
 		if (atomic_inc_return(&nn->pending_async_copies) >
 				(int)rqstp->rq_pool->sp_nrthreads)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0e7f0dd960c1..5242729e38ec 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -137,6 +137,21 @@ struct nfs4_cpntf_state {
 	time64_t		cpntf_time;	/* last time stateid used */
 };
 
+/*
+ * RFC 7862 Section 4.8 states:
+ *
+ * | A copy offload stateid will be valid until either (A) the client
+ * | or server restarts or (B) the client returns the resource by
+ * | issuing an OFFLOAD_CANCEL operation or the client replies to a
+ * | CB_OFFLOAD operation.
+ *
+ * Because a client might not reply to a CB_OFFLOAD, or a reply
+ * might get lost due to connection loss, NFSD purges async copy
+ * state after a short period to prevent it from accumulating
+ * over time.
+ */
+#define NFSD_COPY_INITIAL_TTL 10
+
 struct nfs4_cb_fattr {
 	struct nfsd4_callback ncf_getattr;
 	u32 ncf_cb_status;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a3a59fce33b5..9a0c6c107463 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -714,6 +714,7 @@ struct nfsd4_copy {
 	struct list_head	copies;
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
+	unsigned int		cp_ttl;
 
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
-- 
2.47.0


