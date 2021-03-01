Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321FC32821F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhCAPRj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237039AbhCAPRc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A7664E12
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:16:55 +0000 (UTC)
Subject: [PATCH v1 16/42] NFSD: Add a helper that encodes NFSv3 directory
 offset cookies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:16:55 -0500
Message-ID: <161461181507.8508.7185607597181053733.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: De-duplicate identical code that handles encoding of
directory offset cookies across page boundaries.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   24 ++----------------------
 fs/nfsd/nfs3xdr.c  |   36 +++++++++++++++++++++++-------------
 fs/nfsd/xdr3.h     |    2 ++
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 93d196752f87..90566cd01bdc 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -495,17 +495,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 		count += PAGE_SIZE;
 	}
 	resp->count = count >> 2;
-	if (resp->offset) {
-		if (unlikely(resp->offset1)) {
-			/* we ended up with offset on a page boundary */
-			*resp->offset = htonl(offset >> 32);
-			*resp->offset1 = htonl(offset & 0xffffffff);
-			resp->offset1 = NULL;
-		} else {
-			xdr_encode_hyper(resp->offset, offset);
-		}
-		resp->offset = NULL;
-	}
+	nfs3svc_encode_cookie3(resp, offset);
 
 	return rpc_success;
 }
@@ -560,17 +550,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 		count += PAGE_SIZE;
 	}
 	resp->count = count >> 2;
-	if (resp->offset) {
-		if (unlikely(resp->offset1)) {
-			/* we ended up with offset on a page boundary */
-			*resp->offset = htonl(offset >> 32);
-			*resp->offset1 = htonl(offset & 0xffffffff);
-			resp->offset1 = NULL;
-		} else {
-			xdr_encode_hyper(resp->offset, offset);
-		}
-		resp->offset = NULL;
-	}
+	nfs3svc_encode_cookie3(resp, offset);
 
 out:
 	return rpc_success;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 034e18d9b040..aef72d00d5a9 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1219,6 +1219,28 @@ static __be32 *encode_entryplus_baggage(struct nfsd3_readdirres *cd, __be32 *p,
 	return p;
 }
 
+/**
+ * nfs3svc_encode_cookie3 - Encode a directory offset cookie
+ * @resp: readdir result context
+ * @offset: offset cookie to encode
+ *
+ */
+void nfs3svc_encode_cookie3(struct nfsd3_readdirres *resp, u64 offset)
+{
+	if (!resp->offset)
+		return;
+
+	if (resp->offset1) {
+		/* we ended up with offset on a page boundary */
+		*resp->offset = cpu_to_be32(offset >> 32);
+		*resp->offset1 = cpu_to_be32(offset & 0xffffffff);
+		resp->offset1 = NULL;
+	} else {
+		xdr_encode_hyper(resp->offset, offset);
+	}
+	resp->offset = NULL;
+}
+
 /*
  * Encode a directory entry. This one works for both normal readdir
  * and readdirplus.
@@ -1244,19 +1266,7 @@ encode_entry(struct readdir_cd *ccd, const char *name, int namlen,
 	int		elen;		/* estimated entry length in words */
 	int		num_entry_words = 0;	/* actual number of words */
 
-	if (cd->offset) {
-		u64 offset64 = offset;
-
-		if (unlikely(cd->offset1)) {
-			/* we ended up with offset on a page boundary */
-			*cd->offset = htonl(offset64 >> 32);
-			*cd->offset1 = htonl(offset64 & 0xffffffff);
-			cd->offset1 = NULL;
-		} else {
-			xdr_encode_hyper(cd->offset, offset64);
-		}
-		cd->offset = NULL;
-	}
+	nfs3svc_encode_cookie3(cd, offset);
 
 	/*
 	dprintk("encode_entry(%.*s @%ld%s)\n",
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 8073350418ae..e76e9230827e 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -300,6 +300,8 @@ int nfs3svc_encode_commitres(struct svc_rqst *, __be32 *);
 
 void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
+
+void nfs3svc_encode_cookie3(struct nfsd3_readdirres *resp, u64 offset);
 int nfs3svc_encode_entry(void *, const char *name,
 				int namlen, loff_t offset, u64 ino,
 				unsigned int);


