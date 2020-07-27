Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B315122EB24
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jul 2020 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG0LYE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jul 2020 07:24:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0LYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jul 2020 07:24:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBM4Ch140691;
        Mon, 27 Jul 2020 11:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zhOel54M7SOIatcYENSCxB3GX1D0nU6zd3vC3xTJntc=;
 b=IMKQ+SiikUuZ09rRmslCmDsIpn8V9wZdg428KnZfoHmKK6Z0hPhrk5U55nx9a6oSMJ1A
 CGWe7cW2u/rU9IfwiHn9K+fxHNCh8c1GySJ+V4ygZZ+Sz3zXibPQf8lsev+7PzHh/SD2
 nVe3Nph5+f+mioh7fYwJt4zDoVfid/m6x1mh1HOpJPngZXVPKHBXOoxCW5SYrNE7UOIN
 gSdpcfqO04/uqzVUn7SFNbAa3zsxoCHNlchQ+5Cda2pRAfK7kC8MlLtogYrJ5L/CE06M
 YOnoQoEtR8VtxJiD7CGgCmGokPVir+TqR6p9VEwSIOM0ixCP9VVmFjWUMS5wGZqkwCsG uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32hu1j8xw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 11:23:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBEOdK109079;
        Mon, 27 Jul 2020 11:23:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32hu5qdt16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 11:23:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RBNpa1016399;
        Mon, 27 Jul 2020 11:23:51 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 04:23:51 -0700
Date:   Mon, 27 Jul 2020 14:23:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Frank van der Linden <fllinden@amazon.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Message-ID: <20200727112344.GH389488@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270084
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This should return -ENOMEM on failure instead of success.

Fixes: 95ad37f90c33 ("NFSv4.2: add client side xattr caching.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
---
 fs/nfs/nfs42xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 23fdab977a2a..e75c4bb70266 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -1040,8 +1040,10 @@ int __init nfs4_xattr_cache_init(void)
 		goto out2;
 
 	nfs4_xattr_cache_wq = alloc_workqueue("nfs4_xattr", WQ_MEM_RECLAIM, 0);
-	if (nfs4_xattr_cache_wq == NULL)
+	if (nfs4_xattr_cache_wq == NULL) {
+		ret = -ENOMEM;
 		goto out1;
+	}
 
 	ret = register_shrinker(&nfs4_xattr_cache_shrinker);
 	if (ret)
-- 
2.27.0

