Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F009158353
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgBJTMF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:12:05 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33323 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgBJTME (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:12:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id s35so4107652ybi.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbxxAbVV/Wuz/oyM+A4FJGzJfjXiwMKYJs3eJDFX1EY=;
        b=f60t6V7W9TABh/nABgn3Zz6lNf2FG3QaBnL9v2JQbkKVla7dvHkfbx1nmfPDicces0
         FrQAhMP46m+HL+xgo3HjhZxNx2liZAeNyVb9K2gHGUFz/AicwNQbTpLWq11hWUJHuRsa
         vB3tvdy36PtY+rkMDvdHUJSKA3Iyk+xu1AEG6gTI8NdYAG2Z+r2H8LMhQvjl3WPerS7V
         m7c0xUBDc0ElmpBHcwhOxCxgEaxqSrgx5/R5mp7uilbAqtoneYWr5+2vd5j3wk9OJxQA
         T4tOeDoX6XVOJ/4Uin5vi892guOEgRxWRfXww5U6icEeqGITv1VVMAUvnIMDzjzll+fE
         fjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbxxAbVV/Wuz/oyM+A4FJGzJfjXiwMKYJs3eJDFX1EY=;
        b=ZiuN9Wksrfmw2ldP0m18509RnUPKhvQgRrvE6eWCKPMogTJG1yyhQssjDaR/iuojGm
         ZxvPua4GfjARAfac6WpD51k+OqB4wkTR7AhWvPyVj575aMT4ZIxKQiiZyA9/3ijh3bh/
         mkDtqVK98lDGXvrQV8HbB0CjKqDih2b4RV595qBomAfY/VuYxbu2ndVgb5EYPwxjeM8P
         aDSAUhqIfLCXMXJwufTolQIPQTE8AJg3Y/RgSNXlQvKUQlZqXg7R3MQ17NRQsiwtpyJ5
         x2rLBWpLz8ufdCNfe2qmwjt2BxZmJ6EJw/F3mxFdrb13DwUUNj4CVExnwJnnlPtXBMIx
         bdBg==
X-Gm-Message-State: APjAAAX9WxLW13In9UDX6K7bwNe07RzBwnKQfg9AeeuWOWIimLo4eEVk
        xwx375bDyVpg5XtRVO3PChMS/xQKfg==
X-Google-Smtp-Source: APXvYqybhO+1g4UayGsFUwT59I5nw1QnKl3Oc9d7eQJDmorZQ58E3CwBrDKMrtq4tBhF+P91/Qzu2Q==
X-Received: by 2002:a25:9d84:: with SMTP id v4mr2777474ybp.40.1581361923547;
        Mon, 10 Feb 2020 11:12:03 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v133sm658860ywb.86.2020.02.10.11.12.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:12:03 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Ensure we time out if a delegreturn does not complete
Date:   Mon, 10 Feb 2020 14:09:54 -0500
Message-Id: <20200210190954.557351-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can't allow delegreturn to hold up nfs4_evict_inode() forever,
since that can cause the memory shrinkers to block. This patch
therefore ensures that we eventually time out, and complete the
reclaim of the inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6616a575711e..00fe674c8a49 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6259,6 +6259,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		/* Fallthrough */
 	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
+	case -ETIMEDOUT:
 		task->tk_status = 0;
 		break;
 	case -NFS4ERR_OLD_STATEID:
@@ -6349,7 +6350,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_delegreturn_ops,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
 	};
 	int status = 0;
 
-- 
2.24.1

