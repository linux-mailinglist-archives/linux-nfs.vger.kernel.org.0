Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639FE353184
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Apr 2021 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhDBXao (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 19:30:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhDBXan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Apr 2021 19:30:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NUaE3004034;
        Fri, 2 Apr 2021 23:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8juw05n9USKVXWHoj4+6Hm2JGOgeBvMKxjqyvoiMRzg=;
 b=B69vCrDUxdDxMefm5Anzly4eLyzNQUxxPJIiM9whAJxmU4YkL2rgiYLL6adfWWnHHBui
 UPlks9c3vSw4NNgN89Us8myG5NA7ZZpkXEh/wFTW+LlzeRwHM/+Db+dBiiuozvzslrKA
 wRJTJ677G8M2LPb6MQA/Yo1cOltYU6cil8/dDmFIczL6AepuAk3X+pan3tlGqn5fhc2y
 AlOkzB1SAJ/ndvpvzujZAiNafk+qZDZoReUMBY0IePfJwbeEtKHpr+deV4HQ7la4dtOA
 DmGeCNVtFJlms0FtjsEdZA5iCsZjBbOG25YhmwXve49C7Iu3IBGcDNJs/lSOY1r7vB8A aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37n2aknrgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:30:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NP4L8033715;
        Fri, 2 Apr 2021 23:30:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 37n2acxbt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:30:36 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 132NPvWM035088;
        Fri, 2 Apr 2021 23:30:36 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 37n2acxbsh-3;
        Fri, 02 Apr 2021 23:30:35 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH v2 2/2] NFSv4.2: mount overhead should not be used as threshold for inter-server copy
Date:   Fri,  2 Apr 2021 19:30:31 -0400
Message-Id: <20210402233031.36731-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210402233031.36731-1-dai.ngo@oracle.com>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _wOxAX_Qykqu9oRlGmBkttmO2NDfBF5p
X-Proofpoint-GUID: _wOxAX_Qykqu9oRlGmBkttmO2NDfBF5p
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020158
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

