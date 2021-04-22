Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562A367D80
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhDVJPd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 05:15:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52506 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhDVJPc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 05:15:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9EuEM031163;
        Thu, 22 Apr 2021 09:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xntS/55EiFbzdDwmFm4R7C34nQeasl3GgUIT3Rw89U4=;
 b=vKjMjChvNhTsOIel7KExaIwQHQNK6Cf5huUh26zm9at/S9+9EzyCFjS15jwcSJzxJ0bn
 eLLpyKqQjsbv6vJmXipJjKndw6eznVU8z/m8B3yeMM5i2WObG8AGulbSLNehJfTM96Ml
 yDzjJYdxQ1CcNo1e/7V9MsKfXDLWSfOl0NjfI9yOu24Rp9J27DWXjAyBqpbntmAbZcPu
 eeceEXDJPqrXM3zT2xOVi6yY2ZWDv//+3s6dUmF5yk9TyXv+MvgXBd6+klzztok/scH1
 4iDBZpvlAK2au0hC5nDqbqRBBVd2bNI5OqoBD9l85UlNZpJKJqVNHf2+WSGXAKproRzM QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37yqmnmsje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:14:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9A3qd001482;
        Thu, 22 Apr 2021 09:14:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809evkb4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:14:50 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M9D0qo013728;
        Thu, 22 Apr 2021 09:14:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3809evkb48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:14:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13M9EjKJ031593;
        Thu, 22 Apr 2021 09:14:45 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 02:14:44 -0700
Date:   Thu, 22 Apr 2021 12:14:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] SUNRPC: fix ternary sign expansion bug in tracing
Message-ID: <YIE+fTOOnC9PLXbg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: VnexRzdtOA0_n3_q8V25vGRfYbFlM_GC
X-Proofpoint-GUID: VnexRzdtOA0_n3_q8V25vGRfYbFlM_GC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220078
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This code is supposed to pass negative "err" values for tracing but it
passes positive values instead.  The problem is that the
trace_svcsock_tcp_send() function takes a long but "err" is an int and
"sent" is a u32.  The negative is first type promoted to u32 so it
becomes a high positive then it is promoted to long and it stays
positive.

Fix this by casting "err" directly to long.

Fixes: 998024dee197 ("SUNRPC: Add more svcsock tracepoints")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/sunrpc/svcsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9eb5b6b89077..478f857cdaed 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1174,7 +1174,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	tcp_sock_set_cork(svsk->sk_sk, true);
 	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
 	xdr_free_bvec(xdr);
-	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
+	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
 	if (atomic_dec_and_test(&svsk->sk_sendqlen))
-- 
2.30.2

