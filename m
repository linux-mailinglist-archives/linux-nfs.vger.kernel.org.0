Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD415835E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJTQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:10 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33598 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJTQJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:09 -0500
Received: by mail-yb1-f194.google.com with SMTP id s35so4114043ybi.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OMqptcmVRzEg42M/Hggynq9yT5bF0SzCr+29ph874gs=;
        b=WtHiTNJUUYm2HOKw903oyXMskaymXXDRO+BgikK+fDWnDwBQmx62+aS/meJ7QyvhYt
         Polkexse58XqBG9iEouFX//dYxFaJusjmF1muyM0i6YzSDUvrXzQ1HO0S5IkwHBRR/Lz
         tNu+p8ygigSmW/6KAhd1J3/EG37Wp8VRrA9vl/dUyunhgZZl52an7otRZxGu+nTPkXJj
         eZ3rwy7f0uBq+SYvahbJ3CZRoIq9Kq8kAUZDOEVwxOsfU6/qkycJ/n0l4a8rUjbeL1rM
         AV7+xujds8DQ1BtYRfx08rpcdFs130UZJnIjVwqzqG13T6rD6K0a9atuYtZCxNzv3/LG
         A+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMqptcmVRzEg42M/Hggynq9yT5bF0SzCr+29ph874gs=;
        b=V+8nqUnZpg4fEL2b30cjhL+QOPAa3SKcMRaAiM+ckvfvt8ZopBbeY2mTfNIj25/4ML
         XnjpjTs1y9gLDWUAnrrL1yj0q8pIYREPsAmRQYHpKxxoSq1cTi1joaCCvaUoj8X1/h6I
         xwJ62LCu7iJtg9NwDasCsp4cvwESzjQK4tNQW+ieGexlm52y41SEkDmszgckz6s3BEef
         FQwhSshV+K1TC+I2wsrz/U+pgPlRKUi6Y7hPBc6n48jFRvAD2c8igRwELN8tUYq5XiLy
         np2ZuLhZ1Rb6+r6urH4hw0cSvltCi2Pgy20kwnla9o/eysOm7Ulc/dfDMthXNAblmHZg
         BSZQ==
X-Gm-Message-State: APjAAAW8AbfacCAfLm65UQpz+SMbGA0Ti0q9Eydqckgk1pGDfiGTOY5i
        YdMQPG6CnGHiSb9e2eZ+1bpTPk8upg==
X-Google-Smtp-Source: APXvYqzO+gbVYHwgqMICdW6fFFbTxZ9yoP9aEKL/rpGFA517LTjqUIJNwO+EOsHPOl4xFRAurFNdfg==
X-Received: by 2002:a25:cb90:: with SMTP id b138mr2770485ybg.128.1581362168661;
        Mon, 10 Feb 2020 11:16:08 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:08 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/8] NFS: Assume cred is pinned by open context in I/O requests
Date:   Mon, 10 Feb 2020 14:13:41 -0500
Message-Id: <20200210191345.557460-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-4-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
 <20200210191345.557460-3-trond.myklebust@hammerspace.com>
 <20200210191345.557460-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In read/write/commit, we should be able to assume that the cred is
pinned by the open context.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 2 +-
 fs/nfs/write.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 20b3717cd7ca..c9c3edefc5be 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -627,7 +627,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		.callback_ops = call_ops,
 		.callback_data = hdr,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC | flags,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | flags,
 	};
 	int ret = 0;
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c478b772cc49..5544ee6cfda8 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1707,7 +1707,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 		.callback_ops = call_ops,
 		.callback_data = data,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC | flags,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | flags,
 		.priority = priority,
 	};
 	/* Set up the initial task struct.  */
-- 
2.24.1

