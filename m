Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC6301220
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Jan 2021 02:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbhAWBvi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 20:51:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbhAWBvf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 20:51:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N1nt1X094555;
        Sat, 23 Jan 2021 01:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=BriLrr+Z1Q6Z2RH281crJTXSbMO0HZ1hDgVq4wspCTQ=;
 b=o7pJA+ZAWiOxctF9vOTJ4t4FAgfpjYzxwweBrxGzux2u80QeW+1FMbi/on/Goy5RkmX/
 3aj1yirH/e75PwBe/HD1+ircYnXPq3glsCRN1JimhIoFiLdx+oEkWm8nYPt9xe+aBwkP
 ZmFR3G1SJk9tgY5521XUdJMRYkcAsAB0BpsQggo9cmuLt5IpO4PRRbn3l9VmW5MlwSVI
 zxRp+GI8Fi5recBDWO6l9yR6M+uJiVCqmazJTsI9ieR9sXFCYyi0V1ceTeanP1L+ET/o
 ez1Ys0Ib1+TPt3I7G+aPTEe64EF08Avl9nZMmJ05M8YDswka3HpnuGr/t2BMs/F9VRrv 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3689aa83ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 01:50:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N1om5m133077;
        Sat, 23 Jan 2021 01:50:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3689u8s8m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 01:50:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10N1omZl133105;
        Sat, 23 Jan 2021 01:50:48 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 3689u8s8ga-1;
        Sat, 23 Jan 2021 01:50:48 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4_2: SSC helper should use its own config.
Date:   Fri, 22 Jan 2021 20:50:13 -0500
Message-Id: <20210123015013.34609-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230008
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently NFSv4_2 SSC helper, nfs_ssc, incorrectly uses GRACE_PERIOD
as its config. Fix by adding new config NFS_V4_2_SSC_HELPER which
depends on NFS_V4_2 and is automatically selected when NFSD_V4 is
enabled. Also removed the file name from a comment in nfs_ssc.c.

Fixes: 0cfcd405e758 (NFSv4.2: Fix NFS4ERR_STALE error when doing inter server copy)
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/Kconfig              |  3 +++
 fs/nfs/nfs4file.c       |  4 ++++
 fs/nfs/super.c          | 12 ++++++++++++
 fs/nfs_common/Makefile  |  2 +-
 fs/nfs_common/nfs_ssc.c |  2 --
 fs/nfsd/Kconfig         |  1 +
 6 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..d33a31239cbc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -333,6 +333,9 @@ config NFS_COMMON
 	depends on NFSD || NFS_FS || LOCKD
 	default y
 
+config NFS_V4_2_SSC_HELPER
+	tristate
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

