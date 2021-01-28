Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D763306DD2
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 07:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA1Gp4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 01:45:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhA1Gpn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 01:45:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10S6duwI126552;
        Thu, 28 Jan 2021 06:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=sj+RauG6p0Quw7dBsk3AdGlN2qOQjguTXQLf7S6EjkM=;
 b=sOqQ4/VOA2gHF4uYVgEYU8wmzpYlrXmcdu8NP73idK4qfiFw+guYVXZN97dn1kYjIYOf
 7vOoGhvKLNTdK5ClkW4LrgGk+kyB3umBRKawcjVyNB+hK5vShAF/4DECtKdA6qYjeFSa
 pBy0g87nqBeOc48kcwY27BkQPVVs1ArhCtAIs1f6BWNreDGqX6bo1bpwYm8OWp0csfA5
 cyV3K7nI5+z9Auak4hwKb77/r+r7QYybGY0MBEjOj870gO+GistYuz9uTcvK8y/EE38P
 oP823J9pPmhCAa5Vu8O99nH+zztzfkwlm9e8HbsZMwr+Z8IPYG59dUjA8T+8EOD8HL8u xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7r2m7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 06:44:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10S6aDjL122199;
        Thu, 28 Jan 2021 06:42:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 368wqyuqpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 06:42:47 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S6gUT9143708;
        Thu, 28 Jan 2021 06:42:46 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 368wqyuqpd-1;
        Thu, 28 Jan 2021 06:42:46 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4_2: SSC helper should use its own config.
Date:   Thu, 28 Jan 2021 01:42:26 -0500
Message-Id: <20210128064226.85025-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280033
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
enabled. Also removed the file name from a comment in nfs_ssc.c.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/Kconfig              |  4 ++++
 fs/nfs/nfs4file.c       |  4 ++++
 fs/nfs/super.c          | 12 ++++++++++++
 fs/nfs_common/Makefile  |  2 +-
 fs/nfs_common/nfs_ssc.c |  2 --
 fs/nfsd/Kconfig         |  1 +
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..a55bda4233bb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -333,6 +333,10 @@ config NFS_COMMON
 	depends on NFSD || NFS_FS || LOCKD
 	default y
 
+config NFS_V4_2_SSC_HELPER
+	tristate
+	default y if NFS_V4=y || NFS_FS=y
+
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
 source "fs/cifs/Kconfig"
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..441a2fa073c8 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -420,7 +420,9 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
  */
 void nfs42_ssc_register_ops(void)
 {
+#ifdef CONFIG_NFSD_V4
 	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
+#endif
 }
 
 /**
@@ -431,7 +433,9 @@ void nfs42_ssc_register_ops(void)
  */
 void nfs42_ssc_unregister_ops(void)
 {
+#ifdef CONFIG_NFSD_V4
 	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
+#endif
 }
 #endif /* CONFIG_NFS_V4_2 */
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..c7a924580eec 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -86,9 +86,11 @@ const struct super_operations nfs_sops = {
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
+#ifdef CONFIG_NFS_V4_2
 static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
 	.sco_sb_deactive = nfs_sb_deactive,
 };
+#endif
 
 #if IS_ENABLED(CONFIG_NFS_V4)
 static int __init register_nfs4_fs(void)
@@ -111,15 +113,21 @@ static void unregister_nfs4_fs(void)
 }
 #endif
 
+#ifdef CONFIG_NFS_V4_2
 static void nfs_ssc_register_ops(void)
 {
+#ifdef CONFIG_NFSD_V4
 	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
+#endif
 }
 
 static void nfs_ssc_unregister_ops(void)
 {
+#ifdef CONFIG_NFSD_V4
 	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
+#endif
 }
+#endif /* CONFIG_NFS_V4_2 */
 
 static struct shrinker acl_shrinker = {
 	.count_objects	= nfs_access_cache_count,
@@ -148,7 +156,9 @@ int __init register_nfs_fs(void)
 	ret = register_shrinker(&acl_shrinker);
 	if (ret < 0)
 		goto error_3;
+#ifdef CONFIG_NFS_V4_2
 	nfs_ssc_register_ops();
+#endif
 	return 0;
 error_3:
 	nfs_unregister_sysctl();
@@ -168,7 +178,9 @@ void __exit unregister_nfs_fs(void)
 	unregister_shrinker(&acl_shrinker);
 	nfs_unregister_sysctl();
 	unregister_nfs4_fs();
+#ifdef CONFIG_NFS_V4_2
 	nfs_ssc_unregister_ops();
+#endif
 	unregister_filesystem(&nfs_fs_type);
 }
 
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index fa82f5aaa6d9..119c75ab9fd0 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
-obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
+obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
index f43bbb373913..7c1509e968c8 100644
--- a/fs/nfs_common/nfs_ssc.c
+++ b/fs/nfs_common/nfs_ssc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * fs/nfs_common/nfs_ssc_comm.c
- *
  * Helper for knfsd's SSC to access ops in NFS client modules
  *
  * Author: Dai Ngo <dai.ngo@oracle.com>
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index dbbc583d6273..821e5913faee 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -76,6 +76,7 @@ config NFSD_V4
 	select CRYPTO_MD5
 	select CRYPTO_SHA256
 	select GRACE_PERIOD
+	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
 	  This option enables support in your system's NFS server for
 	  version 4 of the NFS protocol (RFC 3530).
-- 
2.9.5

