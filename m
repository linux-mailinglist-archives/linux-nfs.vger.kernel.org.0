Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E195281EBD
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Oct 2020 00:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJBW6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 18:58:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45794 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBW6M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 18:58:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092Mt7eY102845;
        Fri, 2 Oct 2020 22:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=JRICbKDRaoYSHX4XHqe+lyNAgOdsjCTYOUlWJ8HpOwI=;
 b=qNIdqJbG1aM/4szjQmKOphuzLUbJ9alv2OJM6jUNVsmwppVnnnRPA/D7CM7DTE1xHI5O
 yFU9j9BZBakLL+EubmM/nSj1c264BBCuN4vg8G4MGDaEUmNG4TEANOLYJfGdSoSfTs/B
 kyndhkSrmwFwL+dSTLGix6+TnLoOvexgb6QsDu4G8gCLHW/5le98dc9hJ7LxDCzb3TMi
 ynAun5d+BcmoSGKlomuoqnWWRIYrBNpy5iML76dIlSPv2CCIvMyGFt9ofG1xwqD7EIZ9
 vZAMOsnTXjAYwCEeQDYBIBQh8MUrrmdXfuYL6dvOmkMu7i2r2fi+WGc8HZQl4Zq9Rvyb yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33wupg46ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 22:58:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092MttWb006074;
        Fri, 2 Oct 2020 22:58:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 33tfk476up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 22:58:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 092Mw5oP010493;
        Fri, 2 Oct 2020 22:58:05 GMT
Received: from cdmvmol7.uk.oracle.com (dhcp-10-175-199-221.vpn.oracle.com [10.175.199.221])
        by userp3030.oracle.com with ESMTP id 33tfk476s1-1;
        Fri, 02 Oct 2020 22:58:05 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] lockd: don't use timed rebind with TCP
Date:   Fri,  2 Oct 2020 23:57:50 +0100
Message-Id: <20201002225750.16452-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020175
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is possible for nlm_bind_host() to clear XPRT_BOUND whilst a connection
worker is in the middle of trying to reconnect. When the latter notices
that XPRT_BOUND been cleared under it, in xs_tcp_finish_connecting(),
that results in:

	xs_tcp_setup_socket: connect returned unhandled error -107

Worse, it's possible that the two can get into lockstep, resulting in
the same behaviour repeated indefinitely, with the above error every
300 seconds, without ever recovering, and the connection never being
established. This is most likely to occur when there's a large number
of NLM client tasks following a server reboot.

Since the timed rebind would seem not to be needed for TCP in any case,
whilst the existing connection remains, restrict the timed rebinding to
UDP only.

For TCP, we will still rebind when needed, e.g. on timeout, connection
error (including closure), and in the reclaimer.

Whilst there, refactor some duplicate code.

Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---
 fs/lockd/host.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 0afb6d59bad0..6e98c2ed6ffc 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -439,12 +439,7 @@ nlm_bind_host(struct nlm_host *host)
 	 * RPC rebind is required
 	 */
 	if ((clnt = host->h_rpcclnt) != NULL) {
-		if (time_after_eq(jiffies, host->h_nextrebind)) {
-			rpc_force_rebind(clnt);
-			host->h_nextrebind = jiffies + NLM_HOST_REBIND;
-			dprintk("lockd: next rebind in %lu jiffies\n",
-					host->h_nextrebind - jiffies);
-		}
+		nlm_rebind_host(host);
 	} else {
 		unsigned long increment = nlmsvc_timeout;
 		struct rpc_timeout timeparms = {
@@ -495,15 +490,18 @@ nlm_bind_host(struct nlm_host *host)
 }
 
 /*
- * Force a portmap lookup of the remote lockd port
+ * Force a portmap lookup of the remote lockd port, unless we're using a
+ * TCP connection.
  */
 void
 nlm_rebind_host(struct nlm_host *host)
 {
-	dprintk("lockd: rebind host %s\n", host->h_name);
-	if (host->h_rpcclnt && time_after_eq(jiffies, host->h_nextrebind)) {
+	if (unlikely(host->h_proto == IPPROTO_UDP) && host->h_rpcclnt &&
+			time_after_eq(jiffies, host->h_nextrebind)) {
 		rpc_force_rebind(host->h_rpcclnt);
 		host->h_nextrebind = jiffies + NLM_HOST_REBIND;
+		dprintk("lockd: rebind host %s; next rebind in %lu jiffies\n",
+			host->h_name, host->h_nextrebind - jiffies);
 	}
 }
 
-- 
2.18.4

