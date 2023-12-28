Return-Path: <linux-nfs+bounces-830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F781FB2C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Dec 2023 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9049FB23DE8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Dec 2023 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EB101FE;
	Thu, 28 Dec 2023 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhCF4rwh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD806101F8
	for <linux-nfs@vger.kernel.org>; Thu, 28 Dec 2023 20:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC2BC433C8;
	Thu, 28 Dec 2023 20:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703794917;
	bh=fOdppVxrIBHYEV5j+WMfkWIo5wTTplgip4d3ftRTtEk=;
	h=From:To:Cc:Subject:Date:From;
	b=LhCF4rwhT/qVQvLfC8UGY5IYvD/JcRx93IKe7El2Ig7+b2vQhOdj63LkbCW3adWrk
	 QFMa/txNbOlOBoxx3TEX6HFBcBmD8I6FSkxB06oAgVhkNAlwhl3HFNfPAD5VVCcKiQ
	 gD+m2/xVMY3D909rpF4yF8/6lE6swwUEFtTum0zxz4T+lqJKo3RUMjo1ND+C22gYzT
	 hoBCxnqOTxT5EjJUDZkXV3snxfve6C+fge5jN9pFLolDxds74kOVT7F0yE2S9YkeU1
	 6jo1cDufqXru06KW0Bn6nzHxUrTDrfr6BOcHQXbBA0X5Tt8rVC+i3pdkTkcciORZcO
	 +6KCsvwICqhyg==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] knfsd: fix the fallback implementation of the get_name export operation
Date: Thu, 28 Dec 2023 15:15:10 -0500
Message-ID: <20231228201510.985235-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The fallback implementation for the get_name export operation uses
readdir() to try to match the inode number to a filename. That filename
is then used together with lookup_one() to produce a dentry.
A problem arises when we match the '.' or '..' entries, since that
causes lookup_one() to fail. This has sometimes been seen to occur for
filesystems that violate POSIX requirements around uniqueness of inode
numbers, something that is common for snapshot directories.

This patch just ensures that we skip '.' and '..' rather than allowing a
match.

Fixes: 21d8a15ac333 ("lookup_one_len: don't accept . and ..")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/exportfs/expfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 3ae0154c5680..84af58eaf2ca 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 		container_of(ctx, struct getdents_callback, ctx);
 
 	buf->sequence++;
-	if (buf->ino == ino && len <= NAME_MAX) {
+	/* Ignore the '.' and '..' entries */
+	if ((len > 2 || name[0] != '.' || (len == 2 && name[1] != '.')) &&
+	    buf->ino == ino && len <= NAME_MAX) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;
-- 
2.43.0


