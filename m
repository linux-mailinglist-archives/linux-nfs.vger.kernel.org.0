Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0C482C6B
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiABRgS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:36:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRgS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:36:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CEA6B80B4D
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C938BC36AE7;
        Sun,  2 Jan 2022 17:36:15 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 10/10] NFSD: Trace boot verifier resets
Date:   Sun,  2 Jan 2022 12:36:14 -0500
Message-Id:  <164114497467.7344.3800554443290630816.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587; h=from:subject:message-id; bh=MVjHR9VEG4Cvc8K9ffiVt3k3iLGrlD/2ba+jotdwohA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eKOcOHTdoTh6Dn75wuMpfzLoVSL6QoFmJ2RoeuI kxonmf+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHijgAKCRAzarMzb2Z/l6ezD/ 9ts1kURe+ZsU90jwU8gUDDdmsSs4SJ3S5/mtoJITH1TZvbt4Rqx5uA4f/x6vATnmZfDFhQZBeb3CRH tvZAOmGO0BWW7d8eNZ9sGh9hsG7jSe/DzfskKh55fogWg/b18f1uboW9vvjv+8pH6WqC6BPdlYdhb/ 3hV5AkLWBcONl1UJKLs8hqyqsTP4lBd5TQdBOev2h820W1l27d3AL4pl0LEWOCA2kLfvwZ/vC5NKJy z+CHwuymwV1D9lJxt7pfyJvtMiIoRJ8oRo0kiqPRA4Av/1xKRsQqjwVjVxo8Ymr9yKTDjGKaa84ijL FyZS4F0UaMs6XcTvYxG47VNAbxSKd5l878mkWpsOur9lbBDRjUezM6R5voENz4P6tgFZWfa3Lqb2ef jZebxtBvDFyFAoLmY3blDRLPItxfx/SimtYc7wnmjbejq1bp3lOdncxoJrlgoU+44ewOrfLkCbTskJ l/Jj1xCAme9wEpBSs4tm3ZZgi7opmxzBcyoLE2JKFwuZL8MdRo5XatfdMW6ktlQA0I+WP84czrZFRw wz4Ye3OG8hk3jGJd3+4RkNEs99EgCKr+q5NpDo0zJ8TzqEiupg+qczxgrB8lvxGyhbkqx17Hs5Ojy9 MowbvC3R7H0/sqTsh27wymI7H54im2Ma4voSXtI1/fwbyCb7hgMtHtJMF+5A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

According to commit bbf2f098838a ("nfsd: Reset the boot verifier on
all write I/O errors"), the Linux NFS server forces all clients to
resend pending unstable writes if any server-side write or commit
operation encounters an error (say, ENOSPC). This is a rare and
quite exceptional event that could require administrative recovery
action, so it should be made trace-able. Example trace event:

nfsd-938   [002]  7174.945558: nfsd_writeverf_reset: boot_time=        61cc920d xid=0xdcd62036 error=-28 new verifier=0x08aecc6142515904

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   28 ++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |   13 ++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 54a84b5f7e35..b6b25f0f67a5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -564,6 +564,34 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
+TRACE_EVENT(nfsd_writeverf_reset,
+	TP_PROTO(
+		const struct nfsd_net *nn,
+		const struct svc_rqst *rqstp,
+		int error
+	),
+	TP_ARGS(nn, rqstp, error),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(u32, xid)
+		__field(int, error)
+		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->error = error;
+
+		/* avoid seqlock inside TP_fast_assign */
+		memcpy(__entry->verifier, nn->writeverf,
+		       NFS4_VERIFIER_SIZE);
+	),
+	TP_printk("boot_time=%16llx xid=0x%08x error=%d new verifier=0x%s",
+		__entry->boot_time, __entry->xid, __entry->error,
+		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
+	)
+);
+
 TRACE_EVENT(nfsd_clid_cred_mismatch,
 	TP_PROTO(
 		const struct nfs4_client *clp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 49564457bd3d..e4e59e1660e1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -553,14 +553,17 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
 		if (status < 0) {
+			struct nfsd_net *nn = net_generic(nf_dst->nf_net,
+							  nfsd_net_id);
+
 			trace_nfsd_clone_file_range_err(rqstp,
 					&nfsd4_get_cstate(rqstp)->save_fh,
 					src_pos,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_write_verifier(net_generic(nf_dst->nf_net,
-						  nfsd_net_id));
+			nfsd_reset_write_verifier(nn);
+			trace_nfsd_writeverf_reset(nn, rqstp, status);
 			ret = nfserrno(status);
 		}
 	}
@@ -1017,6 +1020,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0) {
 		nfsd_reset_write_verifier(nn);
+		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1028,8 +1032,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0)
+		if (host_err < 0) {
 			nfsd_reset_write_verifier(nn);
+			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
+		}
 	}
 
 out_nfserr:
@@ -1151,6 +1157,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			break;
 		default:
 			nfsd_reset_write_verifier(nn);
+			trace_nfsd_writeverf_reset(nn, rqstp, err2);
 		}
 		err = nfserrno(err2);
 	} else

