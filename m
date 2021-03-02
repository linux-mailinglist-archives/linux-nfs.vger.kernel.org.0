Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8D32B749
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhCCKxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:53:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41292 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837196AbhCBUli (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 15:41:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Jd4jf192660;
        Tue, 2 Mar 2021 19:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=9sLSpxsUta9Tj7ZOmJnbpVtOOdZRnzp2T6bUBBHIf48=;
 b=zDiK2RhD0BbcfFu7CQb2CubydPzHxNB8ike91u7S27Q9NfC4R41WAY0Q6hCJ56zsDhN6
 32JFOJAkLn6n4DP3K8s4wAET8BW3YqZWQcQZpUJe4+ipSecmcx5jDty0bvWc2kWbxCDF
 Vh0fj5C8Vc3HpSzg1s+hPI+IYeNtXJsV+YF1DAr56XaI2QLvdrX2dUGF6bLUjXycP4GM
 S2YG7f4lN86aWfsgNCsa9NAlTkjtOZcGLc6VzpPPqsrE7IRqKbr2nQ6gi0tK0n3d3Xcf
 Q8DTrVZfz2MNJexFq7LzEqqg0Vo4WQ+gtxRwH6/9GGU4VIBnX/hA/CurNmpIFuK67Vi3 qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkb9243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 19:48:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Jj08Z043509;
        Tue, 2 Mar 2021 19:48:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 36yynpmb4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 19:48:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 122JmmTg057657;
        Tue, 2 Mar 2021 19:48:48 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 36yynpmb4n-1;
        Tue, 02 Mar 2021 19:48:48 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: dst server needs to unmount src server's export after copy is done.
Date:   Tue,  2 Mar 2021 14:48:43 -0500
Message-Id: <20210302194843.98612-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the destination server leaves the source server's export
intact on the destination after copy is done. This patch fixes this
by doing ssc disconnect from nfsd4_do_async_copy after copy is done.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8d6d2678abad..d3d864b8ee4f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1306,7 +1306,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 	nfs42_ssc_close(src->nf_file);
 	/* 'src' is freed by nfsd4_do_async_copy */
 	nfsd_file_put(dst);
-	mntput(ss_mnt);
 }
 
 #else /* CONFIG_NFSD_V4_2_INTER_SSC */
@@ -1472,14 +1471,12 @@ static int nfsd4_do_async_copy(void *data)
 		copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
 		if (!copy->nf_src) {
 			copy->nfserr = nfserr_serverfault;
-			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
 		copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
 					      &copy->stateid);
 		if (IS_ERR(copy->nf_src->nf_file)) {
 			copy->nfserr = nfserr_offload_denied;
-			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
 	}
@@ -1498,8 +1495,10 @@ static int nfsd4_do_async_copy(void *data)
 			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
-	if (!copy->cp_intra)
+	if (!copy->cp_intra) {
+		nfsd4_interssc_disconnect(copy->ss_mnt);
 		kfree(copy->nf_src);
+	}
 	cleanup_async_copy(copy);
 	return 0;
 }
-- 
2.9.5

