Return-Path: <linux-nfs+bounces-12568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25ABADF8CD
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 23:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF88188C0E7
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52327A451;
	Wed, 18 Jun 2025 21:34:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B651F1311
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282450; cv=none; b=Qldjhit54AIRLqlM1xBqde8vCcBDFjoXl3yZW6Z5TIo6OQ4ldiXoF25HwHPFEg4vwHAsvx9vXVWMDMjGx+frPNAqctXH52bxMAmoUxlvzbMX8x9JdAn0HnuN5y40vP5bVSEkaHCgZapcaJLSSpUDfkrcgHejPGYHdXUU0AbL3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282450; c=relaxed/simple;
	bh=6e2thJCeCdBJez+dfzUQGU2XLoFQBVqVKnoij5xMoew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsGwRNktm+4wltbyWA6/HgQcsNRI4NeuaDEmWNHEwuPOFftfG5+X1l0a8nhgPFFh7F4unOjZ+hnzBlbFT2xp3lsjLkbYMpLCmjSa/9L1YV8wlRC1koixV2FM4LRvfs3ecwkYHctsDkgkiN+RN2WgJsmc6KNeYCVHpeSzjkTWmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uS0Pt-000Yqq-5E;
	Wed, 18 Jun 2025 21:33:57 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 1/3] nfsd: provide proper locking for all write_ function
Date: Thu, 19 Jun 2025 07:31:51 +1000
Message-ID: <20250618213347.425503-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618213347.425503-1-neil@brown.name>
References: <20250618213347.425503-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_foo functions are called to handle IO to files in /proc/fs/nfsd/.
The can be called at any time and so generally need locking to ensure
they don't happen at an awkward time.

Many already take nfsd_mutex and check if nfsd_serv has been set.  This
ensures they only run when the server is fully configured.

write_filehandle() does *not* need locking.  It interacts with the
export table which is set up when the netns is set up, so it is always
valid and it has its own locking.  write_filehandle() is needed before
the nfs server is started so checking nfsd_serv would be wrong.

The remaining files which do not have any locking are
write_v4_end_grace(), write_unlock_ip(), and write_unlock_fs().
None of these make sense when the nfs server is not running and there is
evidence that write_v4_end_grace() can race with ->client_tracking_op
setup/shutdown and cause problems.

This patch adds locking to these three and ensures the "unlock"
functions abort if ->nfsd_serv is not set.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsctl.c | 115 +++++++++++++++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 38 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..3710a1992d17 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -200,27 +200,18 @@ static inline struct net *netns(struct file *file)
 	return file_inode(file)->i_sb->s_fs_info;
 }
 
-/*
- * write_unlock_ip - Release all locks used by a client
- *
- * Experimental.
- *
- * Input:
- *			buf:	'\n'-terminated C string containing a
- *				presentation format IP address
- *			size:	length of C string in @buf
- * Output:
- *	On success:	returns zero if all specified locks were released;
- *			returns one if one or more locks were not released
- *	On error:	return code is negative errno value
- */
-static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
+static ssize_t __write_unlock_ip(struct file *file, char *buf, size_t size)
 {
 	struct sockaddr_storage address;
 	struct sockaddr *sap = (struct sockaddr *)&address;
 	size_t salen = sizeof(address);
 	char *fo_path;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -241,24 +232,39 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 }
 
 /*
- * write_unlock_fs - Release all locks on a local file system
+ * write_unlock_ip - Release all locks used by a client
  *
  * Experimental.
  *
  * Input:
- *			buf:	'\n'-terminated C string containing the
- *				absolute pathname of a local file system
+ *			buf:	'\n'-terminated C string containing a
+ *				presentation format IP address
  *			size:	length of C string in @buf
  * Output:
  *	On success:	returns zero if all specified locks were released;
  *			returns one if one or more locks were not released
  *	On error:	return code is negative errno value
  */
-static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
+static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
+{
+	ssize_t rv;
+
+	mutex_lock(&nfsd_mutex);
+	rv = __write_unlock_ip(file, buf, size);
+	mutex_unlock(&nfsd_mutex);
+	return rv;
+}
+
+static ssize_t __write_unlock_fs(struct file *file, char *buf, size_t size)
 {
 	struct path path;
 	char *fo_path;
 	int error;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -291,6 +297,30 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	return error;
 }
 
+/*
+ * write_unlock_fs - Release all locks on a local file system
+ *
+ * Experimental.
+ *
+ * Input:
+ *			buf:	'\n'-terminated C string containing the
+ *				absolute pathname of a local file system
+ *			size:	length of C string in @buf
+ * Output:
+ *	On success:	returns zero if all specified locks were released;
+ *			returns one if one or more locks were not released
+ *	On error:	return code is negative errno value
+ */
+static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
+{
+	ssize_t rv;
+
+	mutex_lock(&nfsd_mutex);
+	rv = __write_unlock_fs(file, buf, size);
+	mutex_unlock(&nfsd_mutex);
+	return rv;
+}
+
 /*
  * write_filehandle - Get a variable-length NFS file handle by path
  *
@@ -1053,6 +1083,29 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 }
 #endif
 
+static ssize_t __write_v4_end_grace(struct file *file, char *buf, size_t size)
+{
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+
+	if (size > 0) {
+		switch(buf[0]) {
+		case 'Y':
+		case 'y':
+		case '1':
+			if (!nn->nfsd_serv)
+				return -EBUSY;
+			trace_nfsd_end_grace(netns(file));
+			nfsd4_end_grace(nn);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%c\n",
+			 nn->grace_ended ? 'Y' : 'N');
+}
+
 /*
  * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
  *
@@ -1075,27 +1128,13 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
  */
 static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 {
-	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
-
-	if (size > 0) {
-		switch(buf[0]) {
-		case 'Y':
-		case 'y':
-		case '1':
-			if (!nn->nfsd_serv)
-				return -EBUSY;
-			trace_nfsd_end_grace(netns(file));
-			nfsd4_end_grace(nn);
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
+	ssize_t rv;
 
-	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%c\n",
-			 nn->grace_ended ? 'Y' : 'N');
+	mutex_lock(&nfsd_mutex);
+	rv = __write_v4_end_grace(file, buf, size);
+	mutex_unlock(&nfsd_mutex);
+	return rv;
 }
-
 #endif
 
 /*----------------------------------------------------------------------------*/
-- 
2.49.0


