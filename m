Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC07B3C7671
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jul 2021 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhGMSaH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Jul 2021 14:30:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhGMSaH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Jul 2021 14:30:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DIHWlO031757;
        Tue, 13 Jul 2021 18:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=+HKwctuIsXoV72efMyg9CEDIWR/ZGYYZyR+Cp7+DL0I=;
 b=bRXqupw8JyvmXUMvkFmfvqybKJvKZ+2t4Mv81yMD7udTUn4z93Tv4AMQr34fDX3PtO4v
 f0x/LOTqtPOi/xwQDgO9tBOoE5lANqoghYRbdXXFfH4xWM21sNSOCU11yQwSS9oel5vP
 txvvME277UUUW4DtT2n6k0mGIsgJCjtU7xkQ1blfdj5IhxIWfEvhqNm4BIOipqRR/AY9
 whxyStpLmGmPNeZamCwUDIMZYhCXHDNuc2xaVcTYp3FsM4fN2M44Yg9FAvtjPSgjtnyg
 ZX2N8fsWdQDVcDLGo3Pe8SLsFfAd8R7YzoI3A+LMkYaA0mRlBR7YBNFifgGjOMKaLOFU 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39sbtugpwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 18:27:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16DIEk4f005269;
        Tue, 13 Jul 2021 18:27:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39q3cc8nhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 18:27:14 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 16DIOqO8040273;
        Tue, 13 Jul 2021 18:27:14 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 39q3cc8ngr-1;
        Tue, 13 Jul 2021 18:27:13 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: remove restriction of copy size for inter-server copy
Date:   Tue, 13 Jul 2021 14:27:08 -0400
Message-Id: <20210713182708.58378-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CNnyYjY0zGrJ6h7v30F24lDXhDkJ5wpp
X-Proofpoint-ORIG-GUID: CNnyYjY0zGrJ6h7v30F24lDXhDkJ5wpp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently inter-server copy is allowed only if the copy size is larger
than (rsize*14) which is the over-head of the mount operation of the
source export. This patch removes this restriction since the client
should not rely on how the server implements the inter-server copy.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c820de58a661..c91565227ea2 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -158,13 +158,11 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		sync = true;
 retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
-		/* for inter copy, if copy size if smaller than 12 RPC
-		 * payloads, fallback to traditional copy. There are
-		 * 14 RPCs during an NFSv4.x mount between source/dest
-		 * servers.
+		/*
+		 * for inter copy, if copy size is too small
+		 * then fallback to generic copy.
 		 */
-		if (sync ||
-			count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
+		if (sync)
 			return -EOPNOTSUPP;
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
-- 
2.9.5

