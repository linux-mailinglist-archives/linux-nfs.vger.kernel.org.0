Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA992C8FF9
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgK3VZk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:25:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56468 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgK3VZk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:25:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULOuZL037456;
        Mon, 30 Nov 2020 21:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=QEtlYwAEJ0y/Srt1QgY1gWVbGohu0qBfhstLusNaT1U=;
 b=ZyNqZ0eNUmsgq8nBdBn/MWR9+wbeZtoXwLlEs9oPRnUiUZ6+SbavGkR57BhV2hvXI5VB
 UMgI9IOUm1rdQitI8JCmhLh/JO5BK+PTHj7NKzRfE952uYfg5AFOZ5bjRp+8kAJMNmFm
 SANFuF9LZglYCy/jAdvEOpOErI+yvTXvoQ724xdBuHNZmOKRM0PVHR4Macrs0SFSm5Go
 GICRf1o17Q6PQca8ffEzxS9Osa+ogqAADgoenxaSMTycWmGxsUEdpnzIIlG4xenIYC1b
 5dtNHZiaIroX0gFIdUXR04MD9hPpjILIepx+aHeSWCq93++wv1yBjjU2IXtl7fql9mq9 Mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2aqjke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:24:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUL5HX8090373;
        Mon, 30 Nov 2020 21:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3540fvs6xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:24:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AULOuSj159539;
        Mon, 30 Nov 2020 21:24:56 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3540fvs6w0-1;
        Mon, 30 Nov 2020 21:24:55 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
Date:   Mon, 30 Nov 2020 16:24:49 -0500
Message-Id: <20201130212449.3470-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
seconds delay regardless of the size of the copy. The delay is from
nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
fails because the seqid in both nfs4_state and nfs4_stateid are 0.

Fix by modifying nfs4_init_cp_state to return the stateid with seqid 1
instead of 0. This is also to conform with section 4.8 of RFC 7862.

Here is the relevant paragraph from section 4.8 of RFC 7862:

   A copy offload stateid's seqid MUST NOT be zero.  In the context of a
   copy offload operation, it is inappropriate to indicate "the most
   recent copy offload operation" using a stateid with a seqid of zero
   (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
   stateid refers to internal state in the server and there may be
   several asynchronous COPY operations being performed in parallel on
   the same file by the server.  Therefore, a copy offload stateid with
   a seqid of zero MUST be considered invalid.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7f27ed6b794..47006eec724e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -769,6 +769,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	spin_lock(&nn->s2s_cp_lock);
 	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
 	stid->stid.si_opaque.so_id = new_id;
+	stid->stid.si_generation = 1;
 	spin_unlock(&nn->s2s_cp_lock);
 	idr_preload_end();
 	if (new_id < 0)
-- 
2.9.5

