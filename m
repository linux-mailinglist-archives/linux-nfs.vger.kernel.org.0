Return-Path: <linux-nfs+bounces-11330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E313CA9F9C1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7271A83BFE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0871297A5E;
	Mon, 28 Apr 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CupyqjNH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2B297A5D;
	Mon, 28 Apr 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869085; cv=none; b=HsN0WKmAz23zFMn/tHYMh1O6Rs1emGCVQ6RJMGgbH2hcF5TvXhldGaNZFQjMtcDp3c+uZtmsBltxp4Btrwux7h1GsAzHIE9c0PzcJtxtgrjphCt8RvlQCS1g0ob1/SmVKP67GYGMxQHTATJD+g8au0WTP3OUWY4IXVXNR3snWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869085; c=relaxed/simple;
	bh=5pK9VnLNkAueCPi14ufUOa2+mgYtrx0H1dXxHMFZIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGoQaIY6KAjx5TbnD5Iv/HWC1PHtlFO37yiT3Sok6OQi07XsCodNMmkxumg7II95jsi9hk7xqxDgajSs6el6JVnZjFU4QSsi/N6BDmMa0XRsry5yRvEguN0YIhtxR8MyeH3lQfw4zxW3tU+JLrMftnv9enfC1+eUEhNcdz+ePG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CupyqjNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450D7C4CEE4;
	Mon, 28 Apr 2025 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869085;
	bh=5pK9VnLNkAueCPi14ufUOa2+mgYtrx0H1dXxHMFZIwE=;
	h=From:To:Cc:Subject:Date:From;
	b=CupyqjNHBafKb73Ze78hkTZVlSbXYAa9pDQDzPu9SuVi1wNQ8zj9kYyts04K0X3i0
	 D4f78szmt4ZkhemlJs6eqBOdUfioIuaUlhx+Fy6VCi2cpyNihsoOdGvcNh2i9nSEy/
	 9hk3FIKepBb7D9fZD6ZHcvOjMYRZ3JXyJ+6TTPQQOyB7J9TGItVJ2k/aqYTP3kevAN
	 W4sUGr0f/zekF0uVNawjYnW8uRZOuQHhNo2JAFUOvWjBM+3xXNKUa+QVW99fyuKs/k
	 W8Y3wDL5gke0hmN1TpobG/KPQ9A89yOQCJZ4mQiyyUpgXQfsDB0VWWfVfG5E4+sFtX
	 2gfNZEiQ9d1cg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH] nfsd: use SHA-256 library API instead of crypto_shash API
Date: Mon, 28 Apr 2025 12:36:58 -0700
Message-ID: <20250428193658.861896-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

This user of SHA-256 does not support any other algorithm, so the
crypto_shash abstraction provides no value.  Just use the SHA-256
library API instead, which is much simpler and easier to use.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/nfsd/Kconfig       |  2 +-
 fs/nfsd/nfs4recover.c | 57 ++++++++-----------------------------------
 2 files changed, 11 insertions(+), 48 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 731a88f6313eb..879e0b104d1c8 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -75,12 +75,12 @@ config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
 	select CRYPTO
+	select CRYPTO_LIB_SHA256
 	select CRYPTO_MD5
-	select CRYPTO_SHA256
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
 	  This option enables support in your system's NFS server for
 	  version 4 of the NFS protocol (RFC 3530).
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index acde3edab7336..c3840793261be 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -31,10 +31,11 @@
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
 
 #include <crypto/hash.h>
+#include <crypto/sha2.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -735,11 +736,10 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
 struct cld_net {
 	struct rpc_pipe		*cn_pipe;
 	spinlock_t		 cn_lock;
 	struct list_head	 cn_list;
 	unsigned int		 cn_xid;
-	struct crypto_shash	*cn_tfm;
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	bool			 cn_has_legacy;
 #endif
 };
 
@@ -1061,12 +1061,10 @@ nfsd4_remove_cld_pipe(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 
 	nfsd4_cld_unregister_net(net, cn->cn_pipe);
 	rpc_destroy_pipe_data(cn->cn_pipe);
-	if (cn->cn_tfm)
-		crypto_free_shash(cn->cn_tfm);
 	kfree(nn->cld_net);
 	nn->cld_net = NULL;
 }
 
 static struct cld_upcall *
@@ -1156,12 +1154,10 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	int ret;
 	struct cld_upcall *cup;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 	struct cld_msg_v2 *cmsg;
-	struct crypto_shash *tfm = cn->cn_tfm;
-	struct xdr_netobj cksum;
 	char *principal = NULL;
 
 	/* Don't upcall if it's already stored */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return;
@@ -1180,36 +1176,22 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	if (clp->cl_cred.cr_raw_principal)
 		principal = clp->cl_cred.cr_raw_principal;
 	else if (clp->cl_cred.cr_principal)
 		principal = clp->cl_cred.cr_principal;
 	if (principal) {
-		cksum.len = crypto_shash_digestsize(tfm);
-		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
-					      cksum.data);
-		if (ret) {
-			kfree(cksum.data);
-			goto out;
-		}
-		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = cksum.len;
-		memcpy(cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
-		       cksum.data, cksum.len);
-		kfree(cksum.data);
+		sha256(principal, strlen(principal),
+		       cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data);
+		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = SHA256_DIGEST_SIZE;
 	} else
 		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = 0;
 
 	ret = cld_pipe_upcall(cn->cn_pipe, cmsg, nn);
 	if (!ret) {
 		ret = cmsg->cm_status;
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
 
-out:
 	free_cld_upcall(cup);
 out_err:
 	if (ret)
 		pr_err("NFSD: Unable to create client record on stable storage: %d\n",
 				ret);
@@ -1347,13 +1329,10 @@ static int
 nfsd4_cld_check_v2(struct nfs4_client *clp)
 {
 	struct nfs4_client_reclaim *crp;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
-	int status;
-	struct crypto_shash *tfm = cn->cn_tfm;
-	struct xdr_netobj cksum;
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return 0;
@@ -1365,10 +1344,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
 		struct xdr_netobj name;
 		char dname[HEXDIR_LEN];
+		int status;
 
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
 		if (status)
 			return -ENOENT;
 
@@ -1387,32 +1367,22 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	}
 #endif
 	return -ENOENT;
 found:
 	if (crp->cr_princhash.len) {
+		u8 digest[SHA256_DIGEST_SIZE];
+
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
 		if (principal == NULL)
 			return -ENOENT;
-		cksum.len = crypto_shash_digestsize(tfm);
-		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL)
-			return -ENOENT;
-		status = crypto_shash_tfm_digest(tfm, principal,
-						 strlen(principal), cksum.data);
-		if (status) {
-			kfree(cksum.data);
+		sha256(principal, strlen(principal), digest);
+		if (memcmp(crp->cr_princhash.data, digest,
+				crp->cr_princhash.len))
 			return -ENOENT;
-		}
-		if (memcmp(crp->cr_princhash.data, cksum.data,
-				crp->cr_princhash.len)) {
-			kfree(cksum.data);
-			return -ENOENT;
-		}
-		kfree(cksum.data);
 	}
 	crp->cr_clp = clp;
 	return 0;
 }
 
@@ -1588,11 +1558,10 @@ nfsd4_cld_tracking_init(struct net *net)
 {
 	int status;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool running;
 	int retries = 10;
-	struct crypto_shash *tfm;
 
 	status = nfs4_cld_state_init(net);
 	if (status)
 		return status;
 
@@ -1613,16 +1582,10 @@ nfsd4_cld_tracking_init(struct net *net)
 
 	if (!running) {
 		status = -ETIMEDOUT;
 		goto err_remove;
 	}
-	tfm = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(tfm)) {
-		status = PTR_ERR(tfm);
-		goto err_remove;
-	}
-	nn->cld_net->cn_tfm = tfm;
 
 	status = nfsd4_cld_get_version(nn);
 	if (status == -EOPNOTSUPP)
 		pr_warn("NFSD: nfsdcld GetVersion upcall failed. Please upgrade nfsdcld.\n");
 

base-commit: 33035b665157558254b3c21c3f049fd728e72368
-- 
2.49.0


