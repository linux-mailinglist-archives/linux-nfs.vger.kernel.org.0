Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929D4B4242
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfIPUqb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39176 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfIPUqb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:31 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so2296852ioc.6
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=ppE39HEEXYbaQ/RycPKzxYIsPFUvcZx03OP1d2jxgYKzBDh71zVuXf9nrAnIqrG0ZP
         wsdnF/bosFRXssrP+MY22p52wpB3ut/t0zKalsfBVP3XvQfAPpWlNOidmsVKJj4HEN+c
         89TIaRHGdFJHYw+0vKo0wsU78vhoYqQVQH1HDK309xTZvplS4xt/aesHJI0BiGfVyYzY
         PhFrp4eNUzCJh8JM2WbGZN4Rl49RBYmI3gthXYjshHzuxlONjSgarO+gvVCCvPv/qTx8
         qrGKfjf4qzwDVtsY7aE0vKRX6XseTpeIHlvfXSn2eK0BoXUwbNlaxfZOV4vmAe6TSzGU
         e60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=je3smfDlvbUDiQlJ3OdQ/SjpgNaw7IhKpY8fmZ61q8p4/ae1ORj9XO28Ma4Gz/fM89
         McdWJk+w7NrVLOPs10dYGeFHC5ITR9laY+pG2TnsEyH4HU8dvdSzxklAVkYJ/4ZaQm/i
         7w+yFti1QmOzlFLMBwkV9mpGA8Wp+z00bhGFJ+42XpSSMFsX3Qhb7C3tBm5oT7VPcSJZ
         JhXDxTb/mW0hTjUcurOPg/Y5OVp4279VtEZdS1iWasZ2ze/9ClFbHHlQHDe175gm3TtG
         HOLAjySN5C5uOMogx84P3UBIOVxEPOgMsXHKBEk3+t6mQos/PJOEPcLf5L3LVWNyofh1
         Z7Bg==
X-Gm-Message-State: APjAAAWwFmlRnKod9PF9Tfrh/8qljuRufVFerPSKo5URtk5HdcBg03FO
        YWDBd9ri1qGq1IPnhrsROA==
X-Google-Smtp-Source: APXvYqwbuNRZHpigaByCk14TWw3JAvaYPfUWctBtVHiC64WR8YmKclVxECeUWMZYBgmL9ald3y/SjA==
X-Received: by 2002:a5d:85da:: with SMTP id e26mr223223ios.101.1568666790358;
        Mon, 16 Sep 2019 13:46:30 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:29 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/9] NFSv4: Handle RPC level errors in LAYOUTRETURN
Date:   Mon, 16 Sep 2019 16:44:14 -0400
Message-Id: <20190916204419.21717-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-4-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Handle RPC level errors by assuming that the RPC call was successful.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  9 +++++++++
 fs/nfs/pnfs.c     | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fcdfddfd3ab4..a5deb00b5ad1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9057,6 +9057,15 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	if (!nfs41_sequence_process(task, &lrp->res.seq_res))
 		return;
 
+	/*
+	 * Was there an RPC level error? Assume the call succeeded,
+	 * and that we need to release the layout
+	 */
+	if (task->tk_rpc_status != 0 && RPC_WAS_SENT(task)) {
+		lrp->res.lrs_present = 0;
+		return;
+	}
+
 	server = NFS_SERVER(lrp->args.inode);
 	switch (task->tk_status) {
 	case -NFS4ERR_OLD_STATEID:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 6436047dc999..abc7188f1853 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1455,6 +1455,21 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 	case 0:
 		retval = 0;
 		break;
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		/* Was there an RPC level error? If not, retry */
+		if (task->tk_rpc_status == 0)
+			break;
+		/* If the call was not sent, let caller handle it */
+		if (!RPC_WAS_SENT(task))
+			return 0;
+		/*
+		 * Otherwise, assume the call succeeded and
+		 * that we need to release the layout
+		 */
+		*ret = 0;
+		(*respp)->lrs_present = 0;
+		retval = 0;
+		break;
 	case -NFS4ERR_DELAY:
 		/* Let the caller handle the retry */
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
-- 
2.21.0

