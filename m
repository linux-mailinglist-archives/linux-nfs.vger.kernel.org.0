Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7684795A3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhLQUnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46558 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbhLQUnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E41B82A92
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB61C36AE8;
        Fri, 17 Dec 2021 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773788;
        bh=dCehqohZUmZgTibtNR97vOQ+iA2rnhGXwCvUG74q8Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4biOXQiFkbBuqaOfNqEQZBtl8tjWGVWbw8+sh3wcBE5h3LjNg43KFnTxUulBpnIq
         fwDM8hsZ7TcnD8cPAkeBpGVt/UrxOOmNRfxP+askpG78NL1FgGNdcCtqB8rMqBVxtu
         a1bS+I0a0ngz5PlQ3d+IuYpJ95Heyi79Spz4BsoGJUFQByuoQHpa26jDlxtVjEQIIO
         POaR2slk8ChdhO+VTEdsVb8toYTWCtYNn2f1uH48DAsfsmtA73ZFUmrekDzibeXvcO
         S5fRawQGI3rNDt0bHg4Y6sfnoEaUV+zZTtUpkkO0VZIArerbC1tCj6D91+IMTPuC5u
         EuGZ5vcaBlCHA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFS: Fix the verifier for case sensitive filesystem in nfs_atomic_open()
Date:   Fri, 17 Dec 2021 15:36:58 -0500
Message-Id: <20211217203658.439352-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217203658.439352-5-trondmy@kernel.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
 <20211217203658.439352-2-trondmy@kernel.org>
 <20211217203658.439352-3-trondmy@kernel.org>
 <20211217203658.439352-4-trondmy@kernel.org>
 <20211217203658.439352-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a490704e10ed..9432820ce21c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1888,6 +1888,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
+	unsigned long dir_verifier;
 	bool switched = false;
 	int created = 0;
 	int err;
@@ -1961,7 +1962,11 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		switch (err) {
 		case -ENOENT:
 			d_splice_alias(NULL, dentry);
-			nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+			if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+				dir_verifier = inode_peek_iversion_raw(dir);
+			else
+				dir_verifier = nfs_save_change_attribute(dir);
+			nfs_set_verifier(dentry, dir_verifier);
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
-- 
2.33.1

