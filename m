Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DC7158360
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBJTQL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:11 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45424 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBJTQL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:11 -0500
Received: by mail-yw1-f66.google.com with SMTP id a125so3929597ywe.12
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bX+88Oqr9VbMzymWapnmRWOT+ucgpVL7mFGX75Ly+eA=;
        b=g/4dgZhF3gRGIk6czUZMOpVH5c0zuV6I5x7NptBcX0l0BYUtO3xKQNVJPLvlG9DEeu
         Q7OCzUgbH4CdWI2C1bac76ojrwwe0OKeiexeAtr5VLVyVnlCkwgcit8GxGp4Wvv+cHly
         TalQdJRmRnTH+B4PaqdUeOg7D5iq2ixSnINhEaYVBZ45xZT9s/YmllXgWzAXp+58i1f5
         MCYW4FDzcnRh4Oa2LUJc3yUsSRiudeXdIfWdAxFrZFJh3GSA3NhGxbDxmTwIAdtPjBg6
         LJHpxCVH8IqlHcd/8ojhwc3fWvc+2007ZY6u52waQk65mpXhOWfJ2+R2bv8BLU1OdumI
         Gckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bX+88Oqr9VbMzymWapnmRWOT+ucgpVL7mFGX75Ly+eA=;
        b=cXlHf+Q05QjCyt06ZMClhOZErwyJpSuJyyPqf4cIzgMHdurVHzt+TLbK0+MhJvnSUr
         FMyaE88OWGXHgSInosU9lN2BkFKZmeOT6YVqhxcpf1t04KBU0VqZmLEign7wf+OCAzs2
         srSQjDO0tybuK/kAt+yM7IhumZ+hVrtGnbOQ1McF+TI5JEhuKbXhJ/1sgo4vHKZuQGjB
         EyXDyyzT83a06/LLNSwYDzPWtQrpkcHlS9DH5PqNLQJ4WS0Wnab1QZ5veBLcog9EDZ47
         GMLd3HKISg9sRyHPyqpKF3YDybViWdmYwJ9DqI99C6kcS122Z3rohJxd9OgeiKsIJcgr
         ar9Q==
X-Gm-Message-State: APjAAAUsr3kJVHLJsy6KQXC45WVoDynM+RXv8IZ+yy5pdEaqWimWBjuf
        PqWshoWeFGQ5+NtW1/NtWOsOCZHIWg==
X-Google-Smtp-Source: APXvYqylnCZKrv4hAD37Ae/hdiWNhSIDVvUqVEof1C/wpiAWSW5tvd3rwma8JLxbUC/fbEgFipN5Rw==
X-Received: by 2002:a0d:e20a:: with SMTP id l10mr2251695ywe.17.1581362169562;
        Mon, 10 Feb 2020 11:16:09 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:09 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] NFSv4: Avoid referencing the cred unnecessarily during NFSv4 I/O
Date:   Mon, 10 Feb 2020 14:13:42 -0500
Message-Id: <20200210191345.557460-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-5-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
 <20200210191345.557460-3-trond.myklebust@hammerspace.com>
 <20200210191345.557460-4-trond.myklebust@hammerspace.com>
 <20200210191345.557460-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid unnecessary references to the cred when we have already referenced
it through the open context or the open owner.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 00fe674c8a49..47464fb419dc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2346,7 +2346,7 @@ static int _nfs4_proc_open_confirm(struct nfs4_opendata *data)
 		.callback_ops = &nfs4_open_confirm_ops,
 		.callback_data = data,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int status;
 
@@ -2511,7 +2511,7 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 		.callback_ops = &nfs4_open_ops,
 		.callback_data = data,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int status;
 
@@ -3651,7 +3651,7 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_close_ops,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int status = -ENOMEM;
 
@@ -6350,7 +6350,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_delegreturn_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | RPC_TASK_TIMEOUT,
 	};
 	int status = 0;
 
@@ -6933,7 +6933,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_lock_ops,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int ret;
 
-- 
2.24.1

