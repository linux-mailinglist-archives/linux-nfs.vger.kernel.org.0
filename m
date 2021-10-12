Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBA42A8ED
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 17:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhJLP7h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 11:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhJLP7b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Oct 2021 11:59:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C5146108F;
        Tue, 12 Oct 2021 15:57:29 +0000 (UTC)
Subject: [PATCH v1 2/2] SUNRPC: Change return value type of .pc_decode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 Oct 2021 11:57:28 -0400
Message-ID: <163405424859.4278.1847585306553557417.stgit@bazille.1015granger.net>
In-Reply-To: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
References: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Returning an undecorated integer is an age-old trope, but it's
not clear (even to previous experts in this code) that the only
valid return values are 1 and 0. These functions do not return
a negative errno, rpc_stat value, or a positive length.

Document there are only two valid return values by having
.pc_decode return only true or false.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr.c             |   96 ++++++++++++++++++------------------
 fs/lockd/xdr4.c            |   97 ++++++++++++++++++------------------
 fs/nfsd/nfs2acl.c          |   30 ++++++-----
 fs/nfsd/nfs3acl.c          |   22 ++++----
 fs/nfsd/nfs3xdr.c          |  118 ++++++++++++++++++++++----------------------
 fs/nfsd/nfs4xdr.c          |   24 ++++-----
 fs/nfsd/nfsd.h             |    2 -
 fs/nfsd/nfssvc.c           |    6 +-
 fs/nfsd/nfsxdr.c           |   62 ++++++++++++-----------
 fs/nfsd/xdr.h              |   20 ++++---
 fs/nfsd/xdr3.h             |   30 ++++++-----
 fs/nfsd/xdr4.h             |    2 -
 include/linux/lockd/xdr.h  |   18 +++----
 include/linux/lockd/xdr4.h |   18 +++----
 include/linux/sunrpc/svc.h |    2 -
 15 files changed, 274 insertions(+), 273 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 895f15222104..622c2ca37dbf 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -145,103 +145,103 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  * Decode Call arguments
  */
 
-int
+bool
 nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	argp->monitor = 1;		/* monitor client by default */
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	argp->lock.fl.fl_type = F_UNLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_stats(xdr, &resp->status))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
@@ -249,25 +249,25 @@ nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return 0;
+		return false;
 	if (len > SM_MAXSTRLEN)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, len);
 	if (!p)
-		return 0;
+		return false;
 	argp->len = len;
 	argp->mon = (char *)p;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
 	if (!p)
-		return 0;
+		return false;
 	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
@@ -278,34 +278,34 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	lock->svid = ~(u32)0;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return 0;
+		return false;
 	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return 0;
+		return false;
 	/* XXX: Range checks are missing in the original code */
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 573c7d580a5e..45551dee26b4 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -144,102 +144,103 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  * Decode Call arguments
  */
 
-int
+bool
 nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
 	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	argp->monitor = 1;		/* monitor client by default */
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &argp->block) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_bool(xdr, &exclusive) < 0)
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	if (exclusive)
 		argp->lock.fl.fl_type = F_WRLCK;
-	return 1;
+
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_lock(xdr, &argp->lock))
-		return 0;
+		return false;
 	argp->lock.fl.fl_type = F_UNLCK;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_stats(xdr, &resp->status))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_reboot *argp = rqstp->rq_argp;
@@ -247,25 +248,25 @@ nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
-		return 0;
+		return false;
 	if (len > SM_MAXSTRLEN)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, len);
 	if (!p)
-		return 0;
+		return false;
 	argp->len = len;
 	argp->mon = (char *)p;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
 	if (!p)
-		return 0;
+		return false;
 	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
@@ -276,34 +277,34 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	lock->svid = ~(u32)0;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
-		return 0;
+		return false;
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (!svcxdr_decode_fhandle(xdr, &lock->fh))
-		return 0;
+		return false;
 	if (!svcxdr_decode_owner(xdr, &lock->oh))
-		return 0;
+		return false;
 	/* XXX: Range checks are missing in the original code */
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_mode) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->fsm_access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 0069c0fdb94f..cf6ba5e7937e 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -188,51 +188,51 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int
+static bool
 nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 	if (argp->mask & ~NFS_ACL_MASK)
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
 				   &argp->acl_access : NULL))
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
 				   &argp->acl_default : NULL))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index b1e352ed2436..9e9f6afb2e00 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -127,38 +127,38 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int
+static bool
 nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_getaclargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->mask) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-static int
+static bool
 nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &argp->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
-		return 0;
+		return false;
 	if (argp->mask & ~NFS_ACL_MASK)
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
 				   &argp->acl_access : NULL))
-		return 0;
+		return false;
 	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
 				   &argp->acl_default : NULL))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index f32ca6d57e30..633367ebc1ad 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -556,7 +556,7 @@ void fill_post_wcc(struct svc_fh *fhp)
  * XDR decode functions
  */
 
-int
+bool
 nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_fhandle *args = rqstp->rq_argp;
@@ -564,7 +564,7 @@ nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_nfs_fh3(xdr, &args->fh);
 }
 
-int
+bool
 nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_sattrargs *args = rqstp->rq_argp;
@@ -574,7 +574,7 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattrguard3(xdr, args);
 }
 
-int
+bool
 nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_diropargs *args = rqstp->rq_argp;
@@ -582,75 +582,75 @@ nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len);
 }
 
-int
+bool
 nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->access) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
 	u32 max_blocksize = svc_max_payload(rqstp);
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
-		return 0;
+		return false;
 
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
-		return 0;
+		return false;
 
 	/* request sanity */
 	if (args->count != args->len)
-		return 0;
+		return false;
 	if (args->count > max_blocksize) {
 		args->count = max_blocksize;
 		args->len = max_blocksize;
 	}
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->count))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->createmode) < 0)
-		return 0;
+		return false;
 	switch (args->createmode) {
 	case NFS3_CREATE_UNCHECKED:
 	case NFS3_CREATE_GUARDED:
@@ -658,15 +658,15 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	case NFS3_CREATE_EXCLUSIVE:
 		args->verf = xdr_inline_decode(xdr, NFS3_CREATEVERFSIZE);
 		if (!args->verf)
-			return 0;
+			return false;
 		break;
 	default:
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_createargs *args = rqstp->rq_argp;
@@ -676,7 +676,7 @@ nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
@@ -685,33 +685,33 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	size_t remaining;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
-		return 0;
+		return false;
 	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
-		return 0;
+		return false;
 
 	/* request sanity */
 	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
 	remaining -= xdr_stream_pos(xdr);
 	if (remaining < xdr_align_size(args->tlen))
-		return 0;
+		return false;
 
 	args->first.iov_base = xdr->p;
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_mknodargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->ftype) < 0)
-		return 0;
+		return false;
 	switch (args->ftype) {
 	case NF3CHR:
 	case NF3BLK:
@@ -725,13 +725,13 @@ nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		/* Valid XDR but illegal file types */
 		break;
 	default:
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_renameargs *args = rqstp->rq_argp;
@@ -742,7 +742,7 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					 &args->tname, &args->tlen);
 }
 
-int
+bool
 nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_linkargs *args = rqstp->rq_argp;
@@ -752,59 +752,59 @@ nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					 &args->tname, &args->tlen);
 }
 
-int
+bool
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
 	if (!args->verf)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 	u32 dircount;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	args->verf = xdr_inline_decode(xdr, NFS3_COOKIEVERFSIZE);
 	if (!args->verf)
-		return 0;
+		return false;
 	/* dircount is ignored */
 	if (xdr_stream_decode_u32(xdr, &dircount) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 35f56dbda462..9099f489f60d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2322,7 +2322,7 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
 	return true;
 }
 
-static int
+static bool
 nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 {
 	struct nfsd4_op *op;
@@ -2335,25 +2335,25 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	int i;
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->taglen) < 0)
-		return 0;
+		return false;
 	max_reply += XDR_UNIT;
 	argp->tag = NULL;
 	if (unlikely(argp->taglen)) {
 		if (argp->taglen > NFSD4_MAX_TAGLEN)
-			return 0;
+			return false;
 		p = xdr_inline_decode(argp->xdr, argp->taglen);
 		if (!p)
-			return 0;
+			return false;
 		argp->tag = svcxdr_savemem(argp, p, argp->taglen);
 		if (!argp->tag)
-			return 0;
+			return false;
 		max_reply += xdr_align_size(argp->taglen);
 	}
 
 	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
-		return 0;
+		return false;
 
 	/*
 	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
@@ -2361,14 +2361,14 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	 * nfsd4_proc can handle this is an NFS-level error.
 	 */
 	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
-		return 1;
+		return true;
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
 		if (!argp->ops) {
 			argp->ops = argp->iops;
 			dprintk("nfsd: couldn't allocate room for COMPOUND\n");
-			return 0;
+			return false;
 		}
 	}
 
@@ -2380,7 +2380,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op->replay = NULL;
 
 		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
-			return 0;
+			return false;
 		if (nfsd4_opnum_in_range(argp, op)) {
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
 			if (op->status != nfs_ok)
@@ -2427,7 +2427,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
 		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
-	return 1;
+	return true;
 }
 
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
@@ -5411,7 +5411,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	}
 }
 
-int
+bool
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6e8ad5f9757c..bfcddd4c7534 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -78,7 +78,7 @@ extern const struct seq_operations nfs_exports_op;
  */
 struct nfsd_voidargs { };
 struct nfsd_voidres { };
-int		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
+bool		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr);
 int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7cd13e9474ff..beb564e8a3db 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1067,10 +1067,10 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
  * @xdr: XDR stream positioned at arguments to decode
  *
  * Return values:
- *   %0: Arguments were not valid
- *   %1: Decoding was successful
+ *   %false: Arguments were not valid
+ *   %true: Decoding was successful
  */
-int nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
+bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 38c4b199a10f..921c1c4344ef 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -272,7 +272,7 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
  * XDR decode functions
  */
 
-int
+bool
 nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_fhandle *args = rqstp->rq_argp;
@@ -280,7 +280,7 @@ nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_fhandle(xdr, &args->fh);
 }
 
-int
+bool
 nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_sattrargs *args = rqstp->rq_argp;
@@ -289,7 +289,7 @@ nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_diropargs *args = rqstp->rq_argp;
@@ -297,54 +297,54 @@ nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len);
 }
 
-int
+bool
 nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readargs *args = rqstp->rq_argp;
 	u32 totalcount;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 	/* totalcount is ignored */
 	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_writeargs *args = rqstp->rq_argp;
 	u32 beginoffset, totalcount;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	/* beginoffset is ignored */
 	if (xdr_stream_decode_u32(xdr, &beginoffset) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
-		return 0;
+		return false;
 	/* totalcount is ignored */
 	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
-		return 0;
+		return false;
 
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
-		return 0;
+		return false;
 	if (args->len > NFSSVC_MAXBLKSIZE_V2)
-		return 0;
+		return false;
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
-int
+bool
 nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_createargs *args = rqstp->rq_argp;
@@ -354,7 +354,7 @@ nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_renameargs *args = rqstp->rq_argp;
@@ -365,7 +365,7 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					&args->tname, &args->tlen);
 }
 
-int
+bool
 nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_linkargs *args = rqstp->rq_argp;
@@ -375,39 +375,39 @@ nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 					&args->tname, &args->tlen);
 }
 
-int
+bool
 nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_symlinkargs *args = rqstp->rq_argp;
 	struct kvec *head = rqstp->rq_arg.head;
 
 	if (!svcxdr_decode_diropargs(xdr, &args->ffh, &args->fname, &args->flen))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
-		return 0;
+		return false;
 	if (args->tlen == 0)
-		return 0;
+		return false;
 
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
 	if (!args->first.iov_base)
-		return 0;
+		return false;
 	return svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
-int
+bool
 nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->cookie) < 0)
-		return 0;
+		return false;
 	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 804f9af94d6d..31be7d30e64e 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -141,16 +141,16 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 60a8909205e5..ef72bc4868da 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -265,21 +265,21 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 1d1b8771bdcf..8812256cd520 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -756,7 +756,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
-int nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 170ad6f5596a..e1362244f909 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -96,15 +96,15 @@ struct nlm_reboot {
  */
 #define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
 
-int	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_res(struct svc_rqst *, __be32 *);
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 68e14e0f2b1f..376b8f6a3763 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -22,15 +22,15 @@
 #define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
-int	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-int	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+bool	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_res(struct svc_rqst *, __be32 *);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index da3c5bc43d85..d6109fa7a57b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -454,7 +454,7 @@ struct svc_procedure {
 	/* process the request: */
 	__be32			(*pc_func)(struct svc_rqst *);
 	/* XDR decode args: */
-	int			(*pc_decode)(struct svc_rqst *rqstp,
+	bool			(*pc_decode)(struct svc_rqst *rqstp,
 					     struct xdr_stream *xdr);
 	/* XDR encode result: */
 	int			(*pc_encode)(struct svc_rqst *, __be32 *data);


