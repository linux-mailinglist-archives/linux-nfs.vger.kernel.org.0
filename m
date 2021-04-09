Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBF35A547
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhDISII (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 14:08:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38852 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhDISIG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 14:08:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139I5BPX156859;
        Fri, 9 Apr 2021 18:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=xRYlUHy1mm9ESga+nBKyhEMMI/M+74ro8K8YpmsUTcA=;
 b=U2crDP/KRmAQ6Y9SGnhqWCbA6gHdN4AYgQxQ9n1tUmAzHCoFqTCzeD3kCkO13/O3fk84
 3pVeH0iIaBF4cafvsWCE8rczgqF0IAxGO661pEmGzn7zq6YgyqvR+3meOxagE0Ibc0xi
 jy6aLRJS2NuyhnwrE43hXZUoQPitrAkQpcCRHgwRICaRVFB6IdJQclbX8JTxFx3AGnr5
 TiHawq7OCj092TVC/oEJCigP4TGtcQU+R0ATwBuNwyykZNI0fp8RXBk8NzMAo3ah4zf+
 yVo04i0ilP98j+7j0QoUR9frUUGwk410HKyPrV6zdzHPg25aXZwPA0UClm1M6gn6V3Sz Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37rvawa9j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 18:07:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139I6Eqs029130;
        Fri, 9 Apr 2021 18:07:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 37rvbhvumn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 18:07:46 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 139I7iZw033412;
        Fri, 9 Apr 2021 18:07:45 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 37rvbhvuku-3;
        Fri, 09 Apr 2021 18:07:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH v3 2/2] NFSv4.2: threshold for inter-server copy should be configurable.
Date:   Fri,  9 Apr 2021 14:05:19 -0400
Message-Id: <20210409180519.25405-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210409180519.25405-1-dai.ngo@oracle.com>
References: <20210409180519.25405-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3WEBM_l-ogRjSn0z2dGCOlD_cS164rbE
X-Proofpoint-GUID: 3WEBM_l-ogRjSn0z2dGCOlD_cS164rbE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replacing threshold computed in __nfs4_copy_file_range with a
module configuration parameter, default to 16MB. This provides
the user the option to configure the threshold to suite each
specific configuration.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs42.h    |  2 ++
 fs/nfs/nfs4file.c | 16 ++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aac..6aecd05 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -60,5 +60,7 @@ static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
 {
 	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
 }
+
+extern unsigned int nfs4_ssc_inter_server_min_size;
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa..57d6d13 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -20,6 +20,12 @@
 
 #ifdef CONFIG_NFS_V4_2
 #include "nfs42.h"
+
+unsigned int nfs4_ssc_inter_server_min_size = (1024*1024*16);
+EXPORT_SYMBOL_GPL(nfs4_ssc_inter_server_min_size);
+module_param(nfs4_ssc_inter_server_min_size, uint, 0644);
+MODULE_PARM_DESC(nfs4_ssc_inter_server_min_size,
+			"threshold to do inter-server copy");
 #endif
 
 #define NFSDBG_FACILITY		NFSDBG_FILE
@@ -158,13 +164,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		sync = true;
 retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
-		/* for inter copy, if copy size if smaller than 12 RPC
-		 * payloads, fallback to traditional copy. There are
-		 * 14 RPCs during an NFSv4.x mount between source/dest
-		 * servers.
+		/*
+		 * for inter copy, if copy size is too small
+		 * then fallback to generic copy.
 		 */
-		if (sync ||
-			count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
+		if (sync || count <= nfs4_ssc_inter_server_min_size)
 			return -EOPNOTSUPP;
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
-- 
1.8.3.1

