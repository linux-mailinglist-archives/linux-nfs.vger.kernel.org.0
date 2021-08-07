Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF55E3E3669
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Aug 2021 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhHGRCo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Aug 2021 13:02:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhHGRCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Aug 2021 13:02:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 177GvBBJ019803;
        Sat, 7 Aug 2021 17:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=lD7Vy3fwcNW2kaO0g+wl5q+PArkTyqE8TRdogbgSYrg=;
 b=RkL2QqG8d4UEnk3s3s4I7x6gF2VQvoOasMavy9m2L03SZ5y6wwaGExDorvKdeUMMypfQ
 JMFz61dgsODyHs0baH8/zfEPrfzgWfApi5ZH2RdKBTrAtRJHB7v3RSpDkHhOyznV02mK
 pStWSeiKuF8Mrlo1xxS6sD+LMSLtMAnnMqlL85GPRb0gMuyPH/sN/Ibf9N2MMSF7EsMP
 D5GKl42pt07NTNm7zLZZCPatEwtIMCIcxjUPxPeeNsNBIg4kn/7PR70xaVv+aYRfGyOp
 0YaiAwS1clqShEH3QNcWlzSLQkPC1wadXQIV3eJvdCJi5kA7rUDL/3rpqiIQtYanjmxb nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=lD7Vy3fwcNW2kaO0g+wl5q+PArkTyqE8TRdogbgSYrg=;
 b=WNl6RcRKNkVHzEjdrvhHGcYgbYC259Gxcke8UHPaHZ0b0XORymxV/xE2FMCYm2uAgTb4
 QqcK4rrP3Pt6vKWybLlOqwfbNnQ2QMAryA8AMK6BM7mTJecMdwwJfyl35wLOlkVNdB8M
 e2k2CsjiU7fxosQhqkIVA3+SH3MKwJiGHMPAIKQLHfW3Q7TNzTdWZyZzult9tvZhRs4+
 r0LOxW8lPHBwKmtsCIErIyDJEya0VkynXSX0+9jRNa+u1wDPGVghKyE91fQXTMr4NQ0g
 5/iVrOt7u4iEsCY86xsaVmDK/NTlo6mTMR06rHPOniexSAvKLpcZRdqlX7E6Xt9OXO7z /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9jqs8n9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:02:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 177Gti4b168067;
        Sat, 7 Aug 2021 17:02:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3a9wg89786-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Aug 2021 17:02:10 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 177H0nKZ175235;
        Sat, 7 Aug 2021 17:02:09 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3a9wg8977q-1;
        Sat, 07 Aug 2021 17:02:09 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     libtirpc-devel@lists.sourceforge.net
Subject: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
Date:   Sat,  7 Aug 2021 13:02:06 -0400
Message-Id: <20210807170206.68768-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RXNR7LCFx3bxY6xXAB3O7P9emGPhz7c3
X-Proofpoint-ORIG-GUID: RXNR7LCFx3bxY6xXAB3O7P9emGPhz7c3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently my_svc_run does not handle poll time allowing idle TCP
connections to remain ESTABLISHED indefinitely. When the number
of connections reaches the limit the open file descriptors
(ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
not handle EMFILE returned from accept(2) this get my_svc_run into
a tight loop calling accept(2) resulting in the RPC service being
down, it's no longer able to service any requests.

Fix by add call to __svc_destroy_idle to my_svc_run to remove
inactive connections when poll(2) returns timeout.

Fixes: b2c9430f46c4 Use poll() instead of select() in svc_run()
Signed-off-by: dai.ngo@oracle.com
---
 src/rpcb_svc_com.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/rpcb_svc_com.c b/src/rpcb_svc_com.c
index 1743dadf5db7..cb33519010d3 100644
--- a/src/rpcb_svc_com.c
+++ b/src/rpcb_svc_com.c
@@ -1048,6 +1048,8 @@ netbuffree(struct netbuf *ap)
 }
 
 
+extern void __svc_destroy_idle(int, bool_t);
+
 void
 my_svc_run()
 {
@@ -1076,6 +1078,7 @@ my_svc_run()
 			 * other outside event) and not caused by poll().
 			 */
 		case 0:
+			__svc_destroy_idle(30, FALSE);
 			continue;
 		default:
 			/*
-- 
2.26.2

