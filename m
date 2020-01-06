Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F6131956
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFU1d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:33 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38823 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFU1d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:33 -0500
Received: by mail-yb1-f193.google.com with SMTP id c13so2083428ybq.5
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZ1CS3jvxnAntYIsRzrlvpOZ3JnbABxA2F2/pGzDRXA=;
        b=b0wX35NDFRrnLKhoS4xIzynJLWPFqZ1+XhtOVRNYBO3s9u9MS+4I6YkglOC3u23VWi
         Jm+22MP53wiYKee4n3M//k4RotBWnRdO6qJlVhAKl2dYL+HikSj5H/f5Ts8ir682jvUV
         i2yrBx3EOPFf7U5EBIw6OAYSEvNnTkOujkvI4HbIBXFQID24d+irqVxdFn9wGCSsR74N
         RNPdB/ohOmIep/4LiihPXzTnG8FUatodln0Kry9IevAbzOV5qZPVLAAjfP+Cs9NY6hAu
         O1/UOXKw7QOkbWWfDs9KFvsUxvnmUaCyOVoj/ZKFRBFadbAIts1QX+j+WWOly3NTNvkZ
         DGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZ1CS3jvxnAntYIsRzrlvpOZ3JnbABxA2F2/pGzDRXA=;
        b=SxlmtDVwXpOMdxmAHoRPi4uJBq9z0pd4FK4gjS6Dxe581lgPuwhVNEt7/jkGieFfIs
         7r9dXLPDMGfEO9P1PmMPSl0/B3Or3A5H1SUdHCp7Mjvj6PRE4w0YTINYi11LfRZFnwE2
         8I3Hc/6kKEBSHgkFqGcngIdMyUm5ROAZ/cgih4kHbUxd0ND5aYFDGR5MHWnz22Ya8Py6
         UM1pJCD/XfrmifYAwYrgjl9VcbuFjlXEDBDPHL4aivaoPwnIvYvOZ/cheseh7xURYKYs
         QeH7253I9jgawgsuhH4S8frHoE1XapZG+KuRpacRDhzBIt9ozuauoHuw2Buwixv6nFuX
         70vw==
X-Gm-Message-State: APjAAAVbXEYwr9roBK2YxMTSqdLa5RQ8/q6+rj/I9id9tdqVaBRQCAou
        l+rwbruIQw4iDE2xeqNl1g==
X-Google-Smtp-Source: APXvYqzBM9vkw03m28viVW+FBqpZVNPXd1JUNxmmbKnitkdHpDyFsPDmcRcbqOGuKkrz4URKHAzUuQ==
X-Received: by 2002:a25:d03:: with SMTP id 3mr23848193ybn.368.1578342451576;
        Mon, 06 Jan 2020 12:27:31 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:31 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/15] NFS/pnfs: Fix pnfs_generic_prepare_to_resend_writes()
Date:   Mon,  6 Jan 2020 15:25:04 -0500
Message-Id: <20200106202514.785483-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-5-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Instead of making assumptions about the commit verifier contents, change
the commit code to ensure we always check that the verifier was set
by the XDR code.

Fixes: f54bcf2ecee9 ("pnfs: Prepare for flexfiles by pulling out common code")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c   | 4 ++--
 fs/nfs/nfs3xdr.c  | 5 ++++-
 fs/nfs/nfs4xdr.c  | 5 ++++-
 fs/nfs/pnfs_nfs.c | 7 +++----
 fs/nfs/write.c    | 4 +++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 040a50fd9bf3..29f00da8a0b7 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -245,10 +245,10 @@ static int nfs_direct_cmp_commit_data_verf(struct nfs_direct_req *dreq,
 					 data->ds_commit_index);
 
 	/* verifier not set so always fail */
-	if (verfp->committed < 0)
+	if (verfp->committed < 0 || data->res.verf->committed <= NFS_UNSTABLE)
 		return 1;
 
-	return nfs_direct_cmp_verf(verfp, &data->verf);
+	return nfs_direct_cmp_verf(verfp, data->res.verf);
 }
 
 /**
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 927eb680f161..69971f6c840d 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2334,6 +2334,7 @@ static int nfs3_xdr_dec_commit3res(struct rpc_rqst *req,
 				   void *data)
 {
 	struct nfs_commitres *result = data;
+	struct nfs_writeverf *verf = result->verf;
 	enum nfs_stat status;
 	int error;
 
@@ -2346,7 +2347,9 @@ static int nfs3_xdr_dec_commit3res(struct rpc_rqst *req,
 	result->op_status = status;
 	if (status != NFS3_OK)
 		goto out_status;
-	error = decode_writeverf3(xdr, &result->verf->verifier);
+	error = decode_writeverf3(xdr, &verf->verifier);
+	if (!error)
+		verf->committed = NFS_FILE_SYNC;
 out:
 	return error;
 out_status:
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 936c57779ff4..d0feef17db50 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4313,11 +4313,14 @@ static int decode_write_verifier(struct xdr_stream *xdr, struct nfs_write_verifi
 
 static int decode_commit(struct xdr_stream *xdr, struct nfs_commitres *res)
 {
+	struct nfs_writeverf *verf = res->verf;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_COMMIT);
 	if (!status)
-		status = decode_write_verifier(xdr, &res->verf->verifier);
+		status = decode_write_verifier(xdr, &verf->verifier);
+	if (!status)
+		verf->committed = NFS_FILE_SYNC;
 	return status;
 }
 
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 82af4809b869..8b37e7f8e789 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -31,12 +31,11 @@ EXPORT_SYMBOL_GPL(pnfs_generic_rw_release);
 /* Fake up some data that will cause nfs_commit_release to retry the writes. */
 void pnfs_generic_prepare_to_resend_writes(struct nfs_commit_data *data)
 {
-	struct nfs_page *first = nfs_list_entry(data->pages.next);
+	struct nfs_writeverf *verf = data->res.verf;
 
 	data->task.tk_status = 0;
-	memcpy(&data->verf.verifier, &first->wb_verf,
-	       sizeof(data->verf.verifier));
-	data->verf.verifier.data[0]++; /* ensure verifier mismatch */
+	memset(&verf->verifier, 0, sizeof(verf->verifier));
+	verf->committed = NFS_UNSTABLE;
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_prepare_to_resend_writes);
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 83e6f691368c..ab3d4611f0aa 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1838,6 +1838,7 @@ static void nfs_commit_done(struct rpc_task *task, void *calldata)
 
 static void nfs_commit_release_pages(struct nfs_commit_data *data)
 {
+	const struct nfs_writeverf *verf = data->res.verf;
 	struct nfs_page	*req;
 	int status = data->task.tk_status;
 	struct nfs_commit_info cinfo;
@@ -1865,7 +1866,8 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 
 		/* Okay, COMMIT succeeded, apparently. Check the verifier
 		 * returned by the server against all stored verfs. */
-		if (!nfs_write_verifier_cmp(&req->wb_verf, &data->verf.verifier)) {
+		if (verf->committed > NFS_UNSTABLE &&
+		    !nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier)) {
 			/* We have a match */
 			if (req->wb_page)
 				nfs_inode_remove_request(req);
-- 
2.24.1

