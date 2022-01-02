Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F8482C66
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiABRfx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53704 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRfw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75F60B80B4A
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72D8C36AEB;
        Sun,  2 Jan 2022 17:35:49 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 06/10] nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
Date:   Sun,  2 Jan 2022 12:35:48 -0500
Message-Id:  <164114494855.7344.8338658376412437331.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=8sEHf0F4tAt6no3KTKBkEWm+Iji4A5ODUbCUFwV/Yq8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJ0ehk4fP2OSx5iV5CX3OKfFnryYWGSnxqHk12t lIM1wgWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHidAAKCRAzarMzb2Z/l3EhD/ wMvC/C26RXdqy4hnisIQLa3g+/CniWAFzZoN10PdefWaCcX7CViQqstYlu5W/SaR9ZN2nBcospoQlj HRgNPAUn8xjXSnIBCoSuIF5CXiscLHLyZIVKbQVgfAbBFMrwQ8xUUblCiT0kvjgLdKCeapsa2AQnZv 0gBrmrOySHvm34v2QcLH8igK4lAg+18AwIn/bCZoNa4s+auxsJjCeW7CCi4ykKUQKQuMehOAneC+dS F+NYTwRwBxO77CLBN4p1FbT+Z/OVenMhUmi809ARQaxPpyWiMEGoy0ftZGLDaj3NMhP4xrlTMyqNpx xpekpX5gjYSD8uwAhoN+yuaLJAf0f1GpYla37GmS670UVwjCryzqJ7Ooy0Yw8z6xb5XVD36G93ek8G 1dsIzcbtW13ntEYJI2M+Nw41LL1i1mrwgeakk16iZqlWmtuzOlFCQEaykLekNZVuKx2/z5t7rt9QZ+ 6M+3fDMpWfZbPAUjjZnMc8x7GXl9rvmXxfQzSDXbOswSsTISNUb1gZ87Hd0X+6XBpnbxeRk8FOeJLC gVkpNT+PJijObvGOzoqJMGUSAEjuxUI0mwU4AjdJaf8XXJ5QVRTBRwmwklJ9NLLUPRLotJ51NqjFDZ drqjk3uMYnZPazGkzsJoJCX1T3XKz2NoXOeBmnfMLgMtQHGfXA/+
 MbJ7HxkQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since a clone error commit can cause the boot verifier to change,
we should trace those errors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ cel: Addressed a checkpatch.pl splat in fs/nfsd/vfs.h ]
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/trace.h    |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      |   18 ++++++++++++++++--
 fs/nfsd/vfs.h      |    3 ++-
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 56405fc58bfc..43057080d2aa 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1101,7 +1101,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	status = nfsd4_clone_file_range(src, clone->cl_src_pos,
+	status = nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ebfe2b878574..54a84b5f7e35 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -389,6 +389,56 @@ TRACE_EVENT(nfsd_dirent,
 	)
 )
 
+DECLARE_EVENT_CLASS(nfsd_copy_err_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*src_fhp,
+		 loff_t		src_offset,
+		 struct svc_fh	*dst_fhp,
+		 loff_t		dst_offset,
+		 u64		count,
+		 int		status),
+	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, count, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, src_fh_hash)
+		__field(loff_t, src_offset)
+		__field(u32, dst_fh_hash)
+		__field(loff_t, dst_offset)
+		__field(u64, count)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->src_fh_hash = knfsd_fh_hash(&src_fhp->fh_handle);
+		__entry->src_offset = src_offset;
+		__entry->dst_fh_hash = knfsd_fh_hash(&dst_fhp->fh_handle);
+		__entry->dst_offset = dst_offset;
+		__entry->count = count;
+		__entry->status = status;
+	),
+	TP_printk("xid=0x%08x src_fh_hash=0x%08x src_offset=%lld "
+			"dst_fh_hash=0x%08x dst_offset=%lld "
+			"count=%llu status=%d",
+		  __entry->xid, __entry->src_fh_hash, __entry->src_offset,
+		  __entry->dst_fh_hash, __entry->dst_offset,
+		  (unsigned long long)__entry->count,
+		  __entry->status)
+)
+
+#define DEFINE_NFSD_COPY_ERR_EVENT(name)		\
+DEFINE_EVENT(nfsd_copy_err_class, nfsd_##name,		\
+	TP_PROTO(struct svc_rqst	*rqstp,		\
+		 struct svc_fh		*src_fhp,	\
+		 loff_t			src_offset,	\
+		 struct svc_fh		*dst_fhp,	\
+		 loff_t			dst_offset,	\
+		 u64			count,		\
+		 int			status),	\
+	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, \
+		count, status))
+
+DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c22511decc4c..70ea7e0aae07 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -40,6 +40,7 @@
 #include "../internal.h"
 #include "acl.h"
 #include "idmap.h"
+#include "xdr4.h"
 #endif /* CONFIG_NFSD_V4 */
 
 #include "nfsd.h"
@@ -517,8 +518,15 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif
 
-__be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
-		struct nfsd_file *nf_dst, u64 dst_pos, u64 count, bool sync)
+static struct nfsd4_compound_state *nfsd4_get_cstate(struct svc_rqst *rqstp)
+{
+	return &((struct nfsd4_compoundres *)rqstp->rq_resp)->cstate;
+}
+
+__be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
+		struct nfsd_file *nf_src, u64 src_pos,
+		struct nfsd_file *nf_dst, u64 dst_pos,
+		u64 count, bool sync)
 {
 	struct file *src = nf_src->nf_file;
 	struct file *dst = nf_dst->nf_file;
@@ -545,6 +553,12 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
 		if (status < 0) {
+			trace_nfsd_clone_file_range_err(rqstp,
+					&nfsd4_get_cstate(rqstp)->save_fh,
+					src_pos,
+					&nfsd4_get_cstate(rqstp)->current_fh,
+					dst_pos,
+					count, status);
 			nfsd_reset_boot_verifier(net_generic(nf_dst->nf_net,
 						 nfsd_net_id));
 			ret = nfserrno(status);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b21b76e6b9a8..9f56dcb22ff7 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -57,7 +57,8 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
 		    struct xdr_netobj *);
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
 				    struct file *, loff_t, loff_t, int);
-__be32		nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
+__be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
+				       struct nfsd_file *nf_src, u64 src_pos,
 				       struct nfsd_file *nf_dst, u64 dst_pos,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */

