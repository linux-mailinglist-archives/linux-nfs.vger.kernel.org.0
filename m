Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786D9ADAA6
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405099AbfIIODN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42250 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405095AbfIIODN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:13 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so28882835iod.9
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=E3gP3ZFxIipvF6EBMaFd2J9ed+u3c3kfAictPVTGoNMI6N07WG5utT9SnAtcO4YQdB
         IT+XaUsKXiqTVfhbTk00MWbWwns3+AsdRKPzB4fDEHXXkccaAL0QQozkXDdb9L0mM9MM
         p645CIq1c/S6di7sEkO9a1gWQSQ9cg1N0/0zbo6nuUXd4M3/lU37IHLjOgw91tBhPYbJ
         EmIp1EXq+ZLe/A5Y4g6PcisXLrXlSwThR3nXb2+0uxK+ilcKtxqTFylTK9K7bRVOSVYH
         +T2GecxXrDrvQXaIjg7o5XPlFfqi5aq1bn2NqtomSBiGkCZWB9C7aLQ/2LwenQ9PVMhM
         LHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+xAWTrh/Lsv4sQba0rlaTvUNAip8h2KHmmPmv3mJ88=;
        b=ewm4nL0utKDOqKiF77hJDdpk1SqYEw9SS8VD7/9hOQ0IkYoDGzuyu6WgFz9s3Xl1TE
         ddqzmWrlPwkz4gcMNsSOrQ9gzvysH/pWWIA0EEe2mKrV5QreSDUKRa+UzqDTWJsHKZN9
         ospyL8/yxzg9CWLyKwTkhPYnbe/IEX/bwSBPsFvOTiBrqsuIQQQ4gHSIkvc+tcuhjmwc
         9nQLrRbGUuwCUOEiEL5Jsna/annKDaox3RYx4mJnmu4IZIHXAkxjQKdb/sLVn584aMaS
         /prNqC8TbFF5/ccjwWOe1J4OSA60S+JoSASEzCeOFhP+KJgVu5tANKhU94+6LD3997+R
         r3Yg==
X-Gm-Message-State: APjAAAVOmbegRTei4wMmwuH+4ryeS/Tz5QlvJHfN9x9HO99s7lnoCUgB
        8mVOpbs5NKvxzygPzs7s5/9/4TyGbQ==
X-Google-Smtp-Source: APXvYqx6IPetCj5FuSeVV+vMJW+LSlV5g9d4G2SE3N+x8JCIKcRlTesdtRx7oucb3FoG899jl/4DmQ==
X-Received: by 2002:a5d:9714:: with SMTP id h20mr21006595iol.294.1568037792635;
        Mon, 09 Sep 2019 07:03:12 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:12 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/9] pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors
Date:   Mon,  9 Sep 2019 10:00:56 -0400
Message-Id: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

IF the server rejected our layout return with a state error such as
NFS4ERR_BAD_STATEID, or even a stale inode error, then we do want
to clear out all the remaining layout segments and mark that stateid
as invalid.

Fixes: 1c5bd76d17cca ("pNFS: Enable layoutreturn operation for...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4525d5acae38..0418b198edd3 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1449,10 +1449,15 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
-	if (ret == 0) {
-		arg_stateid = &args->stateid;
+	switch (ret) {
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		break;
+	case 0:
 		if (res->lrs_present)
 			res_stateid = &res->stateid;
+		/* Fallthrough */
+	default:
+		arg_stateid = &args->stateid;
 	}
 	pnfs_layoutreturn_free_lsegs(lo, arg_stateid, &args->range,
 			res_stateid);
-- 
2.21.0

