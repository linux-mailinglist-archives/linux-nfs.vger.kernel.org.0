Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B439AEF6
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 02:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFDAEX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 20:04:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAEX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 20:04:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15400eH6114644;
        Fri, 4 Jun 2021 00:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=1kGe2AqyfLTFFsrAplTHbEs42mQbkF3C1Kzg+CotD94=;
 b=k3E14FZGkf5kMN2rBcIl0CCcS3iD2rhw473zwC3iZU0qLLHd9SEuNAcWzQi7fHrtA9jC
 iJkuDy1I+O0ddFChNU3K4RTwPYRPVJy5gpJ2W+KyFe0OQsahVC7TpG6GOLuc8IZGYNXW
 dRF911kANFQn1nOUZQgYKJiMPrwiwft6Q3zR2TZCJhCFtPJw6U5aNzDKheMTRc5s44rh
 fgM9co0BBwaoDeloJMTuyePyq1D2sP1jj3RM2kEOXcCR7O2GFLv4XwMgS2LDrkX39C3N
 CwHeBBRYi8z/vrBQ0yhUZ1BtMUp1YVAOihPUJvDrNuka2y1wKVVlEXWdqZFALLyUtTTz QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pmmvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 00:02:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15400kd2042567;
        Fri, 4 Jun 2021 00:02:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38x1bebwb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 00:02:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15402T71045227;
        Fri, 4 Jun 2021 00:02:29 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 38x1bebwag-1;
        Fri, 04 Jun 2021 00:02:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsd: fix kernel test robot warning in SSC code
Date:   Thu,  3 Jun 2021 20:02:26 -0400
Message-Id: <20210604000226.113634-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U36FugLj1hklJOBILVLxTvviIbBhSjmt
X-Proofpoint-ORIG-GUID: U36FugLj1hklJOBILVLxTvviIbBhSjmt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030158
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix by initializing pointer nfsd4_ssc_umount_item with NULL instead of 0.
Replace return value of nfsd4_ssc_setup_dul with __be32 instead of int.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 4 ++--
 fs/nfsd/nfs4state.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bc373e5a6014..7594d9054c6a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1175,7 +1175,7 @@ extern void nfs_sb_deactive(struct super_block *sb);
 /*
  * setup a work entry in the ssc delayed unmount list.
  */
-static int nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
+static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
 {
 	struct nfsd4_ssc_umount_item *ni = 0;
@@ -1399,7 +1399,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 	bool found = false;
 	long timeout;
 	struct nfsd4_ssc_umount_item *tmp;
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
 
 	nfs42_ssc_close(src->nf_file);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2484b59a3c29..cac149376649 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5473,7 +5473,7 @@ EXPORT_SYMBOL_GPL(nfsd4_ssc_init_umount_work);
  */
 static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
 {
-	struct nfsd4_ssc_umount_item *ni = 0;
+	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd4_ssc_umount_item *tmp;
 
 	spin_lock(&nn->nfsd_ssc_lock);
-- 
2.9.5

