Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43A479EC0
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhLSBo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhLSBo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906CAC061574
        for <linux-nfs@vger.kernel.org>; Sat, 18 Dec 2021 17:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F62B80B6E
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB65C36AE2;
        Sun, 19 Dec 2021 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878294;
        bh=BvSDEGwdFBH9f2Xi8QRnyZsuu2wjIdn/ctEuHwDexkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSRhGzdWUBfXF0Ndg0ZWsAmM4zTtzxmuivWfDXh80kwCc15kbd16O8/m1GQAwpQeq
         JQE+eW6H/uvDsZWjaBkIpxwVLn/u1my+32HmBj6EJRcD2pFcnXjATf3YndhuCdOgbA
         9AeP27eFB6lwE+5zQvtgRSXSq+0O9Gyi4aeSzJN/VY4wcTKPZ524Y5yFmVOrQFd98c
         7RBMG6VixVtIRoARf8Ndol5NqXHKYiunre4aq53L4tFnyPPhM3QZGY182UsA+9h7wI
         NWsd+LGbMhXZI/Vxw3LGb0K0P1vjqPjfI4WMPi4kqaibKdxGVxnNNU1crpX4NUjR+M
         h5+XfVvyypqZQ==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/10] nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
Date:   Sat, 18 Dec 2021 20:38:00 -0500
Message-Id: <20211219013803.324724-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-7-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since a clone error commit can cause the boot verifier to change,
we should trace those errors.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/trace.h    | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      | 18 +++++++++++++++--
 fs/nfsd/vfs.h      |  3 ++-
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a36261f89bdf..35f33959a083 100644
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
index f1e0d3c51bc2..001444d9829d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -413,6 +413,56 @@ TRACE_EVENT(nfsd_dirent,
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
index 85e579aa6944..4d2964d08097 100644
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
@@ -542,6 +550,12 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
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
index 6edae1b9a96e..3dba6397d452 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -57,7 +57,8 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
 		    struct xdr_netobj *);
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
 				    struct file *, loff_t, loff_t, int);
-__be32		nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
+__be32		nfsd4_clone_file_range(struct svc_rqst *,
+				       struct nfsd_file *nf_src, u64 src_pos,
 				       struct nfsd_file *nf_dst, u64 dst_pos,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
-- 
2.33.1

