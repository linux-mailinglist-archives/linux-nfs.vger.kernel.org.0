Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA246F453
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhLIT5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhLIT5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:16 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EAC0617A1
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:43 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p65so7994719iof.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgWdsQIw7iIOvaTzUWwihr9PsUnhK9q2bYCCmb5oIDc=;
        b=WXnDCA9WJ+KTC7M5nOSkCHkKBLkeoxLfigNUxbSkbFbD/qD7vTwdLWr1ULsAO0Ge++
         IBF2O1+BKLo18FFvpF5/iifYtQswhduwOuOrgEVgq3LgHrqnsR0Icu7Tbe7xNSJV6xEP
         ZZzrhHk4mk6xv2qEqzimzk767a4i6Slau7iVRYvtvI14iTzmA9uMrbpo/pzYMlLZ9++b
         qQgh56z1LLLQ8NlF1aQBGMtTePIwsQsKfFeOs4FGnoSYJx0l7yWhJPuoB+uFTVpzbuMf
         HgalhZ6C+UC0YFbj6hLI+nfoiUcAEEDoyhogfitNpBer3iziz8xSedq2DeoK2RWdtEGL
         IipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgWdsQIw7iIOvaTzUWwihr9PsUnhK9q2bYCCmb5oIDc=;
        b=L8lesB8C4YQdm5dFphCOufn6fP2fqNZDY0VYHpf9vuH/KOji7exyiFX0Ad4uDMDQvu
         SAOEPfmaNbbyCORKjHsqpJ9/O0eoMDOfLQD9n3eiIJCwMdlRwt+xwrk4H7Rk6o3drVrt
         3+5v2zB9yQeHQavyORznxs6fP7z69d7HQrnR6dn4RT41UkV/ZUkZPrCgXXn7RE0Y823e
         5HoQNp3XA3ij7NUtr3VAhHRyShM7giRnas0u19IGgPIMGxUPKTKDMfHK1Y8aUFeVHIom
         CnaK74KF9/GvFtaXeDUe0aHmDLUmfBAZb2arxjRLY2l9jpe2OwaL6W95O0KIp2+zbgPM
         Vapg==
X-Gm-Message-State: AOAM5305jKPOzVxWG7RFr9Xan1BfOfKJyT75ymn0sMULxu4lXvr63B/V
        bi6oOtbDog4S3hVKWfTBPAR0SDqfaT8=
X-Google-Smtp-Source: ABdhPJzIzOTEyTs/9bjkA7sqIyX4peqF4mXfNz6C0hn+WGyW8v40IhgH8BNlwg9mViI5rB+qPu+gDQ==
X-Received: by 2002:a02:1949:: with SMTP id b70mr11786736jab.7.1639079622453;
        Thu, 09 Dec 2021 11:53:42 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:41 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] NFSv4 expose nfs_parse_server_name function
Date:   Thu,  9 Dec 2021 14:53:32 -0500
Message-Id: <20211209195335.32404-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Make nfs_parse_server_name available outside of nfs4namespace.c.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4_fs.h       | 3 ++-
 fs/nfs/nfs4namespace.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 2402a3d8ba99..734ac09becf7 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -280,7 +280,8 @@ struct rpc_clnt *nfs4_negotiate_security(struct rpc_clnt *, struct inode *,
 int nfs4_submount(struct fs_context *, struct nfs_server *);
 int nfs4_replace_transport(struct nfs_server *server,
 				const struct nfs4_fs_locations *locations);
-
+size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
+			     size_t salen, struct net *net);
 /* nfs4proc.c */
 extern int nfs4_handle_exception(struct nfs_server *, int, struct nfs4_exception *);
 extern int nfs4_async_handle_error(struct rpc_task *task,
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 873342308dc0..f1ed4f60a7f3 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -164,8 +164,8 @@ static int nfs4_validate_fspath(struct dentry *dentry,
 	return 0;
 }
 
-static size_t nfs_parse_server_name(char *string, size_t len,
-		struct sockaddr *sa, size_t salen, struct net *net)
+size_t nfs_parse_server_name(char *string, size_t len, struct sockaddr *sa,
+			     size_t salen, struct net *net)
 {
 	ssize_t ret;
 
-- 
2.27.0

