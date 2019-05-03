Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2032712D96
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfECMbF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 08:31:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37716 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECMbE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 08:31:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43CSpRt090514;
        Fri, 3 May 2019 12:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=LQOfycm9DiItzcIHSSXlEQsv0C/7q1jkf8LiDf+KKSw=;
 b=szdAWCo40rllidfOje6KZzgt9aqLLmaewED2KmA5ClWNGtY67BSOJHRypmwsE1+fSREO
 +VwI6/P6jjsr6HFRtwICfXnCHvWLPhnFbsdyIwHWIN+HDCrSI5ZF4SfHKpfGGIgOW+jC
 b1xLwb04Pe3/8tiA0gZM8WtfTYbtm/rD2GCRucc+BDIZdrIVAYKkGvOl3qUH5yN2OPp2
 1cJ2cwiCzAnveqIjU063nYjW9Ra+Xipia/D4/vodaODDoZyJTapKAoEKaj3I6KSGDwzw
 ZYSMqMztRGFTf4qOSdemWnTBEAj+20cEOcO4GoZI6fi1crtSRa1RaloqCesBYPYikyKQ Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s6xhypda8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:30:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43CSo3o058207;
        Fri, 3 May 2019 12:30:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s7rtc8qyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:30:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x43CUMbG009824;
        Fri, 3 May 2019 12:30:22 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 05:30:21 -0700
Date:   Fri, 3 May 2019 15:30:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        NeilBrown <neilb@suse.com>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix an error code in gss_alloc_msg()
Message-ID: <20190503123009.GC29695@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030078
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030079
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If kstrdup_const() then this function returns zero (success) but it
should return -ENOMEM.

Fixes: ac83228a7101 ("SUNRPC: Use namespace of listening daemon in the client AUTH_GSS upcall")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index b2cbc83d39c7..06fe17c2aea1 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -553,8 +553,10 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 	gss_msg->auth = gss_auth;
 	if (service_name) {
 		gss_msg->service_name = kstrdup_const(service_name, GFP_NOFS);
-		if (!gss_msg->service_name)
+		if (!gss_msg->service_name) {
+			err = -ENOMEM;
 			goto err_put_pipe_version;
+		}
 	}
 	return gss_msg;
 err_put_pipe_version:
-- 
2.18.0

