Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA283367B3B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhDVHio (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 03:38:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52526 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhDVHio (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 03:38:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M7V2MI021188;
        Thu, 22 Apr 2021 07:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=0QvYlo7f8WPbcu0X5P4HfLZlHfvUGyuCgNmfZe3w8iQ=;
 b=PFYq1yu3XNg1WBIdgEekHwVZEuFyIGABPp7Fy6Pk6kifR9fjIoUDSUpX4WQhyKvBxWoq
 dHuS7PXM57XdtwqUHLJ1pTeckrz56x0JOlM3tlb6SGIROXwoI1/OEQp7DYc8v66rbv4v
 pom3DxcXHw1AVpmPyk85gSQA7s3tEwfVP5juTlkqsPSPbKHDhpvNXoOGWRlpErm+ZRRc
 wrjKctBx56inVKIbrO6NKlwiSOpCafrzWMIaLk8K2jXtqt+Iv2N9rb1Gyv+05YHj8ZI+
 QnNLkR0IV0Wq5FZarNyJeqRgIhp0jj8mlVGBOA3vZmfP9IcM60v/aWlZf+O5+fbrHvb3 +Q== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 382yqs83je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 07:38:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13M7aNPE071323;
        Thu, 22 Apr 2021 07:38:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m1tmg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 07:38:05 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M7c50T076550;
        Thu, 22 Apr 2021 07:38:05 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3809m1tmfs-1;
        Thu, 22 Apr 2021 07:38:05 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4.2: Remove ifdef CONFIG_NFSD from NFSv4.2 client SSC code.
Date:   Thu, 22 Apr 2021 03:37:49 -0400
Message-Id: <20210422073749.33099-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zRu9aPztA4WERfoRnEFTLvA12KweqgQm
X-Proofpoint-GUID: zRu9aPztA4WERfoRnEFTLvA12KweqgQm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The client SSC code should not depend on any of the CONFIG_NFSD config.
This patch removes all CONFIG_NFSD from NFSv4.2 client SSC code and
simplifies the config of CONFIG_NFS_V4_2_SSC_HELPER, NFSD_V4_2_INTER_SSC.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/Kconfig        | 4 ++--
 fs/nfs/nfs4file.c | 4 ----
 fs/nfs/super.c    | 4 ----
 fs/nfsd/Kconfig   | 2 +-
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a55bda4233bb..afa585e62332 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -334,8 +334,8 @@ config NFS_COMMON
 	default y
 
 config NFS_V4_2_SSC_HELPER
-	tristate
-	default y if NFS_V4=y || NFS_FS=y
+	bool
+	default y if NFS_V4_2
 
 source "net/sunrpc/Kconfig"
 source "fs/ceph/Kconfig"
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa073c8..57b3821d975a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -420,9 +420,7 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
  */
 void nfs42_ssc_register_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
 	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
-#endif
 }
 
 /**
@@ -433,9 +431,7 @@ void nfs42_ssc_register_ops(void)
  */
 void nfs42_ssc_unregister_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
 	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
-#endif
 }
 #endif /* CONFIG_NFS_V4_2 */
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 94885c6f8f54..e2e51bb24889 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -116,16 +116,12 @@ static void unregister_nfs4_fs(void)
 #ifdef CONFIG_NFS_V4_2
 static void nfs_ssc_register_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
 	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
-#endif
 }
 
 static void nfs_ssc_unregister_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
 	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
-#endif
 }
 #endif /* CONFIG_NFS_V4_2 */
 
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index d6cff5fbe705..c5346196c46f 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -138,7 +138,7 @@ config NFSD_FLEXFILELAYOUT
 
 config NFSD_V4_2_INTER_SSC
 	bool "NFSv4.2 inter server to server COPY"
-	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
+	depends on NFSD_V4 && NFS_V4_2
 	help
 	  This option enables support for NFSv4.2 inter server to
 	  server copy where the destination server calls the NFSv4.2
-- 
2.9.5

