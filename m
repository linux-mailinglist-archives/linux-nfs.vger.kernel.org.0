Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1197B9132E
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfHQVYr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35254 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfHQVYr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:47 -0400
Received: by mail-io1-f68.google.com with SMTP id i22so13251083ioh.2
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BA/ETkjck+FWFnrZFNTs1+XU0segJTkXO5QVqQNNRoo=;
        b=bqNit5jYAtD9piHdPm+kdAvWjHb+o7dDUYtRf1edy96btZirulszylpfvAv3Winue6
         DyNLpg7JPFmIdTEgO898Ns+KbxKATiEURJ00EQAE4YhZCAv/OCx8TAOEAeL7s8ilBOhs
         bJKL5n1gdUnFwMuFB+H6rISrMc8pmQO3MCHkXQmbG6jt2IqmYhUrzAFyIKsL4PQ4Dk3F
         JTSXKBP8t9xpSLkobHe/6GE9HkpTzuwFYBbtUybE5rogw++6TBJs1Q50iDsN7BOQEpzK
         EXpycDTSiq+DDXkmcqfaRKJkwh6cC5Fdzla/gPocCjLciKGsxdyIAB4sfNI7yHcryOXs
         SgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA/ETkjck+FWFnrZFNTs1+XU0segJTkXO5QVqQNNRoo=;
        b=jHpW8FB81Rn4fr3AuFPp/qFXlLxjCclJn2WSj4sCCPui9gvBrU8k5B0MAQkse3l5Oc
         wrFsx0SJNJUlB202e3g0k13DgbUHhKmmDOCMaNrI4MXvfcsq78W7FYsgYIC17P3HpNXT
         B2s5ydmZISEufXwym/vAqEfxandWoYTJ6V2bOxotWJKM0PXzocYfFJR50EXsuzay/yYc
         2paEMqeDrReN5ZWE90mW2o6JFKuTCxfYBgXVOATn7RAWKVb1Y53fhiui8HhTbiwa3L96
         /rXuA6LG9MYArgAQ0eGfREttvHp7hTXYVu+7ZzyXeOPADfb5Teebg1mT/VKzDP8IZERq
         DJTw==
X-Gm-Message-State: APjAAAWTvdBd8YxDeMglH5x5Eo4noZSFpiC0pOXjl5XMA0yFmz9tfkxe
        /s2x+pG8lyP531Q8kNR/6RTP4i0=
X-Google-Smtp-Source: APXvYqxDdaGWCh5HERhYCH9v9F68UmJQph5RhY7r22nstoMUA6kAsxzxQeyWYS1Bd3jDv4S3vUl0jQ==
X-Received: by 2002:a6b:8f82:: with SMTP id r124mr18817093iod.6.1566077085642;
        Sat, 17 Aug 2019 14:24:45 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:45 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/8] NFS: On fatal writeback errors, we need to call nfs_inode_remove_request()
Date:   Sat, 17 Aug 2019 17:22:11 -0400
Message-Id: <20190817212217.22766-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the writeback error is fatal, we need to remove the tracking structures
(i.e. the nfs_page) from the inode.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 92d9cadc6102..3399149435ce 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -57,6 +57,7 @@ static const struct rpc_call_ops nfs_commit_ops;
 static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
+static void nfs_inode_remove_request(struct nfs_page *req);
 static void nfs_clear_request_commit(struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
@@ -591,7 +592,9 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error(struct nfs_page *req, int error)
 {
+	nfs_set_pageerror(page_file_mapping(req->wb_page));
 	nfs_mapping_set_error(req->wb_page, error);
+	nfs_inode_remove_request(req);
 	nfs_end_page_writeback(req);
 	nfs_release_request(req);
 }
-- 
2.21.0

