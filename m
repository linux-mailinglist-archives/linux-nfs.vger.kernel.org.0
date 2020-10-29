Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361DE29F482
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJ2TH0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 15:07:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49642 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ2THZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 15:07:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ58UN138072;
        Thu, 29 Oct 2020 19:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=JGZlQd1mn6I93M2zGOwxVgto28NIWTAKgE+vs1O8HPg=;
 b=zwWsRR8MxNwbf4SXu+o+0Psto74AK2SlA/f1s1AZ5Ds/QdLOx0CeSULo2YVNDOvnnMZD
 SwSwXw/zZviY6s8kaXh9oL8NY8g4tZrT5jrWDscstGjAyXLcnny3GKcfPCByUsN6TGaD
 W/i1oW+9X/r9cFVn03Z1C7Z9Nf5RCIJkRbQuvseHaWXGz0mhC5LqnPetgNJ15ntZhSgw
 ofcbEHiFa5mt/Ys9fB8C096tCGg2OI9APnK3XzktSJ118nV+Xw+xdDs/FEOHcFdHaBfD
 hq2heQXgoIE3dxsGqZUdp0YFO69ojNjsv8ALjhiaNwIa1Z/0QBsQtiVhicfOyRNDqcR6 XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7m6hs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:07:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TJ6AJT089742;
        Thu, 29 Oct 2020 19:07:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 34cx60v0ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 19:07:19 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TJ71Hh092200;
        Thu, 29 Oct 2020 19:07:19 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 34cx60v0ug-2;
        Thu, 29 Oct 2020 19:07:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSD: Fix use-after-free warning when doing inter-server copy
Date:   Thu, 29 Oct 2020 15:07:15 -0400
Message-Id: <20201029190716.70481-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20201029190716.70481-1-dai.ngo@oracle.com>
References: <20201029190716.70481-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The source file nfsd_file is not constructed the same as other
nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
called to free the object; nfsd_file_put is not the inverse of
kzalloc, instead kfree is called by nfsd4_do_async_copy when done.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ad2fa1a8e7ad..9c43cad7e408 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 			struct nfsd_file *dst)
 {
 	nfs42_ssc_close(src->nf_file);
-	nfsd_file_put(src);
+	/* 'src' is freed by nfsd4_do_async_copy */
 	nfsd_file_put(dst);
 	mntput(ss_mnt);
 }
-- 
2.20.1.1226.g1595ea5.dirty

