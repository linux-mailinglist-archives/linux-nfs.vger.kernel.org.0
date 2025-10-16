Return-Path: <linux-nfs+bounces-15304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E97BE506A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B9654256E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E4B223DEF;
	Thu, 16 Oct 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrV/+TYy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DD223DD1;
	Thu, 16 Oct 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638712; cv=none; b=C9p0xE1Eoi40zXJ2qPb8OCeRdUrZN14ybs/mUBxYbhGVmQiUskFRRRCuobQV1DiVownabE4z3kE14i4vl2Nm8IFCG4IXyimICOwU16WRy+qUaVq+8MNAiNiLY+pdUbWSEBd1L/pTzJPbke4ilxXFKS5AsoOlJEIY4/4p0i3I99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638712; c=relaxed/simple;
	bh=eQkgC5nR8t6O6KashQsL8giWcSt3DGLuo1UY7zL7S3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hs7PkYeCzhBnOObWpx6UO4gcqx2kVXPuaK3iPWndCBJ9MCSL0BeEVtVc6ADig0FTNAcUggOrkWvSelYyDBjwUWu6CXf/isxaB+RHFHm850qiBqeCmNRObQOHJnu1XcExjlKgtHO756eqCXLox/tocCoJRoJwrVWdcpel0mxMKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrV/+TYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F01C4CEF1;
	Thu, 16 Oct 2025 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760638712;
	bh=eQkgC5nR8t6O6KashQsL8giWcSt3DGLuo1UY7zL7S3c=;
	h=From:To:Cc:Subject:Date:From;
	b=MrV/+TYyqJnkIpC4VL8plT8MwqeADQyXCsNwD+Mhka1TJPlIsCqtaaYLY+pjQXaYA
	 Amau4GhsO7vHjjmkSYkcDqc/1A4LF+uPXtIdJ6NTAKLFIB+xkXrOOco3ZEcoUgiBlG
	 M0omNU/uBZ21OI2hOO6uLYvxu/AyTnG8MyECrQjAiuWFBc7Au2+XRH3OC3GSAXCnjQ
	 YSITWJYUpfs5Ig90JFLAf+0wIpy42dhxFZWuh5DlXL9H9/azyeK/R0GOOJdU7M/V/6
	 yjrVQRGn6aWKvZIzg6jvqAQMZMx65MvdpgcV9xz6zk9oVpZYRT5lYBRtRxZ4afQOZ7
	 B7HzgkMVnRNKw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] nfsd: Use MD5 library instead of crypto_shash
Date: Thu, 16 Oct 2025 11:15:34 -0700
Message-ID: <20251016181534.17252-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update NFSD's support for "legacy client tracking" (which uses MD5) to
use the MD5 library instead of crypto_shash.  This has several benefits:

- Simpler code.  Notably, much of the error-handling code is no longer
  needed, since the library functions can't fail.

- Improved performance due to reduced overhead.  A microbenchmark of
  nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.

- The MD5 code can now safely be built as a loadable module when nfsd is
  built as a loadable module.  (Previously, nfsd forced the MD5 code to
  built-in, presumably to work around the unreliability of the
  name-based loading.)  Thus select MD5 from the tristate option NFSD if
  NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.

- Fixes a bug where legacy client tracking was not supported on kernels
  booted with "fips=1", due to crypto_shash not allowing MD5 to be used.
  This particular use of MD5 is not for a cryptographic purpose, though,
  so it is acceptable even when fips=1 (see
  https://lore.kernel.org/r/dae495a93cbcc482f4ca23c3a0d9360a1fd8c3a8.camel@redhat.com/).

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Changed in v2:
- Removed the fips_enabled check.
- Added 'select CRYPTO' back to NFSD_V4.

 fs/nfsd/Kconfig       |  4 +--
 fs/nfsd/nfs4recover.c | 76 +++++--------------------------------------
 2 files changed, 11 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index e134dce45e350..94ab9e5bf930e 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -3,10 +3,11 @@ config NFSD
 	tristate "NFS server support"
 	depends on INET
 	depends on FILE_LOCKING
 	depends on FSNOTIFY
 	select CRC32
+	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
 	select CRYPTO_LIB_SHA256 if NFSD_V4
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
 	select NFS_COMMON
@@ -75,12 +76,11 @@ config NFSD_V3_ACL
 config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
-	select CRYPTO
-	select CRYPTO_MD5
+	select CRYPTO # required by RPCSEC_GSS_KRB5
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
 	  This option enables support in your system's NFS server for
 	  version 4 of the NFS protocol (RFC 3530).
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index e2b9472e5c78c..35d645dd6f863 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -30,11 +30,11 @@
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
 
-#include <crypto/hash.h>
+#include <crypto/md5.h>
 #include <crypto/sha2.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/sched.h>
@@ -90,61 +90,22 @@ static void
 nfs4_reset_creds(const struct cred *original)
 {
 	put_cred(revert_creds(original));
 }
 
-static int
+static void
 nfs4_make_rec_clidname(char dname[HEXDIR_LEN], const struct xdr_netobj *clname)
 {
 	u8 digest[MD5_DIGEST_SIZE];
-	struct crypto_shash *tfm;
-	int status;
 
 	dprintk("NFSD: nfs4_make_rec_clidname for %.*s\n",
 			clname->len, clname->data);
-	tfm = crypto_alloc_shash("md5", 0, 0);
-	if (IS_ERR(tfm)) {
-		status = PTR_ERR(tfm);
-		goto out_no_tfm;
-	}
 
-	status = crypto_shash_tfm_digest(tfm, clname->data, clname->len,
-					 digest);
-	if (status)
-		goto out;
+	md5(clname->data, clname->len, digest);
 
 	static_assert(HEXDIR_LEN == 2 * MD5_DIGEST_SIZE + 1);
 	sprintf(dname, "%*phN", MD5_DIGEST_SIZE, digest);
-
-	status = 0;
-out:
-	crypto_free_shash(tfm);
-out_no_tfm:
-	return status;
-}
-
-/*
- * If we had an error generating the recdir name for the legacy tracker
- * then warn the admin. If the error doesn't appear to be transient,
- * then disable recovery tracking.
- */
-static void
-legacy_recdir_name_error(struct nfs4_client *clp, int error)
-{
-	printk(KERN_ERR "NFSD: unable to generate recoverydir "
-			"name (%d).\n", error);
-
-	/*
-	 * if the algorithm just doesn't exist, then disable the recovery
-	 * tracker altogether. The crypto libs will generally return this if
-	 * FIPS is enabled as well.
-	 */
-	if (error == -ENOENT) {
-		printk(KERN_ERR "NFSD: disabling legacy clientid tracking. "
-			"Reboot recovery will not function correctly!\n");
-		nfsd4_client_tracking_exit(clp->net);
-	}
 }
 
 static void
 __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
 		const char *dname, int len, struct nfsd_net *nn)
@@ -180,13 +141,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	if (test_and_set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return;
 	if (!nn->rec_file)
 		return;
 
-	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-	if (status)
-		return legacy_recdir_name_error(clp, status);
+	nfs4_make_rec_clidname(dname, &clp->cl_name);
 
 	status = nfs4_save_creds(&original_cred);
 	if (status < 0)
 		return;
 
@@ -374,13 +333,11 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
 	if (!nn->rec_file || !test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return;
 
-	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-	if (status)
-		return legacy_recdir_name_error(clp, status);
+	nfs4_make_rec_clidname(dname, &clp->cl_name);
 
 	status = mnt_want_write_file(nn->rec_file);
 	if (status)
 		goto out;
 	clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
@@ -657,25 +614,20 @@ nfs4_recoverydir(void)
 }
 
 static int
 nfsd4_check_legacy_client(struct nfs4_client *clp)
 {
-	int status;
 	char dname[HEXDIR_LEN];
 	struct nfs4_client_reclaim *crp;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct xdr_netobj name;
 
 	/* did we already find that this client is stable? */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return 0;
 
-	status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-	if (status) {
-		legacy_recdir_name_error(clp, status);
-		return status;
-	}
+	nfs4_make_rec_clidname(dname, &clp->cl_name);
 
 	/* look for it in the reclaim hashtable otherwise */
 	name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
@@ -1264,17 +1216,14 @@ nfsd4_cld_check(struct nfs4_client *clp)
 	if (crp)
 		goto found;
 
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (nn->cld_net->cn_has_legacy) {
-		int status;
 		char dname[HEXDIR_LEN];
 		struct xdr_netobj name;
 
-		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-		if (status)
-			return -ENOENT;
+		nfs4_make_rec_clidname(dname, &clp->cl_name);
 
 		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data!\n",
 				__func__);
@@ -1315,15 +1264,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
 		struct xdr_netobj name;
 		char dname[HEXDIR_LEN];
-		int status;
 
-		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-		if (status)
-			return -ENOENT;
+		nfs4_make_rec_clidname(dname, &clp->cl_name);
 
 		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data\n",
 					__func__);
@@ -1692,15 +1638,11 @@ nfsd4_cltrack_legacy_recdir(const struct xdr_netobj *name)
 		/* just return nothing if output will be truncated */
 		kfree(result);
 		return NULL;
 	}
 
-	copied = nfs4_make_rec_clidname(result + copied, name);
-	if (copied) {
-		kfree(result);
-		return NULL;
-	}
+	nfs4_make_rec_clidname(result + copied, name);
 
 	return result;
 }
 
 static char *

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


