Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1808158361
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBJTQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:12 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41708 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBJTQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id l22so3939022ywc.8
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZcmMvtTswIf+YTA+DDJp0GV3gjjxF4a82aq2v6Pllwk=;
        b=CMr80gXgP7NEy5pxOzpF/mHW6wKRRgYI8oY4Ebw1PklTuLjqP1dyXNAbhzD3Ludaiz
         r2LbNmrFOGCTAQ27DbJFbMbQFyqv2ZHqCWKh7yjEO7FG0XCtLOiLtoMj9NMy+/0WMWrs
         y4CA+xFAm+WndqwNaVGHX5OWXi7Uetnk3J8K76gJSeZjyaWAaILYeJH5/a0CI+Ng/xoa
         UYN8XJKGcKOO0pyUWCqgSibFSbzGGhoHkzrXxZWnEzREa4LqmO8eOANyXbTOooW0dhWG
         O8z46N3hKThPwKla0flZgAJwVSxGgsYFgsfWdjbJBqnvPj36WrPPERgb0EnvBe8znMUZ
         mmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcmMvtTswIf+YTA+DDJp0GV3gjjxF4a82aq2v6Pllwk=;
        b=eCn7eiIrqlhvqfLs6dKc/nGIuAGGMGruE7UcaefYrC1doWLnmdXcjuCjYpxKHRHFz6
         bhSmsz35pBo5JxHwZG4F5Mi05gtsQK3MQbFgMoQxEcbQd8qcEa7h9uUz3vJU+Ink+m17
         Weh0C7LMXWX26fHR2KpCWEl1+oSp0I5WlCQL01nXDOnHt3GLE7rjL/ncDZYuBLIeFstY
         HSROOF07dM2Tv3RqO44bgEKziVzpg3NMP7IoUYctVjAsDzLYLsEEAj3OQTmA1jhWvtGZ
         AETxQjF8GOv4izrqSFy5K4aLofsxLzd3rffatvB1PRXlRt+6t2vCR3LZlqydsQKO1Ev5
         0IbA==
X-Gm-Message-State: APjAAAV1yHLdRjdzinERhzC+lG3tJ68Ppp6CiFDRqrrSC6dD61d0fdJT
        yF5PAMsyv53ocyyGyFcJl+efl2ZcWg==
X-Google-Smtp-Source: APXvYqxg7MhfqQvz0QXyd8iYTAuqieE78vE6p4sHhMEorpTTGewJa3NpIcWBpNXDWL4rB8+HPcsIAw==
X-Received: by 2002:a0d:db47:: with SMTP id d68mr2428247ywe.338.1581362170423;
        Mon, 10 Feb 2020 11:16:10 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:10 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/8] NFSv4: Avoid unnecessary credential references in layoutget
Date:   Mon, 10 Feb 2020 14:13:43 -0500
Message-Id: <20200210191345.557460-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-6-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
 <20200210191345.557460-3-trond.myklebust@hammerspace.com>
 <20200210191345.557460-4-trond.myklebust@hammerspace.com>
 <20200210191345.557460-5-trond.myklebust@hammerspace.com>
 <20200210191345.557460-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Layoutget is just using the credential attached to the open context.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 fs/nfs/pnfs.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47464fb419dc..7f5802b6d404 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9177,7 +9177,7 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_layoutget_call_ops,
 		.callback_data = lgp,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	struct pnfs_layout_segment *lseg = NULL;
 	struct nfs4_exception exception = {
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b21eb4882846..cb99ac954688 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1073,7 +1073,7 @@ pnfs_alloc_init_layoutget_args(struct inode *ino,
 	lgp->args.ctx = get_nfs_open_context(ctx);
 	nfs4_stateid_copy(&lgp->args.stateid, stateid);
 	lgp->gfp_flags = gfp_flags;
-	lgp->cred = get_cred(ctx->cred);
+	lgp->cred = ctx->cred;
 	return lgp;
 }
 
@@ -1084,7 +1084,6 @@ void pnfs_layoutget_free(struct nfs4_layoutget *lgp)
 	nfs4_free_pages(lgp->args.layout.pages, max_pages);
 	if (lgp->args.inode)
 		pnfs_put_layout_hdr(NFS_I(lgp->args.inode)->layout);
-	put_cred(lgp->cred);
 	put_nfs_open_context(lgp->args.ctx);
 	kfree(lgp);
 }
-- 
2.24.1

