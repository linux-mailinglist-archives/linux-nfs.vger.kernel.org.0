Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE446F451
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhLIT5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhLIT5O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:14 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F00C0617A1
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:40 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d14so4037577ila.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5Rskj1Nwf4FPH1sEExJitDHdUW/0NpzKDoBKlnwmK8=;
        b=ZzEpzD6KXPTkxWJo8wBHWuHO1/2mE+uHZIy6Z57k2+wOKtpKsAcoekqMjS83K9jpXQ
         N/yhaA+TyZOD6GhHB5PqOytiokFf3Ujpv9PbQcbqoVOH0PwtTQ+kJiWvTH50W49gEHNm
         BfoaMAnlBsGc+7YAGyTUrpXXah9L7SSffDcp9wRhETIQRthFukYSuyvCwwTvL05jn46j
         zggIyR4lBUZHkCJejkjFzKjeOPT8jf5IhlgwgCLP0C4cnto8zEUqORD+pktKQpjQiQD3
         lLRG+rDMn8ejNyUTx8nhF7mDOj6aE/cDeGqJD92ccLgzfJAxnplJZJdjS++wEbaYSuyw
         Sg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5Rskj1Nwf4FPH1sEExJitDHdUW/0NpzKDoBKlnwmK8=;
        b=1ehIB559bsRz7027hxIgsOlPPmmmY92iAEmjP1KP8VSSYDcaFrgPOW7B5/o13Z3s/X
         lMYp+SzX28BIjt0BA1wgSlC0UGln01XzQSlrw57f+q+AIUPkt/k1zqAbeU0Sz5c32VIM
         pO0UlIUfoxLPn/KJANWkaY1LAg+8d41JCyL8aApVfh/oeScI85Z8gjP9PgB0vo0TqSNL
         SfLYYFHg4ArCMcUVY3pVwnFwuurbZfLGdiG1fkvkJvl62NDY6kQ6eTKW+zhFB8D2sfkB
         XCqUFIxCIX3luzvq9NpG+OtcfTpOEXC6G7F9O7P4oVqT8wq8cULbkZHBUngZrUg34naJ
         5OGQ==
X-Gm-Message-State: AOAM5309mxzb577FpnmhYhXThAbspmb/rN8qpjc3LrORBXHQ1tuAB40m
        GeDJk5CEZY6YvEO2xHZN0J7FvkkTg9Y=
X-Google-Smtp-Source: ABdhPJzaowN3GKKEJgbTtYRU/XWE6gL4+L/TNSJF8bEyfd3RsIqAL2O0W8Gj3NtT9G6AxmU6tYaG6Q==
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr15058832ile.71.1639079620289;
        Thu, 09 Dec 2021 11:53:40 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:39 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] NFSv4 store server support for fs_location attribute
Date:   Thu,  9 Dec 2021 14:53:30 -0500
Message-Id: <20211209195335.32404-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Define and store if server returns it supports fs_locations attribute
as a capability.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c         | 2 ++
 include/linux/nfs_fs_sb.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 535436dbdc9a..199f03c9d0b2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3873,6 +3873,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
 #endif
+		if (res.attr_bitmask[0] & FATTR4_WORD0_FS_LOCATIONS)
+			server->caps |= NFS_CAP_FS_LOCATIONS;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 2a9acbfe00f0..9a6e70ccde56 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -287,5 +287,5 @@ struct nfs_server {
 #define NFS_CAP_COPY_NOTIFY	(1U << 27)
 #define NFS_CAP_XATTR		(1U << 28)
 #define NFS_CAP_READ_PLUS	(1U << 29)
-
+#define NFS_CAP_FS_LOCATIONS	(1U << 30)
 #endif
-- 
2.27.0

