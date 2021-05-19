Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4B389830
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhESUpw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 16:45:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34622 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhESUpv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 16:45:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JKg57Z007623;
        Wed, 19 May 2021 20:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0QUUv3Jc5Fkru4BnemQ1tEnKu3i/5A3e82msN0WDhi0=;
 b=Z6cQq2k2PvyyySg6I/wlqsrlFlBhXuyrlWxEe+Yvddz9acfGyDLnWxWkJA2+mH0yaXE4
 E8cmFOvioONGdQecyuaNYxXe5OyVp293KtA8TZPjenaXw1Ft2R3WacifmZcZLHaZ/FMC
 c6pq5+i+79aUh/qQH82e0UvyS+3Pj3d677Z4da9Ji9WyXXFDfbvpgl7dEQwwgeEr3626
 eGQBLtSAYCyEB634HYsMxnGHpkdeOeCShrlmSZeCvhnBKPUqNfaZ3reFMwY5qZ+kSyVM
 tGBrDqqkpjkA/vvtHRNgX0nZfYOlolp3gxXRqNffXajH+WUw9iJQf7Rw14p/BQvaZt0U iw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n3dg0681-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:44:28 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JKiR0Q050515;
        Wed, 19 May 2021 20:44:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38meegdf6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:44:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JKiPM8050452;
        Wed, 19 May 2021 20:44:27 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 38meegdf5s-3;
        Wed, 19 May 2021 20:44:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v6 2/2] NFSv4.2: remove restriction of copy size for inter-server copy.
Date:   Wed, 19 May 2021 16:44:21 -0400
Message-Id: <20210519204421.22869-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210519204421.22869-1-dai.ngo@oracle.com>
References: <20210519204421.22869-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7WE4eZm4U5imvKwpgd55VojEHVbv8wRU
X-Proofpoint-GUID: 7WE4eZm4U5imvKwpgd55VojEHVbv8wRU
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

