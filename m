Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25F42C3A8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhJMOnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237194AbhJMOnR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:43:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A4B661163;
        Wed, 13 Oct 2021 14:41:13 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 3/3] SUNRPC: Change return value type of .pc_encode
Date:   Wed, 13 Oct 2021 10:41:13 -0400
Message-Id:  <163413607288.5966.5871448829344675099.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
References:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=31040; h=from:subject:message-id; bh=oWDSmHw7Gxw91GVKLEKxHJjNQvcYBSJ9ecBEEuLMDUs=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvAJhHg3tJ0tBowMlZiTlzECbI+c432YUHR2x4my IPCpceiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbwCQAKCRAzarMzb2Z/l9J7EA C2xmvfTwenVpSDTbsMmMWITyvSDonoZS/2WpvBqR8E2mNuADmkPSj8soe2f511uqdmyfCJ4dypy/NI UGy9y2xUo34fHJawd6MALB3E4Y9KyqyomH5JjrUSzHVsNRJlvk4SvsOfvmHlknFG8LYVA4xPD8NFT5 rczXo20/UYpnjw3RcEJWHIYXjeTKWxhsvb13ie+kxjqg0BYk0hK3gg8/YeQA7aUK6KqN2mGTrtM5ct KsbD78KNznWdfkCqhxkEiAp7vMe0fSt1NMBNmXLf7q3rUw95zJ5fsAM1JL5DQfLRzC3oyk17m3twOD qdDRqD96fW+1pf08uAqvJf2sHpdpKaYXaTfvBxICVR1qbs7cdohNytK/ITQkKhcoKJNG8lgtaxjleG lLe4Z0MJ7j+aY0GaoOW7fl0UlduKsq7i2Mj5szbeI7LZtYv08EcUYRaWS9j7tZiSB0KzXyE3kGT7+f NmPDYZ/ZRDEePWZGWroQ9F54R0Bfdi2EdwZzI6+/V0/A8rGM0TlHiHfhoO4WWCX4bM/+Oq8/KZSnWI xhNiY+QHrhocSSjVhNUcrpQ4nAw8FQQf8BD4CRoYPeZ9AKBLCXH2r5PPcanGncv0aOVtXEI/1z4+dN PMH2LEoZcXmTr9YGjfqNpSap/oE6fKF1WYc6qxhXmMVK83FwSiKAhsoaYZig==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Returning an undecorated integer is an age-old trope, but it's
not clear (even to previous experts in this code) that the only
valid return values are 1 and 0. These functions do not return
a negative errno, rpc_stat value, or a positive length.

Document there are only two valid return values by having
.pc_encode return only true or false.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr.c             |   18 ++---
 fs/lockd/xdr4.c            |   18 ++---
 fs/nfs/callback_xdr.c      |    4 +
 fs/nfsd/nfs2acl.c          |    4 +
 fs/nfsd/nfs3acl.c          |   18 ++---
 fs/nfsd/nfs3xdr.c          |  166 ++++++++++++++++++++++----------------------
 fs/nfsd/nfs4xdr.c          |    4 +
 fs/nfsd/nfsd.h             |    2 -
 fs/nfsd/nfssvc.c           |    8 +-
 fs/nfsd/nfsxdr.c           |   60 ++++++++--------
 fs/nfsd/xdr.h              |   14 ++--
 fs/nfsd/xdr3.h             |   30 ++++----
 fs/nfsd/xdr4.h             |    2 -
 include/linux/lockd/xdr.h  |    8 +-
 include/linux/lockd/xdr4.h |    8 +-
 include/linux/sunrpc/svc.h |    2 -
 16 files changed, 183 insertions(+), 183 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 2595b4d14cd4..2fb5748dae0c 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -313,13 +313,13 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * Encode Reply results
  */
 
-int
+bool
 nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -328,7 +328,7 @@ nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_testrply(xdr, resp);
 }
 
-int
+bool
 nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -337,18 +337,18 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_stats(xdr, resp->status);
 }
 
-int
+bool
 nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_encode_stats(xdr, resp->status))
-		return 0;
+		return false;
 	/* sequence */
 	if (xdr_stream_encode_u32(xdr, 0) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 32231c21c22d..856267c0864b 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -312,13 +312,13 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * Encode Reply results
  */
 
-int
+bool
 nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -327,7 +327,7 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_testrply(xdr, resp);
 }
 
-int
+bool
 nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
@@ -336,18 +336,18 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_encode_stats(xdr, resp->status);
 }
 
-int
+bool
 nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_encode_stats(xdr, resp->status))
-		return 0;
+		return false;
 	/* sequence */
 	if (xdr_stream_encode_u32(xdr, 0) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 286d330488a7..a67c41ec545f 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -67,9 +67,9 @@ static __be32 nfs4_callback_null(struct svc_rqst *rqstp)
  * svc_process_common() looks for an XDR encoder to know when
  * not to drop a Reply.
  */
-static int nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+static bool nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 25592ba1ed50..367551bddfc6 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -240,7 +240,7 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -280,7 +280,7 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* ACCESS */
-static int
+static bool
 nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index e186467b63ec..35b2ebda14da 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -166,7 +166,7 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int
+static bool
 nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
@@ -178,14 +178,14 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	int w;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		inode = d_inode(dentry);
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
-			return 0;
+			return false;
 
 		base = (char *)xdr->p - (char *)head->iov_base;
 
@@ -194,7 +194,7 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 			(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
 		while (w > 0) {
 			if (!*(rqstp->rq_next_page++))
-				return 0;
+				return false;
 			w -= PAGE_SIZE;
 		}
 
@@ -207,18 +207,18 @@ nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					  resp->mask & NFS_DFACL,
 					  NFS_ACL_DEFAULT);
 		if (n <= 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* SETACL */
-static int
+static bool
 nfs3svc_encode_setaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 933e002c3fd1..f3adc9207685 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -812,26 +812,26 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETATTR */
-int
+bool
 nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		lease_get_mtime(d_inode(resp->fh.fh_dentry), &resp->stat.mtime);
 		if (!svcxdr_encode_fattr3(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
 /* SETATTR, REMOVE, RMDIR */
-int
+bool
 nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
@@ -841,166 +841,166 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* LOOKUP */
-int
+bool
 nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* ACCESS */
-int
+bool
 nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* READLINK */
-int
+bool
 nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, 0, resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* READ */
-int
+bool
 nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->eof) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
 				resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* WRITE */
-int
+bool
 nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->committed) < 0)
-			return 0;
+			return false;
 		if (!svcxdr_encode_writeverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
-int
+bool
 nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* RENAME */
-int
+bool
 nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
@@ -1011,7 +1011,7 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* LINK */
-int
+bool
 nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
@@ -1022,33 +1022,33 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 /* READDIR */
-int
+bool
 nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static __be32
@@ -1275,26 +1275,26 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 }
 
 /* FSSTAT */
-int
+bool
 nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fsstat3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static bool
@@ -1321,26 +1321,26 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
 }
 
 /* FSINFO */
-int
+bool
 nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fsinfo3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static bool
@@ -1363,49 +1363,49 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
 }
 
 /* PATHCONF */
-int
+bool
 nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_pathconf3resok(xdr, resp))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /* COMMIT */
-int
+bool
 nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_writeverf3(xdr, resp->verf))
-			return 0;
+			return false;
 		break;
 	default:
 		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c1d42eaf00fc..309b1ace0b06 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5426,7 +5426,7 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return nfsd4_decode_compound(args);
 }
 
-int
+bool
 nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
@@ -5452,5 +5452,5 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	*p++ = htonl(resp->opcnt);
 
 	nfsd4_sequence_done(resp);
-	return 1;
+	return true;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 345f8247d5da..498e5a489826 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,7 +80,7 @@ struct nfsd_voidargs { };
 struct nfsd_voidres { };
 bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
-int		nfssvc_encode_voidres(struct svc_rqst *rqstp,
+bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ed6a28ecf278..362e819ff06a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1078,12 +1078,12 @@ bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * @xdr: XDR stream into which to encode results
  *
  * Return values:
- *   %0: Local error while encoding
- *   %1: Encoding was successful
+ *   %false: Local error while encoding
+ *   %true: Encoding was successful
  */
-int nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 09239f9c74f0..54bce76bde1c 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -414,7 +414,7 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  * XDR encode functions
  */
 
-int
+bool
 nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_stat *resp = rqstp->rq_resp;
@@ -422,110 +422,110 @@ nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_encode_stat(xdr, resp->status);
 }
 
-int
+bool
 nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fhandle(xdr, &resp->fh))
-			return 0;
+			return false;
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, &resp->page, 0, resp->len);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
-			return 0;
+			return false;
 		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
-			return 0;
+			return false;
 		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
 				resp->count);
 		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
-			return 0;
+			return false;
 		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
-			return 0;
+			return false;
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
@@ -533,12 +533,12 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	__be32 *p;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
-		return 0;
+		return false;
 	switch (resp->status) {
 	case nfs_ok:
 		p = xdr_reserve_space(xdr, XDR_UNIT * 5);
 		if (!p)
-			return 0;
+			return false;
 		*p++ = cpu_to_be32(NFSSVC_MAXBLKSIZE_V2);
 		*p++ = cpu_to_be32(stat->f_bsize);
 		*p++ = cpu_to_be32(stat->f_blocks);
@@ -547,7 +547,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		break;
 	}
 
-	return 1;
+	return true;
 }
 
 /**
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 1133fb3bf328..528fb299430e 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -152,13 +152,13 @@ bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
 int nfssvc_encode_entry(void *data, const char *name, int namlen,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index bb017fc7cba1..03fe4e21306c 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -281,21 +281,21 @@ bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 3bd553925c35..846ab6df9d48 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -758,7 +758,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index d8bd26a5525e..398f70093cd3 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -106,9 +106,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 50677be3557d..9a6b55da8fd6 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -32,10 +32,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 extern const struct rpc_version nlm_version4;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 85694cd0db66..0ae28ae6caf2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -457,7 +457,7 @@ struct svc_procedure {
 	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
-	int			(*pc_encode)(struct svc_rqst *rqstp,
+	bool			(*pc_encode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);

