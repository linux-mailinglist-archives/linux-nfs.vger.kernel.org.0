Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF4365E8E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhDTR1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 13:27:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25700 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhDTR1d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 13:27:33 -0400
X-Greylist: delayed 984 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 13:27:33 EDT
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KGvIh7020093;
        Tue, 20 Apr 2021 17:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=cqumB+ebizYEGKxZwoDQZYSeXsw7LBtb99wk8Q+w1ws=;
 b=TdGAdTrjSeTXYReRQRIE/NrFvmpzaHzONWdKjwDHykyvcxbruZ7wJzqR8rbOtE6mByDr
 NHDNDTsN4SAP0QaxF5HjeaZjrFJJUrIK7aV+gRms0EXeRlkFSDkuO9ac294GVwnFrTh2
 GX8sylYUHi+ft7pn/ngEunrGY6TvC+IfF+X0KShQ1TdZESYLbrFHSA2G7IjqOjCfrVcI
 4vcYekxgUs6f4zOFltqmxxr3lvYTAkjQcmquLtm238+XrNygI+m4PC1PuBn3bC7i7XrN
 k+ZJtumcfpV9VsHXCKTbFohE/BD9a7Wxx9GD+Zz9XeAfYnifMJUXzsvcCDfPcN3jNsEZ 4w== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 381bjn8b8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:10:35 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13KH1PWS017499;
        Tue, 20 Apr 2021 17:10:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809esyrjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 17:10:34 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KHAYOG067984;
        Tue, 20 Apr 2021 17:10:34 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3809esyrj6-1;
        Tue, 20 Apr 2021 17:10:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: Remove ifdef CONFIG_NFSD_V4 from nfsV4.2 client SSC code.
Date:   Tue, 20 Apr 2021 13:10:26 -0400
Message-Id: <20210420171026.103588-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wh07OoPFdN1QLK2a8yPS71ksruH3vzst
X-Proofpoint-ORIG-GUID: wh07OoPFdN1QLK2a8yPS71ksruH3vzst
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The client SSC code should not depend on any of the CONFIG_NFSD config.
Replaced CONFIG_NFSD_V4 with CONFIG_NFS_V4_2_SSC_HELPER in nfs4file.c
and super.c. This patch also fixes the compiler warning of unused
variables when NFS_V4_2 is configured and NFSD_V4 is not.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 6 ++++--
 fs/nfs/super.c    | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa073c8..042668f06adc 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -313,6 +313,7 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	return ret < 0 ? ret : count;
 }
 
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 static int read_name_gen = 1;
 #define SSC_READ_NAME_BODY "ssc_read_%d"
 
@@ -411,6 +412,7 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
 	.sco_open = __nfs42_ssc_open,
 	.sco_close = __nfs42_ssc_close,
 };
+#endif	/* CONFIG_NFS_V4_2_SSC_HELPER */
 
 /**
  * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
@@ -420,7 +422,7 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
  */
 void nfs42_ssc_register_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
 #endif
 }
@@ -433,7 +435,7 @@ void nfs42_ssc_register_ops(void)
  */
 void nfs42_ssc_unregister_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
 #endif
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 94885c6f8f54..df17e0ddbc4d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -86,7 +86,7 @@ const struct super_operations nfs_sops = {
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
-#ifdef CONFIG_NFS_V4_2
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
 	.sco_sb_deactive = nfs_sb_deactive,
 };
@@ -116,14 +116,14 @@ static void unregister_nfs4_fs(void)
 #ifdef CONFIG_NFS_V4_2
 static void nfs_ssc_register_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
 #endif
 }
 
 static void nfs_ssc_unregister_ops(void)
 {
-#ifdef CONFIG_NFSD_V4
+#ifdef CONFIG_NFS_V4_2_SSC_HELPER
 	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
 #endif
 }
-- 
2.9.5

