Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB47C8653
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJMNEF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjJMNEE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 09:04:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1991;
        Fri, 13 Oct 2023 06:04:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC66C433C7;
        Fri, 13 Oct 2023 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697202241;
        bh=8nV6dBADutP2rbdZShK89tiZpnEuWT1YAWAXR11xvt4=;
        h=From:Date:Subject:To:Cc:From;
        b=KD+sGzEhIa/zEyS/erdFd/KzWY/v3EWEp6hXdXiYDyvmtAg8qZ2WrkHEiiKTkkRsy
         O12YsF5+FzDz9OkTIANIrMGn4Wnf41i9t5wXLFNn3m8EXS75yvANljf3uuXBHg9xo7
         SNW7D7wJ/QQA+Wc1bkNyUIC3wbGL4+Z05kC1u1ygFnprC+aF+HaL7sE+AANWVPk+if
         xBeqGN/5vYRMw21jJIuOEU5EDNkbPO6T1T8GWVolfh74IUrHblldmbmvTPpTYRzWBb
         yZ0SUTjEQsRoe1YXRWPTOg/vPZJfJAvBgBGJUBW+oWzk/1arBF5WbbMxSSGDPD/M8l
         q8io/TN6bmcSg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 13 Oct 2023 09:03:53 -0400
Subject: [PATCH] nfsd: new Kconfig option for legacy client tracking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-nfsd-cltrack-v1-1-5d8a3a6a39af@kernel.org>
X-B4-Tracking: v=1; b=H4sIADhAKWUC/3XMQQ6DIBCF4auYWZeGoWiwq96jcYE4KtFAMxjTx
 nD3Uvdd/i953wGJ2FOCe3UA0+6Tj6EEXipwsw0TCT+UBiXVDSUqEcY0CLdubN0iGmyNQW2JagP
 l8mIa/fvknl3p2act8ufUd/ytf6AdBQpNirSse9W3zWMhDrReI0/Q5Zy/JIj5yKkAAAA=
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've had a number of attempts at different NFSv4 client tracking
methods over the years, but now nfsdcld has emerged as the clear winner
since the others (recoverydir and the usermodehelper upcall) are
problematic.

As a case in point, the recoverydir backend uses MD5 hashes to encode
long form clientid strings, which means that nfsd repeatedly gets dinged
on FIPS audits, since MD5 isn't considered secure. Its use of MD5 is not
cryptographically significant, so there is no danger there, but allowing
us to compile that out allows us to sidestep the issue entirely.

As a prelude to eventually removing support for these client tracking
methods, add a new Kconfig option that enables them. Mark it deprecated
and make it default to N.

Acked-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Now that we've really settled on nfsdcld being the way forward for
NFSv4 client tracking, put the legacy methods under a new Kconfig option
that defaults to off.

This should make it easier to eventually deprecate this code and remove
it in the future (maybe in v6.10 or so)?
---
 fs/nfsd/Kconfig       | 16 +++++++++
 fs/nfsd/nfs4recover.c | 97 +++++++++++++++++++++++++++++++++------------------
 fs/nfsd/nfsctl.c      |  6 ++++
 3 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 43b88eaf0673..272ab8d5c4d7 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -158,3 +158,19 @@ config NFSD_V4_SECURITY_LABEL
 
 	If you do not wish to enable fine-grained security labels SELinux or
 	Smack policies on NFSv4 files, say N.
+
+config NFSD_LEGACY_CLIENT_TRACKING
+	bool "Support legacy NFSv4 client tracking methods (DEPRECATED)"
+	depends on NFSD_V4
+	default n
+	help
+	  The NFSv4 server needs to store a small amount of information on
+	  stable storage in order to handle state recovery after reboot. Most
+	  modern deployments upcall to a userland daemon for this (nfsdcld),
+	  but older NFS servers may store information directly in a
+	  recoverydir, or spawn a process directly using a usermodehelper
+	  upcall.
+
+	  These legacy client tracking methods have proven to be probelmatic
+	  and will be removed in the future. Say Y here if you need support
+	  for them in the interim.
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3509e73abe1f..2c060e0b1604 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -66,6 +66,7 @@ struct nfsd4_client_tracking_ops {
 static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops;
 static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2;
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 /* Globals */
 static char user_recovery_dirname[PATH_MAX] = "/var/lib/nfs/v4recovery";
 
@@ -720,6 +721,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
 	.version	= 1,
 	.msglen		= 0,
 };
+#endif /* CONFIG_NFSD_LEGACY_CLIENT_TRACKING */
 
 /* Globals */
 #define NFSD_PIPE_DIR		"nfsd"
@@ -731,8 +733,10 @@ struct cld_net {
 	spinlock_t		 cn_lock;
 	struct list_head	 cn_list;
 	unsigned int		 cn_xid;
-	bool			 cn_has_legacy;
 	struct crypto_shash	*cn_tfm;
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
+	bool			 cn_has_legacy;
+#endif
 };
 
 struct cld_upcall {
@@ -793,7 +797,6 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 	uint8_t cmd, princhashlen;
 	struct xdr_netobj name, princhash = { .len = 0, .data = NULL };
 	uint16_t namelen;
-	struct cld_net *cn = nn->cld_net;
 
 	if (get_user(cmd, &cmsg->cm_cmd)) {
 		dprintk("%s: error when copying cmd from userspace", __func__);
@@ -833,11 +836,15 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 				return PTR_ERR(name.data);
 			name.len = namelen;
 		}
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 		if (name.len > 5 && memcmp(name.data, "hash:", 5) == 0) {
+			struct cld_net *cn = nn->cld_net;
+
 			name.len = name.len - 5;
 			memmove(name.data, name.data + 5, name.len);
 			cn->cn_has_legacy = true;
 		}
+#endif
 		if (!nfs4_client_to_reclaim(name, princhash, nn)) {
 			kfree(name.data);
 			kfree(princhash.data);
@@ -1010,7 +1017,9 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 
 	cn->cn_pipe->dentry = dentry;
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	cn->cn_has_legacy = false;
+#endif
 	nn->cld_net = cn;
 	return 0;
 
@@ -1282,10 +1291,6 @@ nfsd4_cld_check(struct nfs4_client *clp)
 {
 	struct nfs4_client_reclaim *crp;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
-	struct cld_net *cn = nn->cld_net;
-	int status;
-	char dname[HEXDIR_LEN];
-	struct xdr_netobj name;
 
 	/* did we already find that this client is stable? */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
@@ -1296,7 +1301,12 @@ nfsd4_cld_check(struct nfs4_client *clp)
 	if (crp)
 		goto found;
 
-	if (cn->cn_has_legacy) {
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
+	if (nn->cld_net->cn_has_legacy) {
+		int status;
+		char dname[HEXDIR_LEN];
+		struct xdr_netobj name;
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
 		if (status)
 			return -ENOENT;
@@ -1314,6 +1324,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
@@ -1327,8 +1338,6 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 	int status;
-	char dname[HEXDIR_LEN];
-	struct xdr_netobj name;
 	struct crypto_shash *tfm = cn->cn_tfm;
 	struct xdr_netobj cksum;
 	char *principal = NULL;
@@ -1342,7 +1351,11 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	if (crp)
 		goto found;
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
+		struct xdr_netobj name;
+		char dname[HEXDIR_LEN];
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
 		if (status)
 			return -ENOENT;
@@ -1360,6 +1373,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
 	return -ENOENT;
 found:
 	if (crp->cr_princhash.len) {
@@ -1663,6 +1677,7 @@ static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2 = {
 	.msglen		= sizeof(struct cld_msg_v2),
 };
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 /* upcall via usermodehelper */
 static char cltrack_prog[PATH_MAX] = "/sbin/nfsdcltrack";
 module_param_string(cltrack_prog, cltrack_prog, sizeof(cltrack_prog),
@@ -2007,28 +2022,10 @@ static const struct nfsd4_client_tracking_ops nfsd4_umh_tracking_ops = {
 	.msglen		= 0,
 };
 
-int
-nfsd4_client_tracking_init(struct net *net)
+static inline int check_for_legacy_methods(int status, struct net *net)
 {
-	int status;
-	struct path path;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	/* just run the init if it the method is already decided */
-	if (nn->client_tracking_ops)
-		goto do_init;
-
-	/* First, try to use nfsdcld */
-	nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
-	status = nn->client_tracking_ops->init(net);
-	if (!status)
-		return status;
-	if (status != -ETIMEDOUT) {
-		nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v0;
-		status = nn->client_tracking_ops->init(net);
-		if (!status)
-			return status;
-	}
+	struct path path;
 
 	/*
 	 * Next, try the UMH upcall.
@@ -2045,14 +2042,46 @@ nfsd4_client_tracking_init(struct net *net)
 	nn->client_tracking_ops = &nfsd4_legacy_tracking_ops;
 	status = kern_path(nfs4_recoverydir(), LOOKUP_FOLLOW, &path);
 	if (!status) {
-		status = d_is_dir(path.dentry);
+		status = !d_is_dir(path.dentry);
 		path_put(&path);
-		if (!status) {
-			status = -EINVAL;
-			goto out;
-		}
+		if (status)
+			return -ENOTDIR;
+		status = nn->client_tracking_ops->init(net);
+	}
+	return status;
+}
+#else
+static inline int check_for_legacy_methods(int status, struct net *net)
+{
+	return status;
+}
+#endif /* CONFIG_LEGACY_NFSD_CLIENT_TRACKING */
+
+int
+nfsd4_client_tracking_init(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int status;
+
+	/* just run the init if it the method is already decided */
+	if (nn->client_tracking_ops)
+		goto do_init;
+
+	/* First, try to use nfsdcld */
+	nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
+	status = nn->client_tracking_ops->init(net);
+	if (!status)
+		return status;
+	if (status != -ETIMEDOUT) {
+		nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v0;
+		status = nn->client_tracking_ops->init(net);
+		if (!status)
+			return status;
 	}
 
+	status = check_for_legacy_methods(status, net);
+	if (status)
+		goto out;
 do_init:
 	status = nn->client_tracking_ops->init(net);
 out:
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a36..48d1dc9cccfb 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -75,7 +75,9 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 static ssize_t write_recoverydir(struct file *file, char *buf, size_t size);
+#endif
 static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size);
 #endif
 
@@ -92,7 +94,9 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	[NFSD_RecoveryDir] = write_recoverydir,
+#endif
 	[NFSD_V4EndGrace] = write_v4_end_grace,
 #endif
 };
@@ -1012,6 +1016,7 @@ static ssize_t write_gracetime(struct file *file, char *buf, size_t size)
 	return nfsd4_write_time(file, buf, size, &nn->nfsd4_grace, nn);
 }
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
 				   struct nfsd_net *nn)
 {
@@ -1072,6 +1077,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
+#endif
 
 /*
  * write_v4_end_grace - release grace period for nfsd's v4.x lock manager

---
base-commit: 401644852d0b2a278811de38081be23f74b5bb04
change-id: 20231012-nfsd-cltrack-6198814aee58

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

