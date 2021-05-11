Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C149837A285
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEKIvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 04:51:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55244 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhEKIva (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 04:51:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B8jeLK157154;
        Tue, 11 May 2021 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5wAAjkj4ACzeBXEE3E6Iu/PHnvPZAggZROarK3l9xAw=;
 b=pYtfn37ewPxZauDdbUYtx/3hBvBAKVHQLJZd9g+QCoTMKbEkYHNIHQqrjoTvhJseF3h+
 Y5WY0O9jbBRlmKMC/wYqGkJcj026sFn/KbArEASxEubGhoFHmgoe3Emv/Hjf+b2iGGwo
 yD+U+dxBNwTjchFAK/4mNHhLxmqulGTPZeVYxguobEyZpTF3H456eIM7zDthhpTwMJqv
 qsN8nOjPIxausGe5xbijMAxMwGheih+7Hk9sRFvzhF1gDc42vT5loumJ6Ub0iRnPLpjR
 NhIft7t6mGapLjv/mIaCoe5zDjpJj3aM61XAmyIvYOQEdWl/B7I6DYuSIgw69rqJUn14 +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9ndxt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 08:50:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14B8keci087612;
        Tue, 11 May 2021 08:50:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38djf8rkey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 08:50:05 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14B8o3w8102717;
        Tue, 11 May 2021 08:50:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38djf8rkct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 08:50:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14B8nobm016763;
        Tue, 11 May 2021 08:49:56 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 May 2021 01:49:50 -0700
Date:   Tue, 11 May 2021 11:49:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Andy Adamson <andros@netapp.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ricardo Labiaga <ricardo.labiaga@netapp.com>,
        Oleg Drokin <green@linuxhacker.ru>,
        Marc Eshel <eshel@almaden.ibm.com>,
        Tao Guo <guotao@nrchpc.ac.cn>, linux-nfs@vger.kernel.org,
        Nikola Livic <nlivic@gmail.com>,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] NFS: fix an incorrect limit in filelayout_decode_layout()
Message-ID: <YJpFJmQcpkX/V8QO@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: WSchhDmeZc3d9pxpd1Ienu6VjxkBQ0pM
X-Proofpoint-GUID: WSchhDmeZc3d9pxpd1Ienu6VjxkBQ0pM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110067
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The "sizeof(struct nfs_fh)" is two bytes too large and could lead to
memory corruption.  It should be NFS_MAXFHSIZE because that's the size
of the ->data[] buffer.

I reversed the size of the arguments to put the variable on the left.

Fixes: 16b374ca439f ("NFSv4.1: pnfs: filelayout: add driver's LAYOUTGET and GETDEVICEINFO infrastructure")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/nfs/filelayout/filelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d158a500c25c..d2103852475f 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -718,7 +718,7 @@ filelayout_decode_layout(struct pnfs_layout_hdr *flo,
 		if (unlikely(!p))
 			goto out_err;
 		fl->fh_array[i]->size = be32_to_cpup(p++);
-		if (sizeof(struct nfs_fh) < fl->fh_array[i]->size) {
+		if (fl->fh_array[i]->size > NFS_MAXFHSIZE) {
 			printk(KERN_ERR "NFS: Too big fh %d received %d\n",
 			       i, fl->fh_array[i]->size);
 			goto out_err;
-- 
2.30.2

