Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D72328237
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhCAPTK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236994AbhCAPSy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A22E64E31
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:14 +0000 (UTC)
Subject: [PATCH v1 29/42] NFSD: Add a helper that encodes NFSv3 directory
 offset cookies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:13 -0500
Message-ID: <161461189318.8508.3990059352774568611.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Add helper function similar to nfs3svc_encode_cookie3().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    3 +--
 fs/nfsd/nfsxdr.c  |   18 ++++++++++++++++--
 fs/nfsd/xdr.h     |    1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 2088bb0887ba..5a0dd6e23c85 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -595,8 +595,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 				    &resp->common, nfssvc_encode_entry);
 
 	resp->count = resp->buffer - buffer;
-	if (resp->offset)
-		*resp->offset = htonl(offset);
+	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
 	return rpc_success;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 39d296aecd3e..a87b21cfe0d0 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -614,6 +614,21 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+/**
+ * nfssvc_encode_nfscookie - Encode a directory offset cookie
+ * @resp: readdir result context
+ * @offset: offset cookie to encode
+ *
+ */
+void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset)
+{
+	if (!resp->offset)
+		return;
+
+	*resp->offset = cpu_to_be32(offset);
+	resp->offset = NULL;
+}
+
 int
 nfssvc_encode_entry(void *ccdv, const char *name,
 		    int namlen, loff_t offset, u64 ino, unsigned int d_type)
@@ -632,8 +647,7 @@ nfssvc_encode_entry(void *ccdv, const char *name,
 		cd->common.err = nfserr_fbig;
 		return -EINVAL;
 	}
-	if (cd->offset)
-		*cd->offset = htonl(offset);
+	nfssvc_encode_nfscookie(cd, offset);
 
 	/* truncate filename */
 	namlen = min(namlen, NFS2_MAXNAMLEN);
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 277b74c511ce..651de13e62fe 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -157,6 +157,7 @@ int nfssvc_encode_readres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
 
+void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
 int nfssvc_encode_entry(void *, const char *name,
 			int namlen, loff_t offset, u64 ino, unsigned int);
 


