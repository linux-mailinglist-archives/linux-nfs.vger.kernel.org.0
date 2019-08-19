Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3325C94E1C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfHST3J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34901 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfHST3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:08 -0400
Received: by mail-io1-f66.google.com with SMTP id i22so6856551ioh.2
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKe9IJM5w7IAu8fm9oR8ZK0S/jMYLoynIc8LUP6DP9g=;
        b=D9agAE3bKFHyNmCMv/KGwwrLYVU1Im6veVcpn6s5kPz3x85wpRTGKxbnJ28bfQERPW
         szTNZVpnrwDG0WVhCgbJ3xrgp2hIi1Kh/Ge6x95Pp7UTm9VfbtEZcN6Bn+qAWUEXxGHH
         UfpfNEcjsW5k25RnGU0Of5wHSLpcdZgpSwr67ISoLSu14jAs0bK7eRv+Vm5hgxjhHhJ/
         /MWrB9f4lUNyiUfZWiDxS3/QnleKpOvVsnwnTKDg1H8lngKmK1UTANvRmVPiGWZihqQo
         EaPM/hLkQmOYxBktse9kngppYYvQlX1/HSaJO9sTPwo8rMhu5/tldMgyWXDloltSgjMy
         ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MKe9IJM5w7IAu8fm9oR8ZK0S/jMYLoynIc8LUP6DP9g=;
        b=c1iWn7AiL6YsYiCnwkWRKGoWmOMElA1w/bQ3/SeZz7ZYfO1bc6tXf2aiyEqPlcODx+
         OQnAL5Cj+Mmi/FffmGLvOdNieK5VncuVEjdEwy5sjEimnXjbOl2gb//IRVkKiPm1cfL0
         ih+sfrNPzjkIkYTI4ybknYFoukc41pZHUqhm5018Dyd/WKENHIPY+H36DUQXocBZdG/k
         y0Fe+tuiYbSgBi1ZzrbDPip5LzucMLk/5+3aBAU9b9yc/SWDjVGYXawO5ja4YNJ6U3XI
         p+wsuDo3/8Ucbt1tJ0+yPLv7lqtCKLDkYUM22Blc3rKUrxTiP4nJF1ftJd2XgDDMTyrx
         4oVQ==
X-Gm-Message-State: APjAAAVMrUNdL/UxgsquoiqQc5pgNmxoW3KZd6cy+RUvBAMgrMo5nVoY
        Ora5J2gwwHje9ORYwI6V72o=
X-Google-Smtp-Source: APXvYqxHs7rKIkgH6hJT032nBH8/lRopF2WBdG+yBDq/yU1j7XfYfBxhRWCkKNMYXg9wy4qJKLIBpw==
X-Received: by 2002:a5e:9408:: with SMTP id q8mr10355497ioj.223.1566242947600;
        Mon, 19 Aug 2019 12:29:07 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:07 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 6/6] NFS: Have nfs4_proc_get_lease_time() call nfs4_call_sync_custom()
Date:   Mon, 19 Aug 2019 15:29:00 -0400
Message-Id: <20190819192900.19312-7-Anna.Schumaker@Netapp.com>
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

This removes some code duplication, since both functions were doing the
same thing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df12af8f6b36..00c7a92e3d6b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8356,7 +8356,6 @@ static const struct rpc_call_ops nfs4_get_lease_time_ops = {
 
 int nfs4_proc_get_lease_time(struct nfs_client *clp, struct nfs_fsinfo *fsinfo)
 {
-	struct rpc_task *task;
 	struct nfs4_get_lease_time_args args;
 	struct nfs4_get_lease_time_res res = {
 		.lr_fsinfo = fsinfo,
@@ -8378,17 +8377,9 @@ int nfs4_proc_get_lease_time(struct nfs_client *clp, struct nfs_fsinfo *fsinfo)
 		.callback_data = &data,
 		.flags = RPC_TASK_TIMEOUT,
 	};
-	int status;
 
 	nfs4_init_sequence(&args.la_seq_args, &res.lr_seq_res, 0, 1);
-	task = rpc_run_task(&task_setup);
-
-	if (IS_ERR(task))
-		return PTR_ERR(task);
-
-	status = task->tk_status;
-	rpc_put_task(task);
-	return status;
+	return nfs4_call_sync_custom(&task_setup);
 }
 
 #ifdef CONFIG_NFS_V4_1
-- 
2.22.1

