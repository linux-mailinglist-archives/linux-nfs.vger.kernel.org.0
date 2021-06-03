Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9339A137
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFCMj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 08:39:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46748 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFCMjz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 08:39:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153CUD8a019036;
        Thu, 3 Jun 2021 12:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=PmquORlyAk6Xmrcol2gQbQQUZjJgXb6Pli6NxRXZqkc=;
 b=qYBWT/9Z6luoBh1ApuTW8xzVH+/iWCCbqL1oO4sqWRgQQ7AaeOQVenWjiFEx+iLsBGKc
 ai0jGCDq0zPgN1nBM/TkUmxZNpO2gWzusGp+bl/7k/k2h1aNIFVTwh0+Eq/mMzAhAf1+
 WYoU/2F7s/97OnB5e9P19YTS/fjEmELHk+T4g0u1aZDGaIf7mAp+kD3RLxvChz6k/HUN
 +Hj7/k+YNtAdqOH3wUuTm7/0+JxTq2ECi+7Do+FV3nzhOMOVTJPN9DBKf7jOR+tsbM5g
 YG9VTUI4eLcuDREMbQz/iBgmdsnGrbkiz0BdjVwM4CaMAAkY50l/fo1z+zeTJ3XWamEL AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ud1sk7an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 12:38:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153CVmkO114713;
        Thu, 3 Jun 2021 12:38:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38udeew4tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 12:38:04 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 153Cc3vG156750;
        Thu, 3 Jun 2021 12:38:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38udeew4sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 12:38:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 153Cbx5V003958;
        Thu, 3 Jun 2021 12:37:59 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jun 2021 05:37:59 -0700
Date:   Thu, 3 Jun 2021 15:37:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Peng Tao <tao.peng@primarydata.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] NFS: Fix a potential NULL dereference in nfs_get_client()
Message-ID: <YLjNITBTTCCiik/+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: GVI-kGKw2pK4jFWW9jfR0WOXN2NqXMSJ
X-Proofpoint-GUID: GVI-kGKw2pK4jFWW9jfR0WOXN2NqXMSJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030085
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

None of the callers are expecting NULL returns from nfs_get_client() so
this code will lead to an Oops.  It's better to return an error
pointer.  I expect that this is dead code so hopefully no one is
affected.

Fixes: 31434f496abb ("nfs: check hostname in nfs_get_client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/nfs/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index cfeaadf56bf0..330f65727c45 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -406,7 +406,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 
 	if (cl_init->hostname == NULL) {
 		WARN_ON(1);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* see if the client already exists */
-- 
2.30.2

