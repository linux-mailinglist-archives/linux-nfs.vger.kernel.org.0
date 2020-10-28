Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADF729DCB9
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 01:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgJ2Abw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 20:31:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgJ2Abv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Oct 2020 20:31:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SKF8q9117431;
        Wed, 28 Oct 2020 20:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=KHS2bOkZkPvUFmHYXxnAj/cdE3emseY+aycgGjpeOk8=;
 b=tDf73eehTbUIRPCCgM7jjUAYNaoeP3Qu/JXBF2uax2jqFL2rYxX5ncGOgMSbzfuNpU64
 KBXrjFt9fKLUbxxwIJNFQL/p1JZok9tS4JvV6oL909qJYjyL05oC7IV8mu0e8SU+P8Dn
 Sj8jQ62t7+EmKdJbeZkjqDatgQNtbRrSo2TKpxTRMdSawTuwA0wLd3VzJ6yOEzTTMMB2
 Q6SFtMxDS2STaAZ+f/QffnrLN2f2ngYmhDuJHtBg0y9XRttDsvcT72IjAkJw3pHuJbfd
 03NkyYd4FKGzrl2q2teVkR3aeUklklKf33hvNlvl7jo7e0AGbo8uTF5dQaS3VKKHTAYd jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34cc7m1jww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 20:16:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SKFOI6010258;
        Wed, 28 Oct 2020 20:16:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 34cx6xp1yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 20:16:58 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09SKGvMn014783;
        Wed, 28 Oct 2020 20:16:57 GMT
Received: from cdmvmol7.uk.oracle.com (dhcp-10-175-181-89.vpn.oracle.com [10.175.181.89])
        by userp3030.oracle.com with ESMTP id 34cx6xp1wy-1;
        Wed, 28 Oct 2020 20:16:57 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] lockd: don't use interval-based rebinding over TCP
Date:   Wed, 28 Oct 2020 20:16:27 +0000
Message-Id: <20201028201627.23625-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NLM uses an interval-based rebinding, i.e. it clears the transport's
binding under certain conditions if more than 60 seconds have elapsed
since the connection was last bound.

This rebinding is not necessary for an autobind RPC client over a
connection-oriented protocol like TCP.

It can also cause problems: it is possible for nlm_bind_host() to clear
XPRT_BOUND whilst a connection worker is in the middle of trying to
reconnect, after it had already been checked in xprt_connect().

When the connection worker notices that XPRT_BOUND has been cleared
under it, in xs_tcp_finish_connecting(), that results in:

	xs_tcp_setup_socket: connect returned unhandled error -107

Worse, it's possible that the two can get into lockstep, resulting in
the same behaviour repeated indefinitely, with the above error every
300 seconds, without ever recovering, and the connection never being
established. This has been seen in practice, with a large number of NLM
client tasks, following a server restart.

The existing callers of nlm_bind_host & nlm_rebind_host should not need
to force the rebind, for TCP, so restrict the interval-based rebinding
to UDP only.

For TCP, we will still rebind when needed, e.g. on timeout, and connection
error (including closure), since connection-related errors on an existing
connection, ECONNREFUSED when trying to connect, and rpc_check_timeout(),
already unconditionally clear XPRT_BOUND.

To avoid having to add the fix, and explanation, to both nlm_bind_host()
and nlm_rebind_host(), remove the duplicate code from the former, and
have it call the latter.

Drop the dprintk, which adds no value over a trace.

Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---
 fs/lockd/host.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 0afb6d59bad0..771c289f6df7 100644
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
@@ -494,13 +489,20 @@ nlm_bind_host(struct nlm_host *host)
 	return clnt;
 }
 
-/*
- * Force a portmap lookup of the remote lockd port
+/**
+ * nlm_rebind_host - If needed, force a portmap lookup of the peer's lockd port
+ * @host: NLM host handle for peer
+ *
+ * This is not needed when using a connection-oriented protocol, such as TCP.
+ * The existing autobind mechanism is sufficient to force a rebind when
+ * required, e.g. on connection state transitions.
  */
 void
 nlm_rebind_host(struct nlm_host *host)
 {
-	dprintk("lockd: rebind host %s\n", host->h_name);
+	if (host->h_proto != IPPROTO_UDP)
+		return;
+
 	if (host->h_rpcclnt && time_after_eq(jiffies, host->h_nextrebind)) {
 		rpc_force_rebind(host->h_rpcclnt);
 		host->h_nextrebind = jiffies + NLM_HOST_REBIND;
-- 
2.18.4

