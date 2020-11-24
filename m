Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBE2C1D14
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 05:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKXEif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 23:38:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgKXEie (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 23:38:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO39GtK032174;
        Tue, 24 Nov 2020 03:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=gcL8AA4zicd9hYBqJ87yzT7yEP4Rvi6QspiwBcs1VMA=;
 b=Rsm0XHq1iuJVkF/4ebwDQblpDwE176JwPhA/ZTzif7WGm52VX5IB8HZ27BX6OWbFPtvh
 +zi61wuLe3UH78DzqpXlP+tcylqcseBYVluokXkKqY6RUdvLAy4XIAcMEthze7VrFCzQ
 65ZNscKNj8BSMSVmB1cakazckb9vLPSFSwcVFjbuAdnOR4wcGS2nhek5XhJLSe4Zb/E5
 l+SHG6uCtFPV2TNX6Sahkb8vdsEHjl4+bfM6UV5Lz5XHshrCEm4zGT5hweSckvY/IiqM
 ilp/kaf0gskgxQvZhBxEZrIlSJSIEue8Lkbh+anN882phRqWlmk0M9c5K+/WlvkKR0Lm KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 34xtaqkw43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:15:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AO39v1i043539;
        Tue, 24 Nov 2020 03:15:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 34ycfmqahq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:15:29 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO3Avdb046232;
        Tue, 24 Nov 2020 03:15:29 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 34ycfmqahk-1;
        Tue, 24 Nov 2020 03:15:29 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com, olga.kornievskaia@gmail.com,
        bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: Fix 5 seconds delay when doing inter server copy
Date:   Mon, 23 Nov 2020 22:15:17 -0500
Message-Id: <20201124031517.66851-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
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

Fix __nfs42_ssc_open to delay setting of NFS_OPEN_STATE in nfs4_state,
until after the call to update_open_stateid, to indicate this is the 1st
open. This fix is part of a 2 patches, the other patch is the fix in the
source server to return the stateid for COPY_NOTIFY request with seqid 1
instead of 0.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 9d354de613da..57b3821d975a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -377,10 +377,10 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out_stateowner;
 
 	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
-	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
 	update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
+	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 
 	nfs_file_set_open_context(filep, ctx);
 	put_nfs_open_context(ctx);
-- 
2.9.5

