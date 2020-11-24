Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F142C1BE6
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 04:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgKXDQV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 22:16:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgKXDQU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 22:16:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO3AuaE070509;
        Tue, 24 Nov 2020 03:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=RrNNwo6iipEXvZmDOrU0HEGwAyv+YjrKNSxu9k1znCk=;
 b=aUdjNg6jtqeC4C7vlIXGn69TtmZIP7Oult9VlogKN+wTAWkDb2oDd2xhqXicFFwWabzC
 yUAvTYGY56oP6gfQGxov7q6Onn5zZLuQnqcPrBQ1hPgPrEuLkYzjyzsNyOCEUNnMlsZW
 dUGQHsn2Jb7+HM/pY/5rqO3M1hM3nLFnFTAibiZgvpfqEA/KYD/hLejT8xmdjdnPLlcW
 5JIG9nQYYeH0P2VWPUT7YbLhNNLfYcz/TCgWc0Ru7JsV2VjD7/30RYNRTY7BxIc77FRQ
 KIPGEE1ZKNSF07vDZ+pccK2dj9AqT80HZYuws+U7BFzLoINaFE6Zgta2r/qaAqPDQ1+m RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34xtum0bjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:16:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO39dTl160684;
        Tue, 24 Nov 2020 03:16:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 34yx8j968a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:16:15 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO3C0a5165160;
        Tue, 24 Nov 2020 03:16:14 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 34yx8j9681-1;
        Tue, 24 Nov 2020 03:16:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
Date:   Mon, 23 Nov 2020 22:16:09 -0500
Message-Id: <20201124031609.67297-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=3 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240018
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
seconds delay regardless of the size of the copy. The delay is from
nfs_set_open_stateid_locked when the check by nfs_stateid_is_sequential
fails because the seqid in both nfs4_state and nfs4_stateid are 0.

Fix by modifying the source server to return the stateid for COPY_NOTIFY
request with seqid 1 instead of 0. This is also to conform with
section 4.8 of RFC 7862.

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
index d7f27ed6b794..33ee1a6961e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -793,6 +793,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	refcount_set(&cps->cp_stateid.sc_count, 1);
 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
 		goto out_free;
+	cps->cp_stateid.stid.si_generation = 1;
 	spin_lock(&nn->s2s_cp_lock);
 	list_add(&cps->cp_list, &p_stid->sc_cp_list);
 	spin_unlock(&nn->s2s_cp_lock);
-- 
2.9.5

