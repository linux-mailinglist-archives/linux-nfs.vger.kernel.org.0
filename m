Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2542A8EC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhJLP7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 11:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhJLP7Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Oct 2021 11:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8D761074;
        Tue, 12 Oct 2021 15:57:23 +0000 (UTC)
Subject: [PATCH v1 1/2] SUNRPC: Replace the "__be32 *p" parameter to
 .pc_decode
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 Oct 2021 11:57:22 -0400
Message-ID: <163405424234.4278.7789336032668009922.stgit@bazille.1015granger.net>
In-Reply-To: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
References: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The passed-in value of the "__be32 *p" parameter is now unused in
every server-side XDR decoder, and can be removed.

Note also that there is a line in each decoder that sets up a local
pointer to a struct xdr_stream. Passing that pointer from the
dispatcher instead saves one line per decoder function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    3 +--
 fs/lockd/xdr.c             |   27 ++++++++++----------------
 fs/lockd/xdr4.c            |   27 ++++++++++----------------
 fs/nfsd/nfs2acl.c          |   12 ++++++------
 fs/nfsd/nfs3acl.c          |    8 ++++----
 fs/nfsd/nfs3xdr.c          |   45 +++++++++++++++-----------------------------
 fs/nfsd/nfs4xdr.c          |    4 ++--
 fs/nfsd/nfsd.h             |    3 ++-
 fs/nfsd/nfssvc.c           |    7 +++----
 fs/nfsd/nfsxdr.c           |   30 ++++++++++-------------------
 fs/nfsd/xdr.h              |   21 +++++++++++----------
 fs/nfsd/xdr3.h             |   31 ++++++++++++++++--------------
 fs/nfsd/xdr4.h             |    2 +-
 include/linux/lockd/xdr.h  |   19 ++++++++++---------
 include/linux/lockd/xdr4.h |   19 +++++++++----------
 include/linux/sunrpc/svc.h |    3 ++-
 16 files changed, 112 insertions(+), 149 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index b632be3ad57b..9a82471bda07 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -780,11 +780,10 @@ module_exit(exit_nlm);
 static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
-	struct kvec *argv = rqstp->rq_arg.head;
 	struct kvec *resv = rqstp->rq_res.head;
 
 	svcxdr_init_decode(rqstp);
-	if (!procp->pc_decode(rqstp, argv->iov_base))
+	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
 	*statp = procp->pc_func(rqstp);
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 9235e60b1769..895f15222104 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -146,15 +146,14 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  */
 
 int
-nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -171,9 +170,8 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -197,9 +195,8 @@ nlmsvc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -218,9 +215,8 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
@@ -233,9 +229,8 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
@@ -247,10 +242,10 @@ nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_reboot *argp = rqstp->rq_argp;
+	__be32 *p;
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
@@ -273,9 +268,8 @@ nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -301,9 +295,8 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
+nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 98e957e4566c..573c7d580a5e 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -145,15 +145,14 @@ svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
  */
 
 int
-nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
 
 int
-nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -170,9 +169,8 @@ nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -196,9 +194,8 @@ nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
@@ -216,9 +213,8 @@ nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
@@ -231,9 +227,8 @@ nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
@@ -245,10 +240,10 @@ nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_reboot *argp = rqstp->rq_argp;
+	__be32 *p;
 	u32 len;
 
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
@@ -271,9 +266,8 @@ nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -299,9 +293,8 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
+nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_lock	*lock = &argp->lock;
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 4b43929c1f25..0069c0fdb94f 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -188,9 +188,9 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
@@ -201,9 +201,9 @@ static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
@@ -222,9 +222,9 @@ static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 5dfe7644a517..b1e352ed2436 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -127,9 +127,9 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
  * XDR decode functions
  */
 
-static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_getaclargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
@@ -140,9 +140,9 @@ static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
+static int
+nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &argp->fh))
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 91d4e2b8b854..f32ca6d57e30 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -557,18 +557,16 @@ void fill_post_wcc(struct svc_fh *fhp)
  */
 
 int
-nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
 	return svcxdr_decode_nfs_fh3(xdr, &args->fh);
 }
 
 int
-nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_sattrargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_nfs_fh3(xdr, &args->fh) &&
@@ -577,18 +575,16 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_diropargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len);
 }
 
 int
-nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_accessargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
@@ -600,9 +596,8 @@ nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
@@ -616,9 +611,8 @@ nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
 	u32 max_blocksize = svc_max_payload(rqstp);
 
@@ -649,9 +643,8 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
@@ -674,9 +667,8 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs3(xdr, &args->fh,
@@ -685,9 +677,8 @@ nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
 	struct kvec *head = rqstp->rq_arg.head;
 	struct kvec *tail = rqstp->rq_arg.tail;
@@ -713,9 +704,8 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_mknodargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
@@ -742,9 +732,8 @@ nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_renameargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs3(xdr, &args->ffh,
@@ -754,9 +743,8 @@ nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_linkargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_nfs_fh3(xdr, &args->ffh) &&
@@ -765,9 +753,8 @@ nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
@@ -784,9 +771,8 @@ nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
 	u32 dircount;
 
@@ -807,9 +793,8 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_commitargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..35f56dbda462 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5412,14 +5412,14 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 }
 
 int
-nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
+nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
 	/* svcxdr_tmp_alloc */
 	args->to_free = NULL;
 
-	args->xdr = &rqstp->rq_arg_stream;
+	args->xdr = xdr;
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9664303afdaf..6e8ad5f9757c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -78,7 +78,8 @@ extern const struct seq_operations nfs_exports_op;
  */
 struct nfsd_voidargs { };
 struct nfsd_voidres { };
-int		nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p);
+int		nfssvc_decode_voidarg(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr);
 int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ccb59e91011b..7cd13e9474ff 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1004,7 +1004,6 @@ nfsd(void *vrqstp)
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
-	struct kvec *argv = &rqstp->rq_arg.head[0];
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	__be32 *p;
 
@@ -1015,7 +1014,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	rqstp->rq_cachetype = proc->pc_cachetype;
 
 	svcxdr_init_decode(rqstp);
-	if (!proc->pc_decode(rqstp, argv->iov_base))
+	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
 	switch (nfsd_cache_lookup(rqstp)) {
@@ -1065,13 +1064,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 /**
  * nfssvc_decode_voidarg - Decode void arguments
  * @rqstp: Server RPC transaction context
- * @p: buffer containing arguments to decode
+ * @xdr: XDR stream positioned at arguments to decode
  *
  * Return values:
  *   %0: Arguments were not valid
  *   %1: Decoding was successful
  */
-int nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+int nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return 1;
 }
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 26a42f87c240..38c4b199a10f 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -273,18 +273,16 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
  */
 
 int
-nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
 	return svcxdr_decode_fhandle(xdr, &args->fh);
 }
 
 int
-nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_sattrargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_fhandle(xdr, &args->fh) &&
@@ -292,18 +290,16 @@ nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_diropargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len);
 }
 
 int
-nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_readargs *args = rqstp->rq_argp;
 	u32 totalcount;
 
@@ -321,9 +317,8 @@ nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_writeargs *args = rqstp->rq_argp;
 	u32 beginoffset, totalcount;
 
@@ -350,9 +345,8 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_createargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs(xdr, &args->fh,
@@ -361,9 +355,8 @@ nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_renameargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_diropargs(xdr, &args->ffh,
@@ -373,9 +366,8 @@ nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_linkargs *args = rqstp->rq_argp;
 
 	return svcxdr_decode_fhandle(xdr, &args->ffh) &&
@@ -384,9 +376,8 @@ nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_symlinkargs *args = rqstp->rq_argp;
 	struct kvec *head = rqstp->rq_arg.head;
 
@@ -405,9 +396,8 @@ nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 }
 
 int
-nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_readdirargs *args = rqstp->rq_argp;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 80fd6d7f3404..804f9af94d6d 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -141,16 +141,17 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_fhandleargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_readargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_writeargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_createargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_renameargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
-int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
+int nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfssvc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
 int nfssvc_encode_statres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstatres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 712c117300cb..60a8909205e5 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -265,21 +265,22 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandleargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_accessargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_readargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_writeargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_createargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_mkdirargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_mknodargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_renameargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_linkargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *);
-int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *);
+int nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_diropargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_accessargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_readargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_createargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_renameargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_linkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int nfs3svc_decode_commitargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
 int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_lookupres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 3e4052e3bd50..1d1b8771bdcf 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -756,7 +756,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
-int nfs4svc_decode_compoundargs(struct svc_rqst *, __be32 *);
+int nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index a98309c0121c..170ad6f5596a 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -96,18 +96,19 @@ struct nlm_reboot {
  */
 #define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
 
-int	nlmsvc_decode_testargs(struct svc_rqst *, __be32 *);
+int	nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+
 int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_lockargs(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_cancargs(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_unlockargs(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_res(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_res(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_void(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_void(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_shareargs(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_notify(struct svc_rqst *, __be32 *);
-int	nlmsvc_decode_reboot(struct svc_rqst *, __be32 *);
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index 5ae766f26e04..68e14e0f2b1f 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -22,21 +22,20 @@
 #define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
+int	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
+int	nlm4svc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-
-int	nlm4svc_decode_testargs(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_lockargs(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_cancargs(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_unlockargs(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_res(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_res(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_void(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_void(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_shareargs(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_notify(struct svc_rqst *, __be32 *);
-int	nlm4svc_decode_reboot(struct svc_rqst *, __be32 *);
 
 extern const struct rpc_version nlm_version4;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4205a6ef4770..da3c5bc43d85 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -454,7 +454,8 @@ struct svc_procedure {
 	/* process the request: */
 	__be32			(*pc_func)(struct svc_rqst *);
 	/* XDR decode args: */
-	int			(*pc_decode)(struct svc_rqst *, __be32 *data);
+	int			(*pc_decode)(struct svc_rqst *rqstp,
+					     struct xdr_stream *xdr);
 	/* XDR encode result: */
 	int			(*pc_encode)(struct svc_rqst *, __be32 *data);
 	/* XDR free result: */


