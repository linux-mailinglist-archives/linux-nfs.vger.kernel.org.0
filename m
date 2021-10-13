Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8642C3A1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhJMOnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237322AbhJMOnK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:43:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5157A610FB;
        Wed, 13 Oct 2021 14:41:07 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/3] SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
Date:   Wed, 13 Oct 2021 10:41:06 -0400
Message-Id:  <163413606616.5966.287818611212459674.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
References:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=27032; h=from:subject:message-id; bh=ULy+vKYW8DGfdeWNE5AUdoJ90YLJV6QQG/5C7G34DK8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvACBUn+xCG9k45T4N/KDKklYpgb+XxMFvcXkWwJ y/YNSVCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbwAgAKCRAzarMzb2Z/l1JiD/ 47gvPuyI1TJsR1YClxAEIwaZOFlQHwjKMPGmtbTDs+n9lkKM/I0+SRpCcPLbZMgTSKKVZNyIXCY18d WYYx2qEPiBSNxSpt4rmXRdQaFw2IMHcAnOJKRT+j0UiKxQwtBIqm7xvZPb1O9PTIqNKvQjodicO4yT uHII5cwX8Sn7ifdwLgnQ9PJutAnfGCZa088dH+9knAKIDf/ERAYRdSejBOlyEhGbNqT2oMCK4ZmCCQ vS15WNHK904t9flCllbcyDjT+L7Iig/vKMKPONPqNpFaIwk7C3LlJBLt/MYmrf+efuASntqvNDpYpP /z7bRUwdYHcJA956fKDFfn6zuwEKKtBSWz6U7CLex/EQh9sk55X2AR2xXpCO9CLReMZUGKPetq2nW0 jZqzIjjxR/fpyHUycWns5n1DRO4+Go8f0XlN9Pb66UaHDIMOF1pnXTsV8181x7kTmSsKwRT/aDbc9Z cG07rCy057eSbllaiVFZAnfDOvrRONj2pxm+rkUJ2zBZdelNCbhKAADsVwXMK+l9NzosIpDAule0ZK tQkGN+Bl1/yydG0jY7KYqwWYM5QWTTwwmokAOjybSEd5X4cZElIqzSl9/emwDJDpq4P9jCBxaT6D1o B85qE1DyGuPCtSND2e3NFDNPzJ5kg/BlH+dr/yb4SUxk+ckB+CUbZ7L6hyHg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The passed-in value of the "__be32 *p" parameter is now unused in
every server-side XDR encoder, and can be removed.

Note also that there is a line in each encoder that sets up a local
pointer to a struct xdr_stream. Passing that pointer from the
dispatcher instead saves one line per encoder function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    3 +--
 fs/lockd/xdr.c             |   11 ++++-------
 fs/lockd/xdr4.c            |   11 ++++-------
 fs/nfs/callback_xdr.c      |    4 ++--
 fs/nfsd/nfs2acl.c          |    8 ++++----
 fs/nfsd/nfs3acl.c          |    8 ++++----
 fs/nfsd/nfs3xdr.c          |   46 +++++++++++++++-----------------------------
 fs/nfsd/nfs4xdr.c          |    7 ++++---
 fs/nfsd/nfsd.h             |    3 ++-
 fs/nfsd/nfssvc.c           |    9 +++------
 fs/nfsd/nfsxdr.c           |   22 ++++++++-------------
 fs/nfsd/xdr.h              |   14 +++++++------
 fs/nfsd/xdr3.h             |   30 ++++++++++++++---------------
 fs/nfsd/xdr4.h             |    2 +-
 include/linux/lockd/xdr.h  |    8 ++++----
 include/linux/lockd/xdr4.h |    8 ++++----
 include/linux/sunrpc/svc.h |    3 ++-
 17 files changed, 85 insertions(+), 112 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 9a82471bda07..b220e1b91726 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -780,7 +780,6 @@ module_exit(exit_nlm);
 static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
-	struct kvec *resv = rqstp->rq_res.head;
 
 	svcxdr_init_decode(rqstp);
 	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
@@ -793,7 +792,7 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		return 1;
 
 	svcxdr_init_encode(rqstp);
-	if (!procp->pc_encode(rqstp, resv->iov_base + resv->iov_len))
+	if (!procp->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
 	return 1;
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 622c2ca37dbf..2595b4d14cd4 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -314,15 +314,14 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -330,9 +329,8 @@ nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -340,9 +338,8 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 45551dee26b4..32231c21c22d 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -313,15 +313,14 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -329,9 +328,8 @@ nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
@@ -339,9 +337,8 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nlm_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 4c48d85f6517..286d330488a7 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -67,9 +67,9 @@ static __be32 nfs4_callback_null(struct svc_rqst *rqstp)
  * svc_process_common() looks for an XDR encoder to know when
  * not to drop a Reply.
  */
-static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p)
+static int nfs4_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len,
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index cf6ba5e7937e..25592ba1ed50 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -240,9 +240,9 @@ nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct inode *inode;
@@ -280,9 +280,9 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* ACCESS */
-static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9e9f6afb2e00..e186467b63ec 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -166,9 +166,9 @@ nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 /* GETACL */
-static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_encode_getaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct kvec *head = rqstp->rq_res.head;
@@ -218,9 +218,9 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* SETACL */
-static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_encode_setaclres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 633367ebc1ad..933e002c3fd1 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -813,9 +813,8 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 
 /* GETATTR */
 int
-nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -833,9 +832,8 @@ nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
 
 /* SETATTR, REMOVE, RMDIR */
 int
-nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -843,9 +841,9 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* LOOKUP */
-int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
+int
+nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -869,9 +867,8 @@ int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
 
 /* ACCESS */
 int
-nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -893,9 +890,8 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READLINK */
 int
-nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -921,9 +917,8 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READ */
 int
-nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -954,9 +949,8 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 
 /* WRITE */
 int
-nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -982,9 +976,8 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
 int
-nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1008,9 +1001,8 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 
 /* RENAME */
 int
-nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1020,9 +1012,8 @@ nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
 
 /* LINK */
 int
-nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_linkres *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
@@ -1032,9 +1023,8 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
 
 /* READDIR */
 int
-nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
@@ -1286,9 +1276,8 @@ svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 
 /* FSSTAT */
 int
-nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1333,9 +1322,8 @@ svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
 
 /* FSINFO */
 int
-nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1376,9 +1364,8 @@ svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
 
 /* PATHCONF */
 int
-nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
@@ -1400,9 +1387,8 @@ nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 
 /* COMMIT */
 int
-nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8623aea38d58..c1d42eaf00fc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5427,10 +5427,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 }
 
 int
-nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
+nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = resp->xdr->buf;
+	struct xdr_buf *buf = xdr->buf;
+	__be32 *p;
 
 	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
 				 buf->tail[0].iov_len);
@@ -5443,7 +5444,7 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 
 	*p++ = resp->cstate.status;
 
-	rqstp->rq_next_page = resp->xdr->page_ptr + 1;
+	rqstp->rq_next_page = xdr->page_ptr + 1;
 
 	*p++ = htonl(resp->taglen);
 	memcpy(p, resp->tag, resp->taglen);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index bfcddd4c7534..345f8247d5da 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -80,7 +80,8 @@ struct nfsd_voidargs { };
 struct nfsd_voidres { };
 bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
-int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
+int		nfssvc_encode_voidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr);
 
 /*
  * Function prototypes.
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index beb564e8a3db..ed6a28ecf278 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1004,8 +1004,6 @@ nfsd(void *vrqstp)
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
-	struct kvec *resv = &rqstp->rq_res.head[0];
-	__be32 *p;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1030,14 +1028,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 * Need to grab the location to store the status, as
 	 * NFSv4 does some encoding while processing
 	 */
-	p = resv->iov_base + resv->iov_len;
 	svcxdr_init_encode(rqstp);
 
 	*statp = proc->pc_func(rqstp);
 	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
-	if (!proc->pc_encode(rqstp, p))
+	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
@@ -1078,13 +1075,13 @@ bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 /**
  * nfssvc_encode_voidres - Encode void results
  * @rqstp: Server RPC transaction context
- * @p: buffer in which to encode results
+ * @xdr: XDR stream into which to encode results
  *
  * Return values:
  *   %0: Local error while encoding
  *   %1: Encoding was successful
  */
-int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
+int nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 921c1c4344ef..09239f9c74f0 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -415,18 +415,16 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
  */
 
 int
-nfssvc_encode_statres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_stat(xdr, resp->status);
 }
 
 int
-nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
@@ -442,9 +440,8 @@ nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
@@ -462,9 +459,8 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -484,9 +480,8 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
@@ -509,9 +504,8 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	struct xdr_buf *dirlist = &resp->dirlist;
 
@@ -532,11 +526,11 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 	struct kstatfs	*stat = &resp->stats;
+	__be32 *p;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 31be7d30e64e..1133fb3bf328 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -152,13 +152,13 @@ bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *);
-int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
+int nfssvc_encode_statres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_attrstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_diropres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
 int nfssvc_encode_entry(void *data, const char *name, int namlen,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index ef72bc4868da..bb017fc7cba1 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -281,21 +281,21 @@ bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_lookupres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_accessres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readlinkres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_writeres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_createres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_renameres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_linkres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_readdirres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_fsstatres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_fsinfores(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_pathconfres(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_commitres(struct svc_rqst *, __be32 *);
+int nfs3svc_encode_getattrres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_wccstat(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_accessres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_writeres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_createres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_renameres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_linkres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_readdirres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_encode_commitres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 6aeb6755278f..3bd553925c35 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -758,7 +758,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
+int nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index e1362244f909..d8bd26a5525e 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -106,9 +106,9 @@ bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_res(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_void(struct svc_rqst *, __be32 *);
-int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *);
+int	nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 376b8f6a3763..50677be3557d 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -32,10 +32,10 @@ bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_res(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_void(struct svc_rqst *, __be32 *);
-int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *);
+int	nlm4svc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 extern const struct rpc_version nlm_version4;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index d6109fa7a57b..85694cd0db66 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -457,7 +457,8 @@ struct svc_procedure {
 	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
-	int			(*pc_encode)(struct svc_rqst *, __be32 *data);
+	int			(*pc_encode)(struct svc_rqst *rqstp,
+					     struct xdr_stream *xdr);
 	/* XDR free result: */
 	void			(*pc_release)(struct svc_rqst *);
 	unsigned int		pc_argsize;	/* argument struct size */

