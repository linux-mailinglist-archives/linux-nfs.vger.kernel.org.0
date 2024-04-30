Return-Path: <linux-nfs+bounces-3104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7238B8118
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C597D289666
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3417B514;
	Tue, 30 Apr 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg6kofaq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F8182C3
	for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507529; cv=none; b=igwDG6XqkmKtT8wyKVSxsvJfcpEUn7P2zyqJmnnU9db1bRb8Vd0zThVwgeeFIwA4d87IHQYnJ/IYVZE8y+iJrQMPp/x5TT4wUAzSgL623zC7MjoqHMNqzH359jNYzE5XqYhzlUkoFyV9WkNRVFWMxwtMBMpcKAjIkUJHm6Vmztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507529; c=relaxed/simple;
	bh=guc9Y8vcGcJjY0T/sKDrin8Z5igsdZplLA0N5I3VQCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCthUTyyF86F7U1I6TVe7UCVpXG6vGArK2pjHTVyUljD7sgsSIZznexWtSjm6tI5y6sQYabV2pHHA3lfptR+7fWfong9NZMODqZ5MO2O0/eDYLZMyq3hCxNxmGYFOGhrJGYu13aoofg+L1hHHqTuKPEW0fbJr2JEFwe3ghJGWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg6kofaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A153C2BBFC;
	Tue, 30 Apr 2024 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507528;
	bh=guc9Y8vcGcJjY0T/sKDrin8Z5igsdZplLA0N5I3VQCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg6kofaquUBJX2O++q0FCAh9W+qjYPIIEO7bE+Hrg26YkLD4mtm09a/4Ldce3Ptsa
	 /rOUSn7wZdVUezOM9/nwD2HaZwKrNEtPRIbpG9Z7dbmsU2MN1PqqYjFJjtnx+4cEXj
	 x/swZh8NXWgGT2g5hTJ0bEhp+ojX9UvC2nTuwpXVYsUjqAVm0wJBqb0g/hQa1rGKK7
	 pE2J7ZOV/00b+EmKwD8LT/OFRk5xhtsqm0NsZXOdeUBSjZ5I17VbupPDcWsmu8+eWh
	 FnUGwgNsCm/w24AXvRxo79Sru/CMVv+gk1/7GX0LJ7lykV9Kx+o5CK0FvDt5J2VsHB
	 7kBBuDFPXgZ5A==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Record status of async copy operation in struct nfsd4_copy
Date: Tue, 30 Apr 2024 16:05:10 -0400
Message-ID: <20240430200519.6253-2-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430200519.6253-1-cel@kernel.org>
References: <20240430200519.6253-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

After a client has started an asynchronous COPY operation, a
subsequent OFFLOAD_STATUS operation will need to report the status
code once that COPY operation has completed. The recorded status
record will be used by a subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 21 ++++++++++-----------
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3dc173b29803..7e6580384cdb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1737,7 +1737,7 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
-static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
+static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 {
 	struct nfsd4_cb_offload *cbo;
 
@@ -1747,12 +1747,12 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
 
 	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
 	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
-	cbo->co_nfserr = nfserr;
+	cbo->co_nfserr = copy->nfserr;
 
 	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
-			      &cbo->co_fh, copy->cp_count, nfserr);
+			      &cbo->co_fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cbo->co_cb);
 }
 
@@ -1766,7 +1766,6 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
-	__be32 nfserr;
 
 	trace_nfsd_copy_do_async(copy);
 	if (nfsd4_ssc_is_inter(copy)) {
@@ -1777,24 +1776,24 @@ static int nfsd4_do_async_copy(void *data)
 		if (IS_ERR(filp)) {
 			switch (PTR_ERR(filp)) {
 			case -EBADF:
-				nfserr = nfserr_wrong_type;
+				copy->nfserr = nfserr_wrong_type;
 				break;
 			default:
-				nfserr = nfserr_offload_denied;
+				copy->nfserr = nfserr_offload_denied;
 			}
 			/* ss_mnt will be unmounted by the laundromat */
 			goto do_callback;
 		}
-		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
-				       false);
+		copy->nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
+					     false);
 		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
 	} else {
-		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
-				       copy->nf_dst->nf_file, false);
+		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+					     copy->nf_dst->nf_file, false);
 	}
 
 do_callback:
-	nfsd4_send_cb_offload(copy, nfserr);
+	nfsd4_send_cb_offload(copy);
 	cleanup_async_copy(copy);
 	return 0;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 446e72b0385e..62805931e857 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -694,6 +694,7 @@ struct nfsd4_copy {
 #define NFSD4_COPY_F_COMMITTED		(3)
 
 	/* response */
+	__be32			nfserr;
 	struct nfsd42_write_res	cp_res;
 	struct knfsd_fh		fh;
 
-- 
2.44.0


