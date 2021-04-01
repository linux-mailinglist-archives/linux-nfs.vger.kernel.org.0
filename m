Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78335233D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhDAXNO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 19:13:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55050 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDAXNO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 19:13:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N8uJm135133;
        Thu, 1 Apr 2021 23:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8juw05n9USKVXWHoj4+6Hm2JGOgeBvMKxjqyvoiMRzg=;
 b=GXv5bCDD7RFUBoiNhjet/W0XhJts2bS1Edwh+cdLmgKLCKpzHOzKsGvaa5y7p2+f2tyX
 gmg/d085JC/qdnioPti32vT8XiP68sCteFKnSk6erdzivcsYsANrTU5UX8jnOQjOksKS
 QTnfApaqpQZpreCzMIM5G1pXy13qgt377R+EoHmnGiwzehW7lWkzkXAOZWDOsQAOAOhG
 XQw9M21IR0T7y5myNHTi2DrRXUxbqo4Ky0t7GvI+PNJ/zvPooRg42zLpjbEiTUsppE59
 2Og6iYmYN8XAD+nI/zkYUT4WJ6aqGb+l/ZGbAkGEBmJEs1ell4FHfQjD6re1/YAzlfe1 GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dub4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N9b9O119153;
        Thu, 1 Apr 2021 23:13:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 37n2ate1vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:04 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 131ND15G130727;
        Thu, 1 Apr 2021 23:13:03 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 37n2ate1u4-3;
        Thu, 01 Apr 2021 23:13:03 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH 2/2] NFSv4.2: mount overhead should not be used as threshold for inter-server copy
Date:   Thu,  1 Apr 2021 19:12:58 -0400
Message-Id: <20210401231258.63292-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210401231258.63292-1-dai.ngo@oracle.com>
References: <20210401231258.63292-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nzof5K0h-JFTQORimzU5cJPy3F6wEKLH
X-Proofpoint-ORIG-GUID: Nzof5K0h-JFTQORimzU5cJPy3F6wEKLH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010149
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since mount and unmount are not done on each copy request, its overhead
should not be considered as the threshold for doing inter-server copy.
The threshold used to determine sync or async copy is also used to decide
whether copy is done with inter-server copy or generic copy.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa073c8..67ca798a1a79 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -158,13 +158,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		sync = true;
 retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
-		/* for inter copy, if copy size if smaller than 12 RPC
-		 * payloads, fallback to traditional copy. There are
-		 * 14 RPCs during an NFSv4.x mount between source/dest
-		 * servers.
+		/*
+		 * for inter copy, if copy size is small enough
+		 * for sync copy then fallback to traditional copy.
 		 */
-		if (sync ||
-			count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
+		if (sync)
 			return -EOPNOTSUPP;
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
-- 
2.9.5

