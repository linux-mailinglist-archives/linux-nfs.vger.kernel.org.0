Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1899369BB1
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhDWVAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 17:00:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19354 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232657AbhDWVAc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Apr 2021 17:00:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NKxKLZ005619;
        Fri, 23 Apr 2021 20:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0QUUv3Jc5Fkru4BnemQ1tEnKu3i/5A3e82msN0WDhi0=;
 b=XrCfT47gnfXHI/3RXftGruGWL6LjI3xKaNG7EXpBP1rsX9jiWSwDaStK/h2U741AQFut
 Vdl+McSe3/gaYXC7X0wEhj2FbkWRSeVmrr+yi0vE4WWBUmf2o1q9VGDh/mRjSf/MnbBx
 nJ2DeFgA5HLm56NMp+n6tBjzJP2vLtgYn8M+f6415r9rjs/er33UWouTBGH+lba1Wdqd
 MKDHYl6ZsCjK+uINBB+guM/j6mMIJZz6fqpLzcIFlnz+Hri5w/XfMxIxKDDyiBz971rB
 ephi+TQWA5cxjeLG1imu5WEVt+wsm8fJkGHS7efYVLVmNgkOpjFTBklRdJye2k4BIKGx XQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 382unxgvbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 20:59:52 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NKxJpE157275;
        Fri, 23 Apr 2021 20:59:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 383cbfyqnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 20:59:51 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NKxnqM158636;
        Fri, 23 Apr 2021 20:59:50 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 383cbfyqm0-3;
        Fri, 23 Apr 2021 20:59:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     trondmy@hammerspace.com, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/2] NFSv4.2: remove restriction of copy size for inter-server copy.
Date:   Fri, 23 Apr 2021 16:59:46 -0400
Message-Id: <20210423205946.24407-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210423205946.24407-1-dai.ngo@oracle.com>
References: <20210423205946.24407-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h0Y5qLMa1JHL171JzYeOKOtkDW9rO2ky
X-Proofpoint-ORIG-GUID: h0Y5qLMa1JHL171JzYeOKOtkDW9rO2ky
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently inter-server copy is allowed only if the copy size is larger
than (rsize*14) which is the over-head of the mount operation of the
source export. This patch, relying on the delayed unmount feature,
removes this restriction since the mount and unmount overhead is now
not applicable for every inter-server copy.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 441a2fa073c8..b5821ed46994 100644
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

