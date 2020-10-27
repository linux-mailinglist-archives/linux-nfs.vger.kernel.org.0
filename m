Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9229B086
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509227AbgJ0OUd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 10:20:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34538 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758596AbgJ0OUT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 10:20:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09REFU92044911;
        Tue, 27 Oct 2020 14:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=DAQgQ08j/OaIwGQgAEOJBZdGf7wUU1XY8J9kawgRTzQ=;
 b=jSWx2kyMBsqQJIZTetmJlCucevuZ7wYg1QOWHjOK7vmyK/P6gryChn8QegkBx5BDawiQ
 Dizg242bl3R6cPj2Mr6MQ3bpQ7TS7VHCUEU3/xsPkJdVhwEZcdkGeE0Q72qZYdjuywFU
 NbzpHfe39rVerc0KkzFQuNQaE7RDg101KshqhbnUbettzeaCWMPeVbH6oe6qa1d+/g7s
 qrYKvctivo5PdORPPsgm7BHano5siopeoFbfwAlf33++yW3oUuz8/MLW1UZ/miQYdj+K
 tgSgCLryWNlMv1d+sK6xMfypd2qQT73Doblax7mzO0uLOgn/SXs+eRcB+aPOGhbSpRrI Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9satcka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 14:20:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09REFRTx145068;
        Tue, 27 Oct 2020 14:18:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34cx6w17we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 14:18:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09REI59H029549;
        Tue, 27 Oct 2020 14:18:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 07:18:05 -0700
Date:   Tue, 27 Oct 2020 17:17:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Artur Molchanov <arturmolchanov@gmail.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] net/sunrpc: clean up error checking in proc_do_xprt()
Message-ID: <20201027141758.GA3488087@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031F93AC-744F-4E02-9948-1C1F5939714B@gmail.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270090
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are three changes but none of them should affect run time:

1)  You can't write to this file because the permissions are 0444.  But
    it sort of looked like you could do a write and it would result in
    a read.  Then it looked like proc_sys_call_handler() just ignored
    it.  Which is confusing.  It's more clear if the "write" just
    returns zero.
2)  The "lenp" pointer is never NULL so that check can be removed.
3)  In the original code, the "if (*lenp < 0)" check didn't work because
    "*lenp" is unsigned.  Fortunately, the memory_read_from_buffer()
    call will never fail in this context so it doesn't affect runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/sunrpc/sysctl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index a18b36b5422d..04526bab4a06 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -63,19 +63,19 @@ static int proc_do_xprt(struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char tmpbuf[256];
-	size_t len;
+	ssize_t len;
 
-	if ((*ppos && !write) || !*lenp) {
-		*lenp = 0;
+	*lenp = 0;
+
+	if (write || *ppos)
 		return 0;
-	}
+
 	len = svc_print_xprts(tmpbuf, sizeof(tmpbuf));
-	*lenp = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
+	len = memory_read_from_buffer(buffer, *lenp, ppos, tmpbuf, len);
+	if (len < 0)
+		return len;
 
-	if (*lenp < 0) {
-		*lenp = 0;
-		return -EINVAL;
-	}
+	*lenp = len;
 	return 0;
 }
 
-- 
2.28.0

