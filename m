Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A32364D5E
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhDSVzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 17:55:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbhDSVzO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Apr 2021 17:55:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JLooHO017792;
        Mon, 19 Apr 2021 21:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MUhiQehgPHFn4wyBqIE4i2Tq20SxhxAu2f3W3rTtUBM=;
 b=DxmuLyIDoTMt/V7QbhhbgIkk+oNttpHZkp3yVKpkQ9dI9PqydSIfg8DR+AUMIgBIvIMQ
 APsM2zdX7SDcpVlQDS+1Gx8djoGzGOOBKNXN1rsVPUOm58mH68wqh1uxQw0VqNJHtC+l
 /1szqIO5JKM9/3dAi79mRaLw/vEcVqHYarIpoJKOS5+CcJHe1/113bTCIjhC1NScS/NF
 oruCGqtgCW4WkSsfC5rh5/SmrkFRpbfB0uyss9cteeBVHAbUj9nbBR6NzZySseNGqSlg
 wrd3FBId3ElGQ5NYdwJ1Bnrre7mvaUcFjJjI5XC5Y5DtIxXEavL2+zl+i43TWdOWmVEV 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37yveacw80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 21:54:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JLo52Q192439;
        Mon, 19 Apr 2021 21:54:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3809jydvar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 21:54:34 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13JLo4tv192235;
        Mon, 19 Apr 2021 21:54:33 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3809jydva8-1;
        Mon, 19 Apr 2021 21:54:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     olga.kornievskaia@gmail.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: Fix warning unused SSC variables from kernel test robot.
Date:   Mon, 19 Apr 2021 17:54:27 -0400
Message-Id: <20210419215427.76404-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vvoY8y1t3MVcjI4r2L52yGbXOTHnGUGl
X-Proofpoint-ORIG-GUID: vvoY8y1t3MVcjI4r2L52yGbXOTHnGUGl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Compiler warning unused variables when NFS_V4_2 is configured and
NFSD_V4 is not:

fs/nfs/super.c:90:40: warning: unused variable 'nfs_ssc_clnt_ops_tbl'
static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {

fs/nfs/nfs4file.c:410:41: warning: unused variable 'nfs4_ssc_clnt_ops_tbl'
static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {

Fix by moving nfs_ssc_clnt_ops_tbl and nfs4_ssc_clnt_ops_tbl to
under NFSD_V4 since they are only used when NFSD_V4 is configured.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 2 ++
 fs/nfs/super.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa073c8..400c8db05808 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -313,6 +313,7 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	return ret < 0 ? ret : count;
 }
 
+#ifdef CONFIG_NFSD_V4
 static int read_name_gen = 1;
 #define SSC_READ_NAME_BODY "ssc_read_%d"
 
@@ -411,6 +412,7 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
 	.sco_open = __nfs42_ssc_open,
 	.sco_close = __nfs42_ssc_close,
 };
+#endif	/* CONFIG_NFSD_V4 */
 
 /**
  * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 94885c6f8f54..a7af01bad344 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -86,7 +86,7 @@ const struct super_operations nfs_sops = {
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
-#ifdef CONFIG_NFS_V4_2
+#ifdef CONFIG_NFSD_V4
 static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
 	.sco_sb_deactive = nfs_sb_deactive,
 };
-- 
2.9.5

