Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D158E15835C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJTQH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:07 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36054 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJTQG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:06 -0500
Received: by mail-yb1-f195.google.com with SMTP id q190so1109437ybg.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FgobD3V7uuOy4LVGAx9rHhnWTaPqCxK05Vocd+6bvMM=;
        b=fcApY0O2/E2Jfj+xceGJmVwXJ+4x+C6qxz9vcSb2EPwUJfz7bbsS7ojqVLfklGfHss
         qyanx1f17n9q5CKjoFdjk/A0PgiG+rDaTVSUgBanZUYSKmui9TSFJtmK4r3ojvDoCnnm
         1qdIqW3gaCXTbGJE/uVe94DvlG6w8HOzaIrc3H7SrXW9YCK7hkQw3L0RMhMEmQ85x8WM
         B6r1Hnwhay9EEZkn29iAH2/FzLDzfipIuLNZtxQUiGW3OtomlujnZXoTb8soneL/7/7E
         8WUGs8vPWl3wxBaQJjTLZHl4gHjh85Y8Lm5lZ/gXwqGth9enk36Lt0eQTgXyP+xkgBmj
         mg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgobD3V7uuOy4LVGAx9rHhnWTaPqCxK05Vocd+6bvMM=;
        b=S+cwcHqqTIbZCOQuvg+FyQBMbb6SyoEdPbNtrAxdLPBzFFsJJRsQgbbHd1viIWJGPv
         RZ6IX1fTM6OKqWtkkPuWRQcbzVAoHqZ9IDS7uKX+sAX8ECeqDAr1Kd5cvaPpwUlT+23z
         aUR6Y5je0y7jgT3Im4/U4B6+FbjdW+Hr2fzLHpKZK1dV2zQTE6hlInQ0fIibBMNwv7UB
         m92hZlbFllokt9q8gywx3Ka3Xsew89Ipd2fwsrRuKOOviU+BrvnGlgN8SVjnfuq2gw6a
         5LydWg9N8VUIemuQHA0uaWsOLUpvpNVE1dF2V5sGFZeno2tiaIiyeghiEqyk+/TiUT8V
         i/qw==
X-Gm-Message-State: APjAAAVp1AL0k6mLsj6hFM8gfoWT5ZHBmw9J5lTV8pg+MNFMr0eCcVFm
        2cLXD7oQB3s+rgedGo+exUtV8+N/gA==
X-Google-Smtp-Source: APXvYqwzfADJ5Fb/IXrQIk9hQDciNw15sFD5Y2925VsEhzNrcgXyekrTHKpHnX6yXvG1VU4/5nXgTQ==
X-Received: by 2002:a5b:384:: with SMTP id k4mr2833453ybp.305.1581362165736;
        Mon, 10 Feb 2020 11:16:05 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:05 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] NFS: alloc_nfs_open_context() must use the file cred when available
Date:   Mon, 10 Feb 2020 14:13:38 -0500
Message-Id: <20200210191345.557460-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we're creating a nfs_open_context() for a specific file pointer,
we must use the cred assigned to that file.

Fixes: a52458b48af1 ("NFS/NFSD/SUNRPC: replace generic creds with 'struct cred'.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 11bf15800ac9..a10fb87c6ac3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -959,16 +959,16 @@ struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
 						struct file *filp)
 {
 	struct nfs_open_context *ctx;
-	const struct cred *cred = get_current_cred();
 
 	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx) {
-		put_cred(cred);
+	if (!ctx)
 		return ERR_PTR(-ENOMEM);
-	}
 	nfs_sb_active(dentry->d_sb);
 	ctx->dentry = dget(dentry);
-	ctx->cred = cred;
+	if (filp)
+		ctx->cred = get_cred(filp->f_cred);
+	else
+		ctx->cred = get_current_cred();
 	ctx->ll_cred = NULL;
 	ctx->state = NULL;
 	ctx->mode = f_mode;
-- 
2.24.1

