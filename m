Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B494E18
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfHST3E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33994 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfHST3E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:04 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so6869876ioa.1
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O0L4th40lZfUVO9h1Mje9KCwXPgIa9fuj6EJ2cZs+8=;
        b=Btr9ix3b1xztCHj5X+hQqlPVKYBNLR7kIWvCamMJ2uxR4+lkH0AXXu98et2mtYHvIA
         /oO2D4S0DEFK/nCzPEPxKd9V5q70BBlei+heYvhtanNCCDTZnXYxIUil7uGK5Y/OOK5M
         FBBd9Zer/8XX/AqRlQHi61MbQmAlYTT7VNm2dr4DjEINs/UWblbIQTeVnQjiEHOL936t
         +PzJ+KU6+f6dCZ8hVsVs4NteBoRg+V9oS+PH7SF8wKZ0+UvFHM6T7ktrACLBXaU58mk2
         kjh+yq9WXAwGV5A7aIB5T6rPBhG5oEMt9hYHI79u8BLg39H5SJr2QEUfm55/qSIlCO22
         DDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+O0L4th40lZfUVO9h1Mje9KCwXPgIa9fuj6EJ2cZs+8=;
        b=Eu7o8AtmtI8NX7Nh4r2furGvl4h+KgiQEhVA07kOdTqHlVLlyv5Qlc/Y1Nvg982dHC
         btd/qEQMkqs76TqpbQoofQ81II3R3K//JpbMxHkW9pYiI+IM1TlZCw0I6IsBEGPiYoPm
         hY5zwG3LMnCfQifQ88KwjPNKxg9yLhn/maLDzZDICPqSG+YC1e3scBs2vMzFunOSKcQE
         LF0jr83ty82AwIKPRaRcuc0cvBdkqV5hb7me38trFIVE3UnY0IOPl6LGAKNBYlzK7Y0M
         9/51YTiFFtFKz4iotERW/vegRfAub5mKs16FRZ0wK0lF56Nd3Toi5dfuUGC+/CmqJ6CU
         t4+w==
X-Gm-Message-State: APjAAAUjNxyA7zqxgLdSDWOwCqWIIlwT4MIl4e9QGonqu1UYhvGtSJeJ
        aNITEUpGVSlIcc/TJ6jub7WljpPl+P8=
X-Google-Smtp-Source: APXvYqzQ8q4fdtpKbWLhRKXUZFclqlaRCZ+6LoPT2/B4Mb1/mcYaTz6K3fb1owFQO90jhZnI7XB+Og==
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr15023269iok.144.1566242943225;
        Mon, 19 Aug 2019 12:29:03 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:02 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/6] NFS: Add an nfs4_call_sync_custom() function
Date:   Mon, 19 Aug 2019 15:28:55 -0400
Message-Id: <20190819192900.19312-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

There are a few cases where we need to manually configure the
rpc_task_setup structure to get the behavior we want.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1406858bae6c..e5b6499c0b8b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1073,14 +1073,26 @@ static const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_done = nfs40_call_sync_done,
 };
 
+static int nfs4_call_sync_custom(struct rpc_task_setup *task_setup)
+{
+	int ret;
+	struct rpc_task *task;
+
+	task = rpc_run_task(task_setup);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	ret = task->tk_status;
+	rpc_put_task(task);
+	return ret;
+}
+
 static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 				   struct nfs_server *server,
 				   struct rpc_message *msg,
 				   struct nfs4_sequence_args *args,
 				   struct nfs4_sequence_res *res)
 {
-	int ret;
-	struct rpc_task *task;
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_call_sync_data data = {
 		.seq_server = server,
@@ -1094,14 +1106,7 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 		.callback_data = &data
 	};
 
-	task = rpc_run_task(&task_setup);
-	if (IS_ERR(task))
-		ret = PTR_ERR(task);
-	else {
-		ret = task->tk_status;
-		rpc_put_task(task);
-	}
-	return ret;
+	return nfs4_call_sync_custom(&task_setup);
 }
 
 int nfs4_call_sync(struct rpc_clnt *clnt,
-- 
2.22.1

