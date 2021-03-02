Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74B232B751
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbhCCK5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:57:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360294AbhCBWS7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 17:18:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122JfAuf054758;
        Tue, 2 Mar 2021 19:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=N8X5B8dJx09fN+XfFOdvDsJBIvnCLolF/4eZgQc3zto=;
 b=SoekSjqi2rG02Qm542aCdkoGfWLNkaobhu+rwNLS22vsbAudu4Ye/RMdoOKwhrCiBQTz
 IjUE/nEgqUTDz5sb/JrNhNkzioZ9Na8RMryBbvsQa1+0XJ3CR1YQweNcY5fxWsasPcdP
 ieWhRdlf6xiGs0Dxuw3oPmjaoh3xkC/BLGh6so1qq9RrnFI5045yNqEn3MujduTbQY9E
 jvnuRi/Q+6SuII3pp2EVEWgLZKk1bjTTK5km2PxiIDg6+Z0nSvNRZcpHbGwtdfwNIh4K
 VrN4Gb9r5F2bUjwtbNcd1HL7NYRj40tKyKatgMOYzjAcu9TpFQEEBRu8XP4QUIGs79hP dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m8wda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 19:47:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Jj0vu063669;
        Tue, 2 Mar 2021 19:47:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 37000xfnf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 19:47:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 122JlCbo072626;
        Tue, 2 Mar 2021 19:47:12 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 37000xfnef-1;
        Tue, 02 Mar 2021 19:47:12 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     trondmy@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: destination file needs to be released after inter-server copy is done.
Date:   Tue,  2 Mar 2021 14:46:59 -0500
Message-Id: <20210302194659.98563-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch is to fix the resource leak problem of the source file
when doing inter-server copy. The fix is to close and release the
file in __nfs42_ssc_close after the copy is done.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..20163fe702a7 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -405,6 +405,12 @@ static void __nfs42_ssc_close(struct file *filep)
 	struct nfs_open_context *ctx = nfs_file_open_context(filep);
 
 	ctx->state->flags = 0;
+
+	if (!filep)
+		return;
+	get_file(filep);
+	filp_close(filep, NULL);
+	fput(filep);
 }
 
 static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
-- 
2.9.5

