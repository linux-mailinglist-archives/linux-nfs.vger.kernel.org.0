Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2638CDFF
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhEUTLM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 15:11:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32238 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237811AbhEUTLL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 15:11:11 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJ92BX002853;
        Fri, 21 May 2021 19:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0QUUv3Jc5Fkru4BnemQ1tEnKu3i/5A3e82msN0WDhi0=;
 b=uM7oafudksz1cwqFwLi15MntIV7JxWy5I0OtUDhUgQW5TTjdSINs2EuGFP6IzwpD0qrX
 dT1Hj9JuHIYbnurc7y2hxHelNMrpah4ZXuWbPllFls1HXclLMfLceaGk0QY8UfO3lBIf
 i1BfAsz/ko1CQjM891RJQZRdXCrXZn46k7hvhPxhLYpCxuKG2GC93aIN9uf+FH1b1eHZ
 EMv+7pnpzLGhkFquzbkFoATiau9ABgwECHbeB+dow5/JYxRwRbzwhMgn5jYnYVllV5zf
 LlRPO8KyoOx1xRqEfQA3L7kHPRcOQl4DPqFYVmStXveqB8DWN4rXo6+pEsiS88WN3wGv nQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4u8s168-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:44 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14LJ6PDf157591;
        Fri, 21 May 2021 19:09:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n4931ym9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:43 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14LJ9fF3162279;
        Fri, 21 May 2021 19:09:43 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 38n4931yjw-3;
        Fri, 21 May 2021 19:09:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v7 2/2] NFSv4.2: remove restriction of copy size for inter-server copy.
Date:   Fri, 21 May 2021 15:09:38 -0400
Message-Id: <20210521190938.24820-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210521190938.24820-1-dai.ngo@oracle.com>
References: <20210521190938.24820-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hKsLZaa7smFf4hrIMg6DuSzGaLAdEkJn
X-Proofpoint-ORIG-GUID: hKsLZaa7smFf4hrIMg6DuSzGaLAdEkJn
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

