Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA997250E3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjFFXkj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jun 2023 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbjFFXki (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jun 2023 19:40:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A90170B
        for <linux-nfs@vger.kernel.org>; Tue,  6 Jun 2023 16:40:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IZAqB000459;
        Tue, 6 Jun 2023 23:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=UC70I+iw1YRHovnYL+xRsrLj+374kDEbdSTeCyZnqCg=;
 b=yLE5lzsa6L0eGhH2gIpB+7Wro1IOVLn5yZqHn8ZGxvOUwNih0xGtq17N5cTyZyHZg1en
 VMxkFZkX6RxAW58w2Mvid6sGh5uCb7Tgoyf3eYZJN5PQRRFts8p2B1wYj9Aev+0HcItj
 U11xcGO1ZJFeerqvmy0oiM5p5gIZKPedih4fYXsFD3LRqUxhSl9dlDTIgOVv/J4jYwQH
 ULF4B59VVbsaHFM+ek48L3Gq1ebHhytQx/IkCXKAe0Ucu+c98/y73HpavLxhpqzs3+Oq
 qalaTq3432fXPNvLAmX17tflQweEM8nKa45WlIphT/jF5/baPDoTJpyhRLUk+N9Y55Vy xA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6r8gjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 23:40:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356N3jtZ037094;
        Tue, 6 Jun 2023 23:40:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6ggryd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 23:40:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356NeUDr005766;
        Tue, 6 Jun 2023 23:40:30 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6ggry7-1;
        Tue, 06 Jun 2023 23:40:30 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: remove dead code in nfs4_open_delegation
Date:   Tue,  6 Jun 2023 16:40:19 -0700
Message-Id: <1686094819-13044-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_17,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060198
X-Proofpoint-ORIG-GUID: TsBJgWQdjtKsGYkx0lec2BjdJOuKgtVA
X-Proofpoint-GUID: TsBJgWQdjtKsGYkx0lec2BjdJOuKgtVA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The intention of this code is to tell the client to return the granted
delegation immediately for whatever reason in the case of OPEN with
NFS4_OPEN_CLAIM_PREVIOUS. However this was already handled above in the
cases of switch(open->op_claim_type).

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b75656d3e8f..58c78a23f90b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5632,11 +5632,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	return;
 out_no_deleg:
 	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
-	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
-	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
-		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
-		open->op_recall = 1;
-	}
 
 	/* 4.1 client asking for a delegation? */
 	if (open->op_deleg_want)
-- 
2.9.5

